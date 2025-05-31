using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class DinhMucMienGiam
    {
        [Key]
        [StringLength(15)]
        public string MaDinhMucMienGiam { get; set; }

        [StringLength(100)]
        [Display(Name = "Đối tượng miễn giảm")]
        public string DoiTuongMienGiam { get; set; }

        [Display(Name = "Tỷ lệ miễn giảm")]
        public float TyLeMienGiam { get; set; }

        [StringLength(100)]
        [Display(Name = "Ghi chú miễn giảm")]
        public string GhiChuMienGiam { get; set; }
    }
}