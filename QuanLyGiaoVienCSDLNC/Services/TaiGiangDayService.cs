// Services/TaiGiangDayService.cs
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.DTOs.TaiGiangDay;
using QuanLyGiaoVienCSDLNC.DTOs.ChiTietGiangDay;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class TaiGiangDayService : ITaiGiangDayService
    {
        private readonly ITaiGiangDayRepository _taiGiangDayRepository;

        public TaiGiangDayService(ITaiGiangDayRepository taiGiangDayRepository)
        {
            _taiGiangDayRepository = taiGiangDayRepository;
        }

        #region TaiGiangDay Operations

        public async Task<ApiResponseDto<List<TaiGiangDay>>> GetAllTaiGiangDayAsync()
        {
            try
            {
                var result = await _taiGiangDayRepository.GetAllTaiGiangDayAsync();
                return ApiResponseDto<List<TaiGiangDay>>.SuccessResult(result, "Lấy danh sách tài giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<TaiGiangDay>>.ErrorResult($"Lỗi khi lấy danh sách tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<TaiGiangDay>> GetTaiGiangDayByIdAsync(string maTaiGiangDay)
        {
            try
            {
                if (string.IsNullOrEmpty(maTaiGiangDay))
                {
                    return ApiResponseDto<TaiGiangDay>.ErrorResult("Mã tài giảng dạy không được để trống");
                }

                var result = await _taiGiangDayRepository.GetTaiGiangDayByIdAsync(maTaiGiangDay);
                if (result == null)
                {
                    return ApiResponseDto<TaiGiangDay>.ErrorResult("Không tìm thấy tài giảng dạy");
                }

                return ApiResponseDto<TaiGiangDay>.SuccessResult(result, "Lấy thông tin tài giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<TaiGiangDay>.ErrorResult($"Lỗi khi lấy thông tin tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<PagedResultDto<TaiGiangDayListDto>>> SearchTaiGiangDayAsync(TaiGiangDaySearchDto searchDto)
        {
            try
            {
                if (searchDto == null)
                {
                    searchDto = new TaiGiangDaySearchDto();
                }

                // Validate pagination parameters
                if (searchDto.PageNumber <= 0) searchDto.PageNumber = 1;
                if (searchDto.PageSize <= 0) searchDto.PageSize = 20;
                if (searchDto.PageSize > 100) searchDto.PageSize = 100;

                var result = await _taiGiangDayRepository.SearchTaiGiangDayAsync(searchDto);
                return ApiResponseDto<PagedResultDto<TaiGiangDayListDto>>.SuccessResult(result, "Tìm kiếm tài giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<PagedResultDto<TaiGiangDayListDto>>.ErrorResult($"Lỗi khi tìm kiếm tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<string>> AddTaiGiangDayAsync(TaiGiangDayCreateDto dto)
        {
            try
            {
                // Validate business rules
                var validationResult = await ValidateTaiGiangDayAsync(dto);
                if (!validationResult.Success)
                {
                    return validationResult;
                }

                var result = await _taiGiangDayRepository.AddTaiGiangDayAsync(dto);
                if (result.success)
                {
                    return ApiResponseDto<string>.SuccessResult(result.maTaiGiangDay, result.message);
                }
                else
                {
                    return ApiResponseDto<string>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                return ApiResponseDto<string>.ErrorResult($"Lỗi khi thêm tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<bool>> UpdateTaiGiangDayAsync(TaiGiangDayUpdateDto dto)
        {
            try
            {
                // Check if exists
                var existing = await _taiGiangDayRepository.GetTaiGiangDayByIdAsync(dto.MaTaiGiangDay);
                if (existing == null)
                {
                    return ApiResponseDto<bool>.ErrorResult("Không tìm thấy tài giảng dạy cần cập nhật");
                }

                var result = await _taiGiangDayRepository.UpdateTaiGiangDayAsync(dto);
                if (result.success)
                {
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                return ApiResponseDto<bool>.ErrorResult($"Lỗi khi cập nhật tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<bool>> DeleteTaiGiangDayAsync(string maTaiGiangDay)
        {
            try
            {
                if (string.IsNullOrEmpty(maTaiGiangDay))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã tài giảng dạy không được để trống");
                }

                var result = await _taiGiangDayRepository.DeleteTaiGiangDayAsync(maTaiGiangDay);
                if (result.success)
                {
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                return ApiResponseDto<bool>.ErrorResult($"Lỗi khi xóa tài giảng dạy: {ex.Message}");
            }
        }

        #endregion

        #region ChiTietGiangDay Operations

        public async Task<ApiResponseDto<string>> PhanCongGiangDayAsync(ChiTietGiangDayCreateDto dto)
        {
            try
            {
                // Validate business rules
                var validationResult = await ValidateChiTietGiangDayAsync(dto);
                if (!validationResult.Success)
                {
                    return validationResult;
                }

                var result = await _taiGiangDayRepository.PhanCongGiangDayAsync(dto);
                if (result.success)
                {
                    return ApiResponseDto<string>.SuccessResult(result.maChiTietGiangDay, result.message);
                }
                else
                {
                    return ApiResponseDto<string>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                return ApiResponseDto<string>.ErrorResult($"Lỗi khi phân công giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<bool>> UpdateChiTietGiangDayAsync(ChiTietGiangDayUpdateDto dto)
        {
            try
            {
                var result = await _taiGiangDayRepository.UpdateChiTietGiangDayAsync(dto);
                if (result.success)
                {
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                return ApiResponseDto<bool>.ErrorResult($"Lỗi khi cập nhật chi tiết giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<bool>> XoaPhanCongGiangDayAsync(string maChiTietGiangDay)
        {
            try
            {
                if (string.IsNullOrEmpty(maChiTietGiangDay))
                {
                    return ApiResponseDto<bool>.ErrorResult("Mã chi tiết giảng dạy không được để trống");
                }

                var result = await _taiGiangDayRepository.XoaPhanCongGiangDayAsync(maChiTietGiangDay);
                if (result.success)
                {
                    return ApiResponseDto<bool>.SuccessResult(true, result.message);
                }
                else
                {
                    return ApiResponseDto<bool>.ErrorResult(result.message);
                }
            }
            catch (Exception ex)
            {
                return ApiResponseDto<bool>.ErrorResult($"Lỗi khi xóa phân công giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<PagedResultDto<ChiTietGiangDayListDto>>> GetDanhSachGiangDayAsync(string maGV = null, string namHoc = null, int pageNumber = 1, int pageSize = 20)
        {
            try
            {
                // Validate pagination parameters
                if (pageNumber <= 0) pageNumber = 1;
                if (pageSize <= 0) pageSize = 20;
                if (pageSize > 100) pageSize = 100;

                var result = await _taiGiangDayRepository.GetDanhSachGiangDayAsync(maGV, namHoc, pageNumber, pageSize);
                return ApiResponseDto<PagedResultDto<ChiTietGiangDayListDto>>.SuccessResult(result, "Lấy danh sách giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<PagedResultDto<ChiTietGiangDayListDto>>.ErrorResult($"Lỗi khi lấy danh sách giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<ChiTietGiangDay>>> GetChiTietGiangDayByTaiGiangDayAsync(string maTaiGiangDay)
        {
            try
            {
                if (string.IsNullOrEmpty(maTaiGiangDay))
                {
                    return ApiResponseDto<List<ChiTietGiangDay>>.ErrorResult("Mã tài giảng dạy không được để trống");
                }

                var result = await _taiGiangDayRepository.GetChiTietGiangDayByTaiGiangDayAsync(maTaiGiangDay);
                return ApiResponseDto<List<ChiTietGiangDay>>.SuccessResult(result, "Lấy danh sách chi tiết giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<ChiTietGiangDay>>.ErrorResult($"Lỗi khi lấy danh sách chi tiết giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<ChiTietGiangDay>>> GetChiTietGiangDayByGiaoVienAsync(string maGV)
        {
            try
            {
                if (string.IsNullOrEmpty(maGV))
                {
                    return ApiResponseDto<List<ChiTietGiangDay>>.ErrorResult("Mã giáo viên không được để trống");
                }

                var result = await _taiGiangDayRepository.GetChiTietGiangDayByGiaoVienAsync(maGV);
                return ApiResponseDto<List<ChiTietGiangDay>>.SuccessResult(result, "Lấy danh sách giảng dạy của giáo viên thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<ChiTietGiangDay>>.ErrorResult($"Lỗi khi lấy danh sách giảng dạy của giáo viên: {ex.Message}");
            }
        }

        #endregion

        #region Lookup Data

        public async Task<ApiResponseDto<List<DoiTuongGiangDay>>> GetAllDoiTuongGiangDayAsync()
        {
            try
            {
                var result = await _taiGiangDayRepository.GetAllDoiTuongGiangDayAsync();
                return ApiResponseDto<List<DoiTuongGiangDay>>.SuccessResult(result, "Lấy danh sách đối tượng giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<DoiTuongGiangDay>>.ErrorResult($"Lỗi khi lấy danh sách đối tượng giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<ThoiGianGiangDay>>> GetAllThoiGianGiangDayAsync()
        {
            try
            {
                var result = await _taiGiangDayRepository.GetAllThoiGianGiangDayAsync();
                return ApiResponseDto<List<ThoiGianGiangDay>>.SuccessResult(result, "Lấy danh sách thời gian giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<ThoiGianGiangDay>>.ErrorResult($"Lỗi khi lấy danh sách thời gian giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<NgonNguGiangDay>>> GetAllNgonNguGiangDayAsync()
        {
            try
            {
                var result = await _taiGiangDayRepository.GetAllNgonNguGiangDayAsync();
                return ApiResponseDto<List<NgonNguGiangDay>>.SuccessResult(result, "Lấy danh sách ngôn ngữ giảng dạy thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<NgonNguGiangDay>>.ErrorResult($"Lỗi khi lấy danh sách ngôn ngữ giảng dạy: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<string>>> GetDistinctNamHocAsync()
        {
            try
            {
                var result = await _taiGiangDayRepository.GetDistinctNamHocAsync();
                return ApiResponseDto<List<string>>.SuccessResult(result, "Lấy danh sách năm học thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<string>>.ErrorResult($"Lỗi khi lấy danh sách năm học: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<string>>> GetDistinctHeAsync()
        {
            try
            {
                var result = await _taiGiangDayRepository.GetDistinctHeAsync();
                return ApiResponseDto<List<string>>.SuccessResult(result, "Lấy danh sách hệ đào tạo thành công");
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<string>>.ErrorResult($"Lỗi khi lấy danh sách hệ đào tạo: {ex.Message}");
            }
        }

        #endregion

        #region Validation Methods

        private async Task<ApiResponseDto<string>> ValidateTaiGiangDayAsync(TaiGiangDayCreateDto dto)
        {
            var errors = new List<string>();

            // Validate required fields
            if (string.IsNullOrEmpty(dto.TenHocPhan))
                errors.Add("Tên học phần không được để trống");

            if (dto.SiSo <= 0 || dto.SiSo > 500)
                errors.Add("Sĩ số phải từ 1 đến 500");

            if (dto.SoTinChi <= 0 || dto.SoTinChi > 10)
                errors.Add("Số tín chỉ phải từ 1 đến 10");

            // Validate lookup data exists
            var doiTuongList = await _taiGiangDayRepository.GetAllDoiTuongGiangDayAsync();
            if (!doiTuongList.Any(dt => dt.MaDoiTuong == dto.MaDoiTuong))
                errors.Add("Mã đối tượng giảng dạy không tồn tại");

            var thoiGianList = await _taiGiangDayRepository.GetAllThoiGianGiangDayAsync();
            if (!thoiGianList.Any(tg => tg.MaThoiGian == dto.MaThoiGian))
                errors.Add("Mã thời gian giảng dạy không tồn tại");

            var ngonNguList = await _taiGiangDayRepository.GetAllNgonNguGiangDayAsync();
            if (!ngonNguList.Any(nn => nn.MaNgonNgu == dto.MaNgonNgu))
                errors.Add("Mã ngôn ngữ giảng dạy không tồn tại");

            if (errors.Any())
            {
                return ApiResponseDto<string>.ErrorResult("Dữ liệu không hợp lệ", errors);
            }

            return ApiResponseDto<string>.SuccessResult(null, "Validation passed");
        }

        private async Task<ApiResponseDto<string>> ValidateChiTietGiangDayAsync(ChiTietGiangDayCreateDto dto)
        {
            var errors = new List<string>();

            // Validate required fields
            if (string.IsNullOrEmpty(dto.MaGV))
                errors.Add("Mã giáo viên không được để trống");

            if (string.IsNullOrEmpty(dto.MaTaiGiangDay))
                errors.Add("Mã tài giảng dạy không được để trống");

            if (dto.SoTiet <= 0 || dto.SoTiet > 200)
                errors.Add("Số tiết phải từ 1 đến 200");

            // Check if TaiGiangDay exists
            var taiGiangDay = await _taiGiangDayRepository.GetTaiGiangDayByIdAsync(dto.MaTaiGiangDay);
            if (taiGiangDay == null)
                errors.Add("Mã tài giảng dạy không tồn tại");

            if (errors.Any())
            {
                return ApiResponseDto<string>.ErrorResult("Dữ liệu không hợp lệ", errors);
            }

            return ApiResponseDto<string>.SuccessResult(null, "Validation passed");
        }

        #endregion
    }
}