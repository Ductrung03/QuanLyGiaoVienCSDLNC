namespace QuanLyGiaoVienCSDLNC.Services.Interfaces
{
    public interface IThongKeService
    {
        Task<dynamic> ThongKeSoGioGiangDayAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null);
        Task<dynamic> ThongKeSoGioNCKHAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null);
        Task<dynamic> ThongKeSoGioKhaoThiAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null);
        Task<dynamic> TongHopKhoiLuongCongTacAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null);
        Task<dynamic> KiemTraHoanThanhDinhMucAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null);
        Task<dynamic> BaoCaoGiangDayTheoKhoaBoMonAsync(string namHoc = null);
        Task<dynamic> BaoCaoNCKHTheoKhoaBoMonAsync(string namHoc = null);
        Task<dynamic> BaoCaoHoanThanhDinhMucTheoKhoaBoMonAsync(string namHoc = null);
    }
}
