using QuanLyGiaoVienCSDLNC.DTOs.NCKH;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Services.Interfaces
{
    public interface INCKHService
    {
        // Quản lý loại NCKH
        Task<ApiResponseDto<List<LoaiNCKH>>> GetAllLoaiNCKHAsync();
        Task<ApiResponseDto<LoaiNCKH>> GetLoaiNCKHByIdAsync(string maLoaiNCKH);

        // Quản lý tài NCKH
        Task<ApiResponseDto<PagedResultDto<TaiNCKHListItemDto>>> SearchTaiNCKHAsync(TaiNCKHSearchDto searchDto);
        Task<ApiResponseDto<List<TaiNCKH>>> GetAllTaiNCKHAsync();
        Task<ApiResponseDto<TaiNCKHDetailDto>> GetTaiNCKHDetailAsync(string maTaiNCKH);
        Task<ApiResponseDto<TaiNCKH>> GetTaiNCKHByIdAsync(string maTaiNCKH);
        Task<ApiResponseDto<List<TaiNCKH>>> GetTaiNCKHByNamHocAsync(string namHoc);
        Task<ApiResponseDto<string>> AddTaiNCKHAsync(TaiNCKHCreateDto dto);
        Task<ApiResponseDto<bool>> UpdateTaiNCKHAsync(TaiNCKHUpdateDto dto);
        Task<ApiResponseDto<bool>> DeleteTaiNCKHAsync(string maTaiNCKH);

        // Quản lý chi tiết NCKH
        Task<ApiResponseDto<List<ChiTietNCKH>>> GetChiTietNCKHByMaGVAsync(string maGV, string namHoc = null);
        Task<ApiResponseDto<List<ChiTietNCKH>>> GetChiTietNCKHByMaTaiNCKHAsync(string maTaiNCKH);
        Task<ApiResponseDto<string>> PhanCongNCKHAsync(ChiTietNCKHCreateDto dto);
        Task<ApiResponseDto<bool>> UpdateChiTietNCKHAsync(ChiTietNCKHUpdateDto dto);
        Task<ApiResponseDto<bool>> DeleteChiTietNCKHAsync(string maChiTietNCKH);

        // Quy đổi giờ chuẩn
        Task<ApiResponseDto<List<QuyDoiGioChuanNCKH>>> GetAllQuyDoiGioChuanAsync();

        // Thống kê và báo cáo
        Task<ApiResponseDto<object>> GetThongKeNCKHByGiaoVienAsync(string maGV, string namHoc = null);
        Task<ApiResponseDto<object>> GetThongKeNCKHByBoMonAsync(string maBM, string namHoc = null);
        Task<ApiResponseDto<object>> GetThongKeNCKHByKhoaAsync(string maKhoa, string namHoc = null);

        // Validation
        Task<ApiResponseDto<bool>> ValidateTaiNCKHDataAsync(TaiNCKHCreateDto dto);
        Task<ApiResponseDto<bool>> ValidateChiTietNCKHDataAsync(ChiTietNCKHCreateDto dto);

        // Utility
        Task<List<string>> GetAvailableNamHocAsync();
        Task<List<string>> GetAvailableVaiTroAsync();
    }
}