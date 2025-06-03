using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.DTOs.GiaoVien;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.DTOs.HocVi;
using QuanLyGiaoVienCSDLNC.DTOs.LyLichKhoaHoc;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class GiaoVienRepository : IGiaoVienRepository
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger<GiaoVienRepository> _logger;

        public GiaoVienRepository(ApplicationDbContext context, ILogger<GiaoVienRepository> logger)
        {
            _context = context;
            _logger = logger;
        }

        #region CRUD Operations

        public async Task<List<GiaoVien>> GetAllGiaoVienAsync()
        {
            try
            {
                return await _context.GiaoViens
                    .Include(g => g.BoMon)
                    .ThenInclude(b => b.Khoa)
                    .OrderBy(g => g.HoTen)
                    .ToListAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting all giao vien");
                throw;
            }
        }

        public async Task<GiaoVien> GetGiaoVienByIdAsync(string maGV)
        {
            try
            {
                return await _context.GiaoViens
                    .Include(g => g.BoMon)
                    .ThenInclude(b => b.Khoa)
                    .FirstOrDefaultAsync(g => g.MaGV == maGV);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting giao vien by id: {MaGV}", maGV);
                throw;
            }
        }

        public async Task<(bool success, string message, string maGV)> AddGiaoVienAsync(GiaoVienCreateDto dto)
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
                    new SqlParameter("@HoTen", dto.HoTen),
                    new SqlParameter("@NgaySinh", dto.NgaySinh),
                    new SqlParameter("@GioiTinh", dto.GioiTinh),
                    new SqlParameter("@QueQuan", dto.QueQuan ?? (object)DBNull.Value),
                    new SqlParameter("@DiaChi", dto.DiaChi ?? (object)DBNull.Value),
                    new SqlParameter("@SDT", dto.SDT),
                    new SqlParameter("@Email", dto.Email),
                    new SqlParameter("@MaBM", dto.MaBM),
                    maGVParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maGV = maGVParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                _logger.LogInformation("Add giao vien result: {Success}, {Message}, {MaGV}", isSuccess, errorMessage, maGV);
                return (isSuccess, errorMessage, maGV);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding giao vien: {@GiaoVien}", dto);
                return (false, $"Lỗi khi thêm giáo viên: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateGiaoVienAsync(GiaoVienUpdateDto dto)
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
                    "EXEC sp_GiaoVien_CapNhat @MaGV, @HoTen, @NgaySinh, @GioiTinh, @QueQuan, @DiaChi, @SDT, @Email, @MaBM, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", dto.MaGV),
                    new SqlParameter("@HoTen", dto.HoTen),
                    new SqlParameter("@NgaySinh", dto.NgaySinh),
                    new SqlParameter("@GioiTinh", dto.GioiTinh),
                    new SqlParameter("@QueQuan", dto.QueQuan ?? (object)DBNull.Value),
                    new SqlParameter("@DiaChi", dto.DiaChi ?? (object)DBNull.Value),
                    new SqlParameter("@SDT", dto.SDT),
                    new SqlParameter("@Email", dto.Email),
                    new SqlParameter("@MaBM", dto.MaBM),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating giao vien: {MaGV}", dto.MaGV);
                return (false, $"Lỗi khi cập nhật giáo viên: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteGiaoVienAsync(string maGV, bool forceDelete = false)
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
                    "EXEC sp_GiaoVien_Xoa @MaGV, @ForceDelete, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@ForceDelete", forceDelete),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting giao vien: {MaGV}", maGV);
                return (false, $"Lỗi khi xóa giáo viên: {ex.Message}");
            }
        }

        #endregion

        #region Advanced Search and Filtering

        public async Task<PagedResultDto<GiaoVienListItemDto>> SearchGiaoVienAsync(GiaoVienSearchDto searchDto)
        {
            var totalRecordsParam = new SqlParameter
            {
                ParameterName = "@TotalRecords",
                SqlDbType = SqlDbType.Int,
                Direction = ParameterDirection.Output
            };

            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_GiaoVien_TimKiem";
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add(new SqlParameter("@SearchText", searchDto.SearchText ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@MaKhoa", searchDto.MaKhoa ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@MaBM", searchDto.MaBM ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@HocVi", searchDto.HocVi ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@HocHam", searchDto.HocHam ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@PageNumber", searchDto.PageNumber));
                        command.Parameters.Add(new SqlParameter("@PageSize", searchDto.PageSize));
                        command.Parameters.Add(totalRecordsParam);

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var giaoviens = new List<GiaoVienListItemDto>();
                            while (await reader.ReadAsync())
                            {
                                giaoviens.Add(new GiaoVienListItemDto
                                {
                                    MaGV = reader["MaGV"].ToString(),
                                    HoTen = reader["HoTen"].ToString(),
                                    NgaySinh = Convert.ToDateTime(reader["NgaySinh"]),
                                    GioiTinh = reader["GioiTinh"].ToString(),
                                    Email = reader["Email"].ToString(),
                                    SDT = Convert.ToInt32(reader["SDT"]),
                                    DiaChi = reader["DiaChi"]?.ToString(),
                                    TenBM = reader["TenBM"].ToString(),
                                    TenKhoa = reader["TenKhoa"].ToString(),
                                    DanhSachHocVi = reader["DanhSachHocVi"]?.ToString(),
                                    HocHamCaoNhat = reader["HocHamCaoNhat"]?.ToString()
                                });
                            }
                            await reader.CloseAsync();

                            int totalRecords = 0;
                            if (totalRecordsParam?.Value != DBNull.Value && totalRecordsParam?.Value != null)
                            {
                                totalRecords = (int)totalRecordsParam.Value;
                            }

                            return new PagedResultDto<GiaoVienListItemDto>(
                                giaoviens, totalRecords, searchDto.PageNumber, searchDto.PageSize
                            );

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error searching giao vien: {@SearchDto}", searchDto);
                throw;
            }
        }

        public async Task<List<GiaoVien>> SearchGiaoVienSimpleAsync(string searchTerm, string maBM = null, string maKhoa = null)
        {
            var searchDto = new GiaoVienSearchDto
            {
                SearchText = searchTerm,
                MaBM = maBM,
                MaKhoa = maKhoa,
                PageNumber = 1,
                PageSize = 1000
            };

            var result = await SearchGiaoVienAsync(searchDto);

            // Convert to GiaoVien entities
            var giaoviens = new List<GiaoVien>();
            foreach (var item in result.Data)
            {
                giaoviens.Add(new GiaoVien
                {
                    MaGV = item.MaGV,
                    HoTen = item.HoTen,
                    NgaySinh = item.NgaySinh,
                    GioiTinh = item.GioiTinh == "Nam",
                    Email = item.Email,
                    SDT = item.SDT,
                    DiaChi = item.DiaChi,
                    QueQuan = item.QueQuan,
                    BoMon = new BoMon
                    {
                        TenBM = item.TenBM,
                        Khoa = new Khoa
                        {
                            TenKhoa = item.TenKhoa
                        }
                    }
                });
            }

            return giaoviens;
        }

        #endregion

        #region Detail Information

        public async Task<GiaoVienDetailDto> GetChiTietGiaoVienAsync(string maGV)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_GiaoVien_ChiTiet";
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@MaGV", maGV));

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var result = new GiaoVienDetailDto();

                            // Đọc thông tin cơ bản (Result Set 1)
                            if (await reader.ReadAsync())
                            {
                                result.ThongTinCoBan = new GiaoVien
                                {
                                    MaGV = reader["MaGV"].ToString(),
                                    HoTen = reader["HoTen"].ToString(),
                                    NgaySinh = Convert.ToDateTime(reader["NgaySinh"]),
                                    GioiTinh = reader["GioiTinh"].ToString() == "Nam",
                                    QueQuan = reader["QueQuan"]?.ToString(),
                                    DiaChi = reader["DiaChi"]?.ToString(),
                                    SDT = Convert.ToInt32(reader["SDT"]),
                                    Email = reader["Email"].ToString(),
                                    MaBM = reader["MaBM"].ToString(),
                                    BoMon = new BoMon
                                    {
                                        MaBM = reader["MaBM"].ToString(),
                                        TenBM = reader["TenBM"].ToString(),
                                        Khoa = new Khoa
                                        {
                                            MaKhoa = reader["MaKhoa"].ToString(),
                                            TenKhoa = reader["TenKhoa"].ToString()
                                        }
                                    }
                                };
                            }

                            // Đọc học vị (Result Set 2)
                            if (await reader.NextResultAsync())
                            {
                                while (await reader.ReadAsync())
                                {
                                    result.DanhSachHocVi.Add(new HocVi
                                    {
                                        MaHocVi = reader["MaHocVi"].ToString(),
                                        TenHocVi = reader["TenHocVi"].ToString(),
                                        NgayNhan = Convert.ToDateTime(reader["NgayNhan"]),
                                        MaGV = maGV
                                    });
                                }
                            }

                            // Đọc học hàm (Result Set 3)
                            if (await reader.NextResultAsync())
                            {
                                while (await reader.ReadAsync())
                                {
                                    result.DanhSachHocHam.Add(new LichSuHocHam
                                    {
                                        MaLSHocHam = reader["MaLSHocHam"].ToString(),
                                        TenHocHam = reader["TenHocHam"].ToString(),
                                        NgayNhan = Convert.ToDateTime(reader["NgayNhan"]),
                                        MaGV = maGV,
                                        MaHocHam = reader["MaHocHam"]?.ToString()
                                    });
                                }
                            }

                            // Đọc chức vụ hiện tại (Result Set 4)
                            if (await reader.NextResultAsync())
                            {
                                while (await reader.ReadAsync())
                                {
                                    result.DanhSachChucVu.Add(new LichSuChucVu
                                    {
                                        MaChucVu = reader["MaChucVu"].ToString(),
                                        NgayNhan = Convert.ToDateTime(reader["NgayNhan"]),
                                        MaGV = maGV,
                                        ChucVu = new ChucVu
                                        {
                                            MaChucVu = reader["MaChucVu"].ToString(),
                                            TenChucVu = reader["TenChucVu"].ToString()
                                        }
                                    });
                                }
                            }

                            // Đọc lý lịch khoa học (Result Set 5)
                            if (await reader.NextResultAsync())
                            {
                                if (await reader.ReadAsync())
                                {
                                    result.LyLichKhoaHoc = new LyLichKhoaHoc
                                    {
                                        HeDaoTaoDH = reader["HeDaoTaoDH"]?.ToString(),
                                        NoiDaoTaoDH = reader["NoiDaoTaoDH"]?.ToString(),
                                        NganhHocDH = reader["NganhHocDH"]?.ToString(),
                                        NamTotNghiepDH = reader["NamTotNghiepDH"] as int?,
                                        ThacSiChuyenNganh = reader["ThacSiChuyenNganh"]?.ToString(),
                                        NamCapBangTS = reader["NamCapBangTS"] as int?,
                                        NoiDaoTaoTS = reader["NoiDaoTaoTS"]?.ToString(),
                                        TenLuanVanTotNghiep = reader["TenLuanVanTotNghiep"]?.ToString(),
                                        TienSiChuyenNganh = reader["TienSiChuyenNganh"]?.ToString(),
                                        NamCapBangSauDH = reader["NamCapBangSauDH"] as int?,
                                        NoiDaoTaoSauDH = reader["NoiDaoTaoSauDH"]?.ToString(),
                                        TenLuanAnSauDH = reader["TenLuanAnSauDH"]?.ToString(),
                                        NgayKhai = reader["NgayKhai"] as DateTime?,
                                        MaGV = maGV
                                    };
                                }
                            }

                            return result;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting chi tiet giao vien: {MaGV}", maGV);
                throw;
            }
        }

        #endregion

        #region Academic Information Management

        public async Task<(bool success, string message)> CapNhatHocViAsync(HocViCreateDto dto)
        {
            var maHocViParam = new SqlParameter
            {
                ParameterName = "@MaHocVi",
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
                    "EXEC sp_HocVi_CapNhat @MaGV, @TenHocVi, @NgayNhan, @MaHocVi OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", dto.MaGV),
                    new SqlParameter("@TenHocVi", dto.TenHocVi),
                    new SqlParameter("@NgayNhan", dto.NgayNhan),
                    maHocViParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating hoc vi: {MaGV}", dto.MaGV);
                return (false, $"Lỗi khi cập nhật học vị: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> CapNhatHocHamAsync(string maGV, string maHocHam, DateTime ngayNhan)
        {
            var maLSHocHamParam = new SqlParameter
            {
                ParameterName = "@MaLSHocHam",
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
                    "EXEC sp_HocHam_CapNhat @MaGV, @MaHocHam, @NgayNhan, @MaLSHocHam OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", maGV),
                    new SqlParameter("@MaHocHam", maHocHam),
                    new SqlParameter("@NgayNhan", ngayNhan),
                    maLSHocHamParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating hoc ham: {MaGV}", maGV);
                return (false, $"Lỗi khi cập nhật học hàm: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> CapNhatLyLichKhoaHocAsync(LyLichKhoaHocDto dto)
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
                    @"EXEC sp_LyLichKhoaHoc_CapNhat @MaGV, @HeDaoTaoDH, @NoiDaoTaoDH, @NganhHocDH, @NuocDaoTaoDH, @NamTotNghiepDH, 
                      @ThacSiChuyenNganh, @NamCapBangTS, @NoiDaoTaoTS, @TenLuanVanTotNghiep, @TienSiChuyenNganh, 
                      @NamCapBangSauDH, @NoiDaoTaoSauDH, @TenLuanAnSauDH, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", dto.MaGV),
                    new SqlParameter("@HeDaoTaoDH", dto.HeDaoTaoDH),
                    new SqlParameter("@NoiDaoTaoDH", dto.NoiDaoTaoDH),
                    new SqlParameter("@NganhHocDH", dto.NganhHocDH),
                    new SqlParameter("@NuocDaoTaoDH", dto.NuocDaoTaoDH ?? (object)DBNull.Value),
                    new SqlParameter("@NamTotNghiepDH", dto.NamTotNghiepDH ?? (object)DBNull.Value),
                    new SqlParameter("@ThacSiChuyenNganh", dto.ThacSiChuyenNganh ?? (object)DBNull.Value),
                    new SqlParameter("@NamCapBangTS", dto.NamCapBangTS ?? (object)DBNull.Value),
                    new SqlParameter("@NoiDaoTaoTS", dto.NoiDaoTaoTS ?? (object)DBNull.Value),
                    new SqlParameter("@TenLuanVanTotNghiep", dto.TenLuanVanTotNghiep ?? (object)DBNull.Value),
                    new SqlParameter("@TienSiChuyenNganh", dto.TienSiChuyenNganh ?? (object)DBNull.Value),
                    new SqlParameter("@NamCapBangSauDH", dto.NamCapBangSauDH ?? (object)DBNull.Value),
                    new SqlParameter("@NoiDaoTaoSauDH", dto.NoiDaoTaoSauDH ?? (object)DBNull.Value),
                    new SqlParameter("@TenLuanAnSauDH", dto.TenLuanAnSauDH ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating ly lich khoa hoc: {MaGV}", dto.MaGV);
                return (false, $"Lỗi khi cập nhật lý lịch khoa học: {ex.Message}");
            }
        }

        #endregion

        #region Position Management

        public async Task<(bool success, string message)> PhanCongChucVuAsync(string maGV, string maChucVu, DateTime? ngayNhan = null)
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
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error phan cong chuc vu: {MaGV}, {MaChucVu}", maGV, maChucVu);
                return (false, $"Lỗi khi phân công chức vụ: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> KetThucChucVuAsync(string maGV, string maChucVu, DateTime? ngayKetThuc = null)
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
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error ket thuc chuc vu: {MaGV}, {MaChucVu}", maGV, maChucVu);
                return (false, $"Lỗi khi kết thúc chức vụ: {ex.Message}");
            }
        }

        #endregion

        #region Statistics and Reports

        public async Task<ThongKeGiaoVien> GetThongKeGiaoVienAsync(string maGV, string namHoc = null)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_BaoCao_TongHopKhoiLuongCongTac";
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@MaGV", maGV));
                        command.Parameters.Add(new SqlParameter("@MaBM", DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@MaKhoa", DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            if (await reader.ReadAsync())
                            {
                                return new ThongKeGiaoVien
                                {
                                    TongGioGiangDay = Convert.ToInt32(reader["TongGioGiangDay"] ?? 0),
                                    TongGioNCKH = Convert.ToInt32(reader["TongGioNCKH"] ?? 0),
                                    TongGioKhaoThi = Convert.ToInt32(reader["TongGioKhaoThi"] ?? 0),
                                    TongGioHoiDong = Convert.ToInt32(reader["TongGioHoiDong"] ?? 0),
                                    TongGioHuongDan = Convert.ToInt32(reader["TongGioHuongDan"] ?? 0),
                                    TongGioQuyChuan = Convert.ToInt32(reader["TongGioQuyChuan"] ?? 0),
                                    DinhMucGiangDay = Convert.ToInt32(reader["DinhMucGiangDay"] ?? 320),
                                    DinhMucNCKH = Convert.ToInt32(reader["DinhMucNCKH"] ?? 300),
                                    PhanTramHoanThanhGiangDay = Convert.ToDecimal(reader["PhanTramGiangDay"] ?? 0),
                                    PhanTramHoanThanhNCKH = Convert.ToDecimal(reader["PhanTramNCKH"] ?? 0),
                                    TrangThaiHoanThanh = reader["TrangThai"]?.ToString() ?? "Chưa đạt"
                                };
                            }
                        }
                    }
                }
                return new ThongKeGiaoVien();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting thong ke giao vien: {MaGV}", maGV);
                throw;
            }
        }

        public async Task<DataTable> GetBaoCaoGiangDayAsync(string maGV, string namHoc = null)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_GiangDay_DanhSach";
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@PageNumber", 1));
                        command.Parameters.Add(new SqlParameter("@PageSize", 1000));
                        command.Parameters.Add(new SqlParameter("@TotalRecords", SqlDbType.Int) { Direction = ParameterDirection.Output });

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var dataTable = new DataTable();
                            dataTable.Load(reader);
                            return dataTable;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting bao cao giang day: {MaGV}", maGV);
                throw;
            }
        }

        public async Task<DataTable> GetBaoCaoNCKHAsync(string maGV, string namHoc = null)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_NCKH_DanhSach";
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@PageNumber", 1));
                        command.Parameters.Add(new SqlParameter("@PageSize", 1000));
                        command.Parameters.Add(new SqlParameter("@TotalRecords", SqlDbType.Int) { Direction = ParameterDirection.Output });

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var dataTable = new DataTable();
                            dataTable.Load(reader);
                            return dataTable;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting bao cao NCKH: {MaGV}", maGV);
                throw;
            }
        }

        public async Task<DataTable> GetBaoCaoTongHopAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_BaoCao_TongHopKhoiLuongCongTac";
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@MaBM", maBM ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@MaKhoa", maKhoa ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var dataTable = new DataTable();
                            dataTable.Load(reader);
                            return dataTable;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting bao cao tong hop");
                throw;
            }
        }

        #endregion

        #region Utility Methods

        public async Task<bool> CheckEmailExistsAsync(string email, string excludeMaGV = null)
        {
            try
            {
                var query = _context.GiaoViens.Where(g => g.Email == email);
                if (!string.IsNullOrEmpty(excludeMaGV))
                {
                    query = query.Where(g => g.MaGV != excludeMaGV);
                }
                return await query.AnyAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking email exists: {Email}", email);
                throw;
            }
        }

        public async Task<bool> CheckSDTExistsAsync(int sdt, string excludeMaGV = null)
        {
            try
            {
                var query = _context.GiaoViens.Where(g => g.SDT == sdt);
                if (!string.IsNullOrEmpty(excludeMaGV))
                {
                    query = query.Where(g => g.MaGV != excludeMaGV);
                }
                return await query.AnyAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking SDT exists: {SDT}", sdt);
                throw;
            }
        }

        public async Task<List<GiaoVien>> GetGiaoVienByBoMonAsync(string maBM)
        {
            try
            {
                return await _context.GiaoViens
                    .Where(g => g.MaBM == maBM)
                    .Include(g => g.BoMon)
                    .OrderBy(g => g.HoTen)
                    .ToListAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting giao vien by bo mon: {MaBM}", maBM);
                throw;
            }
        }

        public async Task<List<GiaoVien>> GetGiaoVienByKhoaAsync(string maKhoa)
        {
            try
            {
                return await _context.GiaoViens
                    .Include(g => g.BoMon)
                    .Where(g => g.BoMon.MaKhoa == maKhoa)
                    .OrderBy(g => g.HoTen)
                    .ToListAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting giao vien by khoa: {MaKhoa}", maKhoa);
                throw;
            }
        }

        public async Task<int> GetTotalGiaoVienCountAsync()
        {
            try
            {
                return await _context.GiaoViens.CountAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting total giao vien count");
                throw;
            }
        }

        #endregion

        #region Dashboard Data

        public async Task<object> GetDashboardDataAsync()
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_Dashboard_TongQuan";
                        command.CommandType = CommandType.StoredProcedure;

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var result = new
                            {
                                TongGiaoVien = 0,
                                TongKhoa = 0,
                                TongBoMon = 0,
                                TongNguoiDung = 0
                            };

                            if (await reader.ReadAsync())
                            {
                                result = new
                                {
                                    TongGiaoVien = Convert.ToInt32(reader["TongGiaoVien"]),
                                    TongKhoa = Convert.ToInt32(reader["TongKhoa"]),
                                    TongBoMon = Convert.ToInt32(reader["TongBoMon"]),
                                    TongNguoiDung = Convert.ToInt32(reader["TongNguoiDung"])
                                };
                            }

                            return result;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting dashboard data");
                throw;
            }
        }

        public async Task<List<object>> GetTopGiaoVienByGiangDayAsync(int top = 10, string namHoc = null)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_Dashboard_TongQuan";
                        command.CommandType = CommandType.StoredProcedure;

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var result = new List<object>();

                            // Skip to result set 4 (Top 10 giáo viên)
                            for (int i = 0; i < 3; i++)
                            {
                                await reader.NextResultAsync();
                            }

                            if (await reader.NextResultAsync())
                            {
                                while (await reader.ReadAsync())
                                {
                                    result.Add(new
                                    {
                                        MaGV = reader["MaGV"].ToString(),
                                        HoTen = reader["HoTen"].ToString(),
                                        TenBM = reader["TenBM"].ToString(),
                                        TongGioGiangDay = Convert.ToInt32(reader["TongGioGiangDay"])
                                    });
                                }
                            }

                            return result.Take(top).ToList();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting top giao vien by giang day");
                throw;
            }
        }

        public async Task<List<object>> GetGiaoVienChuaHoanThanhDinhMucAsync(string namHoc = null)
        {
            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_BaoCao_TongHopKhoiLuongCongTac";
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@MaGV", DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@MaBM", DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@MaKhoa", DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var result = new List<object>();

                            while (await reader.ReadAsync())
                            {
                                var trangThai = reader["TrangThai"]?.ToString();
                                if (trangThai == "Chưa đạt")
                                {
                                    result.Add(new
                                    {
                                        MaGV = reader["MaGV"].ToString(),
                                        HoTen = reader["HoTen"].ToString(),
                                        TenBM = reader["TenBM"].ToString(),
                                        TenKhoa = reader["TenKhoa"].ToString(),
                                        TrangThai = trangThai,
                                        PhanTramGiangDay = Convert.ToDecimal(reader["PhanTramGiangDay"] ?? 0),
                                        PhanTramNCKH = Convert.ToDecimal(reader["PhanTramNCKH"] ?? 0)
                                    });
                                }
                            }

                            return result;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting giao vien chua hoan thanh dinh muc");
                throw;
            }
        }

        #endregion

        #region Export Functions

        public async Task<DataTable> ExportGiaoVienToDataTableAsync(GiaoVienSearchDto searchDto = null)
        {
            try
            {
                searchDto ??= new GiaoVienSearchDto { PageNumber = 1, PageSize = 10000 };

                var result = await SearchGiaoVienAsync(searchDto);
                var dataTable = new DataTable();

                // Define columns
                dataTable.Columns.Add("Mã GV", typeof(string));
                dataTable.Columns.Add("Họ tên", typeof(string));
                dataTable.Columns.Add("Ngày sinh", typeof(string));
                dataTable.Columns.Add("Giới tính", typeof(string));
                dataTable.Columns.Add("Quê quán", typeof(string));
                dataTable.Columns.Add("Địa chỉ", typeof(string));
                dataTable.Columns.Add("Số điện thoại", typeof(string));
                dataTable.Columns.Add("Email", typeof(string));
                dataTable.Columns.Add("Bộ môn", typeof(string));
                dataTable.Columns.Add("Khoa", typeof(string));

                // Add rows
                foreach (var gv in result.Data)
                {
                    dataTable.Rows.Add(
                        gv.MaGV,
                        gv.HoTen,
                        gv.NgaySinh.ToString("dd/MM/yyyy"),
                        gv.GioiTinh,
                        gv.QueQuan,
                        gv.DiaChi,
                        gv.SDT.ToString(),
                        gv.Email,
                        gv.TenBM,
                        gv.TenKhoa
                    );
                }

                return dataTable;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error exporting giao vien to data table");
                throw;
            }
        }

        public async Task<byte[]> ExportGiaoVienToExcelAsync(GiaoVienSearchDto searchDto = null)
        {
            try
            {
                var dataTable = await ExportGiaoVienToDataTableAsync(searchDto);

                using (var package = new ExcelPackage())
                {
                    var worksheet = package.Workbook.Worksheets.Add("Danh sách giáo viên");

                    // Load data
                    worksheet.Cells["A1"].LoadFromDataTable(dataTable, true);

                    // Format header
                    using (var range = worksheet.Cells[1, 1, 1, dataTable.Columns.Count])
                    {
                        range.Style.Font.Bold = true;
                        range.Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                        range.Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightBlue);
                    }

                    // Auto fit columns
                    worksheet.Cells.AutoFitColumns();

                    return package.GetAsByteArray();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error exporting giao vien to excel");
                throw;
            }
        }

        public async Task<byte[]> ExportGiaoVienToPdfAsync(string maGV)
        {
            try
            {
                var chiTiet = await GetChiTietGiaoVienAsync(maGV);
                var gv = chiTiet.ThongTinCoBan;

                using (var ms = new MemoryStream())
                {
                    var document = new Document(PageSize.A4, 50, 50, 25, 25);
                    var writer = PdfWriter.GetInstance(document, ms);

                    document.Open();

                    // Title
                    var titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
                    var title = new Paragraph("THÔNG TIN CHI TIẾT GIÁO VIÊN", titleFont);
                    title.Alignment = Element.ALIGN_CENTER;
                    document.Add(title);

                    document.Add(new Paragraph(" "));

                    // Basic info
                    var normalFont = FontFactory.GetFont(FontFactory.HELVETICA, 12);
                    document.Add(new Paragraph($"Mã giáo viên: {gv.MaGV}", normalFont));
                    document.Add(new Paragraph($"Họ tên: {gv.HoTen}", normalFont));
                    document.Add(new Paragraph($"Ngày sinh: {gv.NgaySinh:dd/MM/yyyy}", normalFont));
                    document.Add(new Paragraph($"Giới tính: {gv.GioiTinhText}", normalFont));
                    document.Add(new Paragraph($"Email: {gv.Email}", normalFont));
                    document.Add(new Paragraph($"Số điện thoại: {gv.SDT}", normalFont));
                    document.Add(new Paragraph($"Bộ môn: {gv.BoMon?.TenBM}", normalFont));
                    document.Add(new Paragraph($"Khoa: {gv.BoMon?.Khoa?.TenKhoa}", normalFont));

                    document.Close();
                    return ms.ToArray();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error exporting giao vien to PDF: {MaGV}", maGV);
                throw;
            }
        }

        #endregion

        // Thêm các method sau vào class GiaoVienRepository

        #region Quản lý học vị đầy đủ

        public async Task<(bool success, string message, string maHocVi)> ThemHocViAsync(HocVi hocVi)
        {
            var maHocViParam = new SqlParameter
            {
                ParameterName = "@MaHocVi",
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
                    "EXEC sp_HocVi_ThemMoi @MaGV, @TenHocVi, @NgayNhan, @MaHocVi OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", hocVi.MaGV),
                    new SqlParameter("@TenHocVi", hocVi.TenHocVi),
                    new SqlParameter("@NgayNhan", hocVi.NgayNhan),
                    maHocViParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maHocVi = maHocViParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maHocVi);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding hoc vi: {@HocVi}", hocVi);
                return (false, $"Lỗi khi thêm học vị: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> CapNhatHocViAsync(HocVi hocVi)
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
                    "EXEC sp_HocVi_CapNhat @MaHocVi, @TenHocVi, @NgayNhan, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaHocVi", hocVi.MaHocVi),
                    new SqlParameter("@TenHocVi", hocVi.TenHocVi),
                    new SqlParameter("@NgayNhan", hocVi.NgayNhan),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating hoc vi: {MaHocVi}", hocVi.MaHocVi);
                return (false, $"Lỗi khi cập nhật học vị: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> XoaHocViAsync(string maHocVi)
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
                    "EXEC sp_HocVi_Xoa @MaHocVi, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaHocVi", maHocVi),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting hoc vi: {MaHocVi}", maHocVi);
                return (false, $"Lỗi khi xóa học vị: {ex.Message}");
            }
        }

        public async Task<PagedResultDto<HocVi>> TimKiemHocViAsync(string maGV = null, string tenHocVi = null, DateTime? tuNgay = null, DateTime? denNgay = null, int pageNumber = 1, int pageSize = 20)
        {
            var totalRecordsParam = new SqlParameter
            {
                ParameterName = "@TotalRecords",
                SqlDbType = SqlDbType.Int,
                Direction = ParameterDirection.Output
            };

            try
            {
                using (var connection = _context.Database.GetDbConnection())
                {
                    await connection.OpenAsync();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = "sp_HocVi_TimKiem";
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@TenHocVi", tenHocVi ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@TuNgay", tuNgay ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@DenNgay", denNgay ?? (object)DBNull.Value));
                        command.Parameters.Add(new SqlParameter("@PageNumber", pageNumber));
                        command.Parameters.Add(new SqlParameter("@PageSize", pageSize));
                        command.Parameters.Add(totalRecordsParam);

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            var hocVis = new List<HocVi>();
                            while (await reader.ReadAsync())
                            {
                                hocVis.Add(new HocVi
                                {
                                    MaHocVi = reader["MaHocVi"].ToString(),
                                    TenHocVi = reader["TenHocVi"].ToString(),
                                    NgayNhan = Convert.ToDateTime(reader["NgayNhan"]),
                                    MaGV = reader["MaGV"].ToString(),
                                    GiaoVien = new GiaoVien
                                    {
                                        MaGV = reader["MaGV"].ToString(),
                                        HoTen = reader["HoTen"].ToString(),
                                        BoMon = new BoMon
                                        {
                                            TenBM = reader["TenBM"].ToString(),
                                            Khoa = new Khoa
                                            {
                                                TenKhoa = reader["TenKhoa"].ToString()
                                            }
                                        }
                                    }
                                });
                            }

                            int totalRecords = (int)(totalRecordsParam.Value ?? 0);
                            return new PagedResultDto<HocVi>(hocVis, totalRecords, pageNumber, pageSize);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error searching hoc vi");
                throw;
            }
        }

        #endregion

        #region Quản lý quân hàm

        public async Task<(bool success, string message, string maQuanHam)> ThemQuanHamAsync(QuanHam quanHam)
        {
            var maQuanHamParam = new SqlParameter
            {
                ParameterName = "@MaQuanHam",
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
                    "EXEC sp_QuanHam_ThemMoi @MaGV, @TenQuanHam, @NgayNhan, @NgayKetThuc, @MaQuanHam OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", quanHam.MaGV),
                    new SqlParameter("@TenQuanHam", quanHam.TenQuanHam),
                    new SqlParameter("@NgayNhan", quanHam.NgayNhan),
                    new SqlParameter("@NgayKetThuc", quanHam.NgayKetThuc ?? (object)DBNull.Value),
                    maQuanHamParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maQuanHam = maQuanHamParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage, maQuanHam);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding quan ham: {@QuanHam}", quanHam);
                return (false, $"Lỗi khi thêm quân hàm: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> CapNhatQuanHamAsync(QuanHam quanHam)
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
                    "EXEC sp_QuanHam_CapNhat @MaQuanHam, @TenQuanHam, @NgayNhan, @NgayKetThuc, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaQuanHam", quanHam.MaQuanHam),
                    new SqlParameter("@TenQuanHam", quanHam.TenQuanHam),
                    new SqlParameter("@NgayNhan", quanHam.NgayNhan),
                    new SqlParameter("@NgayKetThuc", quanHam.NgayKetThuc ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating quan ham: {MaQuanHam}", quanHam.MaQuanHam);
                return (false, $"Lỗi khi cập nhật quân hàm: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> XoaQuanHamAsync(string maQuanHam)
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
                    "EXEC sp_QuanHam_Xoa @MaQuanHam, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaQuanHam", maQuanHam),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting quan ham: {MaQuanHam}", maQuanHam);
                return (false, $"Lỗi khi xóa quân hàm: {ex.Message}");
            }
        }

        public async Task<List<QuanHam>> GetQuanHamByGiaoVienAsync(string maGV)
        {
            try
            {
                return await _context.QuanHams
                    .Where(qh => qh.MaGV == maGV)
                    .Include(qh => qh.GiaoVien)
                    .OrderByDescending(qh => qh.NgayNhan)
                    .ToListAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting quan ham by giao vien: {MaGV}", maGV);
                throw;
            }
        }

        #endregion

        #region Utility Functions

        public async Task<(bool success, string message)> KhoiTaoDuLieuMauAsync()
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
                    "EXEC sp_Utility_KhoiTaoDuLieuMau @ErrorMessage OUTPUT",
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error initializing sample data");
                return (false, $"Lỗi khi khởi tạo dữ liệu mẫu: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> SaoLuuBangAsync(string tenBang, string tenBangSaoLuu = null)
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
                    "EXEC sp_Utility_SaoLuuBang @TenBang, @TenBangSaoLuu, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenBang", tenBang),
                    new SqlParameter("@TenBangSaoLuu", tenBangSaoLuu ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = !string.IsNullOrEmpty(errorMessage) && !errorMessage.StartsWith("Lỗi");

                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error backing up table: {TenBang}", tenBang);
                return (false, $"Lỗi khi sao lưu bảng: {ex.Message}");
            }
        }

        #endregion
    }
}