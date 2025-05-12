using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class Quyen
    {
        [Key]
        [StringLength(50)]
        public string MaQuyen { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên quyền")]
        public string TenQuyen { get; set; }
    }

}
