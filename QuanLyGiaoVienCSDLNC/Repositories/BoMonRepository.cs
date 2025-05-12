using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class BoMonRepository : IBoMonRepository
    {
        private readonly ApplicationDbContext _context;

        public BoMonRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<List<BoMon>> GetAllBoMonAsync()
        {
            return await _context.BoMons.Include(b => b.Khoa).ToListAsync();
        }

        public async Task<BoMon> GetBoMonByIdAsync(string maBM)
        {
            return await _context.BoMons.Include(b => b.Khoa).FirstOrDefaultAsync(b => b.MaBM == maBM);
        }

        public async Task<List<BoMon>> GetBoMonByKhoaIdAsync(string maKhoa)
        {
            return await _context.BoMons.Where(b => b.MaKhoa == maKhoa).ToListAsync();
        }

        public async Task<(bool success, string message, string maBM)> AddBoMonAsync(BoMon boMon)
        {
            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 200,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_ThemBoMon @TenBM, @DiaChi, @MaKhoa, @MaChuNhiemBM, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenBM", boMon.TenBM),
                    new SqlParameter("@DiaChi", boMon.DiaChi ?? (object)DBNull.Value),
                    new SqlParameter("@MaKhoa", boMon.MaKhoa),
                    new SqlParameter("@MaChuNhiemBM", boMon.MaChuNhiemBM ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !errorMessage.StartsWith("Lỗi");

                // Extract MaBM from success message
                string maBM = null;
                if (isSuccess && errorMessage.Contains("Mã bộ môn:"))
                {
                    var parts = errorMessage.Split(':');
                    if (parts.Length > 1)
                    {
                        maBM = parts[1].Trim();
                    }
                }

                return (isSuccess, errorMessage, maBM);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm bộ môn: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateBoMonAsync(BoMon boMon)
        {
            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 200,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_SuaBoMon @MaBM, @TenBM, @DiaChi, @MaKhoa, @MaChuNhiemBM, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaBM", boMon.MaBM),
                    new SqlParameter("@TenBM", boMon.TenBM),
                    new SqlParameter("@DiaChi", boMon.DiaChi ?? (object)DBNull.Value),
                    new SqlParameter("@MaKhoa", boMon.MaKhoa),
                    new SqlParameter("@MaChuNhiemBM", boMon.MaChuNhiemBM ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật bộ môn: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteBoMonAsync(string maBM)
        {
            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 200,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_XoaBoMon @MaBM, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaBM", maBM),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa bộ môn: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> PhanCongChuNhiemBoMonAsync(string maBM, string maGV)
        {
            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 200,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_PhanCongChuNhiemBoMon @MaBM, @MaGV, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaBM", maBM),
                    new SqlParameter("@MaGV", maGV),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công chủ nhiệm bộ môn: {ex.Message}");
            }
        }
    }

}
