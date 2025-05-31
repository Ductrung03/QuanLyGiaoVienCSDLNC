using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class LoaiHoiDong
    {
        [Key]
        [StringLength(15)]
        public string MaLoaiHoiDong { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên loại hội đồng")]
        public string TenLoaiHoiDong { get; set; }

        [StringLength(200)]
        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }
    }
}