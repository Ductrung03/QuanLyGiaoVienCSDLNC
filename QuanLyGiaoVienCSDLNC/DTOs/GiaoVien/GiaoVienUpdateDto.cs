using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs.GiaoVien
{
    public class GiaoVienUpdateDto
    {
        [Required]
        [StringLength(15)]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Họ tên không được để trống")]
        [StringLength(100)]
        [Display(Name = "Họ tên")]
        public string HoTen { get; set; }

        [Required(ErrorMessage = "Ngày sinh không được để trống")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày sinh")]
        public DateTime NgaySinh { get; set; }

        [Display(Name = "Giới tính")]
        public bool GioiTinh { get; set; }

        [StringLength(100)]
        [Display(Name = "Quê quán")]
        public string QueQuan { get; set; }

        [StringLength(100)]
        [Display(Name = "Địa chỉ")]
        public string DiaChi { get; set; }

        [Required(ErrorMessage = "Số điện thoại không được để trống")]
        [Range(100000000, 999999999)]
        [Display(Name = "Số điện thoại")]
        public int SDT { get; set; }

        [Required(ErrorMessage = "Email không được để trống")]
        [EmailAddress]
        [StringLength(100)]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Bộ môn không được để trống")]
        [Display(Name = "Mã bộ môn")]
        public string MaBM { get; set; }
    }
}
