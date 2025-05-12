using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class ThongKeService : IThongKeService
    {
        private readonly IThongKeRepository _thongKeRepository;

        public ThongKeService(IThongKeRepository thongKeRepository)
        {
            _thongKeRepository = thongKeRepository;
        }

        public async Task<dynamic> ThongKeSoGioGiangDayAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            return await _thongKeRepository.ThongKeSoGioGiangDayAsync(maGV, maBM, maKhoa, namHoc);
        }

        public async Task<dynamic> ThongKeSoGioNCKHAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            return await _thongKeRepository.ThongKeSoGioNCKHAsync(maGV, maBM, maKhoa, namHoc);
        }

        public async Task<dynamic> ThongKeSoGioKhaoThiAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            return await _thongKeRepository.ThongKeSoGioKhaoThiAsync(maGV, maBM, maKhoa, namHoc);
        }

        public async Task<dynamic> TongHopKhoiLuongCongTacAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            return await _thongKeRepository.TongHopKhoiLuongCongTacAsync(maGV, maBM, maKhoa, namHoc);
        }

        public async Task<dynamic> KiemTraHoanThanhDinhMucAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            return await _thongKeRepository.KiemTraHoanThanhDinhMucAsync(maGV, maBM, maKhoa, namHoc);
        }

        public async Task<dynamic> BaoCaoGiangDayTheoKhoaBoMonAsync(string namHoc = null)
        {
            return await _thongKeRepository.BaoCaoGiangDayTheoKhoaBoMonAsync(namHoc);
        }

        public async Task<dynamic> BaoCaoNCKHTheoKhoaBoMonAsync(string namHoc = null)
        {
            return await _thongKeRepository.BaoCaoNCKHTheoKhoaBoMonAsync(namHoc);
        }

        public async Task<dynamic> BaoCaoHoanThanhDinhMucTheoKhoaBoMonAsync(string namHoc = null)
        {
            return await _thongKeRepository.BaoCaoHoanThanhDinhMucTheoKhoaBoMonAsync(namHoc);
        }
    }

}
