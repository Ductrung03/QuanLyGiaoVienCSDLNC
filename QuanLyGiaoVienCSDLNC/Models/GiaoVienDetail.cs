namespace QuanLyGiaoVienCSDLNC.Models
{
    public class GiaoVienDetail
    {
        public GiaoVien ThongTinCoBan { get; set; }
        public List<HocVi> DanhSachHocVi { get; set; } = new List<HocVi>();
        public List<LichSuHocHam> DanhSachHocHam { get; set; } = new List<LichSuHocHam>();
        public List<LichSuChucVu> DanhSachChucVu { get; set; } = new List<LichSuChucVu>();
        public LyLichKhoaHoc LyLichKhoaHoc { get; set; }
        public ThongKeGiaoVien ThongKe { get; set; }
    }
}