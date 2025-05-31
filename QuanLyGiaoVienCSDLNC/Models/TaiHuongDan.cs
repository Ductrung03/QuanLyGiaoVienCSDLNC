using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class TaiHuongDan
    {
        [Key]
        [StringLength(15)]
        public string MaHuongDan { get; set; }

        [StringLength(100)]
        [Display(Name = "Họ tên học viên")]
        public string HoTenHocVien { get; set; }

        [StringLength(50)]
        [Display(Name = "Lớp")]
        public string Lop { get; set; }

        [StringLength(50)]
        [Display(Name = "Hệ")]
        public string He { get; set; }

        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [StringLength(200)]
        [Display(Name = "Tên đề tài")]
        public string TenDeTai { get; set; }

        [Display(Name = "Số cán bộ hướng dẫn")]
        public int SoCBHD { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã loại hình hướng dẫn")]
        public string MaLoaiHinhHuongDan { get; set; }

        [ForeignKey("MaLoaiHinhHuongDan")]
        public virtual LoaiHinhHuongDan LoaiHinhHuongDan { get; set; }
    }
}