using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class CongTacKhac
    {
        [Key]
        [StringLength(15)]
        public string MaCongTacKhac { get; set; }

        [StringLength(200)]
        [Display(Name = "Nội dung công việc")]
        public string NoiDungCongViec { get; set; }

        [StringLength(20)]
        [Display(Name = "Năm học")]
        public string NamHoc { get; set; }

        [Display(Name = "Số lượng")]
        public int SoLuong { get; set; }

        [StringLength(200)]
        [Display(Name = "Ghi chú")]
        public string GhiChu { get; set; }
    }
}