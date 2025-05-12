using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class BoMonService : IBoMonService
    {
        private readonly IBoMonRepository _boMonRepository;

        public BoMonService(IBoMonRepository boMonRepository)
        {
            _boMonRepository = boMonRepository;
        }

        public async Task<List<BoMon>> GetAllBoMonAsync()
        {
            return await _boMonRepository.GetAllBoMonAsync();
        }

        public async Task<BoMon> GetBoMonByIdAsync(string maBM)
        {
            return await _boMonRepository.GetBoMonByIdAsync(maBM);
        }

        public async Task<List<BoMon>> GetBoMonByKhoaIdAsync(string maKhoa)
        {
            return await _boMonRepository.GetBoMonByKhoaIdAsync(maKhoa);
        }

        public async Task<(bool success, string message, string maBM)> AddBoMonAsync(BoMon boMon)
        {
            return await _boMonRepository.AddBoMonAsync(boMon);
        }

        public async Task<(bool success, string message)> UpdateBoMonAsync(BoMon boMon)
        {
            return await _boMonRepository.UpdateBoMonAsync(boMon);
        }

        public async Task<(bool success, string message)> DeleteBoMonAsync(string maBM)
        {
            return await _boMonRepository.DeleteBoMonAsync(maBM);
        }

        public async Task<(bool success, string message)> PhanCongChuNhiemBoMonAsync(string maBM, string maGV)
        {
            return await _boMonRepository.PhanCongChuNhiemBoMonAsync(maBM, maGV);
        }
    }

}
