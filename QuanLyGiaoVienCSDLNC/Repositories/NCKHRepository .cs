using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
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

        // Quản lý tài NCKH
        public async Task<List<TaiNCKH>> GetAllTaiNCKHAsync()
        {
            return await _context.TaiNCKHs
                .Include(t => t.LoaiNCKH)
                .ThenInclude(l => l.QuyDoiGioChuanNCKH)
                .OrderByDescending(t => t.NamHoc)
                .ToListAsync();
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

        public async Task<(bool success, string message, string maTaiNCKH)> AddTaiNCKHAsync(TaiNCKH taiNCKH)
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
                    "EXEC sp_NCKH_ThemTai @TenCongTrinhKhoaHoc, @NamHoc, @SoTacGia, @MaLoaiNCKH, @MaTaiNCKH OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenCongTrinhKhoaHoc", taiNCKH.TenCongTrinhKhoaHoc),
                    new SqlParameter("@NamHoc", taiNCKH.NamHoc),
                    new SqlParameter("@SoTacGia", taiNCKH.SoTacGia),
                    new SqlParameter("@MaLoaiNCKH", taiNCKH.MaLoaiNCKH),
                    maTaiNCKHParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maTaiNCKH = maTaiNCKHParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maTaiNCKH);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm tài NCKH: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateTaiNCKHAsync(TaiNCKH taiNCKH)
        {
            try
            {
                _context.TaiNCKHs.Update(taiNCKH);
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

        // Quản lý chi tiết NCKH
        public async Task<List<ChiTietNCKH>> GetChiTietNCKHByMaGVAsync(string maGV)
        {
            return await _context.ChiTietNCKHs
                .Include(ct => ct.TaiNCKH)
                .ThenInclude(t => t.LoaiNCKH)
                .Where(ct => ct.MaGV == maGV)
                .OrderByDescending(ct => ct.TaiNCKH.NamHoc)
                .ToListAsync();
        }

        public async Task<List<ChiTietNCKH>> GetChiTietNCKHByMaTaiNCKHAsync(string maTaiNCKH)
        {
            return await _context.ChiTietNCKHs
                .Include(ct => ct.GiaoVien)
                .Where(ct => ct.MaTaiNCKH == maTaiNCKH)
                .OrderBy(ct => ct.VaiTro)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maChiTietNCKH)> PhanCongNCKHAsync(string maGV, string maTaiNCKH, string vaiTro, float soGio)
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
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaTaiNCKH", maTaiNCKH),
                    new SqlParameter("@VaiTro", vaiTro),
                    new SqlParameter("@SoGio", soGio),
                    maChiTietNCKHParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maChiTietNCKH = maChiTietNCKHParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maChiTietNCKH);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công NCKH: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateChiTietNCKHAsync(ChiTietNCKH chiTietNCKH)
        {
            try
            {
                _context.ChiTietNCKHs.Update(chiTietNCKH);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật chi tiết NCKH thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật chi tiết NCKH: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteChiTietNCKHAsync(string maChiTietNCKH)
        {
            try
            {
                var chiTiet = await _context.ChiTietNCKHs.FindAsync(maChiTietNCKH);
                if (chiTiet == null)
                    return (false, "Không tìm thấy chi tiết NCKH");

                _context.ChiTietNCKHs.Remove(chiTiet);
                await _context.SaveChangesAsync();
                return (true, "Xóa chi tiết NCKH thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa chi tiết NCKH: {ex.Message}");
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
    }
}