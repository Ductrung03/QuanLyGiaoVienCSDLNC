using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IGiaoVienRepository
    {
        Task<List<GiaoVien>> GetAllGiaoVienAsync();
        Task<GiaoVien> GetGiaoVienByIdAsync(string maGV);
        Task<List<GiaoVien>> SearchGiaoVienAsync(string searchTerm, string maBM = null, string maKhoa = null);
        Task<(bool success, string message, string maGV)> AddGiaoVienAsync(GiaoVien giaoVien);
        Task<(bool success, string message)> UpdateGiaoVienAsync(GiaoVien giaoVien);
        Task<(bool success, string message)> DeleteGiaoVienAsync(string maGV);
        Task<dynamic> GetChiTietGiaoVienAsync(string maGV);
    }
}
