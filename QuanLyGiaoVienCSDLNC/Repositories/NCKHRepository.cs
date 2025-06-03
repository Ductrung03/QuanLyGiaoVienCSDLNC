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

        #region Quản lý loại NCKH
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

        public async Task<(bool success, string message)> AddLoaiNCKHAsync(LoaiNCKH loaiNCKH)
        {
            try
            {
                // Tạo mã loại NCKH tự động
                var count = await _context.LoaiNCKHs.CountAsync();
                loaiNCKH.MaLoaiNCKH = "LNCKH" + (count + 1).ToString("D3");

                _context.LoaiNCKHs.Add(loaiNCKH);
                await _context.SaveChangesAsync();
                return (true, "Thêm loại NCKH thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm loại NCKH: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> UpdateLoaiNCKHAsync(LoaiNCKH loaiNCKH)
        {
            try
            {
                _context.LoaiNCKHs.Update(loaiNCKH);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật loại NCKH thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật loại NCKH: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteLoaiNCKHAsync(string maLoaiNCKH)
        {
            try
            {
                var loaiNCKH = await _context.LoaiNCKHs.FindAsync(maLoaiNCKH);
                if (loaiNCKH == null)
                    return (false, "Không tìm thấy loại NCKH");

                // Kiểm tra có tài NCKH nào sử dụng không
                var hasUsage = await _context.TaiNCKHs.AnyAsync(t => t.MaLoaiNCKH == maLoaiNCKH);
                if (hasUsage)
                    return (false, "Không thể xóa vì có tài NCKH đang sử dụng loại này");

                _context.LoaiNCKHs.Remove(loaiNCKH);
                await _context.SaveChangesAsync();
                return (true, "Xóa loại NCKH thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa loại NCKH: {ex.Message}");
            }
        }
        #endregion

        #region Quản lý quy đổi giờ chuẩn
        public async Task<List<QuyDoiGioChuanNCKH>> GetAllQuyDoiGioChuanAsync()
        {
            return await _context.QuyDoiGioChuanNCKHs.ToListAsync();
        }

        public async Task<QuyDoiGioChuanNCKH> GetQuyDoiGioChuanByIdAsync(string maQuyDoi)
        {
            return await _context.QuyDoiGioChuanNCKHs.FindAsync(maQuyDoi);
        }

        public async Task<(bool success, string message)> AddQuyDoiGioChuanAsync(QuyDoiGioChuanNCKH quyDoi)
        {
            try
            {
                // Tạo mã quy đổi tự động
                var count = await _context.QuyDoiGioChuanNCKHs.CountAsync();
                quyDoi.MaQuyDoi = "QD" + (count + 1).ToString("D3");

                _context.QuyDoiGioChuanNCKHs.Add(quyDoi);
                await _context.SaveChangesAsync();
                return (true, "Thêm quy đổi giờ chuẩn thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm quy đổi giờ chuẩn: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> UpdateQuyDoiGioChuanAsync(QuyDoiGioChuanNCKH quyDoi)
        {
            try
            {
                _context.QuyDoiGioChuanNCKHs.Update(quyDoi);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật quy đổi giờ chuẩn thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật quy đổi giờ chuẩn: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteQuyDoiGioChuanAsync(string maQuyDoi)
        {
            try
            {
                var quyDoi = await _context.QuyDoiGioChuanNCKHs.FindAsync(maQuyDoi);
                if (quyDoi == null)
                    return (false, "Không tìm thấy quy đổi giờ chuẩn");

                // Kiểm tra có loại NCKH nào sử dụng không
                var hasUsage = await _context.LoaiNCKHs.AnyAsync(l => l.MaQuyDoi == maQuyDoi);
                if (hasUsage)
                    return (false, "Không thể xóa vì có loại NCKH đang sử dụng");

                _context.QuyDoiGioChuanNCKHs.Remove(quyDoi);
                await _context.SaveChangesAsync();
                return (true, "Xóa quy đổi giờ chuẩn thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa quy đổi giờ chuẩn: {ex.Message}");
            }
        }
        #endregion

        #region Quản lý tài NCKH
        public async Task<List<TaiNCKH>> GetAllTaiNCKHAsync()
        {
            return await _context.TaiNCKHs
                .Include(t => t.LoaiNCKH)
                .ThenInclude(l => l.QuyDoiGioChuanNCKH)
                .OrderByDescending(t => t.NamHoc)
                .ThenBy(t => t.TenCongTrinhKhoaHoc)
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

        public async Task<List<TaiNCKH>> SearchTaiNCKHAsync(string searchTerm = null, string namHoc = null, string maLoaiNCKH = null)
        {
            var query = _context.TaiNCKHs
                .Include(t => t.LoaiNCKH)
                .ThenInclude(l => l.QuyDoiGioChuanNCKH)
                .AsQueryable();

            if (!string.IsNullOrEmpty(searchTerm))
            {
                query = query.Where(t => t.TenCongTrinhKhoaHoc.Contains(searchTerm) ||
                                        t.MaTaiNCKH.Contains(searchTerm));
            }

            if (!string.IsNullOrEmpty(namHoc))
            {
                query = query.Where(t => t.NamHoc == namHoc);
            }

            if (!string.IsNullOrEmpty(maLoaiNCKH))
            {
                query = query.Where(t => t.MaLoaiNCKH == maLoaiNCKH);
            }

            return await query
                .OrderByDescending(t => t.NamHoc)
                .ThenBy(t => t.TenCongTrinhKhoaHoc)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maTaiNCKH)> AddTaiNCKHAsync(TaiNCKH taiNCKH)
        {
            try
            {
                // Sử dụng stored procedure
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

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_TaiNCKH_ThemMoi @TenCongTrinhKhoaHoc, @NamHoc, @SoTacGia, @MaLoaiNCKH, @MaTaiNCKH OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenCongTrinhKhoaHoc", taiNCKH.TenCongTrinhKhoaHoc),
                    new SqlParameter("@NamHoc", taiNCKH.NamHoc),
                    new SqlParameter("@SoTacGia", taiNCKH.SoTacGia),
                    new SqlParameter("@MaLoaiNCKH", taiNCKH.MaLoaiNCKH),
                    maTaiNCKHParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maTaiNCKH = maTaiNCKHParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(maTaiNCKH);

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
                // Kiểm tra có chi tiết giảng dạy không
                var hasChiTiet = await _context.ChiTietNCKHs.AnyAsync(c => c.MaTaiNCKH== maTaiNCKH);
                if (hasChiTiet)
                {
                    return (false, "Không thể xóa tài giảng dạy đã có phân công giáo viên");
                }

                var taiNCKH = await _context.TaiNCKHs.FindAsync(maTaiNCKH);
                if (taiNCKH == null)
                {
                    return (false, "Không tìm thấy tài giảng dạy");
                }

                _context.TaiNCKHs.Remove(taiNCKH);
                await _context.SaveChangesAsync();
                return (true, "Xóa tài giảng dạy thành công");
            }
            
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa tài NCKH: {ex.Message}");
            }
        }
        #endregion

        #region Quản lý chi tiết NCKH
        public async Task<List<ChiTietNCKH>> GetChiTietNCKHByTaiNCKHAsync(string maTaiNCKH)
        {
            return await _context.ChiTietNCKHs
                .Include(ct => ct.GiaoVien)

                .Where(ct => ct.MaTaiNCKH == maTaiNCKH)
                .OrderBy(ct => ct.VaiTro)
                .ThenBy(ct => ct.GiaoVien.HoTen)
                .ToListAsync();
        }

        public async Task<List<ChiTietNCKH>> GetChiTietNCKHByGiaoVienAsync(string maGV, string namHoc = null)
        {
            var query = _context.ChiTietNCKHs
                .Include(ct => ct.TaiNCKH)
                .ThenInclude(t => t.LoaiNCKH)
                .Include(ct => ct.GiaoVien)
                .Where(ct => ct.MaGV == maGV);

            if (!string.IsNullOrEmpty(namHoc))
            {
                query = query.Where(ct => ct.TaiNCKH.NamHoc == namHoc);
            }

            return await query
                .OrderByDescending(ct => ct.TaiNCKH.NamHoc)
                .ThenBy(ct => ct.TaiNCKH.TenCongTrinhKhoaHoc)
                .ToListAsync();
        }

        public async Task<ChiTietNCKH> GetChiTietNCKHByIdAsync(string maChiTietNCKH)
        {
            return await _context.ChiTietNCKHs
                .Include(ct => ct.GiaoVien)
                .Include(ct => ct.TaiNCKH)
                .ThenInclude(t => t.LoaiNCKH)
                .FirstOrDefaultAsync(ct => ct.MaChiTietNCKH == maChiTietNCKH);
        }

        public async Task<(bool success, string message, string maChiTietNCKH)> AddChiTietNCKHAsync(ChiTietNCKH chiTietNCKH)
        {
            try
            {
                // Sử dụng stored procedure
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

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_NCKH_PhanCong @MaGV, @MaTaiNCKH, @VaiTro, @SoGio, @MaChiTietNCKH OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", chiTietNCKH.MaGV),
                    new SqlParameter("@MaTaiNCKH", chiTietNCKH.MaTaiNCKH),
                    new SqlParameter("@VaiTro", chiTietNCKH.VaiTro),
                    new SqlParameter("@SoGio", chiTietNCKH.SoGio),
                    maChiTietNCKHParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maChiTietNCKH = maChiTietNCKHParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(maChiTietNCKH);

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
                // Sử dụng stored procedure
                var errorMessageParam = new SqlParameter
                {
                    ParameterName = "@ErrorMessage",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 500,
                    Direction = ParameterDirection.Output
                };

                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_NCKH_CapNhat @MaChiTietNCKH, @VaiTro, @SoGio, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaChiTietNCKH", chiTietNCKH.MaChiTietNCKH),
                    new SqlParameter("@VaiTro", chiTietNCKH.VaiTro),
                    new SqlParameter("@SoGio", chiTietNCKH.SoGio),
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
            try
            {
                // Sử dụng stored procedure
                var errorMessageParam = new SqlParameter
                {
                    ParameterName = "@ErrorMessage",
                    SqlDbType = SqlDbType.NVarChar,
                    Size = 500,
                    Direction = ParameterDirection.Output
                };

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
        #endregion

        #region Báo cáo và thống kê
        public async Task<dynamic> GetThongKeNCKHTongQuanAsync(string namHoc = null, string maKhoa = null, string maBM = null)
        {
            try
            {
                var parameters = new List<SqlParameter>
                {
                    new SqlParameter("@NamHoc", (object)namHoc ?? DBNull.Value),
                    new SqlParameter("@MaKhoa", (object)maKhoa ?? DBNull.Value),
                    new SqlParameter("@MaBM", (object)maBM ?? DBNull.Value)
                };

                var result = await _context.Database
                    .SqlQueryRaw<dynamic>("EXEC sp_BaoCao_ThongKeNCKHTongQuan @NamHoc, @MaKhoa, @MaBM", parameters.ToArray())
                    .ToListAsync();

                return result;
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy thống kê NCKH tổng quan: {ex.Message}");
            }
        }

        public async Task<List<dynamic>> GetTopGiaoVienNCKHXuatSacAsync(string namHoc = null, int topN = 20, string maKhoa = null)
        {
            try
            {
                var parameters = new List<SqlParameter>
                {
                    new SqlParameter("@NamHoc", (object)namHoc ?? DBNull.Value),
                    new SqlParameter("@TopN", topN),
                    new SqlParameter("@MaKhoa", (object)maKhoa ?? DBNull.Value)
                };

                var result = await _context.Database
                    .SqlQueryRaw<dynamic>("EXEC sp_BaoCao_TopGiaoVienNCKHXuatSac @NamHoc, @TopN, @MaKhoa", parameters.ToArray())
                    .ToListAsync();

                return result;
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy top giáo viên NCKH xuất sắc: {ex.Message}");
            }
        }

        public async Task<List<dynamic>> GetThongKeNCKHTheoKhoaAsync(string namHoc = null)
        {
            var query = from ct in _context.ChiTietNCKHs
                        join t in _context.TaiNCKHs on ct.MaTaiNCKH equals t.MaTaiNCKH
                        join gv in _context.GiaoViens on ct.MaGV equals gv.MaGV
                        join bm in _context.BoMons on gv.MaBM equals bm.MaBM
                        join k in _context.Khoas on bm.MaKhoa equals k.MaKhoa
                        where namHoc == null || t.NamHoc == namHoc
                        group new { ct, t, gv, k } by new { k.MaKhoa, k.TenKhoa } into g
                        select new
                        {
                            MaKhoa = g.Key.MaKhoa,
                            TenKhoa = g.Key.TenKhoa,
                            SoCongTrinh = g.Select(x => x.t.MaTaiNCKH).Distinct().Count(),
                            SoGiaoVienThamGia = g.Select(x => x.gv.MaGV).Distinct().Count(),
                            TongSoGio = g.Sum(x => x.ct.SoGio)
                        };

            return await query.Cast<dynamic>().ToListAsync();
        }

        public async Task<List<dynamic>> GetThongKeNCKHTheoBoMonAsync(string namHoc = null, string maKhoa = null)
        {
            var query = from ct in _context.ChiTietNCKHs
                        join t in _context.TaiNCKHs on ct.MaTaiNCKH equals t.MaTaiNCKH
                        join gv in _context.GiaoViens on ct.MaGV equals gv.MaGV
                        join bm in _context.BoMons on gv.MaBM equals bm.MaBM
                        join k in _context.Khoas on bm.MaKhoa equals k.MaKhoa
                        where (namHoc == null || t.NamHoc == namHoc) &&
                              (maKhoa == null || k.MaKhoa == maKhoa)
                        group new { ct, t, gv, bm, k } by new { bm.MaBM, bm.TenBM, k.TenKhoa } into g
                        select new
                        {
                            MaBM = g.Key.MaBM,
                            TenBM = g.Key.TenBM,
                            TenKhoa = g.Key.TenKhoa,
                            SoCongTrinh = g.Select(x => x.t.MaTaiNCKH).Distinct().Count(),
                            SoGiaoVienThamGia = g.Select(x => x.gv.MaGV).Distinct().Count(),
                            TongSoGio = g.Sum(x => x.ct.SoGio)
                        };

            return await query.Cast<dynamic>().ToListAsync();
        }
        #endregion

        #region Tiện ích
        public async Task<List<string>> GetAvailableNamHocAsync()
        {
            return await _context.TaiNCKHs
                .Select(t => t.NamHoc)
                .Distinct()
                .OrderByDescending(n => n)
                .ToListAsync();
        }

        public async Task<bool> CheckTaiNCKHExistsAsync(string maTaiNCKH)
        {
            return await _context.TaiNCKHs.AnyAsync(t => t.MaTaiNCKH == maTaiNCKH);
        }

        public async Task<bool> CheckChiTietNCKHExistsAsync(string maGV, string maTaiNCKH)
        {
            return await _context.ChiTietNCKHs
                .AnyAsync(ct => ct.MaGV == maGV && ct.MaTaiNCKH == maTaiNCKH);
        }

        public async Task<int> GetSoTacGiaHienTaiAsync(string maTaiNCKH)
        {
            return await _context.ChiTietNCKHs
                .CountAsync(ct => ct.MaTaiNCKH == maTaiNCKH);
        }
        #endregion
    }
}