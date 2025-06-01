using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.DTOs.GiaoVien
{
    public class GiaoVienDetailDto
    {
        public Models.GiaoVien ThongTinCoBan { get; set; }
        public List<QuanLyGiaoVienCSDLNC.Models.HocVi> DanhSachHocVi { get; set; } = new List<QuanLyGiaoVienCSDLNC.Models.HocVi>();
        public List<LichSuHocHam> DanhSachHocHam { get; set; } = new List<LichSuHocHam>();
        public List<LichSuChucVu> DanhSachChucVu { get; set; } = new List<LichSuChucVu>();
        public QuanLyGiaoVienCSDLNC.Models.LyLichKhoaHoc LyLichKhoaHoc { get; set; }
        public List<ChiTietGiangDay> DanhSachGiangDay { get; set; } = new List<ChiTietGiangDay>();
        public List<ChiTietNCKH> DanhSachNCKH { get; set; } = new List<ChiTietNCKH>();
        public ThongKeGiaoVien ThongKe { get; set; }
    }
}
