using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class LichSuHocHam
    {
        [Key]
        [StringLength(15)]
        public string MaLSHocHam { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên học hàm")]
        public string TenHocHam { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày nhận")]
        public DateTime NgayNhan { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã học hàm")]
        public string MaHocHam { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaHocHam")]
        public virtual HocHam HocHam { get; set; }
    }
}
