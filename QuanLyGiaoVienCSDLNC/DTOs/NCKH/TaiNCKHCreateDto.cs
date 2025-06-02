using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs.NCKH
{
    public class TaiNCKHCreateDto
    {
        [Required(ErrorMessage = "Tên công trình khoa học không được để trống")]
        [StringLength(200, ErrorMessage = "Tên công trình không được vượt quá 200 ký tự")]
        [Display(Name = "Tên công trình khoa học")]
        public string TenCongTrinhKhoaHoc { get; set; }

        [Required(ErrorMessage = "Năm học không được để trống")]
        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [Required(ErrorMessage = "Số tác giả không được để trống")]
        [Range(1, 20, ErrorMessage = "Số tác giả phải từ 1 đến 20")]
        [Display(Name = "Số tác giả")]
        public int SoTacGia { get; set; }

        [Required(ErrorMessage = "Loại NCKH không được để trống")]
        [Display(Name = "Mã loại NCKH")]
        public string MaLoaiNCKH { get; set; }
    }
}