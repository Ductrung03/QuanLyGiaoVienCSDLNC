using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class GiaoVien
    {
        [Key]
        [StringLength(15)]
        [Display(Name = "Mã giáo viên")]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Họ tên không được để trống")]
        [StringLength(100, ErrorMessage = "Họ tên không được vượt quá 100 ký tự")]
        [Display(Name = "Họ tên")]
        public string HoTen { get; set; }

        [Required(ErrorMessage = "Ngày sinh không được để trống")]
        [DataType(DataType.Date)]
        [Display(Name = "Ngày sinh")]
        [CustomValidation(typeof(GiaoVien), nameof(ValidateNgaySinh))]
        public DateTime NgaySinh { get; set; }

        [Display(Name = "Giới tính")]
        public bool GioiTinh { get; set; }

        [StringLength(100, ErrorMessage = "Quê quán không được vượt quá 100 ký tự")]
        [Display(Name = "Quê quán")]
        public string QueQuan { get; set; }

        [StringLength(100, ErrorMessage = "Địa chỉ không được vượt quá 100 ký tự")]
        [Display(Name = "Địa chỉ")]
        public string DiaChi { get; set; }

        [Required(ErrorMessage = "Số điện thoại không được để trống")]
        [Range(100000000, 999999999, ErrorMessage = "Số điện thoại phải có 9 chữ số")]
        [Display(Name = "Số điện thoại")]
        public int SDT { get; set; }

        [Required(ErrorMessage = "Email không được để trống")]
        [StringLength(100, ErrorMessage = "Email không được vượt quá 100 ký tự")]
        [EmailAddress(ErrorMessage = "Email không đúng định dạng")]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Bộ môn không được để trống")]
        [StringLength(15)]
        [Display(Name = "Mã bộ môn")]
        public string MaBM { get; set; }

        // Navigation properties
        [ForeignKey("MaBM")]
        public virtual BoMon BoMon { get; set; }

        // Computed properties
        [NotMapped]
        [Display(Name = "Tuổi")]
        public int Tuoi
        {
            get
            {
                var today = DateTime.Today;
                var age = today.Year - NgaySinh.Year;
                if (NgaySinh.Date > today.AddYears(-age)) age--;
                return age;
            }
        }

        [NotMapped]
        [Display(Name = "Giới tính")]
        public string GioiTinhText => GioiTinh ? "Nam" : "Nữ";

        [NotMapped]
        [Display(Name = "Họ tên đầy đủ")]
        public string HoTenDayDu => $"{HoTen} ({MaGV})";

        // Custom validation methods
        public static ValidationResult ValidateNgaySinh(DateTime ngaySinh, ValidationContext context)
        {
            var today = DateTime.Today;
            var age = today.Year - ngaySinh.Year;
            if (ngaySinh.Date > today.AddYears(-age)) age--;

            if (ngaySinh > today)
                return new ValidationResult("Ngày sinh không thể trong tương lai");

            if (age < 22)
                return new ValidationResult("Giáo viên phải từ 22 tuổi trở lên");

            if (age > 70)
                return new ValidationResult("Giáo viên không thể trên 70 tuổi");

            return ValidationResult.Success;
        }
    }
    }