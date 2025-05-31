using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IHoiDongRepository
    {
        // Quản lý loại hội đồng
        Task<List<LoaiHoiDong>> GetAllLoaiHoiDongAsync();
        Task<LoaiHoiDong> GetLoaiHoiDongByIdAsync(string maLoaiHoiDong);

        // Quản lý tài hội đồng
        Task<List<TaiHoiDong>> GetAllTaiHoiDongAsync();
        Task<TaiHoiDong> GetTaiHoiDongByIdAsync(string maHoiDong);
        Task<List<TaiHoiDong>> GetTaiHoiDongByNamHocAsync(string namHoc);
        Task<(bool success, string message, string maHoiDong)> AddTaiHoiDongAsync(TaiHoiDong taiHoiDong);
        Task<(bool success, string message)> UpdateTaiHoiDongAsync(TaiHoiDong taiHoiDong);
        Task<(bool success, string message)> DeleteTaiHoiDongAsync(string maHoiDong);

        // Quản lý thành viên hội đồng
        Task<List<ThamGia>> GetThanhVienHoiDongAsync(string maHoiDong);
        Task<List<ThamGia>> GetHoiDongByGiaoVienAsync(string maGV);
        Task<(bool success, string message, string maThamGia)> ThemThanhVienHoiDongAsync(string maGV, string maHoiDong, float soGio);
        Task<(bool success, string message)> UpdateThamGiaAsync(ThamGia thamGia);
        Task<(bool success, string message)> XoaThanhVienHoiDongAsync(string maThamGia);
    }
}