// Controllers/BaoCaoController.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class BaoCaoController : Controller
    {
        private readonly IThongKeService _thongKeService;
        private readonly IKhoaService _khoaService;
        private readonly IBoMonService _boMonService;
        private readonly IGiaoVienService _giaoVienService;

        public BaoCaoController(IThongKeService thongKeService, IKhoaService khoaService,
            IBoMonService boMonService, IGiaoVienService giaoVienService)
        {
            _thongKeService = thongKeService;
            _khoaService = khoaService;
            _boMonService = boMonService;
            _giaoVienService = giaoVienService;
        }

        // GET: BaoCao/GiangDayTheoGiaoVien
        public async Task<IActionResult> GiangDayTheoGiaoVien(string maGV, string maBM, string maKhoa, string namHoc)
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            // Lấy danh sách khoa, bộ môn, giáo viên để hiển thị trong dropdown lọc
            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa", maKhoa);

            // Lấy danh sách bộ môn dựa trên khoa được chọn (nếu có)
            List<BoMon> boMons;
            if (!string.IsNullOrEmpty(maKhoa))
            {
                boMons = await _boMonService.GetBoMonByKhoaIdAsync(maKhoa);
            }
            else
            {
                boMons = await _boMonService.GetAllBoMonAsync();
            }
            ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM", maBM);

            // Lấy danh sách giáo viên dựa trên bộ môn được chọn (nếu có)
            List<GiaoVien> giaoViens;
            if (!string.IsNullOrEmpty(maBM))
            {
                giaoViens = await _giaoVienService.SearchGiaoVienSimpleAsync(null, maBM, null);
            }
            else if (!string.IsNullOrEmpty(maKhoa))
            {
                giaoViens = await _giaoVienService.SearchGiaoVienSimpleAsync(null, null, maKhoa);
            }
            else
            {
                giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            }
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", maGV);

            // Danh sách năm học
            var namHocs = new List<string> { "2022-2023", "2023-2024", "2024-2025" };
            ViewBag.NamHocs = new SelectList(namHocs, namHoc ?? "2023-2024");

            // Lấy dữ liệu báo cáo
            var data = await _thongKeService.ThongKeSoGioGiangDayAsync(maGV, maBM, maKhoa, namHoc);
            if (data is DataTable dt)
            {
                var columnNames = string.Join(", ", dt.Columns.Cast<DataColumn>().Select(c => c.ColumnName));
                System.Diagnostics.Debug.WriteLine($"Columns: {columnNames}");
            }
            ViewBag.Data = data;

            // Lưu các tham số lọc để hiển thị trong view
            ViewBag.CurrentMaGV = maGV;
            ViewBag.CurrentMaBM = maBM;
            ViewBag.CurrentMaKhoa = maKhoa;
            ViewBag.CurrentNamHoc = namHoc ?? "2023-2024";

            return View();
        }

        // GET: BaoCao/NCKHTheoGiaoVien
        public async Task<IActionResult> NCKHTheoGiaoVien(string maGV, string maBM, string maKhoa, string namHoc)
        {
            // Tương tự như GiangDayTheoGiaoVien
            // Lấy danh sách khoa, bộ môn, giáo viên để hiển thị trong dropdown
            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa", maKhoa);

            // Lấy dữ liệu báo cáo
            var data = await _thongKeService.ThongKeSoGioNCKHAsync(maGV, maBM, maKhoa, namHoc);
            ViewBag.Data = data;

            return View();
        }

        // GET: BaoCao/HoanThanhDinhMuc
        public async Task<IActionResult> HoanThanhDinhMuc(string maGV, string maBM, string maKhoa, string namHoc)
        {
            // Tương tự như GiangDayTheoGiaoVien
            // Lấy danh sách khoa, bộ môn, giáo viên để hiển thị trong dropdown
            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa", maKhoa);

            // Lấy dữ liệu báo cáo
            var data = await _thongKeService.KiemTraHoanThanhDinhMucAsync(maGV, maBM, maKhoa, namHoc);
            ViewBag.Data = data;

            return View();
        }

        // GET: BaoCao/GiangDayTheoKhoaBoMon
        public async Task<IActionResult> GiangDayTheoKhoaBoMon(string namHoc)
        {
            // Danh sách năm học
            var namHocs = new List<string> { "2022-2023", "2023-2024", "2024-2025" };
            ViewBag.NamHocs = new SelectList(namHocs, namHoc ?? "2023-2024");

            // Lấy dữ liệu báo cáo
            var data = await _thongKeService.BaoCaoGiangDayTheoKhoaBoMonAsync(namHoc);
            ViewBag.Data = data;

            return View();
        }

        // GET: BaoCao/NCKHTheoKhoaBoMon
        public async Task<IActionResult> NCKHTheoKhoaBoMon(string namHoc)
        {
            // Danh sách năm học
            var namHocs = new List<string> { "2022-2023", "2023-2024", "2024-2025" };
            ViewBag.NamHocs = new SelectList(namHocs, namHoc ?? "2023-2024");

            // Lấy dữ liệu báo cáo
            var data = await _thongKeService.BaoCaoNCKHTheoKhoaBoMonAsync(namHoc);
            ViewBag.Data = data;

            return View();
        }

        // GET: BaoCao/HoanThanhDinhMucTheoKhoaBoMon
        public async Task<IActionResult> HoanThanhDinhMucTheoKhoaBoMon(string namHoc)
        {
            // Danh sách năm học
            var namHocs = new List<string> { "2022-2023", "2023-2024", "2024-2025" };
            ViewBag.NamHocs = new SelectList(namHocs, namHoc ?? "2023-2024");

            // Lấy dữ liệu báo cáo
            var data = await _thongKeService.BaoCaoHoanThanhDinhMucTheoKhoaBoMonAsync(namHoc);
            ViewBag.Data = data;

            return View();
        }
    }
}