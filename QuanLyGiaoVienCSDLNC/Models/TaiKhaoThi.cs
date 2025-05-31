using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class TaiKhaoThi
    {
        [Key]
        [StringLength(15)]
        public string MaTaiKhaoThi { get; set; }

        [StringLength(100)]
        [Display(Name = "Học phần")]
        public string HocPhan { get; set; }

        [StringLength(50)]
        [Display(Name = "Lớp")]
        public string Lop { get; set; }

        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [StringLength(200)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã loại công tác khảo thí")]
        public string MaLoaiCongTacKhaoThi { get; set; }

        [ForeignKey("MaLoaiCongTacKhaoThi")]
        public virtual LoaiCongTacKhaoThi LoaiCongTacKhaoThi { get; set; }
    }
}