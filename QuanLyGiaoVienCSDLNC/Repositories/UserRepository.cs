using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly ApplicationDbContext _context;

        public UserRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<(bool success, string message, string maLichSu)> LoginAsync(string tenDangNhap, string matKhau)
        {
            var errorMessageParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = SqlDbType.NVarChar,
                Size = 200,
                Direction = ParameterDirection.Output
            };

            var maLichSuParam = new SqlParameter
            {
                ParameterName = "@MaLichSu",
                SqlDbType = SqlDbType.NVarChar,
                Size = 50,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_DangNhap @TenDangNhap, @MatKhau, @MaLichSu OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenDangNhap", tenDangNhap),
                    new SqlParameter("@MatKhau", matKhau),
                    maLichSuParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maLichSuParam.Value?.ToString());
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi đăng nhập: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> LogoutAsync(string maLichSu)
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
                    "EXEC sp_DangXuat @MaLichSu, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaLichSu", maLichSu),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi đăng xuất: {ex.Message}");
            }
        }

        public async Task<(bool success, string message, string maNguoiDung)> AddUserAsync(NguoiDung nguoiDung)
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
                    "EXEC sp_ThemNguoiDung @TenDangNhap, @MatKhau, @MaGV, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenDangNhap", nguoiDung.TenDangNhap),
                    new SqlParameter("@MatKhau", nguoiDung.MatKhau),
                    new SqlParameter("@MaGV", nguoiDung.MaGV ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !errorMessage.StartsWith("Lỗi");

                // Extract MaNguoiDung from success message
                string maNguoiDung = null;
                if (isSuccess && errorMessage.Contains("Mã người dùng:"))
                {
                    var parts = errorMessage.Split(':');
                    if (parts.Length > 1)
                    {
                        maNguoiDung = parts[1].Trim();
                    }
                }

                return (isSuccess, errorMessage, maNguoiDung);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm người dùng: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateUserAsync(NguoiDung nguoiDung)
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
                    "EXEC sp_SuaNguoiDung @MaNguoiDung, @TenDangNhap, @MatKhau, @MaGV, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaNguoiDung", nguoiDung.MaNguoiDung),
                    new SqlParameter("@TenDangNhap", nguoiDung.TenDangNhap),
                    new SqlParameter("@MatKhau", nguoiDung.MatKhau ?? (object)DBNull.Value),
                    new SqlParameter("@MaGV", nguoiDung.MaGV ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật người dùng: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteUserAsync(string maNguoiDung)
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
                    "EXEC sp_XoaNguoiDung @MaNguoiDung, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaNguoiDung", maNguoiDung),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa người dùng: {ex.Message}");
            }
        }

        public async Task<bool> KiemTraQuyenAsync(string maNguoiDung, string maQuyen)
        {
            var coQuyenParam = new SqlParameter
            {
                ParameterName = "@CoQuyen",
                SqlDbType = SqlDbType.Bit,
                Direction = ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_KiemTraQuyen @MaNguoiDung, @MaQuyen, @CoQuyen OUTPUT",
                    new SqlParameter("@MaNguoiDung", maNguoiDung),
                    new SqlParameter("@MaQuyen", maQuyen),
                    coQuyenParam);

                return (bool)coQuyenParam.Value;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public async Task<dynamic> GetUserInfoAsync(string maNguoiDung)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_LayThongTinNguoiDung @MaNguoiDung";
                    var parameter = command.CreateParameter();
                    parameter.ParameterName = "@MaNguoiDung";
                    parameter.Value = maNguoiDung;
                    command.Parameters.Add(parameter);

                    // Đây chỉ là một mẫu, việc triển khai đầy đủ cần xử lý nhiều dữ liệu hơn
                    var result = new
                    {
                        ThongTinCoBan = new NguoiDung(),
                        DanhSachNhom = new List<NhomNguoiDung>(),
                        DanhSachQuyen = new List<Quyen>()
                    };

                    return result;
                }
            }
        }
    }

}
