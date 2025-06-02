using QuanLyGiaoVienCSDLNC.DTOs.NCKH;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface INCKHRepository
    {
        // Quản lý loại NCKH
        Task<List<LoaiNCKH>> GetAllLoaiNCKHAsync();
        Task<LoaiNCKH> GetLoaiNCKHByIdAsync(string maLoaiNCKH);

        // Quản lý tài NCKH - Sử dụng stored procedures
        Task<PagedResultDto<TaiNCKHListItemDto>> SearchTaiNCKHAsync(TaiNCKHSearchDto searchDto);
        Task<List<TaiNCKH>> GetAllTaiNCKHAsync();
        Task<TaiNCKHDetailDto> GetTaiNCKHDetailAsync(string maTaiNCKH);
        Task<TaiNCKH> GetTaiNCKHByIdAsync(string maTaiNCKH);
        Task<List<TaiNCKH>> GetTaiNCKHByNamHocAsync(string namHoc);
        Task<(bool success, string message, string maTaiNCKH)> AddTaiNCKHAsync(TaiNCKHCreateDto dto);
        Task<(bool success, string message)> UpdateTaiNCKHAsync(TaiNCKHUpdateDto dto);
        Task<(bool success, string message)> DeleteTaiNCKHAsync(string maTaiNCKH);

        // Quản lý chi tiết NCKH - Sử dụng stored procedures
        Task<List<ChiTietNCKH>> GetChiTietNCKHByMaGVAsync(string maGV, string namHoc = null);
        Task<List<ChiTietNCKH>> GetChiTietNCKHByMaTaiNCKHAsync(string maTaiNCKH);
        Task<(bool success, string message, string maChiTietNCKH)> PhanCongNCKHAsync(ChiTietNCKHCreateDto dto);
        Task<(bool success, string message)> UpdateChiTietNCKHAsync(ChiTietNCKHUpdateDto dto);
        Task<(bool success, string message)> DeleteChiTietNCKHAsync(string maChiTietNCKH);

        // Quy đổi giờ chuẩn
        Task<List<QuyDoiGioChuanNCKH>> GetAllQuyDoiGioChuanAsync();
        Task<QuyDoiGioChuanNCKH> GetQuyDoiGioChuanByIdAsync(string maQuyDoi);

        // Thống kê và báo cáo
        Task<List<object>> GetThongKeNCKHByGiaoVienAsync(string maGV, string namHoc = null);
        Task<List<object>> GetThongKeNCKHByBoMonAsync(string maBM, string namHoc = null);
        Task<List<object>> GetThongKeNCKHByKhoaAsync(string maKhoa, string namHoc = null);

        // Validation
        Task<bool> KiemTraTacGiaDayDuAsync(string maTaiNCKH);
        Task<bool> KiemTraChuNhiemTonTaiAsync(string maTaiNCKH);
        Task<bool> KiemTraGiaoVienDaThamGiaAsync(string maGV, string maTaiNCKH);
    }
}