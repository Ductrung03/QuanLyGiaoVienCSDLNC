using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class GiaoVien
    {
        [Key]
        [StringLength(15)]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Họ tên không được để trống")]
        [StringLength(100)]
        [Display(Name = "Họ tên")]
        public string HoTen { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Ngày sinh")]
        public DateTime NgaySinh { get; set; }

        [Display(Name = "Giới tính")]
        public bool GioiTinh { get; set; }

        [StringLength(100)]
        [Display(Name = "Quê quán")]
        public string QueQuan { get; set; }

        [StringLength(100)]
        [Display(Name = "Địa chỉ")]
        public string DiaChi { get; set; }

        [Display(Name = "Số điện thoại")]
        public int SDT { get; set; }

        [StringLength(100)]
        [Display(Name = "Email")]
        [EmailAddress]
        public string Email { get; set; }

        [StringLength(15)]
        [Display(Name = "Mã bộ môn")]
        public string MaBM { get; set; }

        [ForeignKey("MaBM")]
        public virtual BoMon BoMon { get; set; }
    }
}