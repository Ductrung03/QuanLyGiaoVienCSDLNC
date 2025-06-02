using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs.NCKH
{
    public class ChiTietNCKHCreateDto
    {
        [Required(ErrorMessage = "Mã giáo viên không được để trống")]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Mã tài NCKH không được để trống")]
        public string MaTaiNCKH { get; set; }

        [Required(ErrorMessage = "Vai trò không được để trống")]
        [StringLength(100)]
        [Display(Name = "Vai trò")]
        public string VaiTro { get; set; }

        [Required(ErrorMessage = "Số giờ không được để trống")]
        [Range(1, 500, ErrorMessage = "Số giờ phải từ 1 đến 500")]
        [Display(Name = "Số giờ")]
        public float SoGio { get; set; }
    }
}