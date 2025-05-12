using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IKhoaRepository
    {
        Task<List<Khoa>> GetAllKhoaAsync();
        Task<Khoa> GetKhoaByIdAsync(string maKhoa);
        Task<(bool success, string message, string maKhoa)> AddKhoaAsync(Khoa khoa);
        Task<(bool success, string message)> UpdateKhoaAsync(Khoa khoa);
        Task<(bool success, string message)> DeleteKhoaAsync(string maKhoa);
        Task<(bool success, string message)> PhanCongChuNhiemKhoaAsync(string maKhoa, string maGV);
    }
}
