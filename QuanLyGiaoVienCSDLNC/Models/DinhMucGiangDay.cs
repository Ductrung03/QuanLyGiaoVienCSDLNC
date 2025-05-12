using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class DinhMucGiangDay
    {
        [Key]
        [StringLength(50)]
        public string MaDinhMucGiangDay { get; set; }

        [StringLength(100)]
        [Display(Name = "Chức danh giảng dạy")]
        public string ChucDanhGiangDay { get; set; }

        [Display(Name = "Định mức giảng dạy")]
        public int dinhMucGiangDay { get; set; }

        [StringLength(100)]
        [Display(Name = "Mức giao dự kiến chất lượng/phòng")]
        public string MucGiaoDuKienChatLuong_GiaoDuKienPhong { get; set; }

        [StringLength(255)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }
    }
}
