using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IChucVuRepository
    {
        // Quản lý chức vụ
        Task<List<ChucVu>> GetAllChucVuAsync();
        Task<ChucVu> GetChucVuByIdAsync(string maChucVu);
        Task<(bool success, string message)> AddChucVuAsync(ChucVu chucVu);
        Task<(bool success, string message)> UpdateChucVuAsync(ChucVu chucVu);
        Task<(bool success, string message)> DeleteChucVuAsync(string maChucVu);

        // Quản lý lịch sử chức vụ
        Task<List<LichSuChucVu>> GetLichSuChucVuByGiaoVienAsync(string maGV);
        Task<List<LichSuChucVu>> GetChucVuHienTaiAsync();
        Task<LichSuChucVu> GetChucVuHienTaiByGiaoVienAsync(string maGV);
        Task<(bool success, string message)> PhanCongChucVuAsync(string maGV, string maChucVu, DateTime? ngayNhan);
        Task<(bool success, string message)> KetThucChucVuAsync(string maGV, string maChucVu, DateTime? ngayKetThuc);

        // Định mức miễn giảm
        Task<List<DinhMucMienGiam>> GetAllDinhMucMienGiamAsync();
        Task<DinhMucMienGiam> GetDinhMucMienGiamByIdAsync(string maDinhMucMienGiam);
        Task<(bool success, string message)> CapNhatDinhMucMienGiamAsync(string maChucVu, string maDinhMucMienGiam);
    }
}