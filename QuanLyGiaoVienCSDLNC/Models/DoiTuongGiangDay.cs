using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class DoiTuongGiangDay
    {
        [Key]
        [StringLength(15)]
        public string MaDoiTuong { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên đối tượng")]
        public string TenDoiTuong { get; set; }

        [Display(Name = "Hệ số quy chuẩn")]
        public float HeSoQuyChuan { get; set; }

        [StringLength(200)]
        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }
    }
}