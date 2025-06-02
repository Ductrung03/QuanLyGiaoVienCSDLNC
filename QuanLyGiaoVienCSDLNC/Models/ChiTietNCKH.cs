using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ChiTietNCKH
    {
        [Key]
        [StringLength(15)]
        public string MaChiTietNCKH { get; set; }

        [StringLength(100)]
        [Display(Name = "Vai trò")]
        public string VaiTro { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã tài NCKH")]
        public string MaTaiNCKH { get; set; }

        [Display(Name = "Số giờ")]
        public double SoGio { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaTaiNCKH")]
        public virtual TaiNCKH TaiNCKH { get; set; }
    }
}