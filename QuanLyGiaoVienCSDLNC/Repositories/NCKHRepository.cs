using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.DTOs.NCKH;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class NCKHRepository : INCKHRepository
    {
        private readonly ApplicationDbContext _context;

        public NCKHRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        // Quản lý loại NCKH
        public async Task<List<LoaiNCKH>> GetAllLoaiNCKHAsync()
        {
            return await _context.LoaiNCKHs
                .Include(l => l.QuyDoiGioChuanNCKH)
                .ToListAsync();
        }

        public async Task<LoaiNCKH> GetLoaiNCKHByIdAsync(string maLoaiNCKH)
        {
            return await _context.LoaiNCKHs
                .Include(l => l.QuyDoiGioChuanNCKH)
                .FirstOrDefaultAsync(l => l.MaLoaiNCKH == maLoaiNCKH);
        }

        // Quản lý tài NCKH - Sử dụng stored procedures
        public async Task<PagedResultDto<TaiNCKHListItemDto>> SearchTaiNCKHAsync(TaiNCKHSearchDto searchDto)
        {
            var totalRecordsParam = new SqlParameter
            {
                ParameterName = "@TotalRecords",
                SqlDbType = SqlDbType.Int,
                Direction = ParameterDirection.Output
            };

            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@MaGV", (object)searchDto.MaGV ?? DBNull.Value),
                new SqlParameter("@NamHoc", (object)searchDto.NamHoc ?? DBNull.Value),
                new SqlParameter("@PageNumber", searchDto.PageNumber),
                new SqlParameter("@PageSize", searchDto.PageSize),
                totalRecordsParam
            };

            var result = await _context.Database.SqlQueryRaw<TaiNCKHListItemDto>(
                "EXEC sp_NCKH_DanhSach @MaGV, @NamHoc, @PageNumber, @PageSize, @TotalRecords OUTPUT",
                parameters.ToArray()).ToListAsync();

            var totalRecords = (int)(totalRecordsParam.Value ?? 0);

            return new PagedResultDto<TaiNCKHListItemDto>(result, totalRecords, searchDto.PageNumber, searchDto.PageSize);
        }

        public async Task<List<TaiNCKH>> GetAllTaiNCKHAsync()
        {
            return await _context.TaiNCKHs
                .Include(t => t.LoaiNCKH)
                .ThenInclude(l => l.QuyDoiGioChuanNCKH)
                .OrderByDescending(t => t.NamHoc)
                .ToListAsync();
        }

        public async Task<TaiNCKHDetailDto> GetTaiNCKHDetailAsync(string maTaiNCKH)
        {
            var taiNCKH = await _context.TaiNCKHs
                .Include(t => t.LoaiNCKH)
                .ThenInclude(l => l.QuyDoiGioChuanNCKH)
                .FirstOrDefaultAsync(t => t.MaTaiNCKH == maTaiNCKH);

            if (taiNCKH == null) return null;

            var chiTietList = await GetChiTietNCKHByMaTaiNCKHAsync(maTaiNCKH);

            return new TaiNCKHDetailDto
            {
                ThongTinCoBan = taiNCKH,
                LoaiNCKH = taiNCKH.LoaiNCKH,
                QuyDoiGioChuan = taiNCKH.LoaiNCKH?.QuyDoiGioChuanNCKH,
                DanhSachTacGia = chiTietList,
                SoTacGiaHienTai = chiTietList.Count,
                DayDuTacGia = chiTietList.Count >= taiNCKH.SoTacGia
            };
        }

        public async Task<TaiNCKH> GetTaiNCKHByIdAsync(string maTaiNCKH)
        {
            return await _context.TaiNCKHs
                .Include(t => t.LoaiNCKH)
                .ThenInclude(l => l.QuyDoiGioChuanNCKH)
                .FirstOrDefaultAsync(t => t.MaTaiNCKH == maTaiNCKH);
        }

        public async Task<List<TaiNCKH>> GetTaiNCKHByNamHocAsync(string namHoc)
        {
            return await _context.TaiNCKHs
                .Include(t => t.LoaiNCKH)
                .Where(t => t.NamHoc == namHoc)
                .OrderBy(t => t.TenCongTrinhKhoaHoc)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maTaiNCKH)> AddTaiNCKHAsync(TaiNCKHCreateDto dto)
        {
            var maTaiNCKHParam = new SqlParameter
            {
                ParameterName = "@MaTaiNCKH",
                SqlDbType = SqlDbType.Char,
                Size = 15,
                Direction = ParameterDirection.Output
            };

            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 500,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_TaiNCKH_ThemMoi @TenCongTrinhKhoaHoc, @NamHoc, @SoTacGia, @MaLoaiNCKH, @MaTaiNCKH OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenCongTrinhKhoaHoc", dto.TenCongTrinhKhoaHoc),
                    new SqlParameter("@NamHoc", dto.NamHoc),
                    new SqlParameter("@SoTacGia", dto.SoTacGia),
                    new SqlParameter("@MaLoaiNCKH", dto.MaLoaiNCKH),
                    maTaiNCKHParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maTaiNCKH = maTaiNCKHParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(maTaiNCKH) && !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maTaiNCKH);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm tài NCKH: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateTaiNCKHAsync(TaiNCKHUpdateDto dto)
        {
            try
            {
                var taiNCKH = await _context.TaiNCKHs.FindAsync(dto.MaTaiNCKH);
                if (taiNCKH == null)
                    return (false, "Không tìm thấy tài NCKH");

                taiNCKH.TenCongTrinhKhoaHoc = dto.TenCongTrinhKhoaHoc;
                taiNCKH.NamHoc = dto.NamHoc;
                taiNCKH.SoTacGia = dto.SoTacGia;
                taiNCKH.MaLoaiNCKH = dto.MaLoaiNCKH;

                await _context.SaveChangesAsync();
                return (true, "Cập nhật tài NCKH thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật tài NCKH: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteTaiNCKHAsync(string maTaiNCKH)
        {
            try
            {
                var taiNCKH = await _context.TaiNCKHs.FindAsync(maTaiNCKH);
                if (taiNCKH == null)
                    return (false, "Không tìm thấy tài NCKH");

                // Kiểm tra xem có chi tiết NCKH nào không
                var hasDetails = await _context.ChiTietNCKHs.AnyAsync(ct => ct.MaTaiNCKH == maTaiNCKH);
                if (hasDetails)
                    return (false, "Không thể xóa vì có chi tiết NCKH liên quan");

                _context.TaiNCKHs.Remove(taiNCKH);
                await _context.SaveChangesAsync();
                return (true, "Xóa tài NCKH thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa tài NCKH: {ex.Message}");
            }
        }

        // Quản lý chi tiết NCKH - Sử dụng stored procedures
        public async Task<List<ChiTietNCKH>> GetChiTietNCKHByMaGVAsync(string maGV, string namHoc = null)
        {
            var query = _context.ChiTietNCKHs
                .Include(ct => ct.TaiNCKH)
                .ThenInclude(t => t.LoaiNCKH)
                .Include(ct => ct.GiaoVien)
                .Where(ct => ct.MaGV == maGV);

            if (!string.IsNullOrEmpty(namHoc))
                query = query.Where(ct => ct.TaiNCKH.NamHoc == namHoc);

            return await query.OrderByDescending(ct => ct.TaiNCKH.NamHoc).ToListAsync();
        }

        public async Task<List<ChiTietNCKH>> GetChiTietNCKHByMaTaiNCKHAsync(string maTaiNCKH)
        {
            return await _context.ChiTietNCKHs
                .Include(ct => ct.GiaoVien)
                .Where(ct => ct.MaTaiNCKH == maTaiNCKH)
                .OrderBy(ct => ct.VaiTro)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maChiTietNCKH)> PhanCongNCKHAsync(ChiTietNCKHCreateDto dto)
        {
            var maChiTietNCKHParam = new SqlParameter
            {
                ParameterName = "@MaChiTietNCKH",
                SqlDbType = SqlDbType.Char,
                Size = 15,
                Direction = ParameterDirection.Output
            };

            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 500,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_NCKH_PhanCong @MaGV, @MaTaiNCKH, @VaiTro, @SoGio, @MaChiTietNCKH OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", dto.MaGV),
                    new SqlParameter("@MaTaiNCKH", dto.MaTaiNCKH),
                    new SqlParameter("@VaiTro", dto.VaiTro),
                    new SqlParameter("@SoGio", dto.SoGio),
                    maChiTietNCKHParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maChiTietNCKH = maChiTietNCKHParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(maChiTietNCKH) && !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maChiTietNCKH);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công NCKH: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateChiTietNCKHAsync(ChiTietNCKHUpdateDto dto)
        {
            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 500,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_NCKH_CapNhat @MaChiTietNCKH, @VaiTro, @SoGio, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaChiTietNCKH", dto.MaChiTietNCKH),
                    new SqlParameter("@VaiTro", dto.VaiTro),
                    new SqlParameter("@SoGio", dto.SoGio),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật chi tiết NCKH: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteChiTietNCKHAsync(string maChiTietNCKH)
        {
            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 500,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_NCKH_XoaPhanCong @MaChiTietNCKH, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaChiTietNCKH", maChiTietNCKH),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa phân công NCKH: {ex.Message}");
            }
        }

        // Quy đổi giờ chuẩn
        public async Task<List<QuyDoiGioChuanNCKH>> GetAllQuyDoiGioChuanAsync()
        {
            return await _context.QuyDoiGioChuanNCKHs.ToListAsync();
        }

        public async Task<QuyDoiGioChuanNCKH> GetQuyDoiGioChuanByIdAsync(string maQuyDoi)
        {
            return await _context.QuyDoiGioChuanNCKHs.FindAsync(maQuyDoi);
        }

        // Thống kê và báo cáo
        public async Task<List<object>> GetThongKeNCKHByGiaoVienAsync(string maGV, string namHoc = null)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@MaGV", maGV),
                new SqlParameter("@NamHoc", (object)namHoc ?? DBNull.Value)
            };

            return await _context.Database.SqlQueryRaw<object>(
                "SELECT * FROM vw_ThongKeNCKHByGiaoVien WHERE MaGV = @MaGV AND (@NamHoc IS NULL OR NamHoc = @NamHoc)",
                parameters.ToArray()).ToListAsync();
        }

        public async Task<List<object>> GetThongKeNCKHByBoMonAsync(string maBM, string namHoc = null)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@MaBM", maBM),
                new SqlParameter("@NamHoc", (object)namHoc ?? DBNull.Value)
            };

            return await _context.Database.SqlQueryRaw<object>(
                "SELECT * FROM vw_ThongKeNCKHByBoMon WHERE MaBM = @MaBM AND (@NamHoc IS NULL OR NamHoc = @NamHoc)",
                parameters.ToArray()).ToListAsync();
        }

        public async Task<List<object>> GetThongKeNCKHByKhoaAsync(string maKhoa, string namHoc = null)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@MaKhoa", maKhoa),
                new SqlParameter("@NamHoc", (object)namHoc ?? DBNull.Value)
            };

            return await _context.Database.SqlQueryRaw<object>(
                "SELECT * FROM vw_ThongKeNCKHByKhoa WHERE MaKhoa = @MaKhoa AND (@NamHoc IS NULL OR NamHoc = @NamHoc)",
                parameters.ToArray()).ToListAsync();
        }

        // Validation
        public async Task<bool> KiemTraTacGiaDayDuAsync(string maTaiNCKH)
        {
            var taiNCKH = await _context.TaiNCKHs.FindAsync(maTaiNCKH);
            if (taiNCKH == null) return false;

            var soTacGiaHienTai = await _context.ChiTietNCKHs.CountAsync(ct => ct.MaTaiNCKH == maTaiNCKH);
            return soTacGiaHienTai >= taiNCKH.SoTacGia;
        }

        public async Task<bool> KiemTraChuNhiemTonTaiAsync(string maTaiNCKH)
        {
            return await _context.ChiTietNCKHs.AnyAsync(ct => ct.MaTaiNCKH == maTaiNCKH && ct.VaiTro == "Chủ nhiệm");
        }

        public async Task<bool> KiemTraGiaoVienDaThamGiaAsync(string maGV, string maTaiNCKH)
        {
            return await _context.ChiTietNCKHs.AnyAsync(ct => ct.MaGV == maGV && ct.MaTaiNCKH == maTaiNCKH);
        }
    }
}