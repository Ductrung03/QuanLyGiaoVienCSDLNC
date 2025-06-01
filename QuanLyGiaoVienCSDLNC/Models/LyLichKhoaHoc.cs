using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    namespace QuanLyGiaoVienCSDLNC.Models
    {
        public class LyLichKhoaHoc
        {
            [Key]
            [StringLength(15)]
            public string MaLyLichKhoaHoc { get; set; } // Thêm primary key

            [Required]
            [StringLength(100)]
            [Display(Name = "Hệ đào tạo đại học")]
            public string HeDaoTaoDH { get; set; }

            [Required]
            [StringLength(100)]
            [Display(Name = "Nơi đào tạo đại học")]
            public string NoiDaoTaoDH { get; set; }

            [Required]
            [StringLength(100)]
            [Display(Name = "Ngành học đại học")]
            public string NganhHocDH { get; set; }

            [Display(Name = "Nước đào tạo đại học")]
            public int? NuocDaoTaoDH { get; set; }

            [Display(Name = "Năm tốt nghiệp đại học")]
            public int? NamTotNghiepDH { get; set; }

            [StringLength(100)]
            [Display(Name = "Chuyên ngành thạc sĩ")]
            public string ThacSiChuyenNganh { get; set; }

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

            [Display(Name = "Năm cấp bằng sau đại học")]
            public int? NamCapBangSauDH { get; set; }

            [StringLength(100)]
            [Display(Name = "Nơi đào tạo sau đại học")]
            public string NoiDaoTaoSauDH { get; set; }

            [StringLength(200)]
            [Display(Name = "Tên luận án sau đại học")]
            public string TenLuanAnSauDH { get; set; }

            [DataType(DataType.Date)]
            [Display(Name = "Ngày khai")]
            public DateTime? NgayKhai { get; set; }

            [StringLength(15)]
            [Display(Name = "Mã giáo viên")]
            public string MaGV { get; set; }

            [ForeignKey("MaGV")]
            public virtual GiaoVien GiaoVien { get; set; }
        }
    }
   }
