using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class NhomNguoiDung
    {
        [Key]
        [StringLength(50)]
        public string MaNhom { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên nhóm")]
        public string TenNhom { get; set; }
    }
}
