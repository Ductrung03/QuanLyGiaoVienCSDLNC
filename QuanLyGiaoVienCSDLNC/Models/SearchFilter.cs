namespace QuanLyGiaoVienCSDLNC.Models
{
    public class SearchFilter
    {
        public string SearchText { get; set; }
        public string MaKhoa { get; set; }
        public string MaBM { get; set; }
        public string HocVi { get; set; }
        public string HocHam { get; set; }
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 20;
        public string SortBy { get; set; } = "HoTen";
        public bool SortDesc { get; set; } = false;
    }
}