using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class QuanHam
    {
        [Key]
        [StringLength(15)]
        public string MaQuanHam { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên quân hàm")]
        public string TenQuanHam { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày nhận")]
        public DateTime NgayNhan { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày kết thúc")]
        public DateTime? NgayKetThuc { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }
    }
}