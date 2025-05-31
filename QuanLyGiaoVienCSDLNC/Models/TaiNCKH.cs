using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class TaiNCKH
    {
        [Key]
        [StringLength(15)]
        public string MaTaiNCKH { get; set; }

        [Required]
        [StringLength(200)]
        [Display(Name = "Tên công trình khoa học")]
        public string TenCongTrinhKhoaHoc { get; set; }

        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [Display(Name = "Số tác giả")]
        public int SoTacGia { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã loại NCKH")]
        public string MaLoaiNCKH { get; set; }

        [ForeignKey("MaLoaiNCKH")]
        public virtual LoaiNCKH LoaiNCKH { get; set; }
    }
}