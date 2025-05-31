using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class HuongDanRepository : IHuongDanRepository
    {
        private readonly ApplicationDbContext _context;

        public HuongDanRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        // Quản lý loại hình hướng dẫn
        public async Task<List<LoaiHinhHuongDan>> GetAllLoaiHinhHuongDanAsync()
        {
            return await _context.LoaiHinhHuongDans.ToListAsync();
        }

        public async Task<LoaiHinhHuongDan> GetLoaiHinhHuongDanByIdAsync(string maLoaiHinhHuongDan)
        {
            return await _context.LoaiHinhHuongDans.FindAsync(maLoaiHinhHuongDan);
        }

        // Quản lý tài hướng dẫn
        public async Task<List<TaiHuongDan>> GetAllTaiHuongDanAsync()
        {
            return await _context.TaiHuongDans
                .Include(t => t.LoaiHinhHuongDan)
                .OrderByDescending(t => t.NamHoc)
                .ThenBy(t => t.HoTenHocVien)
                .ToListAsync();
        }

        public async Task<TaiHuongDan> GetTaiHuongDanByIdAsync(string maHuongDan)
        {
            return await _context.TaiHuongDans
                .Include(t => t.LoaiHinhHuongDan)
                .FirstOrDefaultAsync(t => t.MaHuongDan == maHuongDan);
        }

        public async Task<List<TaiHuongDan>> GetTaiHuongDanByNamHocAsync(string namHoc)
        {
            return await _context.TaiHuongDans
                .Include(t => t.LoaiHinhHuongDan)
                .Where(t => t.NamHoc == namHoc)
                .OrderBy(t => t.HoTenHocVien)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maHuongDan)> AddTaiHuongDanAsync(TaiHuongDan taiHuongDan)
        {
            var maHuongDanParam = new SqlParameter
            {
                ParameterName = "@MaHuongDan",
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
                    "EXEC sp_HuongDan_ThemTai @HoTenHocVien, @Lop, @He, @NamHoc, @TenDeTai, @SoCBHD, @MaLoaiHinhHuongDan, @MaHuongDan OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@HoTenHocVien", taiHuongDan.HoTenHocVien),
                    new SqlParameter("@Lop", taiHuongDan.Lop),
                    new SqlParameter("@He", taiHuongDan.He),
                    new SqlParameter("@NamHoc", taiHuongDan.NamHoc),
                    new SqlParameter("@TenDeTai", taiHuongDan.TenDeTai),
                    new SqlParameter("@SoCBHD", taiHuongDan.SoCBHD),
                    new SqlParameter("@MaLoaiHinhHuongDan", taiHuongDan.MaLoaiHinhHuongDan),
                    maHuongDanParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maHuongDan = maHuongDanParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maHuongDan);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm tài hướng dẫn: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateTaiHuongDanAsync(TaiHuongDan taiHuongDan)
        {
            try
            {
                _context.TaiHuongDans.Update(taiHuongDan);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật tài hướng dẫn thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật tài hướng dẫn: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteTaiHuongDanAsync(string maHuongDan)
        {
            try
            {
                var taiHuongDan = await _context.TaiHuongDans.FindAsync(maHuongDan);
                if (taiHuongDan == null)
                    return (false, "Không tìm thấy tài hướng dẫn");

                // Kiểm tra xem có phân công hướng dẫn nào không
                var hasAssignments = await _context.ThamGiaHuongDans.AnyAsync(tg => tg.MaHuongDan == maHuongDan);
                if (hasAssignments)
                    return (false, "Không thể xóa vì đã có phân công hướng dẫn");

                _context.TaiHuongDans.Remove(taiHuongDan);
                await _context.SaveChangesAsync();
                return (true, "Xóa tài hướng dẫn thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa tài hướng dẫn: {ex.Message}");
            }
        }

        // Quản lý phân công hướng dẫn
        public async Task<List<ThamGiaHuongDan>> GetHuongDanByGiaoVienAsync(string maGV)
        {
            return await _context.ThamGiaHuongDans
                .Include(tg => tg.TaiHuongDan)
                .ThenInclude(hd => hd.LoaiHinhHuongDan)
                .Where(tg => tg.MaGV == maGV)
                .OrderByDescending(tg => tg.TaiHuongDan.NamHoc)
                .ToListAsync();
        }

        public async Task<List<ThamGiaHuongDan>> GetGiaoVienHuongDanAsync(string maHuongDan)
        {
            return await _context.ThamGiaHuongDans
                .Include(tg => tg.GiaoVien)
                .ThenInclude(gv => gv.BoMon)
                .Where(tg => tg.MaHuongDan == maHuongDan)
                .ToListAsync();
        }

        public async Task<(bool success, string message, string maThamGiaHuongDan)> PhanCongHuongDanAsync(string maGV, string maHuongDan, float soGio)
        {
            var maThamGiaHuongDanParam = new SqlParameter
            {
                ParameterName = "@MaThamGiaHuongDan",
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
                    "EXEC sp_HuongDan_PhanCong @MaGV, @MaHuongDan, @SoGio, @MaThamGiaHuongDan OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaHuongDan", maHuongDan),
                    new SqlParameter("@SoGio", soGio),
                    maThamGiaHuongDanParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maThamGiaHuongDan = maThamGiaHuongDanParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maThamGiaHuongDan);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công hướng dẫn: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateThamGiaHuongDanAsync(ThamGiaHuongDan thamGiaHuongDan)
        {
            try
            {
                _context.ThamGiaHuongDans.Update(thamGiaHuongDan);
                await _context.SaveChangesAsync();
                return (true, "Cập nhật phân công hướng dẫn thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật phân công hướng dẫn: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteThamGiaHuongDanAsync(string maThamGiaHuongDan)
        {
            try
            {
                var thamGia = await _context.ThamGiaHuongDans.FindAsync(maThamGiaHuongDan);
                if (thamGia == null)
                    return (false, "Không tìm thấy phân công hướng dẫn");

                _context.ThamGiaHuongDans.Remove(thamGia);
                await _context.SaveChangesAsync();
                return (true, "Xóa phân công hướng dẫn thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa phân công hướng dẫn: {ex.Message}");
            }
        }
    }
}