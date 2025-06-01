using QuanLyGiaoVienCSDLNC.Models.QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Models;

namespace QuanLyGiaoVienCSDLNC.DTOs
{
    public class GiaoVienDetailDto
    {
        public GiaoVien ThongTinCoBan { get; set; }
        public List<HocVi> DanhSachHocVi { get; set; } = new List<HocVi>();
        public List<LichSuHocHam> DanhSachHocHam { get; set; } = new List<LichSuHocHam>();
        public List<LichSuChucVu> DanhSachChucVu { get; set; } = new List<LichSuChucVu>();
        public LyLichKhoaHoc LyLichKhoaHoc { get; set; }
        public List<ChiTietGiangDay> DanhSachGiangDay { get; set; } = new List<ChiTietGiangDay>();
        public List<ChiTietNCKH> DanhSachNCKH { get; set; } = new List<ChiTietNCKH>();
        public ThongKeGiaoVien ThongKe { get; set; }
    }
}
