using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface ITaiGiangDayRepository
    {
        Task<List<TaiGiangDay>> GetAllTaiGiangDayAsync();
        Task<TaiGiangDay> GetTaiGiangDayByIdAsync(string maTaiGiangDay);
        Task<(bool success, string message, string maTaiGiangDay)> AddTaiGiangDayAsync(TaiGiangDay taiGiangDay);
        Task<(bool success, string message, string maChiTietGiangDay)> PhanCongGiangDayAsync(string maGV, string maTaiGiangDay, int soTiet, string ghiChu, string maNoiDungGiangDay);
    }
}
