using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class QuyDoiGioChuanNCKH
    {
        [Key]
        [StringLength(15)]
        public string MaQuyDoi { get; set; }

        [StringLength(50)]
        [Display(Name = "Đơn vị tính")]
        public string DonViTinh { get; set; }

        [Display(Name = "Quy ra giờ chuẩn")]
        public double QuyRaGioChuan { get; set; }

        [StringLength(200)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [StringLength(100)]
        [Display(Name = "Nhóm công việc")]
        public string NhomCongViec { get; set; }

        [StringLength(200)]
        [Display(Name = "Nội dung")]
        public string NoiDung { get; set; }
    }
}