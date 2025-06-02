using QuanLyGiaoVienCSDLNC.DTOs.NCKH;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class NCKHService : INCKHService
    {
        private readonly INCKHRepository _nckhRepository;
        private readonly IGiaoVienRepository _giaoVienRepository;

        public NCKHService(INCKHRepository nckhRepository, IGiaoVienRepository giaoVienRepository)
        {
            _nckhRepository = nckhRepository;
            _giaoVienRepository = giaoVienRepository;
        }

        // Quản lý loại NCKH
        public async Task<ApiResponseDto<List<LoaiNCKH>>> GetAllLoaiNCKHAsync()
        {
            try
            {
                var result = await _nckhRepository.GetAllLoaiNCKHAsync();
                return ApiResponseDto<List<LoaiNCKH>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<LoaiNCKH>>.ErrorResult($"Lỗi khi lấy danh sách loại NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<LoaiNCKH>> GetLoaiNCKHByIdAsync(string maLoaiNCKH)
        {
            try
            {
                var result = await _nckhRepository.GetLoaiNCKHByIdAsync(maLoaiNCKH);
                if (result == null)
                    return ApiResponseDto<LoaiNCKH>.ErrorResult("Không tìm thấy loại NCKH");

                return ApiResponseDto<LoaiNCKH>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<LoaiNCKH>.ErrorResult($"Lỗi khi lấy thông tin loại NCKH: {ex.Message}");
            }
        }

        // Quản lý tài NCKH
        public async Task<ApiResponseDto<PagedResultDto<TaiNCKHListItemDto>>> SearchTaiNCKHAsync(TaiNCKHSearchDto searchDto)
        {
            try
            {
                var result = await _nckhRepository.SearchTaiNCKHAsync(searchDto);
                return ApiResponseDto<PagedResultDto<TaiNCKHListItemDto>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<PagedResultDto<TaiNCKHListItemDto>>.ErrorResult($"Lỗi khi tìm kiếm tài NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<TaiNCKH>>> GetAllTaiNCKHAsync()
        {
            try
            {
                var result = await _nckhRepository.GetAllTaiNCKHAsync();
                return ApiResponseDto<List<TaiNCKH>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<TaiNCKH>>.ErrorResult($"Lỗi khi lấy danh sách tài NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<TaiNCKHDetailDto>> GetTaiNCKHDetailAsync(string maTaiNCKH)
        {
            try
            {
                var result = await _nckhRepository.GetTaiNCKHDetailAsync(maTaiNCKH);
                if (result == null)
                    return ApiResponseDto<TaiNCKHDetailDto>.ErrorResult("Không tìm thấy tài NCKH");

                return ApiResponseDto<TaiNCKHDetailDto>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<TaiNCKHDetailDto>.ErrorResult($"Lỗi khi lấy chi tiết tài NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<TaiNCKH>> GetTaiNCKHByIdAsync(string maTaiNCKH)
        {
            try
            {
                var result = await _nckhRepository.GetTaiNCKHByIdAsync(maTaiNCKH);
                if (result == null)
                    return ApiResponseDto<TaiNCKH>.ErrorResult("Không tìm thấy tài NCKH");

                return ApiResponseDto<TaiNCKH>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<TaiNCKH>.ErrorResult($"Lỗi khi lấy thông tin tài NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<TaiNCKH>>> GetTaiNCKHByNamHocAsync(string namHoc)
        {
            try
            {
                var result = await _nckhRepository.GetTaiNCKHByNamHocAsync(namHoc);
                return ApiResponseDto<List<TaiNCKH>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<TaiNCKH>>.ErrorResult($"Lỗi khi lấy danh sách tài NCKH theo năm học: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<string>> AddTaiNCKHAsync(TaiNCKHCreateDto dto)
        {
            try
            {
                // Validation
                var validationResult = await ValidateTaiNCKHDataAsync(dto);
                if (!validationResult.Success)
                    return ApiResponseDto<string>.ErrorResult(validationResult.Message, validationResult.Errors);

                var (success, message, maTaiNCKH) = await _nckhRepository.AddTaiNCKHAsync(dto);

                if (success)
                    return ApiResponseDto<string>.SuccessResult(maTaiNCKH, message);
                else
                    return ApiResponseDto<string>.ErrorResult(message);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<string>.ErrorResult($"Lỗi khi thêm tài NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<bool>> UpdateTaiNCKHAsync(TaiNCKHUpdateDto dto)
        {
            try
            {
                var (success, message) = await _nckhRepository.UpdateTaiNCKHAsync(dto);

                if (success)
                    return ApiResponseDto<bool>.SuccessResult(true, message);
                else
                    return ApiResponseDto<bool>.ErrorResult(message);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<bool>.ErrorResult($"Lỗi khi cập nhật tài NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<bool>> DeleteTaiNCKHAsync(string maTaiNCKH)
        {
            try
            {
                var (success, message) = await _nckhRepository.DeleteTaiNCKHAsync(maTaiNCKH);

                if (success)
                    return ApiResponseDto<bool>.SuccessResult(true, message);
                else
                    return ApiResponseDto<bool>.ErrorResult(message);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<bool>.ErrorResult($"Lỗi khi xóa tài NCKH: {ex.Message}");
            }
        }

        // Quản lý chi tiết NCKH
        public async Task<ApiResponseDto<List<ChiTietNCKH>>> GetChiTietNCKHByMaGVAsync(string maGV, string namHoc = null)
        {
            try
            {
                var result = await _nckhRepository.GetChiTietNCKHByMaGVAsync(maGV, namHoc);
                return ApiResponseDto<List<ChiTietNCKH>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<ChiTietNCKH>>.ErrorResult($"Lỗi khi lấy danh sách NCKH của giáo viên: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<List<ChiTietNCKH>>> GetChiTietNCKHByMaTaiNCKHAsync(string maTaiNCKH)
        {
            try
            {
                var result = await _nckhRepository.GetChiTietNCKHByMaTaiNCKHAsync(maTaiNCKH);
                return ApiResponseDto<List<ChiTietNCKH>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<ChiTietNCKH>>.ErrorResult($"Lỗi khi lấy danh sách tác giả của tài NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<string>> PhanCongNCKHAsync(ChiTietNCKHCreateDto dto)
        {
            try
            {
                // Validation
                var validationResult = await ValidateChiTietNCKHDataAsync(dto);
                if (!validationResult.Success)
                    return ApiResponseDto<string>.ErrorResult(validationResult.Message, validationResult.Errors);

                var (success, message, maChiTietNCKH) = await _nckhRepository.PhanCongNCKHAsync(dto);

                if (success)
                    return ApiResponseDto<string>.SuccessResult(maChiTietNCKH, message);
                else
                    return ApiResponseDto<string>.ErrorResult(message);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<string>.ErrorResult($"Lỗi khi phân công NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<bool>> UpdateChiTietNCKHAsync(ChiTietNCKHUpdateDto dto)
        {
            try
            {
                var (success, message) = await _nckhRepository.UpdateChiTietNCKHAsync(dto);

                if (success)
                    return ApiResponseDto<bool>.SuccessResult(true, message);
                else
                    return ApiResponseDto<bool>.ErrorResult(message);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<bool>.ErrorResult($"Lỗi khi cập nhật chi tiết NCKH: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<bool>> DeleteChiTietNCKHAsync(string maChiTietNCKH)
        {
            try
            {
                var (success, message) = await _nckhRepository.DeleteChiTietNCKHAsync(maChiTietNCKH);

                if (success)
                    return ApiResponseDto<bool>.SuccessResult(true, message);
                else
                    return ApiResponseDto<bool>.ErrorResult(message);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<bool>.ErrorResult($"Lỗi khi xóa phân công NCKH: {ex.Message}");
            }
        }

        // Quy đổi giờ chuẩn
        public async Task<ApiResponseDto<List<QuyDoiGioChuanNCKH>>> GetAllQuyDoiGioChuanAsync()
        {
            try
            {
                var result = await _nckhRepository.GetAllQuyDoiGioChuanAsync();
                return ApiResponseDto<List<QuyDoiGioChuanNCKH>>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<List<QuyDoiGioChuanNCKH>>.ErrorResult($"Lỗi khi lấy danh sách quy đổi giờ chuẩn: {ex.Message}");
            }
        }

        // Thống kê và báo cáo
        public async Task<ApiResponseDto<object>> GetThongKeNCKHByGiaoVienAsync(string maGV, string namHoc = null)
        {
            try
            {
                var result = await _nckhRepository.GetThongKeNCKHByGiaoVienAsync(maGV, namHoc);
                return ApiResponseDto<object>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<object>.ErrorResult($"Lỗi khi thống kê NCKH theo giáo viên: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<object>> GetThongKeNCKHByBoMonAsync(string maBM, string namHoc = null)
        {
            try
            {
                var result = await _nckhRepository.GetThongKeNCKHByBoMonAsync(maBM, namHoc);
                return ApiResponseDto<object>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<object>.ErrorResult($"Lỗi khi thống kê NCKH theo bộ môn: {ex.Message}");
            }
        }

        public async Task<ApiResponseDto<object>> GetThongKeNCKHByKhoaAsync(string maKhoa, string namHoc = null)
        {
            try
            {
                var result = await _nckhRepository.GetThongKeNCKHByKhoaAsync(maKhoa, namHoc);
                return ApiResponseDto<object>.SuccessResult(result);
            }
            catch (Exception ex)
            {
                return ApiResponseDto<object>.ErrorResult($"Lỗi khi thống kê NCKH theo khoa: {ex.Message}");
            }
        }

        // Validation
        public async Task<ApiResponseDto<bool>> ValidateTaiNCKHDataAsync(TaiNCKHCreateDto dto)
        {
            var errors = new List<string>();

            // Kiểm tra tên công trình
            if (string.IsNullOrWhiteSpace(dto.TenCongTrinhKhoaHoc))
                errors.Add("Tên công trình khoa học không được để trống");

            // Kiểm tra năm học
            if (string.IsNullOrWhiteSpace(dto.NamHoc))
                errors.Add("Năm học không được để trống");

            // Kiểm tra số tác giả
            if (dto.SoTacGia <= 0 || dto.SoTacGia > 20)
                errors.Add("Số tác giả phải từ 1 đến 20");

            // Kiểm tra loại NCKH
            if (string.IsNullOrWhiteSpace(dto.MaLoaiNCKH))
                errors.Add("Loại NCKH không được để trống");
            else
            {
                var loaiNCKH = await _nckhRepository.GetLoaiNCKHByIdAsync(dto.MaLoaiNCKH);
                if (loaiNCKH == null)
                    errors.Add("Loại NCKH không tồn tại");
            }

            if (errors.Any())
                return ApiResponseDto<bool>.ErrorResult("Dữ liệu không hợp lệ", errors);

            return ApiResponseDto<bool>.SuccessResult(true);
        }

        public async Task<ApiResponseDto<bool>> ValidateChiTietNCKHDataAsync(ChiTietNCKHCreateDto dto)
        {
            var errors = new List<string>();

            // Kiểm tra giáo viên
            if (string.IsNullOrWhiteSpace(dto.MaGV))
                errors.Add("Mã giáo viên không được để trống");
            else
            {
                var giaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(dto.MaGV);
                if (giaoVien == null)
                    errors.Add("Giáo viên không tồn tại");
            }

            // Kiểm tra tài NCKH
            if (string.IsNullOrWhiteSpace(dto.MaTaiNCKH))
                errors.Add("Mã tài NCKH không được để trống");
            else
            {
                var taiNCKH = await _nckhRepository.GetTaiNCKHByIdAsync(dto.MaTaiNCKH);
                if (taiNCKH == null)
                    errors.Add("Tài NCKH không tồn tại");
                else
                {
                    // Kiểm tra đã đủ tác giả chưa
                    if (await _nckhRepository.KiemTraTacGiaDayDuAsync(dto.MaTaiNCKH))
                        errors.Add("Đã đủ số tác giả cho công trình này");

                    // Kiểm tra giáo viên đã tham gia chưa
                    if (await _nckhRepository.KiemTraGiaoVienDaThamGiaAsync(dto.MaGV, dto.MaTaiNCKH))
                        errors.Add("Giáo viên đã tham gia công trình này");

                    // Kiểm tra vai trò chủ nhiệm
                    if (dto.VaiTro == "Chủ nhiệm" && await _nckhRepository.KiemTraChuNhiemTonTaiAsync(dto.MaTaiNCKH))
                        errors.Add("Đã có chủ nhiệm cho công trình này");
                }
            }

            // Kiểm tra vai trò
            if (string.IsNullOrWhiteSpace(dto.VaiTro))
                errors.Add("Vai trò không được để trống");

            // Kiểm tra số giờ
            if (dto.SoGio <= 0 || dto.SoGio > 500)
                errors.Add("Số giờ phải từ 1 đến 500");

            if (errors.Any())
                return ApiResponseDto<bool>.ErrorResult("Dữ liệu không hợp lệ", errors);

            return ApiResponseDto<bool>.SuccessResult(true);
        }

        // Utility
        public async Task<List<string>> GetAvailableNamHocAsync()
        {
            var allTaiNCKH = await _nckhRepository.GetAllTaiNCKHAsync();
            return allTaiNCKH.Select(t => t.NamHoc).Distinct().OrderByDescending(n => n).ToList();
        }

        public async Task<List<string>> GetAvailableVaiTroAsync()
        {
            return new List<string>
            {
                "Chủ nhiệm",
                "Thành viên",
                "Cộng tác viên",
                "Tư vấn"
            };
        }
    }
}