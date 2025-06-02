using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ThamGia
    {
        [Key]
        [StringLength(15)]
        public string MaThamGia { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã hội đồng")]
        public string MaHoiDong { get; set; }

        [Display(Name = "Số giờ")]
        public double SoGio { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaHoiDong")]
        public virtual TaiHoiDong TaiHoiDong { get; set; }
    }
}