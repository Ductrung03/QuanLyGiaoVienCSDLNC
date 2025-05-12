// Controllers/HomeController.cs
using Microsoft.AspNetCore.Mvc;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;
using System.Diagnostics;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class HomeController : Controller
    {
        private readonly IThongKeService _thongKeService;
        private readonly IGiaoVienService _giaoVienService;

        public HomeController(IThongKeService thongKeService, IGiaoVienService giaoVienService)
        {
            _thongKeService = thongKeService;
            _giaoVienService = giaoVienService;
        }

        public async Task<IActionResult> Index()
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            // Hiển thị thông tin thống kê tổng quan
            var giaoviens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.TongSoGiaoVien = giaoviens.Count;

            var namHoc = "2023-2024"; // Mặc định lấy năm học hiện tại
            var thongKeGiangDay = await _thongKeService.ThongKeSoGioGiangDayAsync(null, null, null, namHoc);
            ViewBag.ThongKeGiangDay = thongKeGiangDay;

            var kiemTraDinhMuc = await _thongKeService.KiemTraHoanThanhDinhMucAsync(null, null, null, namHoc);
            ViewBag.KiemTraDinhMuc = kiemTraDinhMuc;

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}