// Controllers/KhoaController.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class KhoaController : Controller
    {
        private readonly IKhoaService _khoaService;
        private readonly IGiaoVienService _giaoVienService;

        public KhoaController(IKhoaService khoaService, IGiaoVienService giaoVienService)
        {
            _khoaService = khoaService;
            _giaoVienService = giaoVienService;
        }

        // GET: Khoa
        public async Task<IActionResult> Index()
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var khoas = await _khoaService.GetAllKhoaAsync();
            return View(khoas);
        }

        // GET: Khoa/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var khoa = await _khoaService.GetKhoaByIdAsync(id);
            if (khoa == null)
            {
                return NotFound();
            }

            return View(khoa);
        }

        // GET: Khoa/Create
        public async Task<IActionResult> Create()
        {
            // Lấy danh sách giáo viên để hiển thị trong dropdown khi chọn chủ nhiệm khoa
            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen");

            return View();
        }

        // POST: Khoa/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Khoa khoa)
        {
            if (ModelState.IsValid)
            {
                var result = await _khoaService.AddKhoaAsync(khoa);
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

            // Nếu có lỗi, tải lại danh sách giáo viên
            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", khoa.MaChuNhiemKhoa);

            return View(khoa);
        }

        // GET: Khoa/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var khoa = await _khoaService.GetKhoaByIdAsync(id);
            if (khoa == null)
            {
                return NotFound();
            }

            // Lấy danh sách giáo viên để hiển thị trong dropdown khi chọn chủ nhiệm khoa
            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", khoa.MaChuNhiemKhoa);

            return View(khoa);
        }

        // POST: Khoa/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, Khoa khoa)
        {
            if (id != khoa.MaKhoa)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                var result = await _khoaService.UpdateKhoaAsync(khoa);
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

            // Nếu có lỗi, tải lại danh sách giáo viên
            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", khoa.MaChuNhiemKhoa);

            return View(khoa);
        }

        // GET: Khoa/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var khoa = await _khoaService.GetKhoaByIdAsync(id);
            if (khoa == null)
            {
                return NotFound();
            }

            return View(khoa);
        }

        // POST: Khoa/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var result = await _khoaService.DeleteKhoaAsync(id);
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

        // GET: Khoa/PhanCongChuNhiem/5
        public async Task<IActionResult> PhanCongChuNhiem(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var khoa = await _khoaService.GetKhoaByIdAsync(id);
            if (khoa == null)
            {
                return NotFound();
            }

            // Lấy danh sách giáo viên để hiển thị trong dropdown khi chọn chủ nhiệm khoa
            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", khoa.MaChuNhiemKhoa);

            return View(khoa);
        }

        // POST: Khoa/PhanCongChuNhiem/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PhanCongChuNhiem(string id, string maGV)
        {
            if (id == null)
            {
                return NotFound();
            }

            var result = await _khoaService.PhanCongChuNhiemKhoaAsync(id, maGV);
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