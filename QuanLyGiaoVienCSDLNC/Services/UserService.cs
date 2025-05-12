using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<(bool success, string message, string maLichSu)> LoginAsync(string tenDangNhap, string matKhau)
        {
            return await _userRepository.LoginAsync(tenDangNhap, matKhau);
        }

        public async Task<(bool success, string message)> LogoutAsync(string maLichSu)
        {
            return await _userRepository.LogoutAsync(maLichSu);
        }

        public async Task<(bool success, string message, string maNguoiDung)> AddUserAsync(NguoiDung nguoiDung)
        {
            return await _userRepository.AddUserAsync(nguoiDung);
        }

        public async Task<(bool success, string message)> UpdateUserAsync(NguoiDung nguoiDung)
        {
            return await _userRepository.UpdateUserAsync(nguoiDung);
        }

        public async Task<(bool success, string message)> DeleteUserAsync(string maNguoiDung)
        {
            return await _userRepository.DeleteUserAsync(maNguoiDung);
        }

        public async Task<bool> KiemTraQuyenAsync(string maNguoiDung, string maQuyen)
        {
            return await _userRepository.KiemTraQuyenAsync(maNguoiDung, maQuyen);
        }

        public async Task<dynamic> GetUserInfoAsync(string maNguoiDung)
        {
            return await _userRepository.GetUserInfoAsync(maNguoiDung);
        }
    }

}
