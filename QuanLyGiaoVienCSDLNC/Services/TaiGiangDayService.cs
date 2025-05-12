using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class TaiGiangDayService : ITaiGiangDayService
    {
        private readonly ITaiGiangDayRepository _taiGiangDayRepository;

        public TaiGiangDayService(ITaiGiangDayRepository taiGiangDayRepository)
        {
            _taiGiangDayRepository = taiGiangDayRepository;
        }

        public async Task<List<TaiGiangDay>> GetAllTaiGiangDayAsync()
        {
            return await _taiGiangDayRepository.GetAllTaiGiangDayAsync();
        }

        public async Task<TaiGiangDay> GetTaiGiangDayByIdAsync(string maTaiGiangDay)
        {
            return await _taiGiangDayRepository.GetTaiGiangDayByIdAsync(maTaiGiangDay);
        }

        public async Task<(bool success, string message, string maTaiGiangDay)> AddTaiGiangDayAsync(TaiGiangDay taiGiangDay)
        {
            return await _taiGiangDayRepository.AddTaiGiangDayAsync(taiGiangDay);
        }

        public async Task<(bool success, string message, string maChiTietGiangDay)> PhanCongGiangDayAsync(string maGV, string maTaiGiangDay, int soTiet, string ghiChu, string maNoiDungGiangDay)
        {
            return await _taiGiangDayRepository.PhanCongGiangDayAsync(maGV, maTaiGiangDay, soTiet, ghiChu, maNoiDungGiangDay);
        }
    }

}
