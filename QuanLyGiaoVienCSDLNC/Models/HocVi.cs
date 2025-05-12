using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class HocVi
    {
        [Key]
        [StringLength(15)]
        public string MaHocVi { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên học vị")]
        public string TenHocVi { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày nhận")]
        public DateTime NgayNhan { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }
    }
}
