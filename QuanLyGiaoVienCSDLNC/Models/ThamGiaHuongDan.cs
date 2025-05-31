using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ThamGiaHuongDan
    {
        [Key]
        [StringLength(15)]
        public string MaThamGiaHuongDan { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã hướng dẫn")]
        public string MaHuongDan { get; set; }

        [Display(Name = "Số giờ")]
        public float SoGio { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaHuongDan")]
        public virtual TaiHuongDan TaiHuongDan { get; set; }
    }
}