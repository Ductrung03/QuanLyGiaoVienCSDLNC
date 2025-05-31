using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class NhatKyThayDoi
    {
        [Key]
        [StringLength(50)]
        public string MaNhatKy { get; set; }

        [StringLength(50)]
        [Display(Name = "Mã lịch sử")]
        public string MaLichSu { get; set; }

        [Display(Name = "Thời gian thay đổi")]
        public DateTime ThoiGianThayDoi { get; set; }

        [StringLength(255)]
        [Display(Name = "Nội dung thay đổi")]
        public string NoiDungThayDoi { get; set; }

        [StringLength(255)]
        [Display(Name = "Thông tin cũ")]
        public string ThongTinCu { get; set; }

        [StringLength(255)]
        [Display(Name = "Thông tin mới")]
        public string ThongTinMoi { get; set; }

        [ForeignKey("MaLichSu")]
        public virtual LichSuDangNhap LichSuDangNhap { get; set; }
    }
}