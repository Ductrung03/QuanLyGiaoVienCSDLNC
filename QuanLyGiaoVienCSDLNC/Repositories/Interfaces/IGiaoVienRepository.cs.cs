using QuanLyGiaoVienCSDLNC.DTOs.GiaoVien;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.DTOs.HocVi;
using QuanLyGiaoVienCSDLNC.DTOs.LyLichKhoaHoc;
using QuanLyGiaoVienCSDLNC.Models;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IGiaoVienRepository
    {
        // CRUD Operations
        Task<List<GiaoVien>> GetAllGiaoVienAsync();
        Task<GiaoVien> GetGiaoVienByIdAsync(string maGV);
        Task<(bool success, string message, string maGV)> AddGiaoVienAsync(GiaoVienCreateDto dto);
        Task<(bool success, string message)> UpdateGiaoVienAsync(GiaoVienUpdateDto dto);
        Task<(bool success, string message)> DeleteGiaoVienAsync(string maGV, bool forceDelete = false);

        // Advanced Search and Filtering
        Task<PagedResultDto<GiaoVienListItemDto>> SearchGiaoVienAsync(GiaoVienSearchDto searchDto);
        Task<List<GiaoVien>> SearchGiaoVienSimpleAsync(string searchTerm, string maBM = null, string maKhoa = null);

        // Detail Information
        Task<GiaoVienDetailDto> GetChiTietGiaoVienAsync(string maGV);

        // Academic Information Management
        Task<(bool success, string message)> CapNhatHocViAsync(HocViCreateDto dto);
        Task<(bool success, string message)> CapNhatHocHamAsync(string maGV, string maHocHam, DateTime ngayNhan);
        Task<(bool success, string message)> CapNhatLyLichKhoaHocAsync(LyLichKhoaHocDto dto);

        // === THÊM MỚI: Quản lý học vị đầy đủ ===
        Task<(bool success, string message, string maHocVi)> ThemHocViAsync(HocVi hocVi);
        Task<(bool success, string message)> CapNhatHocViAsync(HocVi hocVi);
        Task<(bool success, string message)> XoaHocViAsync(string maHocVi);
        Task<PagedResultDto<HocVi>> TimKiemHocViAsync(string maGV = null, string tenHocVi = null, DateTime? tuNgay = null, DateTime? denNgay = null, int pageNumber = 1, int pageSize = 20);

        // === THÊM MỚI: Quản lý quân hàm ===
        Task<(bool success, string message, string maQuanHam)> ThemQuanHamAsync(QuanHam quanHam);
        Task<(bool success, string message)> CapNhatQuanHamAsync(QuanHam quanHam);
        Task<(bool success, string message)> XoaQuanHamAsync(string maQuanHam);
        Task<List<QuanHam>> GetQuanHamByGiaoVienAsync(string maGV);

        // Position Management
        Task<(bool success, string message)> PhanCongChucVuAsync(string maGV, string maChucVu, DateTime? ngayNhan = null);
        Task<(bool success, string message)> KetThucChucVuAsync(string maGV, string maChucVu, DateTime? ngayKetThuc = null);

        // Statistics and Reports
        Task<QuanLyGiaoVienCSDLNC.DTOs.GiaoVien.ThongKeGiaoVien> GetThongKeGiaoVienAsync(string maGV, string namHoc = null);
        Task<DataTable> GetBaoCaoGiangDayAsync(string maGV, string namHoc = null);
        Task<DataTable> GetBaoCaoNCKHAsync(string maGV, string namHoc = null);
        Task<DataTable> GetBaoCaoTongHopAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null);

        // Utility Methods
        Task<bool> CheckEmailExistsAsync(string email, string excludeMaGV = null);
        Task<bool> CheckSDTExistsAsync(int sdt, string excludeMaGV = null);
        Task<List<GiaoVien>> GetGiaoVienByBoMonAsync(string maBM);
        Task<List<GiaoVien>> GetGiaoVienByKhoaAsync(string maKhoa);
        Task<int> GetTotalGiaoVienCountAsync();

        // === THÊM MỚI: Utility functions ===
        Task<(bool success, string message)> KhoiTaoDuLieuMauAsync();
        Task<(bool success, string message)> SaoLuuBangAsync(string tenBang, string tenBangSaoLuu = null);

        // Dashboard Data
        Task<object> GetDashboardDataAsync();
        Task<List<object>> GetTopGiaoVienByGiangDayAsync(int top = 10, string namHoc = null);
        Task<List<object>> GetGiaoVienChuaHoanThanhDinhMucAsync(string namHoc = null);

        // Export Functions
        Task<DataTable> ExportGiaoVienToDataTableAsync(GiaoVienSearchDto searchDto = null);
        Task<byte[]> ExportGiaoVienToExcelAsync(GiaoVienSearchDto searchDto = null);
        Task<byte[]> ExportGiaoVienToPdfAsync(string maGV);
    }
}