using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ChiTietTaiKhaoThi
    {
        [Key]
        [StringLength(15)]
        public string MaChiTietTaiKhaoThi { get; set; }

        [Display(Name = "Số bài")]
        public int SoBai { get; set; }

        [Display(Name = "Số giờ quy chuẩn")]
        public double SoGioQuyChuan { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã tài khảo thí")]
        public string MaTaiKhaoThi { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaTaiKhaoThi")]
        public virtual TaiKhaoThi TaiKhaoThi { get; set; }
    }
}