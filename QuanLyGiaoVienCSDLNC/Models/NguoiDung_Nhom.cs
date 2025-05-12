using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class NguoiDung_Nhom
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(50)]
        public string MaNguoiDung { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string MaNhom { get; set; }

        [ForeignKey("MaNguoiDung")]
        public virtual NguoiDung NguoiDung { get; set; }

        [ForeignKey("MaNhom")]
        public virtual NhomNguoiDung NhomNguoiDung { get; set; }
    }
}
