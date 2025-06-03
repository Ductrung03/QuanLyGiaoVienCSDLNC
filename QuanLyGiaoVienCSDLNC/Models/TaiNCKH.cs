using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class TaiNCKH
    {
        [Key]
        [StringLength(15)]
        public string MaTaiNCKH { get; set; }

        [Required(ErrorMessage = "Tên công trình không được để trống")]
        [StringLength(200)]
        [Display(Name = "Tên công trình khoa học")]
        public string TenCongTrinhKhoaHoc { get; set; }

        [Required(ErrorMessage = "Năm học không được để trống")]
        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [Required(ErrorMessage = "Số tác giả không được để trống")]
        [Range(1, 20, ErrorMessage = "Số tác giả phải từ 1 đến 20")]
        [Display(Name = "Số tác giả")]
        public int SoTacGia { get; set; }

        [Required(ErrorMessage = "Loại NCKH không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã loại NCKH")]
        public string MaLoaiNCKH { get; set; }

        // Navigation properties
        [ForeignKey("MaLoaiNCKH")]
        public virtual LoaiNCKH LoaiNCKH { get; set; }

        public virtual ICollection<ChiTietNCKH> ChiTietNCKHs { get; set; } = new List<ChiTietNCKH>();

        // Computed properties
        [NotMapped]
        [Display(Name = "Số tác giả hiện tại")]
        public int SoTacGiaHienTai => ChiTietNCKHs?.Count ?? 0;

        [NotMapped]
        [Display(Name = "Trạng thái")]
        public string TrangThai => SoTacGiaHienTai >= SoTacGia ? "Đủ tác giả" : "Thiếu tác giả";

        [NotMapped]
        [Display(Name = "Tổng số giờ")]
        public double TongSoGio => ChiTietNCKHs?.Sum(x => x.SoGio) ?? 0;

        [NotMapped]
        [Display(Name = "Chủ nhiệm")]
        public string ChuNhiem => ChiTietNCKHs?.FirstOrDefault(x => x.VaiTro == "Chủ nhiệm")?.GiaoVien?.HoTen ?? "Chưa có";

        [NotMapped]
        [Display(Name = "Có đủ tác giả")]
        public bool DaDuTacGia => SoTacGiaHienTai >= SoTacGia;
    }
}   