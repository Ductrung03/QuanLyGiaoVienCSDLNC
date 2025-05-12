using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class DinhMucNghienCuu
    {
        [Key]
        [StringLength(50)]
        public string MaDinhMucNghienCuu { get; set; }

        [StringLength(100)]
        [Display(Name = "Chức danh giảng dạy")]
        public string ChucDanhGiangDay { get; set; }

        [Display(Name = "Định mức thời gian hoạt động NCKH")]
        public int DinhMucThoiGianHoatDongNghienCuuKhoaHoc { get; set; }

        [Display(Name = "Định mức giờ chuẩn hoạt động NCKH")]
        public int DinhMucGioChuanHoatDongNghienCuuKhoaHoc { get; set; }
    }
}
