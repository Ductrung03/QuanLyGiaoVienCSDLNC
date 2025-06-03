using QuanLyGiaoVienCSDLNC.DTOs.GiaoVien;
using QuanLyGiaoVienCSDLNC.DTOs.Common;
using QuanLyGiaoVienCSDLNC.DTOs.HocVi;
using QuanLyGiaoVienCSDLNC.DTOs.LyLichKhoaHoc;
using QuanLyGiaoVienCSDLNC.Models;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Services.Interfaces
{
    public interface IGiaoVienService
    {
        // CRUD Operations
        Task<List<GiaoVien>> GetAllGiaoVienAsync();
        Task<GiaoVien> GetGiaoVienByIdAsync(string maGV);
        Task<ApiResponseDto<string>> AddGiaoVienAsync(GiaoVienCreateDto dto);
        Task<ApiResponseDto<bool>> UpdateGiaoVienAsync(GiaoVienUpdateDto dto);
        Task<ApiResponseDto<bool>> DeleteGiaoVienAsync(string maGV, bool forceDelete = false);

        // Search and Filtering
        Task<ApiResponseDto<PagedResultDto<GiaoVienListItemDto>>> SearchGiaoVienAsync(GiaoVienSearchDto searchDto);
        Task<List<GiaoVien>> SearchGiaoVienSimpleAsync(string searchTerm, string maBM = null, string maKhoa = null);

        // Detail Information
        Task<ApiResponseDto<GiaoVienDetailDto>> GetChiTietGiaoVienAsync(string maGV);

        // Academic Information Management
        Task<ApiResponseDto<bool>> CapNhatHocViAsync(HocViCreateDto dto);
        Task<ApiResponseDto<bool>> CapNhatHocHamAsync(string maGV, string maHocHam, DateTime ngayNhan);
        Task<ApiResponseDto<bool>> CapNhatLyLichKhoaHocAsync(LyLichKhoaHocDto dto);

        // === THÊM MỚI: Quản lý học vị đầy đủ ===
        Task<ApiResponseDto<string>> ThemHocViAsync(HocVi hocVi);
        Task<ApiResponseDto<bool>> CapNhatHocViAsync(HocVi hocVi);
        Task<ApiResponseDto<bool>> XoaHocViAsync(string maHocVi);
        Task<ApiResponseDto<PagedResultDto<HocVi>>> TimKiemHocViAsync(string maGV = null, string tenHocVi = null, DateTime? tuNgay = null, DateTime? denNgay = null, int pageNumber = 1, int pageSize = 20);

        // === THÊM MỚI: Quản lý quân hàm ===
        Task<ApiResponseDto<string>> ThemQuanHamAsync(QuanHam quanHam);
        Task<ApiResponseDto<bool>> CapNhatQuanHamAsync(QuanHam quanHam);
        Task<ApiResponseDto<bool>> XoaQuanHamAsync(string maQuanHam);
        Task<List<QuanHam>> GetQuanHamByGiaoVienAsync(string maGV);

        // Position Management
        Task<ApiResponseDto<bool>> PhanCongChucVuAsync(string maGV, string maChucVu, DateTime? ngayNhan = null);
        Task<ApiResponseDto<bool>> KetThucChucVuAsync(string maGV, string maChucVu, DateTime? ngayKetThuc = null);

        // Statistics and Reports
        Task<ApiResponseDto<ThongKeGiaoVien>> GetThongKeGiaoVienAsync(string maGV, string namHoc = null);
        Task<ApiResponseDto<DataTable>> GetBaoCaoGiangDayAsync(string maGV, string namHoc = null);
        Task<ApiResponseDto<DataTable>> GetBaoCaoNCKHAsync(string maGV, string namHoc = null);
        Task<ApiResponseDto<DataTable>> GetBaoCaoTongHopAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null);

        // Validation
        Task<ApiResponseDto<bool>> ValidateGiaoVienDataAsync(GiaoVienCreateDto dto, string excludeMaGV = null);
        Task<bool> CheckEmailExistsAsync(string email, string excludeMaGV = null);
        Task<bool> CheckSDTExistsAsync(int sdt, string excludeMaGV = null);

        // === THÊM MỚI: Utility functions ===
        Task<ApiResponseDto<bool>> KhoiTaoDuLieuMauAsync();
        Task<ApiResponseDto<bool>> SaoLuuBangAsync(string tenBang, string tenBangSaoLuu = null);

        // Dashboard and Statistics
        Task<ApiResponseDto<object>> GetDashboardDataAsync();
        Task<ApiResponseDto<List<object>>> GetTopGiaoVienByGiangDayAsync(int top = 10, string namHoc = null);
        Task<ApiResponseDto<List<object>>> GetGiaoVienChuaHoanThanhDinhMucAsync(string namHoc = null);

        // Export
        Task<ApiResponseDto<byte[]>> ExportGiaoVienToExcelAsync(GiaoVienSearchDto searchDto = null);
        Task<ApiResponseDto<byte[]>> ExportGiaoVienToPdfAsync(string maGV);

        // Utility
        Task<List<GiaoVien>> GetGiaoVienByBoMonAsync(string maBM);
        Task<List<GiaoVien>> GetGiaoVienByKhoaAsync(string maKhoa);
        Task<int> GetTotalGiaoVienCountAsync();
    }
}