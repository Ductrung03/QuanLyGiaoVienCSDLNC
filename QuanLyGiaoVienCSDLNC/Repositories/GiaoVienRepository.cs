using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Models.QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class GiaoVienRepository : IGiaoVienRepository
    {
        private readonly ApplicationDbContext _context;

        public GiaoVienRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<List<GiaoVien>> GetAllGiaoVienAsync()
        {
            return await _context.GiaoViens.Include(g => g.BoMon).ThenInclude(b => b.Khoa).ToListAsync();
        }

        public async Task<GiaoVien> GetGiaoVienByIdAsync(string maGV)
        {
            return await _context.GiaoViens.Include(g => g.BoMon).ThenInclude(b => b.Khoa).FirstOrDefaultAsync(g => g.MaGV == maGV);
        }

        public async Task<List<GiaoVien>> SearchGiaoVienAsync(string searchTerm, string maBM = null, string maKhoa = null)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@TimKiem", searchTerm ?? (object)DBNull.Value),
                new SqlParameter("@MaBM", maBM ?? (object)DBNull.Value),
                new SqlParameter("@MaKhoa", maKhoa ?? (object)DBNull.Value)
            };

            var result = await _context.GiaoViens.FromSqlRaw(
                "EXEC sp_TimKiemGiaoVien @TimKiem, @MaBM, @MaKhoa",
                parameters.ToArray()).ToListAsync();

            return result;
        }

        public async Task<(bool success, string message, string maGV)> AddGiaoVienAsync(GiaoVien giaoVien)
        {
            var maGVParam = new SqlParameter
            {
                ParameterName = "@MaGV",
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
                    "EXEC sp_GiaoVien_ThemMoi @HoTen, @NgaySinh, @GioiTinh, @QueQuan, @DiaChi, @SDT, @Email, @MaBM, @MaGV OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@HoTen", giaoVien.HoTen),
                    new SqlParameter("@NgaySinh", giaoVien.NgaySinh),
                    new SqlParameter("@GioiTinh", giaoVien.GioiTinh),
                    new SqlParameter("@QueQuan", giaoVien.QueQuan ?? (object)DBNull.Value),
                    new SqlParameter("@DiaChi", giaoVien.DiaChi ?? (object)DBNull.Value),
                    new SqlParameter("@SDT", giaoVien.SDT),
                    new SqlParameter("@Email", giaoVien.Email),
                    new SqlParameter("@MaBM", giaoVien.MaBM),
                    maGVParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maGV = maGVParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maGV);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm giáo viên: {ex.Message}", null);
            }
        }
        public async Task<(bool success, string message)> UpdateGiaoVienAsync(GiaoVien giaoVien)
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
                    "EXEC sp_SuaGiaoVien @MaGV, @HoTen, @NgaySinh, @GioiTinh, @QueQuan, @DiaChi, @SDT, @Email, @MaBM, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", giaoVien.MaGV),
                    new SqlParameter("@HoTen", giaoVien.HoTen),
                    new SqlParameter("@NgaySinh", giaoVien.NgaySinh),
                    new SqlParameter("@GioiTinh", giaoVien.GioiTinh),
                    new SqlParameter("@QueQuan", giaoVien.QueQuan ?? (object)DBNull.Value),
                    new SqlParameter("@DiaChi", giaoVien.DiaChi ?? (object)DBNull.Value),
                    new SqlParameter("@SDT", giaoVien.SDT),
                    new SqlParameter("@Email", giaoVien.Email),
                    new SqlParameter("@MaBM", giaoVien.MaBM),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật giáo viên: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteGiaoVienAsync(string maGV)
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
                    "EXEC sp_XoaGiaoVien @MaGV, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                return (!errorMessage.StartsWith("Lỗi"), errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa giáo viên: {ex.Message}");
            }
        }

        public async Task<dynamic> GetChiTietGiaoVienAsync(string maGV)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_LayChiTietGiaoVien @MaGV";
                    var parameter = command.CreateParameter();
                    parameter.ParameterName = "@MaGV";
                    parameter.Value = maGV;
                    command.Parameters.Add(parameter);

                    var result = new
                    {
                        ThongTinCoBan = new GiaoVien(),
                        DanhSachHocVi = new List<HocVi>(),
                        DanhSachHocHam = new List<dynamic>(),
                        DanhSachChucVu = new List<dynamic>(),
                        LyLichKhoaHoc = new List<LyLichKhoaHoc>(),
                    };

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        // Đọc thông tin cơ bản
                        if (await reader.ReadAsync())
                        {
                            result.ThongTinCoBan.MaGV = reader["MaGV"].ToString();
                            result.ThongTinCoBan.HoTen = reader["HoTen"].ToString();
                            result.ThongTinCoBan.NgaySinh = reader.GetDateTime(reader.GetOrdinal("NgaySinh"));
                            result.ThongTinCoBan.GioiTinh = reader.GetBoolean(reader.GetOrdinal("GioiTinh"));
                            result.ThongTinCoBan.QueQuan = reader["QueQuan"].ToString();
                            result.ThongTinCoBan.DiaChi = reader["DiaChi"].ToString();
                            result.ThongTinCoBan.SDT = reader.GetInt32(reader.GetOrdinal("SDT"));
                            result.ThongTinCoBan.Email = reader["Email"].ToString();
                            result.ThongTinCoBan.MaBM = reader["MaBM"].ToString();
                        }

                        // Tiếp tục đọc các kết quả khác
                        // (Thực tế sẽ cần xử lý nhiều hơn để đọc đầy đủ thông tin từ stored procedure)

                        return result;
                    }
                }
            }
        }
    }

}
