using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Services.Interfaces
{
    public interface INCKHService
    {
        // Quản lý loại NCKH
        Task<List<LoaiNCKH>> GetAllLoaiNCKHAsync();
        Task<LoaiNCKH> GetLoaiNCKHByIdAsync(string maLoaiNCKH);
        Task<(bool success, string message)> AddLoaiNCKHAsync(LoaiNCKH loaiNCKH);
        Task<(bool success, string message)> UpdateLoaiNCKHAsync(LoaiNCKH loaiNCKH);
        Task<(bool success, string message)> DeleteLoaiNCKHAsync(string maLoaiNCKH);

        // Quản lý quy đổi giờ chuẩn
        Task<List<QuyDoiGioChuanNCKH>> GetAllQuyDoiGioChuanAsync();
        Task<QuyDoiGioChuanNCKH> GetQuyDoiGioChuanByIdAsync(string maQuyDoi);
        Task<(bool success, string message)> AddQuyDoiGioChuanAsync(QuyDoiGioChuanNCKH quyDoi);
        Task<(bool success, string message)> UpdateQuyDoiGioChuanAsync(QuyDoiGioChuanNCKH quyDoi);
        Task<(bool success, string message)> DeleteQuyDoiGioChuanAsync(string maQuyDoi);

        // Quản lý tài NCKH
        Task<List<TaiNCKH>> GetAllTaiNCKHAsync();
        Task<TaiNCKH> GetTaiNCKHByIdAsync(string maTaiNCKH);
        Task<List<TaiNCKH>> GetTaiNCKHByNamHocAsync(string namHoc);
        Task<List<TaiNCKH>> SearchTaiNCKHAsync(string searchTerm = null, string namHoc = null, string maLoaiNCKH = null);
        Task<(bool success, string message, string maTaiNCKH)> AddTaiNCKHAsync(TaiNCKH taiNCKH);
        Task<(bool success, string message)> UpdateTaiNCKHAsync(TaiNCKH taiNCKH);
        Task<(bool success, string message)> DeleteTaiNCKHAsync(string maTaiNCKH);

        // Quản lý chi tiết NCKH
        Task<List<ChiTietNCKH>> GetChiTietNCKHByTaiNCKHAsync(string maTaiNCKH);
        Task<List<ChiTietNCKH>> GetChiTietNCKHByGiaoVienAsync(string maGV, string namHoc = null);
        Task<ChiTietNCKH> GetChiTietNCKHByIdAsync(string maChiTietNCKH);
        Task<(bool success, string message, string maChiTietNCKH)> AddChiTietNCKHAsync(ChiTietNCKH chiTietNCKH);
        Task<(bool success, string message)> UpdateChiTietNCKHAsync(ChiTietNCKH chiTietNCKH);
        Task<(bool success, string message)> DeleteChiTietNCKHAsync(string maChiTietNCKH);

        // Báo cáo và thống kê
        Task<dynamic> GetThongKeNCKHTongQuanAsync(string namHoc = null, string maKhoa = null, string maBM = null);
        Task<List<dynamic>> GetTopGiaoVienNCKHXuatSacAsync(string namHoc = null, int topN = 20, string maKhoa = null);
        Task<List<dynamic>> GetThongKeNCKHTheoKhoaAsync(string namHoc = null);
        Task<List<dynamic>> GetThongKeNCKHTheoBoMonAsync(string namHoc = null, string maKhoa = null);

        // Tiện ích
        Task<List<string>> GetAvailableNamHocAsync();
        Task<List<string>> GetAvailableVaiTroAsync();
        Task<bool> ValidateTaiNCKHAsync(TaiNCKH taiNCKH, bool isUpdate = false);
        Task<bool> ValidateChiTietNCKHAsync(ChiTietNCKH chiTietNCKH, bool isUpdate = false);
        Task<bool> CanDeleteTaiNCKHAsync(string maTaiNCKH);
        Task<bool> CanAddTacGiaAsync(string maTaiNCKH);
    }
}