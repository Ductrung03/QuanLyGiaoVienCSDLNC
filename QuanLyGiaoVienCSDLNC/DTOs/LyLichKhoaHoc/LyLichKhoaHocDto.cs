using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.DTOs.LyLichKhoaHoc
{
    public class LyLichKhoaHocDto
    {
        [Required]
        public string MaGV { get; set; }

        [Required(ErrorMessage = "Hệ đào tạo đại học không được để trống")]
        [StringLength(100)]
        [Display(Name = "Hệ đào tạo đại học")]
        public string HeDaoTaoDH { get; set; }

        [Required(ErrorMessage = "Nơi đào tạo đại học không được để trống")]
        [StringLength(100)]
        [Display(Name = "Nơi đào tạo đại học")]
        public string NoiDaoTaoDH { get; set; }

        [Required(ErrorMessage = "Ngành học đại học không được để trống")]
        [StringLength(100)]
        [Display(Name = "Ngành học đại học")]
        public string NganhHocDH { get; set; }

        [StringLength(100)]
        [Display(Name = "Nước đào tạo đại học")]
        public string NuocDaoTaoDH { get; set; }

        [Range(1950, 2030, ErrorMessage = "Năm tốt nghiệp không hợp lệ")]
        [Display(Name = "Năm tốt nghiệp đại học")]
        public int? NamTotNghiepDH { get; set; }

        [StringLength(100)]
        [Display(Name = "Chuyên ngành thạc sĩ")]
        public string ThacSiChuyenNganh { get; set; }

        [Range(1950, 2030, ErrorMessage = "Năm cấp bằng không hợp lệ")]
        [Display(Name = "Năm cấp bằng tiến sĩ")]
        public int? NamCapBangTS { get; set; }

        [StringLength(100)]
        [Display(Name = "Nơi đào tạo tiến sĩ")]
        public string NoiDaoTaoTS { get; set; }

        [StringLength(200)]
        [Display(Name = "Tên luận văn tốt nghiệp")]
        public string TenLuanVanTotNghiep { get; set; }

        [StringLength(100)]
        [Display(Name = "Chuyên ngành tiến sĩ")]
        public string TienSiChuyenNganh { get; set; }

        [Range(1950, 2030, ErrorMessage = "Năm cấp bằng không hợp lệ")]
        [Display(Name = "Năm cấp bằng sau đại học")]
        public int? NamCapBangSauDH { get; set; }

        [StringLength(100)]
        [Display(Name = "Nơi đào tạo sau đại học")]
        public string NoiDaoTaoSauDH { get; set; }

        [StringLength(200)]
        [Display(Name = "Tên luận án sau đại học")]
        public string TenLuanAnSauDH { get; set; }
    }
}