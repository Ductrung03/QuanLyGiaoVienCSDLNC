using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ThoiGianGiangDay
    {
        [Key]
        [StringLength(15)]
        public string MaThoiGian { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên thời gian")]
        public string TenThoiGian { get; set; }

        [Display(Name = "Hệ số quy chuẩn")]
        public double HeSoQuyChuan { get; set; }

        [StringLength(200)]
        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }
    }
}