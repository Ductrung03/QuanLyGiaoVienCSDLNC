using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class LoaiCongTacKhaoThi
    {
        [Key]
        [StringLength(15)]
        public string MaLoaiCongTacKhaoThi { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên loại công tác khảo thí")]
        public string TenLoaiCongTacKhaoThi { get; set; }

        [StringLength(200)]
        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }
    }
}