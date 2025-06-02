using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class TaiGiangDay
    {
        [Key]
        [StringLength(15)]
        public string MaTaiGiangDay { get; set; }

        [Required(ErrorMessage = "Tên học phần không được để trống")]
        [StringLength(100)]
        [Display(Name = "Tên học phần")]
        public string TenHocPhan { get; set; }

        [Required(ErrorMessage = "Sĩ số không được để trống")]
        [Range(1, 500, ErrorMessage = "Sĩ số phải từ 1 đến 500")]
        [Display(Name = "Sĩ số")]
        public int SiSo { get; set; }

        [Required(ErrorMessage = "Hệ đào tạo không được để trống")]
        [StringLength(20)]
        [Display(Name = "Hệ đào tạo")]
        public string He { get; set; }

        [Required(ErrorMessage = "Lớp không được để trống")]
        [StringLength(20)]
        [Display(Name = "Lớp")]
        public string Lop { get; set; }

        [Required(ErrorMessage = "Số tín chỉ không được để trống")]
        [Range(1, 10, ErrorMessage = "Số tín chỉ phải từ 1 đến 10")]
        [Display(Name = "Số tín chỉ")]
        public int SoTinChi { get; set; }

        [StringLength(200)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [Required(ErrorMessage = "Năm học không được để trống")]
        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [Required(ErrorMessage = "Đối tượng giảng dạy không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã đối tượng")]
        public string MaDoiTuong { get; set; }

        [Required(ErrorMessage = "Thời gian giảng dạy không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã thời gian")]
        public string MaThoiGian { get; set; }

        [Required(ErrorMessage = "Ngôn ngữ giảng dạy không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã ngôn ngữ")]
        public string MaNgonNgu { get; set; }

        // Navigation properties
        [ForeignKey("MaDoiTuong")]
        public virtual DoiTuongGiangDay DoiTuongGiangDay { get; set; }

        [ForeignKey("MaThoiGian")]
        public virtual ThoiGianGiangDay ThoiGianGiangDay { get; set; }

        [ForeignKey("MaNgonNgu")]
        public virtual NgonNguGiangDay NgonNguGiangDay { get; set; }

        // Collection navigation properties
        public virtual ICollection<ChiTietGiangDay> ChiTietGiangDays { get; set; }

        // Computed properties
        [NotMapped]
        [Display(Name = "Trạng thái")]
        public string TrangThai => ChiTietGiangDays?.Any() == true ? "Đã phân công" : "Chưa phân công";

        [NotMapped]
        [Display(Name = "Số giáo viên")]
        public int SoGiaoVienPhanCong => ChiTietGiangDays?.Count() ?? 0;

        [NotMapped]
        [Display(Name = "Tổng số tiết")]
        public int TongSoTiet => ChiTietGiangDays?.Sum(x => x.SoTiet) ?? 0;

        [NotMapped]
        [Display(Name = "Tổng giờ quy đổi")]
        public double TongGioQuyDoi => ChiTietGiangDays?.Sum(x => x.SoTietQuyDoi) ?? 0;
    }
}