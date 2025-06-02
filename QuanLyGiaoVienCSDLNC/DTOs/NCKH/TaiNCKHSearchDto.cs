namespace QuanLyGiaoVienCSDLNC.DTOs.NCKH
{
    public class TaiNCKHSearchDto
    {
        public string SearchText { get; set; }
        public string NamHoc { get; set; }
        public string MaLoaiNCKH { get; set; }
        public string MaGV { get; set; }
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 20;
        public string SortBy { get; set; } = "TenCongTrinhKhoaHoc";
        public bool SortDesc { get; set; } = false;
    }
}