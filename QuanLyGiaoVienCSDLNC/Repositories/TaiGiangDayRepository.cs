using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class TaiGiangDayRepository : ITaiGiangDayRepository
    {
        private readonly ApplicationDbContext _context;

        public TaiGiangDayRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<List<TaiGiangDay>> GetAllTaiGiangDayAsync()
        {
            return await _context.TaiGiangDays.ToListAsync();
        }

        public async Task<TaiGiangDay> GetTaiGiangDayByIdAsync(string maTaiGiangDay)
        {
            return await _context.TaiGiangDays.FirstOrDefaultAsync(t => t.MaTaiGiangDay == maTaiGiangDay);
        }

        public async Task<(bool success, string message, string maTaiGiangDay)> AddTaiGiangDayAsync(TaiGiangDay taiGiangDay)
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
                    "EXEC sp_ThemTaiGiangDay @TenHocPhan, @SiSo, @He, @Lop, @SoTinChi, @GhiChu, @NamHoc, @MaDoiTuong, @MaThoiGian, @MaNgonNgu, @ErrorMessage OUTPUT",
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
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !errorMessage.StartsWith("Lỗi");

                // Extract MaTaiGiangDay from success message
                string maTaiGiangDay = null;
                if (isSuccess && errorMessage.Contains("Mã công tác:"))
                {
                    var parts = errorMessage.Split(':');
                    if (parts.Length > 1)
                    {
                        maTaiGiangDay = parts[1].Trim();
                    }
                }

                return (isSuccess, errorMessage, maTaiGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm công tác giảng dạy: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message, string maChiTietGiangDay)> PhanCongGiangDayAsync(string maGV, string maTaiGiangDay, int soTiet, string ghiChu, string maNoiDungGiangDay)
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
                    "EXEC sp_PhanCongGiangDay @MaGV, @MaTaiGiangDay, @SoTiet, @GhiChu, @MaNoiDungGiangDay, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaTaiGiangDay", maTaiGiangDay),
                    new SqlParameter("@SoTiet", soTiet),
                    new SqlParameter("@GhiChu", ghiChu ?? (object)DBNull.Value),
                    new SqlParameter("@MaNoiDungGiangDay", maNoiDungGiangDay ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !errorMessage.StartsWith("Lỗi");

                // Extract MaChiTietGiangDay from success message
                string maChiTietGiangDay = null;
                if (isSuccess && errorMessage.Contains("Mã chi tiết:"))
                {
                    var parts = errorMessage.Split(':');
                    if (parts.Length > 1)
                    {
                        maChiTietGiangDay = parts[1].Trim();
                    }
                }

                return (isSuccess, errorMessage, maChiTietGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công giảng dạy: {ex.Message}", null);
            }
        }
    }

}
