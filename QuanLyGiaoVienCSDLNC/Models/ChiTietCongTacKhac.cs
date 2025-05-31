using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ChiTietCongTacKhac
    {
        [Key]
        [StringLength(15)]
        public string MaChiTietCongTacKhac { get; set; }

        [StringLength(100)]
        [Display(Name = "Vai trò")]
        public string VaiTro { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã công tác khác")]
        public string MaCongTacKhac { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaCongTacKhac")]
        public virtual CongTacKhac CongTacKhac { get; set; }
    }
}