using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class LichSuChucVu
    {
        [Key]
        [StringLength(15)]
        public string MaLichSuChucVu { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày nhận")]
        public DateTime NgayNhan { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày kết thúc")]
        public DateTime? NgayKetThuc { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã chức vụ")]
        public string MaChucVu { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaChucVu")]
        public virtual ChucVu ChucVu { get; set; }
    }
}