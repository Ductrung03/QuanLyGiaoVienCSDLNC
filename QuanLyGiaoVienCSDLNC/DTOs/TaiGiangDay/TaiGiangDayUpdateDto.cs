using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs.TaiGiangDay
{
    public class TaiGiangDayUpdateDto
    {
        [Required]
        [StringLength(15)]
        public string MaTaiGiangDay { get; set; }

        [Required(ErrorMessage = "Tên học phần không được để trống")]
        [StringLength(100, ErrorMessage = "Tên học phần không được vượt quá 100 ký tự")]
        [Display(Name = "Tên học phần")]
        public string TenHocPhan { get; set; }

        [Required(ErrorMessage = "Sĩ số không được để trống")]
        [Range(1, 500, ErrorMessage = "Sĩ số phải từ 1 đến 500")]
        [Display(Name = "Sĩ số")]
        public int SiSo { get; set; }

        [Required(ErrorMessage = "Hệ đào tạo không được để trống")]
        [StringLength(20, ErrorMessage = "Hệ đào tạo không được vượt quá 20 ký tự")]
        [Display(Name = "Hệ đào tạo")]
        public string He { get; set; }

        [Required(ErrorMessage = "Lớp không được để trống")]
        [StringLength(20, ErrorMessage = "Lớp không được vượt quá 20 ký tự")]
        [Display(Name = "Lớp")]
        public string Lop { get; set; }

        [Required(ErrorMessage = "Số tín chỉ không được để trống")]
        [Range(1, 10, ErrorMessage = "Số tín chỉ phải từ 1 đến 10")]
        [Display(Name = "Số tín chỉ")]
        public int SoTinChi { get; set; }

        [StringLength(200, ErrorMessage = "Ghi chú không được vượt quá 200 ký tự")]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [Required(ErrorMessage = "Năm học không được để trống")]
        [StringLength(20, ErrorMessage = "Năm học không được vượt quá 20 ký tự")]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [Required(ErrorMessage = "Mã đối tượng không được để trống")]
        [StringLength(15, ErrorMessage = "Mã đối tượng không được vượt quá 15 ký tự")]
        [Display(Name = "Mã đối tượng")]
        public string MaDoiTuong { get; set; }

        [Required(ErrorMessage = "Mã thời gian không được để trống")]
        [StringLength(15, ErrorMessage = "Mã thời gian không được vượt quá 15 ký tự")]
        [Display(Name = "Mã thời gian")]
        public string MaThoiGian { get; set; }

        [Required(ErrorMessage = "Mã ngôn ngữ không được để trống")]
        [StringLength(15, ErrorMessage = "Mã ngôn ngữ không được vượt quá 15 ký tự")]
        [Display(Name = "Mã ngôn ngữ")]
        public string MaNgonNgu { get; set; }
    }
}
