using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class GiaoVienService : IGiaoVienService
    {
        private readonly IGiaoVienRepository _giaoVienRepository;

        public GiaoVienService(IGiaoVienRepository giaoVienRepository)
        {
            _giaoVienRepository = giaoVienRepository;
        }

        public async Task<List<GiaoVien>> GetAllGiaoVienAsync()
        {
            return await _giaoVienRepository.GetAllGiaoVienAsync();
        }

        public async Task<GiaoVien> GetGiaoVienByIdAsync(string maGV)
        {
            return await _giaoVienRepository.GetGiaoVienByIdAsync(maGV);
        }

        public async Task<List<GiaoVien>> SearchGiaoVienAsync(string searchTerm, string maBM = null, string maKhoa = null)
        {
            return await _giaoVienRepository.SearchGiaoVienAsync(searchTerm, maBM, maKhoa);
        }

        public async Task<(bool success, string message, string maGV)> AddGiaoVienAsync(GiaoVien giaoVien)
        {
            return await _giaoVienRepository.AddGiaoVienAsync(giaoVien);
        }

        public async Task<(bool success, string message)> UpdateGiaoVienAsync(GiaoVien giaoVien)
        {
            return await _giaoVienRepository.UpdateGiaoVienAsync(giaoVien);
        }

        public async Task<(bool success, string message)> DeleteGiaoVienAsync(string maGV)
        {
            return await _giaoVienRepository.DeleteGiaoVienAsync(maGV);
        }

        public async Task<dynamic> GetChiTietGiaoVienAsync(string maGV)
        {
            return await _giaoVienRepository.GetChiTietGiaoVienAsync(maGV);
        }
    }

}
