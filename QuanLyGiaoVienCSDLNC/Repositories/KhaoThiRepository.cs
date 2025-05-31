using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class KhaoThiRepository : IKhaoThiRepository
    {
        private readonly ApplicationDbContext _context;

        public KhaoThiRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        // Quản lý loại công tác khảo thí
        public async Task<List<LoaiCongTacKhaoThi>> GetAllLoaiCongTacKhaoThiAsync()
        {
            return await _context.LoaiCongTacKhaoThis.ToListAsync();
        }

        public async Task<LoaiCongTacKhaoThi> GetLoaiCongTacKhaoThiByIdAsync(string maLoaiCongTacKhaoThi)
        {
            return await _context.LoaiCongTacKhaoThis.FindAsync(maLoaiCongTacKhaoThi);
        }

        // Quản lý tài khảo thí
        public async Task<List<TaiKhaoThi>> GetAllTaiKhaoThiAsync()
        {
            return await _context.TaiKhaoThis
                .Include(t => t.LoaiCongTacKhaoThi)
                .OrderByDescending(t => t.NamHoc)
                .ThenBy(t => t.HocPhan)
                .ToListAsync();
        }

        public async Task<TaiKhaoThi> GetTaiKhaoThiByIdAsync(string maTaiKhaoThi)
        {
            return await _context.TaiKhaoThis
                .Include(t => t.LoaiCongTacKhaoThi)
                .FirstOrDefaultAsync(t => t.MaTaiKhaoThi == maTaiKhaoThi);
        }

        public async Task<List<TaiKhaoThi>> GetTaiKhaoThiByNamHocAsync(string namHoc)
        {
            return await _context.TaiKhaoThis
                .Include(t => t.LoaiCongTacKhaoThi)
                .Where(t => t.NamHoc == namHoc)
                .OrderBy(t => t.HocPhan)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maTaiKhaoThi)> AddTaiKhaoThiAsync(TaiKhaoThi taiKhaoThi)
        {
            var maTaiKhaoThiParam = new SqlParameter
            {
                ParameterName = "@MaTaiKhaoThi",
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
                    "EXEC sp_KhaoThi_ThemTai @HocPhan, @Lop, @NamHoc, @GhiChu, @MaLoaiCongTacKhaoThi, @MaTaiKhaoThi OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@HocPhan", taiKhaoThi.HocPhan),
                    new SqlParameter("@Lop", taiKhaoThi.Lop),
                    new SqlParameter("@NamHoc", taiKhaoThi.NamHoc),
                    new SqlParameter("@GhiChu", taiKhaoThi.GhiChu ?? (object)DBNull.Value),
                    new SqlParameter("@MaLoaiCongTacKhaoThi", taiKhaoThi.MaLoaiCongTacKhaoThi),
                    maTaiKhaoThiParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maTaiKhaoThi = maTaiKhaoThiParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maTaiKhaoThi);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm tài khảo thí: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateTaiKhaoThiAsync(TaiKhaoThi taiKhaoThi)
        {
            try
            {
                _context.TaiKhaoThis.Update(taiKhaoThi);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật tài khảo thí thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật tài khảo thí: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteTaiKhaoThiAsync(string maTaiKhaoThi)
        {
            try
            {
                var taiKhaoThi = await _context.TaiKhaoThis.FindAsync(maTaiKhaoThi);
                if (taiKhaoThi == null)
                    return (false, "Không tìm thấy tài khảo thí");

                // Kiểm tra xem có chi tiết khảo thí nào không
                var hasDetails = await _context.ChiTietTaiKhaoThis.AnyAsync(ct => ct.MaTaiKhaoThi == maTaiKhaoThi);
                if (hasDetails)
                    return (false, "Không thể xóa vì có chi tiết khảo thí liên quan");

                _context.TaiKhaoThis.Remove(taiKhaoThi);
                await _context.SaveChangesAsync();
                return (true, "Xóa tài khảo thí thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa tài khảo thí: {ex.Message}");
            }
        }

        // Quản lý chi tiết tài khảo thí
        public async Task<List<ChiTietTaiKhaoThi>> GetChiTietTaiKhaoThiByMaGVAsync(string maGV)
        {
            return await _context.ChiTietTaiKhaoThis
                .Include(ct => ct.TaiKhaoThi)
                .ThenInclude(t => t.LoaiCongTacKhaoThi)
                .Where(ct => ct.MaGV == maGV)
                .OrderByDescending(ct => ct.TaiKhaoThi.NamHoc)
                .ToListAsync();
        }

        public async Task<List<ChiTietTaiKhaoThi>> GetChiTietTaiKhaoThiByMaTaiKhaoThiAsync(string maTaiKhaoThi)
        {
            return await _context.ChiTietTaiKhaoThis
                .Include(ct => ct.GiaoVien)
                .Where(ct => ct.MaTaiKhaoThi == maTaiKhaoThi)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maChiTietTaiKhaoThi)> PhanCongKhaoThiAsync(string maGV, string maTaiKhaoThi, int soBai)
        {
            var maChiTietTaiKhaoThiParam = new SqlParameter
            {
                ParameterName = "@MaChiTietTaiKhaoThi",
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
                    "EXEC sp_KhaoThi_PhanCong @MaGV, @MaTaiKhaoThi, @SoBai, @MaChiTietTaiKhaoThi OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaTaiKhaoThi", maTaiKhaoThi),
                    new SqlParameter("@SoBai", soBai),
                    maChiTietTaiKhaoThiParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maChiTietTaiKhaoThi = maChiTietTaiKhaoThiParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maChiTietTaiKhaoThi);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công khảo thí: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateChiTietTaiKhaoThiAsync(ChiTietTaiKhaoThi chiTietTaiKhaoThi)
        {
            try
            {
                _context.ChiTietTaiKhaoThis.Update(chiTietTaiKhaoThi);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật chi tiết khảo thí thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật chi tiết khảo thí: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteChiTietTaiKhaoThiAsync(string maChiTietTaiKhaoThi)
        {
            try
            {
                var chiTiet = await _context.ChiTietTaiKhaoThis.FindAsync(maChiTietTaiKhaoThi);
                if (chiTiet == null)
                    return (false, "Không tìm thấy chi tiết khảo thí");

                _context.ChiTietTaiKhaoThis.Remove(chiTiet);
                await _context.SaveChangesAsync();
                return (true, "Xóa chi tiết khảo thí thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa chi tiết khảo thí: {ex.Message}");
            }
        }
    }
}