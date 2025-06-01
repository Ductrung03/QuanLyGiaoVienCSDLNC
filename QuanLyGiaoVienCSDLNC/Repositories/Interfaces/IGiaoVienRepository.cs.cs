using QuanLyGiaoVienCSDLNC.DTOs.GiaoVien;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Models.QuanLyGiaoVienCSDLNC.Models;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IGiaoVienRepository
    {
        // Basic CRUD operations
        Task<List<GiaoVien>> GetAllGiaoVienAsync();
        Task<GiaoVien> GetGiaoVienByIdAsync(string maGV);
        Task<(bool success, string message, string maGV)> AddGiaoVienAsync(GiaoVien giaoVien);
        Task<(bool success, string message)> UpdateGiaoVienAsync(GiaoVien giaoVien);
        Task<(bool success, string message)> DeleteGiaoVienAsync(string maGV, bool forceDelete = false);

        // Search and filtering
        Task<(List<GiaoVien> data, int totalRecords)> SearchGiaoVienAsync(GiaoVienSearchDto searchDto);
        Task<List<GiaoVien>> SearchGiaoVienSimpleAsync(string searchTerm, string maBM = null, string maKhoa = null);

        // Detail information
        Task<GiaoVienDetailDto> GetChiTietGiaoVienAsync(string maGV);

        // Statistics and reports
        Task<ThongKeGiaoVien> GetThongKeGiaoVienAsync(string maGV, string namHoc = null);
        Task<DataTable> GetBaoCaoGiangDayAsync(string maGV, string namHoc = null);
        Task<DataTable> GetBaoCaoNCKHAsync(string maGV, string namHoc = null);

        // Academic information management
        Task<(bool success, string message)> CapNhatHocViAsync(string maGV, string tenHocVi, DateTime ngayNhan);
        Task<(bool success, string message)> CapNhatHocHamAsync(string maGV, string maHocHam, DateTime ngayNhan);
        Task<(bool success, string message)> CapNhatLyLichKhoaHocAsync(string maGV, LyLichKhoaHoc lyLichKhoaHoc);

        // Position management
        Task<(bool success, string message)> PhanCongChucVuAsync(string maGV, string maChucVu, DateTime? ngayNhan = null);
        Task<(bool success, string message)> KetThucChucVuAsync(string maGV, string maChucVu, DateTime? ngayKetThuc = null);

        // Utility methods
        Task<bool> CheckEmailExistsAsync(string email, string excludeMaGV = null);
        Task<bool> CheckSDTExistsAsync(int sdt, string excludeMaGV = null);
        Task<List<GiaoVien>> GetGiaoVienByBoMonAsync(string maBM);
        Task<List<GiaoVien>> GetGiaoVienByKhoaAsync(string maKhoa);
        Task<int> GetTotalGiaoVienCountAsync();

        // Dashboard data
        Task<object> GetDashboardDataAsync();
        Task<List<object>> GetTopGiaoVienByGiangDayAsync(int top = 10, string namHoc = null);
        Task<List<object>> GetGiaoVienChuaHoanThanhDinhMucAsync(string namHoc = null);

        // Export functions
        Task<DataTable> ExportGiaoVienToDataTableAsync(GiaoVienSearchDto searchDto = null);
        Task<byte[]> ExportGiaoVienToExcelAsync(GiaoVienSearchDto searchDto = null);
        Task<byte[]> ExportGiaoVienToPdfAsync(string maGV);
    }
}