// Controllers/GiangDayController.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class GiangDayController : Controller
    {
        private readonly ITaiGiangDayService _taiGiangDayService;
        private readonly IGiaoVienService _giaoVienService;

        public GiangDayController(ITaiGiangDayService taiGiangDayService, IGiaoVienService giaoVienService)
        {
            _taiGiangDayService = taiGiangDayService;
            _giaoVienService = giaoVienService;
        }

        // GET: GiangDay
        public async Task<IActionResult> Index()
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var taiGiangDays = await _taiGiangDayService.GetAllTaiGiangDayAsync();
            return View(taiGiangDays);
        }

        // GET: GiangDay/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taiGiangDay = await _taiGiangDayService.GetTaiGiangDayByIdAsync(id);
            if (taiGiangDay == null)
            {
                return NotFound();
            }

            return View(taiGiangDay);
        }

        // GET: GiangDay/Create
        public IActionResult Create()
        {
            // Hiển thị form tạo mới tải giảng dạy
            // Cần lấy thêm các danh sách mã đối tượng, thời gian, ngôn ngữ
            return View();
        }

        // POST: GiangDay/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(TaiGiangDay taiGiangDay)
        {
            if (ModelState.IsValid)
            {
                var result = await _taiGiangDayService.AddTaiGiangDayAsync(taiGiangDay);
                if (result.success)
                {
                    TempData["SuccessMessage"] = result.message;
                    return RedirectToAction(nameof(Index));
                }
                else
                {
                    ModelState.AddModelError("", result.message);
                }
            }
            return View(taiGiangDay);
        }

        // GET: GiangDay/PhanCong/5
        public async Task<IActionResult> PhanCong(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taiGiangDay = await _taiGiangDayService.GetTaiGiangDayByIdAsync(id);
            if (taiGiangDay == null)
            {
                return NotFound();
            }

            // Lấy danh sách giáo viên để hiển thị trong dropdown
            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen");

            ViewBag.TaiGiangDay = taiGiangDay;
            return View();
        }

        // POST: GiangDay/PhanCong/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PhanCong(string id, string maGV, int soTiet, string ghiChu, string maNoiDungGiangDay)
        {
            if (id == null)
            {
                return NotFound();
            }

            var result = await _taiGiangDayService.PhanCongGiangDayAsync(maGV, id, soTiet, ghiChu, maNoiDungGiangDay);
            if (result.success)
            {
                TempData["SuccessMessage"] = result.message;
                return RedirectToAction(nameof(Index));
            }
            else
            {
                // Lấy danh sách giáo viên để hiển thị lại trong dropdown
                var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
                ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", maGV);

                var taiGiangDay = await _taiGiangDayService.GetTaiGiangDayByIdAsync(id);
                ViewBag.TaiGiangDay = taiGiangDay;

                TempData["ErrorMessage"] = result.message;
                return View();
            }
        }
    }
}