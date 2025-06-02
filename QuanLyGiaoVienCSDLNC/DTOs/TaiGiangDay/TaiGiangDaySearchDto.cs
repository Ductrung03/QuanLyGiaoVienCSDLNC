namespace QuanLyGiaoVienCSDLNC.DTOs.TaiGiangDay
{
    public class TaiGiangDaySearchDto
    {
        public string SearchText { get; set; }
        public string NamHoc { get; set; }
        public string He { get; set; }
        public string MaDoiTuong { get; set; }
        public string MaThoiGian { get; set; }
        public string MaNgonNgu { get; set; }
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 20;
        public string SortBy { get; set; } = "TenHocPhan";
        public bool SortDesc { get; set; } = false;
    }
}