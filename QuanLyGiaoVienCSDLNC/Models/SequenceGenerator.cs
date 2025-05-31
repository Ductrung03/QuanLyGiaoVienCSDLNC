using System.ComponentModel.DataAnnotations;

namespace QuanLyGiaoVienCSDLNC.Models
{
    public class SequenceGenerator
    {
        [Key]
        [StringLength(50)]
        public string TableName { get; set; }

        [Required]
        public int LastSequence { get; set; } = 0;
    }
}