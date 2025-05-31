using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class LoaiNCKH
    {
        [Key]
        [StringLength(15)]
        public string MaLoaiNCKH { get; set; }

        [StringLength(200)]
        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên loại NCKH")]
        public string TenLoaiNCKH { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã quy đổi")]
        public string MaQuyDoi { get; set; }

        [ForeignKey("MaQuyDoi")]
        public virtual QuyDoiGioChuanNCKH QuyDoiGioChuanNCKH { get; set; }
    }
}