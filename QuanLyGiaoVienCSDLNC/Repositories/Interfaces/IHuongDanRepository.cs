using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IHuongDanRepository
    {
        // Quản lý loại hình hướng dẫn
        Task<List<LoaiHinhHuongDan>> GetAllLoaiHinhHuongDanAsync();
        Task<LoaiHinhHuongDan> GetLoaiHinhHuongDanByIdAsync(string maLoaiHinhHuongDan);

        // Quản lý tài hướng dẫn
        Task<List<TaiHuongDan>> GetAllTaiHuongDanAsync();
        Task<TaiHuongDan> GetTaiHuongDanByIdAsync(string maHuongDan);
        Task<List<TaiHuongDan>> GetTaiHuongDanByNamHocAsync(string namHoc);
        Task<(bool success, string message, string maHuongDan)> AddTaiHuongDanAsync(TaiHuongDan taiHuongDan);
        Task<(bool success, string message)> UpdateTaiHuongDanAsync(TaiHuongDan taiHuongDan);
        Task<(bool success, string message)> DeleteTaiHuongDanAsync(string maHuongDan);

        // Quản lý phân công hướng dẫn
        Task<List<ThamGiaHuongDan>> GetHuongDanByGiaoVienAsync(string maGV);
        Task<List<ThamGiaHuongDan>> GetGiaoVienHuongDanAsync(string maHuongDan);
        Task<(bool success, string message, string maThamGiaHuongDan)> PhanCongHuongDanAsync(string maGV, string maHuongDan, float soGio);
        Task<(bool success, string message)> UpdateThamGiaHuongDanAsync(ThamGiaHuongDan thamGiaHuongDan);
        Task<(bool success, string message)> DeleteThamGiaHuongDanAsync(string maThamGiaHuongDan);
    }
}