// Controllers/GiaoVienController.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class GiaoVienController : Controller
    {
        private readonly IGiaoVienService _giaoVienService;
        private readonly IBoMonService _boMonService;
        private readonly IKhoaService _khoaService;

        public GiaoVienController(IGiaoVienService giaoVienService, IBoMonService boMonService, IKhoaService khoaService)
        {
            _giaoVienService = giaoVienService;
            _boMonService = boMonService;
            _khoaService = khoaService;
        }

        // GET: GiaoVien
        public async Task<IActionResult> Index(string searchString, string maBM, string maKhoa)
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            // Lấy danh sách khoa để hiển thị lọc
            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa");

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
            ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM");

            // Tìm kiếm giáo viên
            var giaoviens = await _giaoVienService.SearchGiaoVienAsync(searchString, maBM, maKhoa);

            // Lưu các tham số lọc để hiển thị trong view
            ViewBag.CurrentSearch = searchString;
            ViewBag.CurrentMaBM = maBM;
            ViewBag.CurrentMaKhoa = maKhoa;

            return View(giaoviens);
        }

        // GET: GiaoVien/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
            if (giaoVien == null)
            {
                return NotFound();
            }

            // Lấy thông tin chi tiết giáo viên
            var chiTiet = await _giaoVienService.GetChiTietGiaoVienAsync(id);
            ViewBag.ChiTiet = chiTiet;

            return View(giaoVien);
        }

        // GET: GiaoVien/Create
        public async Task<IActionResult> Create()
        {
            // Lấy danh sách bộ môn để hiển thị trong dropdown
            var boMons = await _boMonService.GetAllBoMonAsync();
            ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM");

            return View();
        }

        // POST: GiaoVien/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(GiaoVien giaoVien)
        {
            if (ModelState.IsValid)
            {
                var result = await _giaoVienService.AddGiaoVienAsync(giaoVien);
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

            // Nếu có lỗi, tải lại danh sách bộ môn
            var boMons = await _boMonService.GetAllBoMonAsync();
            ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM", giaoVien.MaBM);

            return View(giaoVien);
        }

        // GET: GiaoVien/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
            if (giaoVien == null)
            {
                return NotFound();
            }

            // Lấy danh sách bộ môn để hiển thị trong dropdown
            var boMons = await _boMonService.GetAllBoMonAsync();
            ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM", giaoVien.MaBM);

            return View(giaoVien);
        }

        // POST: GiaoVien/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, GiaoVien giaoVien)
        {
            if (id != giaoVien.MaGV)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                var result = await _giaoVienService.UpdateGiaoVienAsync(giaoVien);
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

            // Nếu có lỗi, tải lại danh sách bộ môn
            var boMons = await _boMonService.GetAllBoMonAsync();
            ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM", giaoVien.MaBM);

            return View(giaoVien);
        }

        // GET: GiaoVien/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
            if (giaoVien == null)
            {
                return NotFound();
            }

            return View(giaoVien);
        }

        // POST: GiaoVien/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var result = await _giaoVienService.DeleteGiaoVienAsync(id);
            if (result.success)
            {
                TempData["SuccessMessage"] = result.message;
            }
            else
            {
                TempData["ErrorMessage"] = result.message;
            }
            return RedirectToAction(nameof(Index));
        }
    }
}