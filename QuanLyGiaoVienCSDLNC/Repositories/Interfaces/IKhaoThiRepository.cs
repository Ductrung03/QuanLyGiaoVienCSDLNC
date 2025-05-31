using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IKhaoThiRepository
    {
        // Quản lý loại công tác khảo thí
        Task<List<LoaiCongTacKhaoThi>> GetAllLoaiCongTacKhaoThiAsync();
        Task<LoaiCongTacKhaoThi> GetLoaiCongTacKhaoThiByIdAsync(string maLoaiCongTacKhaoThi);

        // Quản lý tài khảo thí
        Task<List<TaiKhaoThi>> GetAllTaiKhaoThiAsync();
        Task<TaiKhaoThi> GetTaiKhaoThiByIdAsync(string maTaiKhaoThi);
        Task<List<TaiKhaoThi>> GetTaiKhaoThiByNamHocAsync(string namHoc);
        Task<(bool success, string message, string maTaiKhaoThi)> AddTaiKhaoThiAsync(TaiKhaoThi taiKhaoThi);
        Task<(bool success, string message)> UpdateTaiKhaoThiAsync(TaiKhaoThi taiKhaoThi);
        Task<(bool success, string message)> DeleteTaiKhaoThiAsync(string maTaiKhaoThi);

        // Quản lý chi tiết tài khảo thí
        Task<List<ChiTietTaiKhaoThi>> GetChiTietTaiKhaoThiByMaGVAsync(string maGV);
        Task<List<ChiTietTaiKhaoThi>> GetChiTietTaiKhaoThiByMaTaiKhaoThiAsync(string maTaiKhaoThi);
        Task<(bool success, string message, string maChiTietTaiKhaoThi)> PhanCongKhaoThiAsync(string maGV, string maTaiKhaoThi, int soBai);
        Task<(bool success, string message)> UpdateChiTietTaiKhaoThiAsync(ChiTietTaiKhaoThi chiTietTaiKhaoThi);
        Task<(bool success, string message)> DeleteChiTietTaiKhaoThiAsync(string maChiTietTaiKhaoThi);
    }
}