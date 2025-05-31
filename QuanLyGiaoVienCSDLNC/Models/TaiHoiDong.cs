using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class TaiHoiDong
    {
        [Key]
        [StringLength(15)]
        public string MaHoiDong { get; set; }

        [Display(Name = "Số lượng")]
        public int SoLuong { get; set; }

        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [Display(Name = "Thời gian bắt đầu")]
        public DateTime ThoiGianBatDau { get; set; }

        [Display(Name = "Thời gian kết thúc")]
        public DateTime ThoiGianKetThuc { get; set; }

        [StringLength(200)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã loại hội đồng")]
        public string MaLoaiHoiDong { get; set; }

        [ForeignKey("MaLoaiHoiDong")]
        public virtual LoaiHoiDong LoaiHoiDong { get; set; }
    }
}