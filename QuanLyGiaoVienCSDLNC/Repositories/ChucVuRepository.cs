using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class ChucVuRepository : IChucVuRepository
    {
        private readonly ApplicationDbContext _context;

        public ChucVuRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        // Quản lý chức vụ
        public async Task<List<ChucVu>> GetAllChucVuAsync()
        {
            return await _context.ChucVus
                .Include(cv => cv.DinhMucMienGiam)
                .ToListAsync();
        }

        public async Task<ChucVu> GetChucVuByIdAsync(string maChucVu)
        {
            return await _context.ChucVus
                .Include(cv => cv.DinhMucMienGiam)
                .FirstOrDefaultAsync(cv => cv.MaChucVu == maChucVu);
        }

        public async Task<(bool success, string message)> AddChucVuAsync(ChucVu chucVu)
        {
            try
            {
                // Generate MaChucVu
                var count = await _context.ChucVus.CountAsync() + 1;
                chucVu.MaChucVu = "CV" + count.ToString("D3");

                _context.ChucVus.Add(chucVu);
                await _context.SaveChangesAsync();
                return (true, "Thêm chức vụ thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm chức vụ: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> UpdateChucVuAsync(ChucVu chucVu)
        {
            try
            {
                _context.ChucVus.Update(chucVu);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật chức vụ thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật chức vụ: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteChucVuAsync(string maChucVu)
        {
            try
            {
                var chucVu = await _context.ChucVus.FindAsync(maChucVu);
                if (chucVu == null)
                    return (false, "Không tìm thấy chức vụ");

                // Kiểm tra xem có lịch sử chức vụ nào không
                var hasHistory = await _context.LichSuChucVus.AnyAsync(ls => ls.MaChucVu == maChucVu);
                if (hasHistory)
                    return (false, "Không thể xóa vì có lịch sử chức vụ liên quan");

                _context.ChucVus.Remove(chucVu);
                await _context.SaveChangesAsync();
                return (true, "Xóa chức vụ thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa chức vụ: {ex.Message}");
            }
        }

        // Quản lý lịch sử chức vụ
        public async Task<List<LichSuChucVu>> GetLichSuChucVuByGiaoVienAsync(string maGV)
        {
            return await _context.LichSuChucVus
                .Include(ls => ls.ChucVu)
                .ThenInclude(cv => cv.DinhMucMienGiam)
                .Where(ls => ls.MaGV == maGV)
                .OrderByDescending(ls => ls.NgayNhan)
                .ToListAsync();
        }

        public async Task<List<LichSuChucVu>> GetChucVuHienTaiAsync()
        {
            return await _context.LichSuChucVus
                .Include(ls => ls.GiaoVien)
                .Include(ls => ls.ChucVu)
                .Where(ls => ls.NgayKetThuc == null)
                .OrderBy(ls => ls.GiaoVien.HoTen)
                .ToListAsync();
        }

        public async Task<LichSuChucVu> GetChucVuHienTaiByGiaoVienAsync(string maGV)
        {
            return await _context.LichSuChucVus
                .Include(ls => ls.ChucVu)
                .ThenInclude(cv => cv.DinhMucMienGiam)
                .Where(ls => ls.MaGV == maGV && ls.NgayKetThuc == null)
                .OrderByDescending(ls => ls.NgayNhan)
                .FirstOrDefaultAsync();
        }

        public async Task<(bool success, string message)> PhanCongChucVuAsync(string maGV, string maChucVu, DateTime? ngayNhan)
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
                    "EXEC sp_ChucVu_PhanCong @MaGV, @MaChucVu, @NgayNhan, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaChucVu", maChucVu),
                    new SqlParameter("@NgayNhan", ngayNhan ?? DateTime.Now),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công chức vụ: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> KetThucChucVuAsync(string maGV, string maChucVu, DateTime? ngayKetThuc)
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
                    "EXEC sp_ChucVu_KetThuc @MaGV, @MaChucVu, @NgayKetThuc, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaChucVu", maChucVu),
                    new SqlParameter("@NgayKetThuc", ngayKetThuc ?? DateTime.Now),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi kết thúc chức vụ: {ex.Message}");
            }
        }

        // Định mức miễn giảm
        public async Task<List<DinhMucMienGiam>> GetAllDinhMucMienGiamAsync()
        {
            return await _context.DinhMucMienGiams.ToListAsync();
        }

        public async Task<DinhMucMienGiam> GetDinhMucMienGiamByIdAsync(string maDinhMucMienGiam)
        {
            return await _context.DinhMucMienGiams.FindAsync(maDinhMucMienGiam);
        }

        public async Task<(bool success, string message)> CapNhatDinhMucMienGiamAsync(string maChucVu, string maDinhMucMienGiam)
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
                    "EXEC sp_DinhMucMienGiam_CapNhat @MaChucVu, @MaDinhMucMienGiam, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaChucVu", maChucVu),
                    new SqlParameter("@MaDinhMucMienGiam", maDinhMucMienGiam),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật định mức miễn giảm: {ex.Message}");
            }
        }
    }
}