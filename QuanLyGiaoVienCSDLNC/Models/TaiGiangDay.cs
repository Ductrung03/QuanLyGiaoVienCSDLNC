using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class TaiGiangDay
    {
        [Key]
        [StringLength(15)]
        public string MaTaiGiangDay { get; set; }

        [StringLength(100)]
        [Display(Name = "Tên học phần")]
        public string TenHocPhan { get; set; }

        [Display(Name = "Sĩ số")]
        public int SiSo { get; set; }

        [StringLength(20)]
        [Display(Name = "Hệ")]
        public string He { get; set; }

        [StringLength(20)]
        [Display(Name = "Lớp")]
        public string Lop { get; set; }

        [Display(Name = "Số tín chỉ")]
        public int SoTinChi { get; set; }

        [StringLength(200)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }

        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã đối tượng")]
        public string MaDoiTuong { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã thời gian")]
        public string MaThoiGian { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã ngôn ngữ")]
        public string MaNgonNgu { get; set; }
    }
}
