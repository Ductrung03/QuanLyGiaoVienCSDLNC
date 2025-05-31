using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class HoiDongRepository : IHoiDongRepository
    {
        private readonly ApplicationDbContext _context;

        public HoiDongRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        // Quản lý loại hội đồng
        public async Task<List<LoaiHoiDong>> GetAllLoaiHoiDongAsync()
        {
            return await _context.LoaiHoiDongs.ToListAsync();
        }

        public async Task<LoaiHoiDong> GetLoaiHoiDongByIdAsync(string maLoaiHoiDong)
        {
            return await _context.LoaiHoiDongs.FindAsync(maLoaiHoiDong);
        }

        // Quản lý tài hội đồng
        public async Task<List<TaiHoiDong>> GetAllTaiHoiDongAsync()
        {
            return await _context.TaiHoiDongs
                .Include(t => t.LoaiHoiDong)
                .OrderByDescending(t => t.ThoiGianBatDau)
                .ToListAsync();
        }

        public async Task<TaiHoiDong> GetTaiHoiDongByIdAsync(string maHoiDong)
        {
            return await _context.TaiHoiDongs
                .Include(t => t.LoaiHoiDong)
                .FirstOrDefaultAsync(t => t.MaHoiDong == maHoiDong);
        }

        public async Task<List<TaiHoiDong>> GetTaiHoiDongByNamHocAsync(string namHoc)
        {
            return await _context.TaiHoiDongs
                .Include(t => t.LoaiHoiDong)
                .Where(t => t.NamHoc == namHoc)
                .OrderBy(t => t.ThoiGianBatDau)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maHoiDong)> AddTaiHoiDongAsync(TaiHoiDong taiHoiDong)
        {
            var maHoiDongParam = new SqlParameter
            {
                ParameterName = "@MaHoiDong",
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
                    "EXEC sp_HoiDong_ThemMoi @SoLuong, @NamHoc, @ThoiGianBatDau, @ThoiGianKetThuc, @GhiChu, @MaLoaiHoiDong, @MaHoiDong OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@SoLuong", taiHoiDong.SoLuong),
                    new SqlParameter("@NamHoc", taiHoiDong.NamHoc),
                    new SqlParameter("@ThoiGianBatDau", taiHoiDong.ThoiGianBatDau),
                    new SqlParameter("@ThoiGianKetThuc", taiHoiDong.ThoiGianKetThuc),
                    new SqlParameter("@GhiChu", taiHoiDong.GhiChu ?? (object)DBNull.Value),
                    new SqlParameter("@MaLoaiHoiDong", taiHoiDong.MaLoaiHoiDong),
                    maHoiDongParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maHoiDong = maHoiDongParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maHoiDong);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm hội đồng: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateTaiHoiDongAsync(TaiHoiDong taiHoiDong)
        {
            try
            {
                _context.TaiHoiDongs.Update(taiHoiDong);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật hội đồng thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật hội đồng: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteTaiHoiDongAsync(string maHoiDong)
        {
            try
            {
                var taiHoiDong = await _context.TaiHoiDongs.FindAsync(maHoiDong);
                if (taiHoiDong == null)
                    return (false, "Không tìm thấy hội đồng");

                // Kiểm tra xem có thành viên nào không
                var hasMembers = await _context.ThamGias.AnyAsync(tg => tg.MaHoiDong == maHoiDong);
                if (hasMembers)
                    return (false, "Không thể xóa vì hội đồng đã có thành viên");

                _context.TaiHoiDongs.Remove(taiHoiDong);
                await _context.SaveChangesAsync();
                return (true, "Xóa hội đồng thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa hội đồng: {ex.Message}");
            }
        }

        // Quản lý thành viên hội đồng
        public async Task<List<ThamGia>> GetThanhVienHoiDongAsync(string maHoiDong)
        {
            return await _context.ThamGias
                .Include(tg => tg.GiaoVien)
                .ThenInclude(gv => gv.BoMon)
                .Where(tg => tg.MaHoiDong == maHoiDong)
                .ToListAsync();
        }

        public async Task<List<ThamGia>> GetHoiDongByGiaoVienAsync(string maGV)
        {
            return await _context.ThamGias
                .Include(tg => tg.TaiHoiDong)
                .ThenInclude(hd => hd.LoaiHoiDong)
                .Where(tg => tg.MaGV == maGV)
                .OrderByDescending(tg => tg.TaiHoiDong.ThoiGianBatDau)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maThamGia)> ThemThanhVienHoiDongAsync(string maGV, string maHoiDong, float soGio)
        {
            var maThamGiaParam = new SqlParameter
            {
                ParameterName = "@MaThamGia",
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
                    "EXEC sp_HoiDong_ThemThanhVien @MaGV, @MaHoiDong, @SoGio, @MaThamGia OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaHoiDong", maHoiDong),
                    new SqlParameter("@SoGio", soGio),
                    maThamGiaParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maThamGia = maThamGiaParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maThamGia);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm thành viên hội đồng: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateThamGiaAsync(ThamGia thamGia)
        {
            try
            {
                _context.ThamGias.Update(thamGia);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật thành viên hội đồng thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật thành viên hội đồng: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> XoaThanhVienHoiDongAsync(string maThamGia)
        {
            try
            {
                var thamGia = await _context.ThamGias.FindAsync(maThamGia);
                if (thamGia == null)
                    return (false, "Không tìm thấy thành viên hội đồng");

                _context.ThamGias.Remove(thamGia);
                await _context.SaveChangesAsync();
                return (true, "Xóa thành viên hội đồng thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa thành viên hội đồng: {ex.Message}");
            }
        }
    }
}