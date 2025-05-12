using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class Nhom_Quyen
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(50)]
        public string MaNhom { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string MaQuyen { get; set; }

        [ForeignKey("MaNhom")]
        public virtual NhomNguoiDung NhomNguoiDung { get; set; }

        [ForeignKey("MaQuyen")]
        public virtual Quyen Quyen { get; set; }
    }
}
