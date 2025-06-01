using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs
{
    public class GiaoVienCreateUpdateDto
    {
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Họ tên không được để trống")]
        [StringLength(100)]
        public string HoTen { get; set; }

        [Required(ErrorMessage = "Ngày sinh không được để trống")]
        [DataType(DataType.Date)]
        public DateTime NgaySinh { get; set; }

        public bool GioiTinh { get; set; }

        [StringLength(100)]
        public string QueQuan { get; set; }

        [StringLength(100)]
        public string DiaChi { get; set; }

        [Required(ErrorMessage = "Số điện thoại không được để trống")]
        [Range(100000000, 999999999)]
        public int SDT { get; set; }

        [Required(ErrorMessage = "Email không được để trống")]
        [EmailAddress]
        [StringLength(100)]
        public string Email { get; set; }

        [Required(ErrorMessage = "Bộ môn không được để trống")]
        public string MaBM { get; set; }
    }
}
