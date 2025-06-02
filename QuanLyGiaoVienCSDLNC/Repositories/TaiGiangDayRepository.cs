using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class GiangDayRepository : IGiangDayRepository
    {
        private readonly ApplicationDbContext _context;

        public GiangDayRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        #region TaiGiangDay CRUD

        public async Task<List<TaiGiangDay>> GetAllTaiGiangDayAsync()
        {
            return await _context.TaiGiangDays
                .Include(t => t.DoiTuongGiangDay)
                .Include(t => t.ThoiGianGiangDay)
                .Include(t => t.NgonNguGiangDay)
                .Include(t => t.ChiTietGiangDays)
                    .ThenInclude(c => c.GiaoVien)
                .OrderByDescending(t => t.NamHoc)
                .ThenBy(t => t.TenHocPhan)
                .ToListAsync();
        }

        public async Task<TaiGiangDay> GetTaiGiangDayByIdAsync(string maTaiGiangDay)
        {
            return await _context.TaiGiangDays
                .Include(t => t.DoiTuongGiangDay)
                .Include(t => t.ThoiGianGiangDay)
                .Include(t => t.NgonNguGiangDay)
                .Include(t => t.ChiTietGiangDays)
                    .ThenInclude(c => c.GiaoVien)
                        .ThenInclude(g => g.BoMon)
                .FirstOrDefaultAsync(t => t.MaTaiGiangDay == maTaiGiangDay);
        }

        public async Task<List<TaiGiangDay>> SearchTaiGiangDayAsync(string searchTerm = null, string namHoc = null, string he = null, string maDoiTuong = null)
        {
            var query = _context.TaiGiangDays
                .Include(t => t.DoiTuongGiangDay)
                .Include(t => t.ThoiGianGiangDay)
                .Include(t => t.NgonNguGiangDay)
                .Include(t => t.ChiTietGiangDays)
                .AsQueryable();

            if (!string.IsNullOrEmpty(searchTerm))
            {
                query = query.Where(t => t.TenHocPhan.Contains(searchTerm) ||
                                        t.Lop.Contains(searchTerm) ||
                                        t.MaTaiGiangDay.Contains(searchTerm));
            }

            if (!string.IsNullOrEmpty(namHoc))
            {
                query = query.Where(t => t.NamHoc == namHoc);
            }

            if (!string.IsNullOrEmpty(he))
            {
                query = query.Where(t => t.He == he);
            }

            if (!string.IsNullOrEmpty(maDoiTuong))
            {
                query = query.Where(t => t.MaDoiTuong == maDoiTuong);
            }

            return await query
                .OrderByDescending(t => t.NamHoc)
                .ThenBy(t => t.TenHocPhan)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maTaiGiangDay)> AddTaiGiangDayAsync(TaiGiangDay taiGiangDay)
        {
            var maTaiGiangDayParam = new SqlParameter
            {
                ParameterName = "@MaTaiGiangDay",
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
                    "EXEC sp_TaiGiangDay_ThemMoi @TenHocPhan, @SiSo, @He, @Lop, @SoTinChi, @GhiChu, @NamHoc, @MaDoiTuong, @MaThoiGian, @MaNgonNgu, @MaTaiGiangDay OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenHocPhan", taiGiangDay.TenHocPhan),
                    new SqlParameter("@SiSo", taiGiangDay.SiSo),
                    new SqlParameter("@He", taiGiangDay.He),
                    new SqlParameter("@Lop", taiGiangDay.Lop),
                    new SqlParameter("@SoTinChi", taiGiangDay.SoTinChi),
                    new SqlParameter("@GhiChu", taiGiangDay.GhiChu ?? (object)DBNull.Value),
                    new SqlParameter("@NamHoc", taiGiangDay.NamHoc),
                    new SqlParameter("@MaDoiTuong", taiGiangDay.MaDoiTuong),
                    new SqlParameter("@MaThoiGian", taiGiangDay.MaThoiGian),
                    new SqlParameter("@MaNgonNgu", taiGiangDay.MaNgonNgu),
                    maTaiGiangDayParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maTaiGiangDay = maTaiGiangDayParam.Value?.ToString();

                var isSuccess = !string.IsNullOrEmpty(maTaiGiangDay);
                return (isSuccess, errorMessage, maTaiGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm tài giảng dạy: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateTaiGiangDayAsync(TaiGiangDay taiGiangDay)
        {
            try
            {
                var existing = await _context.TaiGiangDays.FindAsync(taiGiangDay.MaTaiGiangDay);
                if (existing == null)
                {
                    return (false, "Không tìm thấy tài giảng dạy");
                }

                existing.TenHocPhan = taiGiangDay.TenHocPhan;
                existing.SiSo = taiGiangDay.SiSo;
                existing.He = taiGiangDay.He;
                existing.Lop = taiGiangDay.Lop;
                existing.SoTinChi = taiGiangDay.SoTinChi;
                existing.GhiChu = taiGiangDay.GhiChu;
                existing.NamHoc = taiGiangDay.NamHoc;
                existing.MaDoiTuong = taiGiangDay.MaDoiTuong;
                existing.MaThoiGian = taiGiangDay.MaThoiGian;
                existing.MaNgonNgu = taiGiangDay.MaNgonNgu;

                await _context.SaveChangesAsync();
                return (true, "Cập nhật tài giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteTaiGiangDayAsync(string maTaiGiangDay)
        {
            try
            {
                // Kiểm tra có chi tiết giảng dạy không
                var hasChiTiet = await _context.ChiTietGiangDays.AnyAsync(c => c.MaTaiGiangDay == maTaiGiangDay);
                if (hasChiTiet)
                {
                    return (false, "Không thể xóa tài giảng dạy đã có phân công giáo viên");
                }

                var taiGiangDay = await _context.TaiGiangDays.FindAsync(maTaiGiangDay);
                if (taiGiangDay == null)
                {
                    return (false, "Không tìm thấy tài giảng dạy");
                }

                _context.TaiGiangDays.Remove(taiGiangDay);
                await _context.SaveChangesAsync();
                return (true, "Xóa tài giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa tài giảng dạy: {ex.Message}");
            }
        }

        #endregion

        #region ChiTietGiangDay Operations

        public async Task<List<ChiTietGiangDay>> GetChiTietGiangDayByTaiGiangDayAsync(string maTaiGiangDay)
        {
            return await _context.ChiTietGiangDays
                .Include(c => c.GiaoVien)
                    .ThenInclude(g => g.BoMon)
                .Include(c => c.TaiGiangDay)
                .Where(c => c.MaTaiGiangDay == maTaiGiangDay)
                .OrderBy(c => c.GiaoVien.HoTen)
                .ToListAsync();
        }

        public async Task<List<ChiTietGiangDay>> GetChiTietGiangDayByGiaoVienAsync(string maGV, string namHoc = null)
        {
            var query = _context.ChiTietGiangDays
                .Include(c => c.TaiGiangDay)
                    .ThenInclude(t => t.DoiTuongGiangDay)
                .Include(c => c.TaiGiangDay)
                    .ThenInclude(t => t.ThoiGianGiangDay)
                .Include(c => c.TaiGiangDay)
                    .ThenInclude(t => t.NgonNguGiangDay)
                .Where(c => c.MaGV == maGV);

            if (!string.IsNullOrEmpty(namHoc))
            {
                query = query.Where(c => c.TaiGiangDay.NamHoc == namHoc);
            }

            return await query
                .OrderByDescending(c => c.TaiGiangDay.NamHoc)
                .ThenBy(c => c.TaiGiangDay.TenHocPhan)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maChiTietGiangDay)> PhanCongGiangDayAsync(string maGV, string maTaiGiangDay, int soTiet, string ghiChu = null, string NoiDungGiangDay = null, bool checkConflict = true)
        {
            var maChiTietGiangDayParam = new SqlParameter
            {
                ParameterName = "@MaChiTietGiangDay",
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
                    "EXEC sp_GiangDay_PhanCong @MaGV, @MaTaiGiangDay, @SoTiet, @GhiChu, @NoiDungGiangDay, @CheckConflict, @MaChiTietGiangDay OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaTaiGiangDay", maTaiGiangDay),
                    new SqlParameter("@SoTiet", soTiet),
                    new SqlParameter("@GhiChu", ghiChu ?? (object)DBNull.Value),
                    new SqlParameter("@NoiDungGiangDay", NoiDungGiangDay ?? (object)DBNull.Value),
                    new SqlParameter("@CheckConflict", checkConflict),
                    maChiTietGiangDayParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maChiTietGiangDay = maChiTietGiangDayParam.Value?.ToString();

                var isSuccess = !string.IsNullOrEmpty(maChiTietGiangDay);
                return (isSuccess, errorMessage, maChiTietGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công giảng dạy: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateChiTietGiangDayAsync(string maChiTietGiangDay, int soTiet, string ghiChu)
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
                    "EXEC sp_GiangDay_CapNhat @MaChiTietGiangDay, @SoTiet, @GhiChu, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaChiTietGiangDay", maChiTietGiangDay),
                    new SqlParameter("@SoTiet", soTiet),
                    new SqlParameter("@GhiChu", ghiChu ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = errorMessage.Contains("thành công");
                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật chi tiết giảng dạy: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> XoaPhanCongGiangDayAsync(string maChiTietGiangDay)
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
                    "EXEC sp_GiangDay_XoaPhanCong @MaChiTietGiangDay, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaChiTietGiangDay", maChiTietGiangDay),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = errorMessage.Contains("thành công");
                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa phân công giảng dạy: {ex.Message}");
            }
        }

        #endregion

        #region Lookup Data

        public async Task<List<DoiTuongGiangDay>> GetAllDoiTuongGiangDayAsync()
        {
            return await _context.DoiTuongGiangDays.OrderBy(d => d.TenDoiTuong).ToListAsync();
        }

        public async Task<List<ThoiGianGiangDay>> GetAllThoiGianGiangDayAsync()
        {
            return await _context.ThoiGianGiangDays.OrderBy(t => t.TenThoiGian).ToListAsync();
        }

        public async Task<List<NgonNguGiangDay>> GetAllNgonNguGiangDayAsync()
        {
            return await _context.NgonNguGiangDays.OrderBy(n => n.TenNgonNgu).ToListAsync();
        }

        public async Task<List<string>> GetDistinctNamHocAsync()
        {
            return await _context.TaiGiangDays
                .Select(t => t.NamHoc)
                .Distinct()
                .OrderByDescending(n => n)
                .ToListAsync();
        }

        public async Task<List<string>> GetDistinctHeAsync()
        {
            return await _context.TaiGiangDays
                .Select(t => t.He)
                .Distinct()
                .OrderBy(h => h)
                .ToListAsync();
        }

        #endregion

        #region Statistics

        public async Task<object> GetThongKeGiangDayAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            try
            {
                // Sử dụng stored procedure báo cáo nếu có, hoặc tính toán từ dữ liệu
                var query = _context.ChiTietGiangDays
                    .Include(c => c.TaiGiangDay)
                    .Include(c => c.GiaoVien)
                        .ThenInclude(g => g.BoMon)
                            .ThenInclude(b => b.Khoa)
                    .AsQueryable();

                if (!string.IsNullOrEmpty(maGV))
                    query = query.Where(c => c.MaGV == maGV);

                if (!string.IsNullOrEmpty(maBM))
                    query = query.Where(c => c.GiaoVien.MaBM == maBM);

                if (!string.IsNullOrEmpty(maKhoa))
                    query = query.Where(c => c.GiaoVien.BoMon.MaKhoa == maKhoa);

                if (!string.IsNullOrEmpty(namHoc))
                    query = query.Where(c => c.TaiGiangDay.NamHoc == namHoc);

                var data = await query.ToListAsync();

                // Chuyển đổi kết quả thành List<object> để tránh lỗi kiểu
                var chiTietList = data.Any()
                    ? data.GroupBy(c => new { c.MaGV, c.GiaoVien.HoTen })
                        .Select(g => (object)new
                        {
                            MaGV = g.Key.MaGV,
                            HoTen = g.Key.HoTen,
                            SoTiet = g.Sum(c => c.SoTiet),
                            SoTietQuyDoi = g.Sum(c => c.SoTietQuyDoi),
                            SoTaiGiangDay = g.Select(c => c.MaTaiGiangDay).Distinct().Count()
                        }).ToList()
                    : new List<object>(); // Danh sách rỗng kiểu List<object>

                return new
                {
                    TongSoTiet = data.Sum(c => c.SoTiet),
                    TongSoTietQuyDoi = data.Sum(c => c.SoTietQuyDoi),
                    SoTaiGiangDay = data.Select(c => c.MaTaiGiangDay).Distinct().Count(),
                    SoGiaoVien = data.Select(c => c.MaGV).Distinct().Count(),
                    ChiTiet = chiTietList // Luôn có property ChiTiet
                };
            }
            catch (Exception ex)
            {
                // Trả về object với cấu trúc mặc định khi có lỗi
                return new
                {
                    TongSoTiet = 0,
                    TongSoTietQuyDoi = 0.0,
                    SoTaiGiangDay = 0,
                    SoGiaoVien = 0,
                    ChiTiet = new List<object>(),
                    ErrorMessage = $"Lỗi khi lấy thống kê giảng dạy: {ex.Message}"
                };
            }
        }
        #endregion
    }
}