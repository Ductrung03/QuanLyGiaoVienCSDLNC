using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class HocHam
    {
        [Key]
        [StringLength(15)]
        public string MaHocHam { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên học hàm")]
        public string TenHocHam { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã định mức nghiên cứu")]
        public string MaDinhMucNghienCuu { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã định mức giảng dạy")]
        public string MaDinhMucGiangDay { get; set; }
    }
}
