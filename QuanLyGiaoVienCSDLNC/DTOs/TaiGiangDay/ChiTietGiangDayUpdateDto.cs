using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs.ChiTietGiangDay
{
    public class ChiTietGiangDayUpdateDto
    {
        [Required]
        [StringLength(15)]
        public string MaChiTietGiangDay { get; set; }

        [Required(ErrorMessage = "Số tiết không được để trống")]
        [Range(1, 200, ErrorMessage = "Số tiết phải từ 1 đến 200")]
        [Display(Name = "Số tiết")]
        public int SoTiet { get; set; }

        [StringLength(200, ErrorMessage = "Ghi chú không được vượt quá 200 ký tự")]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }
    }
}