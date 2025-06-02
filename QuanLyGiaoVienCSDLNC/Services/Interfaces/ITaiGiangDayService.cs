// Services/Interfaces/ITaiGiangDayService.cs
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.DTOs.TaiGiangDay;
using QuanLyGiaoVienCSDLNC.DTOs.ChiTietGiangDay;
using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Services.Interfaces
{
    public interface ITaiGiangDayService
    {
        #region TaiGiangDay Operations
        Task<ApiResponseDto<List<TaiGiangDay>>> GetAllTaiGiangDayAsync();
        Task<ApiResponseDto<TaiGiangDay>> GetTaiGiangDayByIdAsync(string maTaiGiangDay);
        Task<ApiResponseDto<PagedResultDto<TaiGiangDayListDto>>> SearchTaiGiangDayAsync(TaiGiangDaySearchDto searchDto);
        Task<ApiResponseDto<string>> AddTaiGiangDayAsync(TaiGiangDayCreateDto dto);
        Task<ApiResponseDto<bool>> UpdateTaiGiangDayAsync(TaiGiangDayUpdateDto dto);
        Task<ApiResponseDto<bool>> DeleteTaiGiangDayAsync(string maTaiGiangDay);
        #endregion

        #region ChiTietGiangDay Operations
        Task<ApiResponseDto<string>> PhanCongGiangDayAsync(ChiTietGiangDayCreateDto dto);
        Task<ApiResponseDto<bool>> UpdateChiTietGiangDayAsync(ChiTietGiangDayUpdateDto dto);
        Task<ApiResponseDto<bool>> XoaPhanCongGiangDayAsync(string maChiTietGiangDay);
        Task<ApiResponseDto<PagedResultDto<ChiTietGiangDayListDto>>> GetDanhSachGiangDayAsync(string maGV = null, string namHoc = null, int pageNumber = 1, int pageSize = 20);
        Task<ApiResponseDto<List<ChiTietGiangDay>>> GetChiTietGiangDayByTaiGiangDayAsync(string maTaiGiangDay);
        Task<ApiResponseDto<List<ChiTietGiangDay>>> GetChiTietGiangDayByGiaoVienAsync(string maGV);
        #endregion

        #region Lookup Data
        Task<ApiResponseDto<List<DoiTuongGiangDay>>> GetAllDoiTuongGiangDayAsync();
        Task<ApiResponseDto<List<ThoiGianGiangDay>>> GetAllThoiGianGiangDayAsync();
        Task<ApiResponseDto<List<NgonNguGiangDay>>> GetAllNgonNguGiangDayAsync();
        Task<ApiResponseDto<List<string>>> GetDistinctNamHocAsync();
        Task<ApiResponseDto<List<string>>> GetDistinctHeAsync();
        #endregion
    }
}