using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ChiTietNCKH
    {
        [Key]
        [StringLength(15)]
        public string MaChiTietNCKH { get; set; }

        [Required(ErrorMessage = "Vai trò không được để trống")]
        [StringLength(100)]
        [Display(Name = "Vai trò")]
        public string VaiTro { get; set; }

        [Required(ErrorMessage = "Giáo viên không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Tài NCKH không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã tài NCKH")]
        public string MaTaiNCKH { get; set; }

        [Required(ErrorMessage = "Số giờ không được để trống")]
        [Range(0.1, 500, ErrorMessage = "Số giờ phải từ 0.1 đến 500")]
        [Display(Name = "Số giờ")]
        public double SoGio { get; set; }

        // Navigation properties
        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaTaiNCKH")]
        public virtual TaiNCKH TaiNCKH { get; set; }

        // Computed properties
        [NotMapped]
        [Display(Name = "Tên giáo viên")]
        public string TenGiaoVien => GiaoVien?.HoTen ?? "";

        [NotMapped]
        [Display(Name = "Tên công trình")]
        public string TenCongTrinh => TaiNCKH?.TenCongTrinhKhoaHoc ?? "";

        [NotMapped]
        [Display(Name = "Năm học")]
        public string NamHoc => TaiNCKH?.NamHoc ?? "";

        [NotMapped]
        [Display(Name = "Loại NCKH")]
        public string TenLoaiNCKH => TaiNCKH?.LoaiNCKH?.TenLoaiNCKH ?? "";

        [NotMapped]
        [Display(Name = "Bộ môn")]
        public string TenBoMon => GiaoVien?.BoMon?.TenBM ?? "";
    }
}