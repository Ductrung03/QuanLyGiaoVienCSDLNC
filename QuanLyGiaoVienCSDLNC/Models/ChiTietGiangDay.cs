using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class ChiTietGiangDay
    {
        [Key]
        [StringLength(15)]
        public string MaChiTietGiangDay { get; set; }

        [Required(ErrorMessage = "Số tiết không được để trống")]
        [Range(1, 200, ErrorMessage = "Số tiết phải từ 1 đến 200")]
        [Display(Name = "Số tiết")]
        public int SoTiet { get; set; }

        [Display(Name = "Số tiết quy đổi")]
        public double SoTietQuyDoi { get; set; }

        [StringLength(200)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [Required(ErrorMessage = "Giáo viên không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Tài giảng dạy không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã tải giảng dạy")]
        public string MaTaiGiangDay { get; set; }

        [StringLength(200)]
        [Display(Name = "Nội dung giảng dạy")]
        public string NoiDungGiangDay { get; set; }

        [ForeignKey("MaGV")]
        public virtual GiaoVien GiaoVien { get; set; }

        [ForeignKey("MaTaiGiangDay")]
        public virtual TaiGiangDay TaiGiangDay { get; set; }
    }
}