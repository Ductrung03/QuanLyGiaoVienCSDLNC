using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ChiTietGiangDay
    {
        [Key]
        [StringLength(15)]
        public string MaChiTietGiangDay { get; set; }

        [Display(Name = "Số tiết")]
        public int SoTiet { get; set; }

        [Display(Name = "Số tiết quy đổi")]
        public double SoTietQuyDoi { get; set; }

        [StringLength(200)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã tải giảng dạy")]
        public string MaTaiGiangDay { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã nội dung giảng dạy")]
        public string MaNoiDungGiangDay { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaTaiGiangDay")]
        public virtual TaiGiangDay TaiGiangDay { get; set; }
    }
}
