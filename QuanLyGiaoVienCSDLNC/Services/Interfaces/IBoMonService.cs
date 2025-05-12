using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Services.Interfaces
{
    public interface IBoMonService
    {
        Task<List<BoMon>> GetAllBoMonAsync();
        Task<BoMon> GetBoMonByIdAsync(string maBM);
        Task<List<BoMon>> GetBoMonByKhoaIdAsync(string maKhoa);
        Task<(bool success, string message, string maBM)> AddBoMonAsync(BoMon boMon);
        Task<(bool success, string message)> UpdateBoMonAsync(BoMon boMon);
        Task<(bool success, string message)> DeleteBoMonAsync(string maBM);
        Task<(bool success, string message)> PhanCongChuNhiemBoMonAsync(string maBM, string maGV);
    }
}
