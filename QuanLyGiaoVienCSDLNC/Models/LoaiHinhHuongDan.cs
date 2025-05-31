using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class LoaiHinhHuongDan
    {
        [Key]
        [StringLength(15)]
        public string MaLoaiHinhHuongDan { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên loại hình hướng dẫn")]
        public string TenLoaiHinhHuongDan { get; set; }

        [StringLength(200)]
        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }
    }
}