using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.DTOs.NCKH
{
    public class TaiNCKHDetailDto
    {
        public TaiNCKH ThongTinCoBan { get; set; }
        public LoaiNCKH LoaiNCKH { get; set; }
        public QuyDoiGioChuanNCKH QuyDoiGioChuan { get; set; }
        public List<ChiTietNCKH> DanhSachTacGia { get; set; } = new List<ChiTietNCKH>();
        public int SoTacGiaHienTai { get; set; }
        public bool DayDuTacGia { get; set; }
    }
}