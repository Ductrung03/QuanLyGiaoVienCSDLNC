using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Services.Interfaces
{
    public interface IGiangDayService
    {
        // TaiGiangDay operations
        Task<List<TaiGiangDay>> GetAllTaiGiangDayAsync();
        Task<TaiGiangDay> GetTaiGiangDayByIdAsync(string maTaiGiangDay);
        Task<List<TaiGiangDay>> SearchTaiGiangDayAsync(string searchTerm = null, string namHoc = null, string he = null, string maDoiTuong = null);
        Task<(bool success, string message, string maTaiGiangDay)> AddTaiGiangDayAsync(TaiGiangDay taiGiangDay);
        Task<(bool success, string message)> UpdateTaiGiangDayAsync(TaiGiangDay taiGiangDay);
        Task<(bool success, string message)> DeleteTaiGiangDayAsync(string maTaiGiangDay);

        // ChiTietGiangDay operations
        Task<List<ChiTietGiangDay>> GetChiTietGiangDayByTaiGiangDayAsync(string maTaiGiangDay);
        Task<List<ChiTietGiangDay>> GetChiTietGiangDayByGiaoVienAsync(string maGV, string namHoc = null);
        Task<(bool success, string message, string maChiTietGiangDay)> PhanCongGiangDayAsync(string maGV, string maTaiGiangDay, int soTiet, string ghiChu = null, string noiDungGiangDay = null, bool checkConflict = true);
        Task<(bool success, string message)> UpdateChiTietGiangDayAsync(string maChiTietGiangDay, int soTiet, string ghiChu);
        Task<(bool success, string message)> XoaPhanCongGiangDayAsync(string maChiTietGiangDay);

        // Lookup data
        Task<List<DoiTuongGiangDay>> GetAllDoiTuongGiangDayAsync();
        Task<List<ThoiGianGiangDay>> GetAllThoiGianGiangDayAsync();
        Task<List<NgonNguGiangDay>> GetAllNgonNguGiangDayAsync();
        Task<List<string>> GetDistinctNamHocAsync();
        Task<List<string>> GetDistinctHeAsync();

        // Statistics and reports
        Task<object> GetThongKeGiangDayAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null);

        // Validation
        Task<(bool isValid, List<string> errors)> ValidateTaiGiangDayAsync(TaiGiangDay taiGiangDay, bool isUpdate = false);
        Task<(bool isValid, List<string> errors)> ValidatePhanCongAsync(string maGV, string maTaiGiangDay, int soTiet, bool checkConflict = true);
    }
}