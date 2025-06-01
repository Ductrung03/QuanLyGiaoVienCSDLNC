namespace QuanLyGiaoVienCSDLNC.DTOs.GiaoVien
{
    public class GiaoVienListItemDto
    {
        public string MaGV { get; set; }
        public string HoTen { get; set; }
        public DateTime NgaySinh { get; set; }
        public string GioiTinh { get; set; }
        public string Email { get; set; }
        public int SDT { get; set; }
        public string DiaChi { get; set; }
        public string QueQuan { get; set; }
        public string TenBM { get; set; }
        public string TenKhoa { get; set; }
        public string DanhSachHocVi { get; set; }
        public string HocHamCaoNhat { get; set; }
        public int Tuoi { get; set; }
        public string TrangThai { get; set; } = "Hoạt động";
    }
}