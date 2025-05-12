using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class NguoiDung
    {
        [Key]
        [StringLength(50)]
        public string MaNguoiDung { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên đăng nhập")]
        public string TenDangNhap { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Mật khẩu")]
        [DataType(DataType.Password)]
        public string MatKhau { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }
    }
}
