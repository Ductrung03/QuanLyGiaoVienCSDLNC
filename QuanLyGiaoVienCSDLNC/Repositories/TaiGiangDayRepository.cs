// Repositories/TaiGiangDayRepository.cs
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.DTOs.TaiGiangDay;
using QuanLyGiaoVienCSDLNC.DTOs.ChiTietGiangDay;
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

        #region TaiGiangDay CRUD Operations

        public async Task<List<TaiGiangDay>> GetAllTaiGiangDayAsync()
        {
            return await _context.TaiGiangDays.ToListAsync();
        }

        public async Task<TaiGiangDay> GetTaiGiangDayByIdAsync(string maTaiGiangDay)
        {
            return await _context.TaiGiangDays.FirstOrDefaultAsync(t => t.MaTaiGiangDay == maTaiGiangDay);
        }

        public async Task<PagedResultDto<TaiGiangDayListDto>> SearchTaiGiangDayAsync(TaiGiangDaySearchDto searchDto)
        {
            var query = from tgd in _context.TaiGiangDays
                        join dt in _context.DoiTuongGiangDays on tgd.MaDoiTuong equals dt.MaDoiTuong into dtGroup
                        from dt in dtGroup.DefaultIfEmpty()
                        join tg in _context.ThoiGianGiangDays on tgd.MaThoiGian equals tg.MaThoiGian into tgGroup
                        from tg in tgGroup.DefaultIfEmpty()
                        join nn in _context.NgonNguGiangDays on tgd.MaNgonNgu equals nn.MaNgonNgu into nnGroup
                        from nn in nnGroup.DefaultIfEmpty()
                        select new TaiGiangDayListDto
                        {
                            MaTaiGiangDay = tgd.MaTaiGiangDay,
                            TenHocPhan = tgd.TenHocPhan,
                            SiSo = tgd.SiSo,
                            He = tgd.He,
                            Lop = tgd.Lop,
                            SoTinChi = tgd.SoTinChi,
                            GhiChu = tgd.GhiChu,
                            NamHoc = tgd.NamHoc,
                            TenDoiTuong = dt != null ? dt.TenDoiTuong : "",
                            TenThoiGian = tg != null ? tg.TenThoiGian : "",
                            TenNgonNgu = nn != null ? nn.TenNgonNgu : "",
                            SoGiaoVienPhanCong = _context.ChiTietGiangDays.Count(c => c.MaTaiGiangDay == tgd.MaTaiGiangDay),
                            TrangThai = _context.ChiTietGiangDays.Any(c => c.MaTaiGiangDay == tgd.MaTaiGiangDay) ? "Đã phân công" : "Chưa phân công"
                        };

            // Apply filters
            if (!string.IsNullOrEmpty(searchDto.SearchText))
            {
                query = query.Where(x => x.TenHocPhan.Contains(searchDto.SearchText) ||
                                        x.Lop.Contains(searchDto.SearchText));
            }

            if (!string.IsNullOrEmpty(searchDto.NamHoc))
            {
                query = query.Where(x => x.NamHoc == searchDto.NamHoc);
            }

            if (!string.IsNullOrEmpty(searchDto.He))
            {
                query = query.Where(x => x.He == searchDto.He);
            }

            if (!string.IsNullOrEmpty(searchDto.MaDoiTuong))
            {
                query = query.Where(x => x.TenDoiTuong.Contains(searchDto.MaDoiTuong));
            }

            // Apply sorting
            switch (searchDto.SortBy?.ToLower())
            {
                case "tenhocphan":
                    query = searchDto.SortDesc ? query.OrderByDescending(x => x.TenHocPhan) : query.OrderBy(x => x.TenHocPhan);
                    break;
                case "namhoc":
                    query = searchDto.SortDesc ? query.OrderByDescending(x => x.NamHoc) : query.OrderBy(x => x.NamHoc);
                    break;
                case "lop":
                    query = searchDto.SortDesc ? query.OrderByDescending(x => x.Lop) : query.OrderBy(x => x.Lop);
                    break;
                default:
                    query = query.OrderBy(x => x.TenHocPhan);
                    break;
            }

            var totalRecords = await query.CountAsync();
            var data = await query
                .Skip((searchDto.PageNumber - 1) * searchDto.PageSize)
                .Take(searchDto.PageSize)
                .ToListAsync();

            return new PagedResultDto<TaiGiangDayListDto>(data, totalRecords, searchDto.PageNumber, searchDto.PageSize);
        }

        public async Task<(bool success, string message, string maTaiGiangDay)> AddTaiGiangDayAsync(TaiGiangDayCreateDto dto)
        {
            var maTaiGiangDayParam = new SqlParameter
            {
                ParameterName = "@MaTaiGiangDay",
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
                    "EXEC sp_TaiGiangDay_ThemMoi @TenHocPhan, @SiSo, @He, @Lop, @SoTinChi, @GhiChu, @NamHoc, @MaDoiTuong, @MaThoiGian, @MaNgonNgu, @MaTaiGiangDay OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@TenHocPhan", dto.TenHocPhan),
                    new SqlParameter("@SiSo", dto.SiSo),
                    new SqlParameter("@He", dto.He),
                    new SqlParameter("@Lop", dto.Lop),
                    new SqlParameter("@SoTinChi", dto.SoTinChi),
                    new SqlParameter("@GhiChu", dto.GhiChu ?? (object)DBNull.Value),
                    new SqlParameter("@NamHoc", dto.NamHoc),
                    new SqlParameter("@MaDoiTuong", dto.MaDoiTuong),
                    new SqlParameter("@MaThoiGian", dto.MaThoiGian),
                    new SqlParameter("@MaNgonNgu", dto.MaNgonNgu),
                    maTaiGiangDayParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maTaiGiangDay = maTaiGiangDayParam.Value?.ToString();

                var isSuccess = !string.IsNullOrEmpty(maTaiGiangDay);
                return (isSuccess, errorMessage, maTaiGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm tài giảng dạy: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateTaiGiangDayAsync(TaiGiangDayUpdateDto dto)
        {
            try
            {
                var taiGiangDay = await _context.TaiGiangDays.FindAsync(dto.MaTaiGiangDay);
                if (taiGiangDay == null)
                {
                    return (false, "Không tìm thấy tài giảng dạy");
                }

                taiGiangDay.TenHocPhan = dto.TenHocPhan;
                taiGiangDay.SiSo = dto.SiSo;
                taiGiangDay.He = dto.He;
                taiGiangDay.Lop = dto.Lop;
                taiGiangDay.SoTinChi = dto.SoTinChi;
                taiGiangDay.GhiChu = dto.GhiChu;
                taiGiangDay.NamHoc = dto.NamHoc;
                taiGiangDay.MaDoiTuong = dto.MaDoiTuong;
                taiGiangDay.MaThoiGian = dto.MaThoiGian;
                taiGiangDay.MaNgonNgu = dto.MaNgonNgu;

                await _context.SaveChangesAsync();
                return (true, "Cập nhật tài giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteTaiGiangDayAsync(string maTaiGiangDay)
        {
            try
            {
                // Kiểm tra xem có chi tiết giảng dạy nào không
                var hasChiTiet = await _context.ChiTietGiangDays.AnyAsync(c => c.MaTaiGiangDay == maTaiGiangDay);
                if (hasChiTiet)
                {
                    return (false, "Không thể xóa tài giảng dạy đã có phân công giáo viên");
                }

                var taiGiangDay = await _context.TaiGiangDays.FindAsync(maTaiGiangDay);
                if (taiGiangDay == null)
                {
                    return (false, "Không tìm thấy tài giảng dạy");
                }

                _context.TaiGiangDays.Remove(taiGiangDay);
                await _context.SaveChangesAsync();
                return (true, "Xóa tài giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa tài giảng dạy: {ex.Message}");
            }
        }

        #endregion

        #region ChiTietGiangDay Operations

        public async Task<(bool success, string message, string maChiTietGiangDay)> PhanCongGiangDayAsync(ChiTietGiangDayCreateDto dto)
        {
            var maChiTietGiangDayParam = new SqlParameter
            {
                ParameterName = "@MaChiTietGiangDay",
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
                    "EXEC sp_GiangDay_PhanCong @MaGV, @MaTaiGiangDay, @SoTiet, @GhiChu, @MaNoiDungGiangDay, @CheckConflict, @MaChiTietGiangDay OUTPUT, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaGV", dto.MaGV),
                    new SqlParameter("@MaTaiGiangDay", dto.MaTaiGiangDay),
                    new SqlParameter("@SoTiet", dto.SoTiet),
                    new SqlParameter("@GhiChu", dto.GhiChu ?? (object)DBNull.Value),
                    new SqlParameter("@MaNoiDungGiangDay", dto.MaNoiDungGiangDay ?? (object)DBNull.Value),
                    new SqlParameter("@CheckConflict", dto.CheckConflict),
                    maChiTietGiangDayParam,
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var maChiTietGiangDay = maChiTietGiangDayParam.Value?.ToString();

                var isSuccess = !string.IsNullOrEmpty(maChiTietGiangDay);
                return (isSuccess, errorMessage, maChiTietGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công giảng dạy: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateChiTietGiangDayAsync(ChiTietGiangDayUpdateDto dto)
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
                    "EXEC sp_GiangDay_CapNhat @MaChiTietGiangDay, @SoTiet, @GhiChu, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaChiTietGiangDay", dto.MaChiTietGiangDay),
                    new SqlParameter("@SoTiet", dto.SoTiet),
                    new SqlParameter("@GhiChu", dto.GhiChu ?? (object)DBNull.Value),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = errorMessage.Contains("thành công");
                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật chi tiết giảng dạy: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> XoaPhanCongGiangDayAsync(string maChiTietGiangDay)
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
                    "EXEC sp_GiangDay_XoaPhanCong @MaChiTietGiangDay, @ErrorMessage OUTPUT",
                    new SqlParameter("@MaChiTietGiangDay", maChiTietGiangDay),
                    errorMessageParam);

                var errorMessage = errorMessageParam.Value?.ToString();
                var isSuccess = errorMessage.Contains("thành công");
                return (isSuccess, errorMessage);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa phân công giảng dạy: {ex.Message}");
            }
        }

        public async Task<PagedResultDto<ChiTietGiangDayListDto>> GetDanhSachGiangDayAsync(string maGV = null, string namHoc = null, int pageNumber = 1, int pageSize = 20)
        {
            var totalRecordsParam = new SqlParameter
            {
                ParameterName = "@TotalRecords",
                SqlDbType = SqlDbType.Int,
                Direction = ParameterDirection.Output
            };

            var result = new List<ChiTietGiangDayListDto>();

            try
            {
                using (var command = _context.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "sp_GiangDay_DanhSach";
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@PageNumber", pageNumber));
                    command.Parameters.Add(new SqlParameter("@PageSize", pageSize));
                    command.Parameters.Add(totalRecordsParam);

                    await _context.Database.OpenConnectionAsync();

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            result.Add(new ChiTietGiangDayListDto
                            {
                                MaChiTietGiangDay = reader["MaChiTietGiangDay"].ToString(),
                                MaGV = reader["MaGV"].ToString(),
                                HoTen = reader["HoTen"].ToString(),
                                MaTaiGiangDay = reader["MaTaiGiangDay"].ToString(),
                                TenHocPhan = reader["TenHocPhan"].ToString(),
                                Lop = reader["Lop"].ToString(),
                                SiSo = Convert.ToInt32(reader["SiSo"]),
                                SoTinChi = Convert.ToInt32(reader["SoTinChi"]),
                                He = reader["He"].ToString(),
                                NamHoc = reader["NamHoc"].ToString(),
                                SoTiet = Convert.ToInt32(reader["SoTiet"]),
                                SoTietQuyDoi = Convert.ToSingle(reader["SoTietQuyDoi"]),
                                GhiChu = reader["GhiChu"].ToString(),
                                TenDoiTuong = reader["TenDoiTuong"].ToString(),
                                TenThoiGian = reader["TenThoiGian"].ToString(),
                                TenNgonNgu = reader["TenNgonNgu"].ToString()
                            });
                        }
                    }
                }

                var totalRecords = totalRecordsParam.Value != DBNull.Value ? Convert.ToInt32(totalRecordsParam.Value) : 0;
                return new PagedResultDto<ChiTietGiangDayListDto>(result, totalRecords, pageNumber, pageSize);
            }
            catch (Exception ex)
            {
                return new PagedResultDto<ChiTietGiangDayListDto>(new List<ChiTietGiangDayListDto>(), 0, pageNumber, pageSize);
            }
        }

        public async Task<List<ChiTietGiangDay>> GetChiTietGiangDayByTaiGiangDayAsync(string maTaiGiangDay)
        {
            return await _context.ChiTietGiangDays
                .Include(c => c.GiaoVien)
                .Where(c => c.MaTaiGiangDay == maTaiGiangDay)
                .ToListAsync();
        }

        public async Task<List<ChiTietGiangDay>> GetChiTietGiangDayByGiaoVienAsync(string maGV)
        {
            return await _context.ChiTietGiangDays
                .Include(c => c.TaiGiangDay)
                .Where(c => c.MaGV == maGV)
                .ToListAsync();
        }

        #endregion

        #region Lookup Data

        public async Task<List<DoiTuongGiangDay>> GetAllDoiTuongGiangDayAsync()
        {
            return await _context.DoiTuongGiangDays.ToListAsync();
        }

        public async Task<List<ThoiGianGiangDay>> GetAllThoiGianGiangDayAsync()
        {
            return await _context.ThoiGianGiangDays.ToListAsync();
        }

        public async Task<List<NgonNguGiangDay>> GetAllNgonNguGiangDayAsync()
        {
            return await _context.NgonNguGiangDays.ToListAsync();
        }

        public async Task<List<string>> GetDistinctNamHocAsync()
        {
            return await _context.TaiGiangDays
                .Select(t => t.NamHoc)
                .Distinct()
                .OrderByDescending(n => n)
                .ToListAsync();
        }

        public async Task<List<string>> GetDistinctHeAsync()
        {
            return await _context.TaiGiangDays
                .Select(t => t.He)
                .Distinct()
                .OrderBy(h => h)
                .ToListAsync();
        }

        #endregion
    }
}