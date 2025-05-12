using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    // Models/BoMon.cs
    public class BoMon
    {
        [Key]
        [StringLength(15)]
        public string MaBM { get; set; }

        [Required(ErrorMessage = "Tên bộ môn không được để trống")]
        [StringLength(100)]
        [Display(Name = "Tên bộ môn")]
        public string TenBM { get; set; }

        [StringLength(100)]
        [Display(Name = "Địa chỉ")]
        public string DiaChi { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã khoa")]
        public string MaKhoa { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã chủ nhiệm bộ môn")]
        public string MaChuNhiemBM { get; set; }

        [ForeignKey("MaKhoa")]
        public virtual Khoa Khoa { get; set; }
    }

}
