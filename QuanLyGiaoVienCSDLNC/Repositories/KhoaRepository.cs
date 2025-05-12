using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class KhoaRepository : IKhoaRepository
    {
        private readonly ApplicationDbContext _context;

        public KhoaRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<List<Khoa>> GetAllKhoaAsync()
        {
            return await _context.Khoas.ToListAsync();
        }

        public async Task<Khoa> GetKhoaByIdAsync(string maKhoa)
        {
            return await _context.Khoas.FirstOrDefaultAsync(k => k.MaKhoa == maKhoa);
        }

        public async Task<(bool success, string message, string maKhoa)> AddKhoaAsync(Khoa khoa)
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
                    "EXEC sp_ThemKhoa @TenKhoa, @DiaChi, @MaChuNhiemKhoa, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenKhoa", khoa.TenKhoa),
                    new SqlParameter("@DiaChi", khoa.DiaChi ?? (object)DBNull.Value),
                    new SqlParameter("@MaChuNhiemKhoa", khoa.MaChuNhiemKhoa ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !errorMessage.StartsWith("Lỗi");

                // Extract MaKhoa from success message
                string maKhoa = null;
                if (isSuccess && errorMessage.Contains("Mã khoa:"))
                {
                    var parts = errorMessage.Split(':');
                    if (parts.Length > 1)
                    {
                        maKhoa = parts[1].Trim();
                    }
                }

                return (isSuccess, errorMessage, maKhoa);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm khoa: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateKhoaAsync(Khoa khoa)
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
                    "EXEC sp_SuaKhoa @MaKhoa, @TenKhoa, @DiaChi, @MaChuNhiemKhoa, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaKhoa", khoa.MaKhoa),
                    new SqlParameter("@TenKhoa", khoa.TenKhoa),
                    new SqlParameter("@DiaChi", khoa.DiaChi ?? (object)DBNull.Value),
                    new SqlParameter("@MaChuNhiemKhoa", khoa.MaChuNhiemKhoa ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật khoa: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteKhoaAsync(string maKhoa)
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
                    "EXEC sp_XoaKhoa @MaKhoa, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaKhoa", maKhoa),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa khoa: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> PhanCongChuNhiemKhoaAsync(string maKhoa, string maGV)
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
                    "EXEC sp_PhanCongChuNhiemKhoa @MaKhoa, @MaGV, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaKhoa", maKhoa),
                    new SqlParameter("@MaGV", maGV),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công chủ nhiệm khoa: {ex.Message}");
            }
        }
    }

}
