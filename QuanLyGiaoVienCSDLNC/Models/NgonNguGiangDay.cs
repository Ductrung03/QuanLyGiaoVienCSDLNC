using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class NgonNguGiangDay
    {
        [Key]
        [StringLength(15)]
        public string MaNgonNgu { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên ngôn ngữ")]
        public string TenNgonNgu { get; set; }

        [Display(Name = "Hệ số quy chuẩn")]
        public double HeSoQuyChuan { get; set; }

        [StringLength(200)]
        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }
    }
}