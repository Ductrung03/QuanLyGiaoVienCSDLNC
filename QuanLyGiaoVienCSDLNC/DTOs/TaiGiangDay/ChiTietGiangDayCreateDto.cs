using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs.ChiTietGiangDay
{
    public class ChiTietGiangDayCreateDto
    {
        [Required(ErrorMessage = "Mã giáo viên không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Mã tải giảng dạy không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã tải giảng dạy")]
        public string MaTaiGiangDay { get; set; }

        [Required(ErrorMessage = "Số tiết không được để trống")]
        [Range(1, 200, ErrorMessage = "Số tiết phải từ 1 đến 200")]
        [Display(Name = "Số tiết")]
        public int SoTiet { get; set; }

        [StringLength(200, ErrorMessage = "Ghi chú không được vượt quá 200 ký tự")]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã nội dung giảng dạy")]
        public string NoiDungGiangDay { get; set; }

        [Display(Name = "Kiểm tra trùng lịch")]
        public bool CheckConflict { get; set; } = true;
    }
}
