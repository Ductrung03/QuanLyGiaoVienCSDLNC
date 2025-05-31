using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface INCKHRepository
    {
        // Quản lý loại NCKH
        Task<List<LoaiNCKH>> GetAllLoaiNCKHAsync();
        Task<LoaiNCKH> GetLoaiNCKHByIdAsync(string maLoaiNCKH);

        // Quản lý tài NCKH
        Task<List<TaiNCKH>> GetAllTaiNCKHAsync();
        Task<TaiNCKH> GetTaiNCKHByIdAsync(string maTaiNCKH);
        Task<List<TaiNCKH>> GetTaiNCKHByNamHocAsync(string namHoc);
        Task<(bool success, string message, string maTaiNCKH)> AddTaiNCKHAsync(TaiNCKH taiNCKH);
        Task<(bool success, string message)> UpdateTaiNCKHAsync(TaiNCKH taiNCKH);
        Task<(bool success, string message)> DeleteTaiNCKHAsync(string maTaiNCKH);

        // Quản lý chi tiết NCKH
        Task<List<ChiTietNCKH>> GetChiTietNCKHByMaGVAsync(string maGV);
        Task<List<ChiTietNCKH>> GetChiTietNCKHByMaTaiNCKHAsync(string maTaiNCKH);
        Task<(bool success, string message, string maChiTietNCKH)> PhanCongNCKHAsync(string maGV, string maTaiNCKH, string vaiTro, float soGio);
        Task<(bool success, string message)> UpdateChiTietNCKHAsync(ChiTietNCKH chiTietNCKH);
        Task<(bool success, string message)> DeleteChiTietNCKHAsync(string maChiTietNCKH);

        // Quy đổi giờ chuẩn
        Task<List<QuyDoiGioChuanNCKH>> GetAllQuyDoiGioChuanAsync();
        Task<QuyDoiGioChuanNCKH> GetQuyDoiGioChuanByIdAsync(string maQuyDoi);
    }
}