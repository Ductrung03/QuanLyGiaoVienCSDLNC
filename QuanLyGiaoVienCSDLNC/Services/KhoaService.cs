using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class KhoaService : IKhoaService
    {
        private readonly IKhoaRepository _khoaRepository;

        public KhoaService(IKhoaRepository khoaRepository)
        {
            _khoaRepository = khoaRepository;
        }

        public async Task<List<Khoa>> GetAllKhoaAsync()
        {
            return await _khoaRepository.GetAllKhoaAsync();
        }

        public async Task<Khoa> GetKhoaByIdAsync(string maKhoa)
        {
            return await _khoaRepository.GetKhoaByIdAsync(maKhoa);
        }

        public async Task<(bool success, string message, string maKhoa)> AddKhoaAsync(Khoa khoa)
        {
            return await _khoaRepository.AddKhoaAsync(khoa);
        }

        public async Task<(bool success, string message)> UpdateKhoaAsync(Khoa khoa)
        {
            return await _khoaRepository.UpdateKhoaAsync(khoa);
        }

        public async Task<(bool success, string message)> DeleteKhoaAsync(string maKhoa)
        {
            return await _khoaRepository.DeleteKhoaAsync(maKhoa);
        }

        public async Task<(bool success, string message)> PhanCongChuNhiemKhoaAsync(string maKhoa, string maGV)
        {
            return await _khoaRepository.PhanCongChuNhiemKhoaAsync(maKhoa, maGV);
        }
    }

}
