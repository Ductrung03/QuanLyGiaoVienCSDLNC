using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.Repositories.Interfaces
{
    public interface IUserRepository
    {
        Task<(bool success, string message, string maLichSu)> LoginAsync(string tenDangNhap, string matKhau);
        Task<(bool success, string message)> LogoutAsync(string maLichSu);
        Task<(bool success, string message, string maNguoiDung)> AddUserAsync(NguoiDung nguoiDung);
        Task<(bool success, string message)> UpdateUserAsync(NguoiDung nguoiDung);
        Task<(bool success, string message)> DeleteUserAsync(string maNguoiDung);
        Task<bool> KiemTraQuyenAsync(string maNguoiDung, string maQuyen);
        Task<dynamic> GetUserInfoAsync(string maNguoiDung);
    }
}
