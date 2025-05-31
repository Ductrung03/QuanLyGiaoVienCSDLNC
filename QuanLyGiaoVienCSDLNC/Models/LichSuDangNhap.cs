using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class LichSuDangNhap
    {
        [Key]
        [StringLength(50)]
        public string MaLichSu { get; set; }

        [Display(Name = "Thời điểm đăng nhập")]
        public DateTime ThoiDiemDangNhap { get; set; }

        [Display(Name = "Thời điểm đăng xuất")]
        public DateTime? ThoiDiemDangXuat { get; set; }

        [StringLength(50)]
        [Display(Name = "Mã người dùng")]
        public string MaNguoiDung { get; set; }

        [ForeignKey("MaNguoiDung")]
        public virtual NguoiDung NguoiDung { get; set; }
    }
}