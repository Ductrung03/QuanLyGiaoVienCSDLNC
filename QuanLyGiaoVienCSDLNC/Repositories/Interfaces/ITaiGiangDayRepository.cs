// Repositories/Interfaces/ITaiGiangDayRepository.cs
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.DTOs.TaiGiangDay;
using QuanLyGiaoVienCSDLNC.DTOs.ChiTietGiangDay;
using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface ITaiGiangDayRepository
    {
        #region TaiGiangDay CRUD Operations
        Task<List<TaiGiangDay>> GetAllTaiGiangDayAsync();
        Task<TaiGiangDay> GetTaiGiangDayByIdAsync(string maTaiGiangDay);
        Task<PagedResultDto<TaiGiangDayListDto>> SearchTaiGiangDayAsync(TaiGiangDaySearchDto searchDto);
        Task<(bool success, string message, string maTaiGiangDay)> AddTaiGiangDayAsync(TaiGiangDayCreateDto dto);
        Task<(bool success, string message)> UpdateTaiGiangDayAsync(TaiGiangDayUpdateDto dto);
        Task<(bool success, string message)> DeleteTaiGiangDayAsync(string maTaiGiangDay);
        #endregion

        #region ChiTietGiangDay Operations
        Task<(bool success, string message, string maChiTietGiangDay)> PhanCongGiangDayAsync(ChiTietGiangDayCreateDto dto);
        Task<(bool success, string message)> UpdateChiTietGiangDayAsync(ChiTietGiangDayUpdateDto dto);
        Task<(bool success, string message)> XoaPhanCongGiangDayAsync(string maChiTietGiangDay);
        Task<PagedResultDto<ChiTietGiangDayListDto>> GetDanhSachGiangDayAsync(string maGV = null, string namHoc = null, int pageNumber = 1, int pageSize = 20);
        Task<List<ChiTietGiangDay>> GetChiTietGiangDayByTaiGiangDayAsync(string maTaiGiangDay);
        Task<List<ChiTietGiangDay>> GetChiTietGiangDayByGiaoVienAsync(string maGV);
        #endregion

        #region Lookup Data
        Task<List<DoiTuongGiangDay>> GetAllDoiTuongGiangDayAsync();
        Task<List<ThoiGianGiangDay>> GetAllThoiGianGiangDayAsync();
        Task<List<NgonNguGiangDay>> GetAllNgonNguGiangDayAsync();
        Task<List<string>> GetDistinctNamHocAsync();
        Task<List<string>> GetDistinctHeAsync();
        #endregion
    }
}