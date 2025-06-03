using QuanLyGiaoVienCSDLNC.DTOs.GiaoVien;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.DTOs.HocVi;
using QuanLyGiaoVienCSDLNC.DTOs.LyLichKhoaHoc;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;
using System.Data;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class GiaoVienService : IGiaoVienService
    {
        private readonly IGiaoVienRepository _giaoVienRepository;
        private readonly IBoMonRepository _boMonRepository;
        private readonly ILogger<GiaoVienService> _logger;

        public GiaoVienService(
            IGiaoVienRepository giaoVienRepository,
            IBoMonRepository boMonRepository,
            ILogger<GiaoVienService> logger)
        {
            _giaoVienRepository = giaoVienRepository;
            _boMonRepository = boMonRepository;
            _logger = logger;
        }

        #region CRUD Operations

        public async Task<List<GiaoVien>> GetAllGiaoVienAsync()
        {
            try
            {
                return await _giaoVienRepository.GetAllGiaoVienAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetAllGiaoVienAsync");
                throw;
            }
        }

        public async Task<GiaoVien> GetGiaoVienByIdAsync(string maGV)
        {
            try
            {
                if (string.IsNullOrEmpty(maGV))
                    return null;

                return await _giaoVienRepository.GetGiaoVienByIdAsync(maGV);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetGiaoVienByIdAsync: {MaGV}", maGV);
                throw;
            }
        }

        public async Task<ApiResponseDto<string>> AddGiaoVienAsync(GiaoVienCreateDto dto)
        {
            try
            {
                // Validate input data
                var validationResult = await ValidateGiaoVienDataAsync(dto);
                if (!validationResult.Success)
                {
                    return ApiResponseDto<string>.ErrorResult(validationResult.Message, validationResult.Errors);
                }

                // Check business rules
                if (await CheckEmailExistsAsync(dto.Email))
                {
                    return ApiResponseDto<string>.ErrorResult("Email đã tồn tại trong hệ thống");
                }

                if (await CheckSDTExistsAsync(dto.SDT))
                {
                    return ApiResponseDto<string>.ErrorResult("Số điện thoại đã tồn tại trong hệ thống");
                }

                // Check age constraint
                var age = DateTime.Today.Year - dto.NgaySinh.Year;
                if (dto.NgaySinh.Date > DateTime.Today.AddYears(-age)) age--;

                if (age < 22)
                {
                    return ApiResponseDto<string>.ErrorResult("Giáo viên phải từ 22 tuổi trở lên");
                }

                if (age > 70)
                {
                    return ApiResponseDto<string>.ErrorResult("Giáo viên không thể trên 70 tuổi");
                }

                // Add to database
                var result = await _giaoVienRepository.AddGiaoVienAsync(dto);

                if (result.success)
                {
                    _logger.LogInformation("Successfully added giao vien: {MaGV}", result.maGV);
                    return ApiResponseDto<string>.SuccessResult(result.maGV, result.message);
                }
                else
                {
                    _logger.LogWarning("Failed to add giao vien: {Message}", result.message);
                    return ApiResponseDto<string>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in AddGiaoVienAsync: {@Dto}", dto);
                return ApiResponseDto<string>.ErrorResult("Lỗi hệ thống khi thêm giáo viên");
            }
        }

        public async Task<ApiResponseDto<bool>> UpdateGiaoVienAsync(GiaoVienUpdateDto dto)
        {
            try
            {
                // Validate input data
                var validationResult = await ValidateGiaoVienUpdateDataAsync(dto);
                if (!validationResult.Success)
                {
                    return ApiResponseDto<bool>.ErrorResult(validationResult.Message, validationResult.Errors);
                }

                // Check if giao vien exists
                var existingGiaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(dto.MaGV);
                if (existingGiaoVien == null)
                {
                    return ApiResponseDto<bool>.ErrorResult("Không tìm thấy giáo viên");
                }

                // Check email uniqueness (exclude current record)
                if (await CheckEmailExistsAsync(dto.Email, dto.MaGV))
                {
                    return ApiResponseDto<bool>.ErrorResult("Email đã được sử dụng bởi giáo viên khác");
                }

                // Check SDT uniqueness (exclude current record)
                if (await CheckSDTExistsAsync(dto.SDT, dto.MaGV))
                {
                    return ApiResponseDto<bool>.ErrorResult("Số điện thoại đã được sử dụng bởi giáo viên khác");
                }

                // Update to database
                var result = await _giaoVienRepository.UpdateGiaoVienAsync(dto);

                if (result.success)
                {
                    _logger.LogInformation("Successfully updated giao vien: {MaGV}", dto.MaGV);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    _logger.LogWarning("Failed to update giao vien: {Message}", result.message);
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in UpdateGiaoVienAsync: {@Dto}", dto);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi cập nhật giáo viên");
            }
        }

        public async Task<ApiResponseDto<bool>> DeleteGiaoVienAsync(string maGV, bool forceDelete = false)
        {
            try
            {
                if (string.IsNullOrEmpty(maGV))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã giáo viên không được để trống");
                }

                // Check if giao vien exists
                var existingGiaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(maGV);
                if (existingGiaoVien == null)
                {
                    return ApiResponseDto<bool>.ErrorResult("Không tìm thấy giáo viên");
                }

                // Delete from database
                var result = await _giaoVienRepository.DeleteGiaoVienAsync(maGV, forceDelete);

                if (result.success)
                {
                    _logger.LogInformation("Successfully deleted giao vien: {MaGV}", maGV);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    _logger.LogWarning("Failed to delete giao vien: {Message}", result.message);
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in DeleteGiaoVienAsync: {MaGV}", maGV);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi xóa giáo viên");
            }
        }

        #endregion

        #region Search and Filtering

        public async Task<ApiResponseDto<PagedResultDto<GiaoVienListItemDto>>> SearchGiaoVienAsync(GiaoVienSearchDto searchDto)
        {
            try
            {
                // Validate search parameters
                if (searchDto.PageNumber < 1) searchDto.PageNumber = 1;
                if (searchDto.PageSize < 1 || searchDto.PageSize > 100) searchDto.PageSize = 20;

                var result = await _giaoVienRepository.SearchGiaoVienAsync(searchDto);
                return ApiResponseDto<PagedResultDto<GiaoVienListItemDto>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in SearchGiaoVienAsync: {@SearchDto}", searchDto);
                return ApiResponseDto<PagedResultDto<GiaoVienListItemDto>>.ErrorResult("Lỗi hệ thống khi tìm kiếm giáo viên");
            }
        }

        public async Task<List<GiaoVien>> SearchGiaoVienSimpleAsync(string searchTerm, string maBM = null, string maKhoa = null)
        {
            try
            {
                return await _giaoVienRepository.SearchGiaoVienSimpleAsync(searchTerm, maBM, maKhoa);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in SearchGiaoVienSimpleAsync");
                throw;
            }
        }

        #endregion

        #region Detail Information

        public async Task<ApiResponseDto<GiaoVienDetailDto>> GetChiTietGiaoVienAsync(string maGV)
        {
            try
            {
                if (string.IsNullOrEmpty(maGV))
                {
                    return ApiResponseDto<GiaoVienDetailDto>.ErrorResult("Mã giáo viên không được để trống");
                }

                var result = await _giaoVienRepository.GetChiTietGiaoVienAsync(maGV);

                if (result?.ThongTinCoBan == null)
                {
                    return ApiResponseDto<GiaoVienDetailDto>.ErrorResult("Không tìm thấy thông tin giáo viên");
                }

                // Get statistics
                result.ThongKe = await _giaoVienRepository.GetThongKeGiaoVienAsync(maGV);

                return ApiResponseDto<GiaoVienDetailDto>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetChiTietGiaoVienAsync: {MaGV}", maGV);
                return ApiResponseDto<GiaoVienDetailDto>.ErrorResult("Lỗi hệ thống khi lấy thông tin chi tiết giáo viên");
            }
        }

        #endregion

        #region Academic Information Management

        public async Task<ApiResponseDto<bool>> CapNhatHocViAsync(HocViCreateDto dto)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(dto.MaGV))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã giáo viên không được để trống");
                }

                if (string.IsNullOrEmpty(dto.TenHocVi))
                {
                    return ApiResponseDto<bool>.ErrorResult("Tên học vị không được để trống");
                }

                if (dto.NgayNhan > DateTime.Today)
                {
                    return ApiResponseDto<bool>.ErrorResult("Ngày nhận không thể trong tương lai");
                }

                // Check if giao vien exists
                var existingGiaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(dto.MaGV);
                if (existingGiaoVien == null)
                {
                    return ApiResponseDto<bool>.ErrorResult("Không tìm thấy giáo viên");
                }

                var result = await _giaoVienRepository.CapNhatHocViAsync(dto);

                if (result.success)
                {
                    _logger.LogInformation("Successfully updated hoc vi for giao vien: {MaGV}", dto.MaGV);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in CapNhatHocViAsync: {@Dto}", dto);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi cập nhật học vị");
            }
        }

        public async Task<ApiResponseDto<bool>> CapNhatHocHamAsync(string maGV, string maHocHam, DateTime ngayNhan)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(maGV))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã giáo viên không được để trống");
                }

                if (string.IsNullOrEmpty(maHocHam))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã học hàm không được để trống");
                }

                if (ngayNhan > DateTime.Today)
                {
                    return ApiResponseDto<bool>.ErrorResult("Ngày nhận không thể trong tương lai");
                }

                // Check if giao vien exists
                var existingGiaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(maGV);
                if (existingGiaoVien == null)
                {
                    return ApiResponseDto<bool>.ErrorResult("Không tìm thấy giáo viên");
                }

                var result = await _giaoVienRepository.CapNhatHocHamAsync(maGV, maHocHam, ngayNhan);

                if (result.success)
                {
                    _logger.LogInformation("Successfully updated hoc ham for giao vien: {MaGV}", maGV);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in CapNhatHocHamAsync: {MaGV}, {MaHocHam}", maGV, maHocHam);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi cập nhật học hàm");
            }
        }

        public async Task<ApiResponseDto<bool>> CapNhatLyLichKhoaHocAsync(LyLichKhoaHocDto dto)
        {
            try
            {
                // Validate input
                var validationErrors = ValidateLyLichKhoaHoc(dto);
                if (validationErrors.Any())
                {
                    return ApiResponseDto<bool>.ErrorResult("Dữ liệu không hợp lệ", validationErrors);
                }

                // Check if giao vien exists
                var existingGiaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(dto.MaGV);
                if (existingGiaoVien == null)
                {
                    return ApiResponseDto<bool>.ErrorResult("Không tìm thấy giáo viên");
                }

                var result = await _giaoVienRepository.CapNhatLyLichKhoaHocAsync(dto);

                if (result.success)
                {
                    _logger.LogInformation("Successfully updated ly lich khoa hoc for giao vien: {MaGV}", dto.MaGV);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in CapNhatLyLichKhoaHocAsync: {@Dto}", dto);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi cập nhật lý lịch khoa học");
            }
        }

        #endregion

        #region Position Management

        public async Task<ApiResponseDto<bool>> PhanCongChucVuAsync(string maGV, string maChucVu, DateTime? ngayNhan = null)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(maGV))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã giáo viên không được để trống");
                }

                if (string.IsNullOrEmpty(maChucVu))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã chức vụ không được để trống");
                }

                // Check if giao vien exists
                var existingGiaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(maGV);
                if (existingGiaoVien == null)
                {
                    return ApiResponseDto<bool>.ErrorResult("Không tìm thấy giáo viên");
                }

                var result = await _giaoVienRepository.PhanCongChucVuAsync(maGV, maChucVu, ngayNhan);

                if (result.success)
                {
                    _logger.LogInformation("Successfully assigned chuc vu for giao vien: {MaGV}, {MaChucVu}", maGV, maChucVu);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in PhanCongChucVuAsync: {MaGV}, {MaChucVu}", maGV, maChucVu);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi phân công chức vụ");
            }
        }

        public async Task<ApiResponseDto<bool>> KetThucChucVuAsync(string maGV, string maChucVu, DateTime? ngayKetThuc = null)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(maGV))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã giáo viên không được để trống");
                }

                if (string.IsNullOrEmpty(maChucVu))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã chức vụ không được để trống");
                }

                var result = await _giaoVienRepository.KetThucChucVuAsync(maGV, maChucVu, ngayKetThuc);

                if (result.success)
                {
                    _logger.LogInformation("Successfully ended chuc vu for giao vien: {MaGV}, {MaChucVu}", maGV, maChucVu);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in KetThucChucVuAsync: {MaGV}, {MaChucVu}", maGV, maChucVu);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi kết thúc chức vụ");
            }
        }

        #endregion

        #region Statistics and Reports

        public async Task<ApiResponseDto<ThongKeGiaoVien>> GetThongKeGiaoVienAsync(string maGV, string namHoc = null)
        {
            try
            {
                if (string.IsNullOrEmpty(maGV))
                {
                    return ApiResponseDto<ThongKeGiaoVien>.ErrorResult("Mã giáo viên không được để trống");
                }

                var result = await _giaoVienRepository.GetThongKeGiaoVienAsync(maGV, namHoc);
                return ApiResponseDto<ThongKeGiaoVien>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetThongKeGiaoVienAsync: {MaGV}", maGV);
                return ApiResponseDto<ThongKeGiaoVien>.ErrorResult("Lỗi hệ thống khi lấy thống kê giáo viên");
            }
        }

        public async Task<ApiResponseDto<DataTable>> GetBaoCaoGiangDayAsync(string maGV, string namHoc = null)
        {
            try
            {
                var result = await _giaoVienRepository.GetBaoCaoGiangDayAsync(maGV, namHoc);
                return ApiResponseDto<DataTable>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetBaoCaoGiangDayAsync: {MaGV}", maGV);
                return ApiResponseDto<DataTable>.ErrorResult("Lỗi hệ thống khi lấy báo cáo giảng dạy");
            }
        }

        public async Task<ApiResponseDto<DataTable>> GetBaoCaoNCKHAsync(string maGV, string namHoc = null)
        {
            try
            {
                var result = await _giaoVienRepository.GetBaoCaoNCKHAsync(maGV, namHoc);
                return ApiResponseDto<DataTable>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetBaoCaoNCKHAsync: {MaGV}", maGV);
                return ApiResponseDto<DataTable>.ErrorResult("Lỗi hệ thống khi lấy báo cáo NCKH");
            }
        }

        public async Task<ApiResponseDto<DataTable>> GetBaoCaoTongHopAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            try
            {
                var result = await _giaoVienRepository.GetBaoCaoTongHopAsync(maGV, maBM, maKhoa, namHoc);
                return ApiResponseDto<DataTable>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetBaoCaoTongHopAsync");
                return ApiResponseDto<DataTable>.ErrorResult("Lỗi hệ thống khi lấy báo cáo tổng hợp");
            }
        }

        #endregion

        #region Validation

        public async Task<ApiResponseDto<bool>> ValidateGiaoVienDataAsync(GiaoVienCreateDto dto, string excludeMaGV = null)
        {
            var errors = new List<string>();

            // Basic validation
            if (string.IsNullOrWhiteSpace(dto.HoTen))
                errors.Add("Họ tên không được để trống");

            if (dto.NgaySinh > DateTime.Today)
                errors.Add("Ngày sinh không thể trong tương lai");

            if (string.IsNullOrWhiteSpace(dto.Email))
                errors.Add("Email không được để trống");
            else if (!IsValidEmail(dto.Email))
                errors.Add("Email không đúng định dạng");

            if (dto.SDT < 100000000 || dto.SDT > 999999999)
                errors.Add("Số điện thoại phải có 9 chữ số");

            if (string.IsNullOrWhiteSpace(dto.MaBM))
                errors.Add("Bộ môn không được để trống");

            // Check if bo mon exists
            if (!string.IsNullOrEmpty(dto.MaBM))
            {
                var boMon = await _boMonRepository.GetBoMonByIdAsync(dto.MaBM);
                if (boMon == null)
                    errors.Add("Bộ môn không tồn tại");
            }

            if (errors.Any())
            {
                return ApiResponseDto<bool>.ErrorResult("Dữ liệu không hợp lệ", errors);
            }

            return ApiResponseDto<bool>.SuccessResult(true);
        }

        private async Task<ApiResponseDto<bool>> ValidateGiaoVienUpdateDataAsync(GiaoVienUpdateDto dto)
        {
            var errors = new List<string>();

            // Basic validation
            if (string.IsNullOrWhiteSpace(dto.MaGV))
                errors.Add("Mã giáo viên không được để trống");

            if (string.IsNullOrWhiteSpace(dto.HoTen))
                errors.Add("Họ tên không được để trống");

            if (dto.NgaySinh > DateTime.Today)
                errors.Add("Ngày sinh không thể trong tương lai");

            if (string.IsNullOrWhiteSpace(dto.Email))
                errors.Add("Email không được để trống");
            else if (!IsValidEmail(dto.Email))
                errors.Add("Email không đúng định dạng");

            if (dto.SDT < 100000000 || dto.SDT > 999999999)
                errors.Add("Số điện thoại phải có 9 chữ số");

            if (string.IsNullOrWhiteSpace(dto.MaBM))
                errors.Add("Bộ môn không được để trống");

            // Check if bo mon exists
            if (!string.IsNullOrEmpty(dto.MaBM))
            {
                var boMon = await _boMonRepository.GetBoMonByIdAsync(dto.MaBM);
                if (boMon == null)
                    errors.Add("Bộ môn không tồn tại");
            }

            if (errors.Any())
            {
                return ApiResponseDto<bool>.ErrorResult("Dữ liệu không hợp lệ", errors);
            }

            return ApiResponseDto<bool>.SuccessResult(true);
        }

        private List<string> ValidateLyLichKhoaHoc(LyLichKhoaHocDto dto)
        {
            var errors = new List<string>();

            if (string.IsNullOrWhiteSpace(dto.MaGV))
                errors.Add("Mã giáo viên không được để trống");

            if (string.IsNullOrWhiteSpace(dto.HeDaoTaoDH))
                errors.Add("Hệ đào tạo đại học không được để trống");

            if (string.IsNullOrWhiteSpace(dto.NoiDaoTaoDH))
                errors.Add("Nơi đào tạo đại học không được để trống");

            if (string.IsNullOrWhiteSpace(dto.NganhHocDH))
                errors.Add("Ngành học đại học không được để trống");

            if (dto.NamTotNghiepDH.HasValue && (dto.NamTotNghiepDH < 1950 || dto.NamTotNghiepDH > DateTime.Today.Year))
                errors.Add("Năm tốt nghiệp đại học không hợp lệ");

            if (dto.NamCapBangTS.HasValue && (dto.NamCapBangTS < 1950 || dto.NamCapBangTS > DateTime.Today.Year))
                errors.Add("Năm cấp bằng tiến sĩ không hợp lệ");

            if (dto.NamCapBangSauDH.HasValue && (dto.NamCapBangSauDH < 1950 || dto.NamCapBangSauDH > DateTime.Today.Year))
                errors.Add("Năm cấp bằng sau đại học không hợp lệ");

            return errors;
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> CheckEmailExistsAsync(string email, string excludeMaGV = null)
        {
            return await _giaoVienRepository.CheckEmailExistsAsync(email, excludeMaGV);
        }

        public async Task<bool> CheckSDTExistsAsync(int sdt, string excludeMaGV = null)
        {
            return await _giaoVienRepository.CheckSDTExistsAsync(sdt, excludeMaGV);
        }

        #endregion

        #region Dashboard and Statistics

        public async Task<ApiResponseDto<object>> GetDashboardDataAsync()
        {
            try
            {
                var result = await _giaoVienRepository.GetDashboardDataAsync();
                return ApiResponseDto<object>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetDashboardDataAsync");
                return ApiResponseDto<object>.ErrorResult("Lỗi hệ thống khi lấy dữ liệu dashboard");
            }
        }

        public async Task<ApiResponseDto<List<object>>> GetTopGiaoVienByGiangDayAsync(int top = 10, string namHoc = null)
        {
            try
            {
                var result = await _giaoVienRepository.GetTopGiaoVienByGiangDayAsync(top, namHoc);
                return ApiResponseDto<List<object>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetTopGiaoVienByGiangDayAsync");
                return ApiResponseDto<List<object>>.ErrorResult("Lỗi hệ thống khi lấy top giáo viên");
            }
        }

        public async Task<ApiResponseDto<List<object>>> GetGiaoVienChuaHoanThanhDinhMucAsync(string namHoc = null)
        {
            try
            {
                var result = await _giaoVienRepository.GetGiaoVienChuaHoanThanhDinhMucAsync(namHoc);
                return ApiResponseDto<List<object>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetGiaoVienChuaHoanThanhDinhMucAsync");
                return ApiResponseDto<List<object>>.ErrorResult("Lỗi hệ thống khi lấy danh sách giáo viên chưa hoàn thành định mức");
            }
        }

        #endregion

        #region Export

        public async Task<ApiResponseDto<byte[]>> ExportGiaoVienToExcelAsync(GiaoVienSearchDto searchDto = null)
        {
            try
            {
                var result = await _giaoVienRepository.ExportGiaoVienToExcelAsync(searchDto);
                return ApiResponseDto<byte[]>.SuccessResult(result, "Xuất Excel thành công");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ExportGiaoVienToExcelAsync");
                return ApiResponseDto<byte[]>.ErrorResult("Lỗi hệ thống khi xuất Excel");
            }
        }

        public async Task<ApiResponseDto<byte[]>> ExportGiaoVienToPdfAsync(string maGV)
        {
            try
            {
                if (string.IsNullOrEmpty(maGV))
                {
                    return ApiResponseDto<byte[]>.ErrorResult("Mã giáo viên không được để trống");
                }

                var result = await _giaoVienRepository.ExportGiaoVienToPdfAsync(maGV);
                return ApiResponseDto<byte[]>.SuccessResult(result, "Xuất PDF thành công");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ExportGiaoVienToPdfAsync: {MaGV}", maGV);
                return ApiResponseDto<byte[]>.ErrorResult("Lỗi hệ thống khi xuất PDF");
            }
        }

        #endregion

        #region Utility

        public async Task<List<GiaoVien>> GetGiaoVienByBoMonAsync(string maBM)
        {
            try
            {
                return await _giaoVienRepository.GetGiaoVienByBoMonAsync(maBM);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetGiaoVienByBoMonAsync: {MaBM}", maBM);
                throw;
            }
        }

        public async Task<List<GiaoVien>> GetGiaoVienByKhoaAsync(string maKhoa)
        {
            try
            {
                return await _giaoVienRepository.GetGiaoVienByKhoaAsync(maKhoa);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetGiaoVienByKhoaAsync: {MaKhoa}", maKhoa);
                throw;
            }
        }

        public async Task<int> GetTotalGiaoVienCountAsync()
        {
            try
            {
                return await _giaoVienRepository.GetTotalGiaoVienCountAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetTotalGiaoVienCountAsync");
                throw;
            }
        }

        #endregion

        // Thêm các method sau vào class GiaoVienService

        #region Quản lý học vị đầy đủ

        public async Task<ApiResponseDto<string>> ThemHocViAsync(HocVi hocVi)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(hocVi.MaGV))
                {
                    return ApiResponseDto<string>.ErrorResult("Mã giáo viên không được để trống");
                }

                if (string.IsNullOrEmpty(hocVi.TenHocVi))
                {
                    return ApiResponseDto<string>.ErrorResult("Tên học vị không được để trống");
                }

                if (hocVi.NgayNhan > DateTime.Today)
                {
                    return ApiResponseDto<string>.ErrorResult("Ngày nhận không thể trong tương lai");
                }

                // Check if giao vien exists
                var existingGiaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(hocVi.MaGV);
                if (existingGiaoVien == null)
                {
                    return ApiResponseDto<string>.ErrorResult("Không tìm thấy giáo viên");
                }

                var result = await _giaoVienRepository.ThemHocViAsync(hocVi);

                if (result.success)
                {
                    _logger.LogInformation("Successfully added hoc vi: {MaHocVi} for giao vien: {MaGV}", result.maHocVi, hocVi.MaGV);
                    return ApiResponseDto<string>.SuccessResult(result.maHocVi, result.message);
                }
                else
                {
                    return ApiResponseDto<string>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ThemHocViAsync: {@HocVi}", hocVi);
                return ApiResponseDto<string>.ErrorResult("Lỗi hệ thống khi thêm học vị");
            }
        }

        public async Task<ApiResponseDto<bool>> CapNhatHocViAsync(HocVi hocVi)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(hocVi.MaHocVi))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã học vị không được để trống");
                }

                if (string.IsNullOrEmpty(hocVi.TenHocVi))
                {
                    return ApiResponseDto<bool>.ErrorResult("Tên học vị không được để trống");
                }

                if (hocVi.NgayNhan > DateTime.Today)
                {
                    return ApiResponseDto<bool>.ErrorResult("Ngày nhận không thể trong tương lai");
                }

                var result = await _giaoVienRepository.CapNhatHocViAsync(hocVi);

                if (result.success)
                {
                    _logger.LogInformation("Successfully updated hoc vi: {MaHocVi}", hocVi.MaHocVi);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in CapNhatHocViAsync: {@HocVi}", hocVi);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi cập nhật học vị");
            }
        }

        public async Task<ApiResponseDto<bool>> XoaHocViAsync(string maHocVi)
        {
            try
            {
                if (string.IsNullOrEmpty(maHocVi))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã học vị không được để trống");
                }

                var result = await _giaoVienRepository.XoaHocViAsync(maHocVi);

                if (result.success)
                {
                    _logger.LogInformation("Successfully deleted hoc vi: {MaHocVi}", maHocVi);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in XoaHocViAsync: {MaHocVi}", maHocVi);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi xóa học vị");
            }
        }

        public async Task<ApiResponseDto<PagedResultDto<HocVi>>> TimKiemHocViAsync(string maGV = null, string tenHocVi = null, DateTime? tuNgay = null, DateTime? denNgay = null, int pageNumber = 1, int pageSize = 20)
        {
            try
            {
                // Validate search parameters
                if (pageNumber < 1) pageNumber = 1;
                if (pageSize < 1 || pageSize > 100) pageSize = 20;

                var result = await _giaoVienRepository.TimKiemHocViAsync(maGV, tenHocVi, tuNgay, denNgay, pageNumber, pageSize);
                return ApiResponseDto<PagedResultDto<HocVi>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in TimKiemHocViAsync");
                return ApiResponseDto<PagedResultDto<HocVi>>.ErrorResult("Lỗi hệ thống khi tìm kiếm học vị");
            }
        }

        #endregion

        #region Quản lý quân hàm

        public async Task<ApiResponseDto<string>> ThemQuanHamAsync(QuanHam quanHam)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(quanHam.MaGV))
                {
                    return ApiResponseDto<string>.ErrorResult("Mã giáo viên không được để trống");
                }

                if (string.IsNullOrEmpty(quanHam.TenQuanHam))
                {
                    return ApiResponseDto<string>.ErrorResult("Tên quân hàm không được để trống");
                }

                if (quanHam.NgayNhan > DateTime.Today)
                {
                    return ApiResponseDto<string>.ErrorResult("Ngày nhận không thể trong tương lai");
                }

                if (quanHam.NgayKetThuc.HasValue && quanHam.NgayKetThuc <= quanHam.NgayNhan)
                {
                    return ApiResponseDto<string>.ErrorResult("Ngày kết thúc phải sau ngày nhận");
                }

                // Check if giao vien exists
                var existingGiaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(quanHam.MaGV);
                if (existingGiaoVien == null)
                {
                    return ApiResponseDto<string>.ErrorResult("Không tìm thấy giáo viên");
                }

                var result = await _giaoVienRepository.ThemQuanHamAsync(quanHam);

                if (result.success)
                {
                    _logger.LogInformation("Successfully added quan ham: {MaQuanHam} for giao vien: {MaGV}", result.maQuanHam, quanHam.MaGV);
                    return ApiResponseDto<string>.SuccessResult(result.maQuanHam, result.message);
                }
                else
                {
                    return ApiResponseDto<string>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ThemQuanHamAsync: {@QuanHam}", quanHam);
                return ApiResponseDto<string>.ErrorResult("Lỗi hệ thống khi thêm quân hàm");
            }
        }

        public async Task<ApiResponseDto<bool>> CapNhatQuanHamAsync(QuanHam quanHam)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(quanHam.MaQuanHam))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã quân hàm không được để trống");
                }

                if (string.IsNullOrEmpty(quanHam.TenQuanHam))
                {
                    return ApiResponseDto<bool>.ErrorResult("Tên quân hàm không được để trống");
                }

                if (quanHam.NgayNhan > DateTime.Today)
                {
                    return ApiResponseDto<bool>.ErrorResult("Ngày nhận không thể trong tương lai");
                }

                if (quanHam.NgayKetThuc.HasValue && quanHam.NgayKetThuc <= quanHam.NgayNhan)
                {
                    return ApiResponseDto<bool>.ErrorResult("Ngày kết thúc phải sau ngày nhận");
                }

                var result = await _giaoVienRepository.CapNhatQuanHamAsync(quanHam);

                if (result.success)
                {
                    _logger.LogInformation("Successfully updated quan ham: {MaQuanHam}", quanHam.MaQuanHam);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in CapNhatQuanHamAsync: {@QuanHam}", quanHam);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi cập nhật quân hàm");
            }
        }

        public async Task<ApiResponseDto<bool>> XoaQuanHamAsync(string maQuanHam)
        {
            try
            {
                if (string.IsNullOrEmpty(maQuanHam))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã quân hàm không được để trống");
                }

                var result = await _giaoVienRepository.XoaQuanHamAsync(maQuanHam);

                if (result.success)
                {
                    _logger.LogInformation("Successfully deleted quan ham: {MaQuanHam}", maQuanHam);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in XoaQuanHamAsync: {MaQuanHam}", maQuanHam);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi xóa quân hàm");
            }
        }

        public async Task<List<QuanHam>> GetQuanHamByGiaoVienAsync(string maGV)
        {
            try
            {
                return await _giaoVienRepository.GetQuanHamByGiaoVienAsync(maGV);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GetQuanHamByGiaoVienAsync: {MaGV}", maGV);
                throw;
            }
        }

        #endregion

        #region Utility Functions

        public async Task<ApiResponseDto<bool>> KhoiTaoDuLieuMauAsync()
        {
            try
            {
                var result = await _giaoVienRepository.KhoiTaoDuLieuMauAsync();

                if (result.success)
                {
                    _logger.LogInformation("Successfully initialized sample data");
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in KhoiTaoDuLieuMauAsync");
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi khởi tạo dữ liệu mẫu");
            }
        }

        public async Task<ApiResponseDto<bool>> SaoLuuBangAsync(string tenBang, string tenBangSaoLuu = null)
        {
            try
            {
                if (string.IsNullOrEmpty(tenBang))
                {
                    return ApiResponseDto<bool>.ErrorResult("Tên bảng không được để trống");
                }

                var result = await _giaoVienRepository.SaoLuuBangAsync(tenBang, tenBangSaoLuu);

                if (result.success)
                {
                    _logger.LogInformation("Successfully backed up table: {TenBang}", tenBang);
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in SaoLuuBangAsync: {TenBang}", tenBang);
                return ApiResponseDto<bool>.ErrorResult("Lỗi hệ thống khi sao lưu bảng");
            }
        }

        #endregion
    }
}