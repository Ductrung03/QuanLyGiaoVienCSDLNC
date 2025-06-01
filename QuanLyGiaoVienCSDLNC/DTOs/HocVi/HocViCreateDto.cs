using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs.HocVi
{
    public class HocViCreateDto
    {
        [Required(ErrorMessage = "Mã giáo viên không được để trống")]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Tên học vị không được để trống")]
        [StringLength(100)]
        [Display(Name = "Tên học vị")]
        public string TenHocVi { get; set; }

        [Required(ErrorMessage = "Ngày nhận không được để trống")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày nhận")]
        public DateTime NgayNhan { get; set; }
    }
}
