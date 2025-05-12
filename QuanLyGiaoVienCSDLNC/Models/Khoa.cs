using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class Khoa
    {
        [Key]
        [StringLength(15)]
        public string MaKhoa { get; set; }

        [Required(ErrorMessage = "Tên khoa không được để trống")]
        [StringLength(100)]
        [Display(Name = "Tên khoa")]
        public string TenKhoa { get; set; }

        [StringLength(100)]
        [Display(Name = "Địa chỉ")]
        public string DiaChi { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã chủ nhiệm khoa")]
        public string MaChuNhiemKhoa { get; set; }
    }
}
