using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ChucVu
    {
        [Key]
        [StringLength(15)]
        public string MaChucVu { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên chức vụ")]
        public string TenChucVu { get; set; }

        [StringLength(200)]
        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã định mức miễn giảm")]
        public string MaDinhMucMienGiam { get; set; }

        [ForeignKey("MaDinhMucMienGiam")]
        public virtual DinhMucMienGiam DinhMucMienGiam { get; set; }
    }
}