// Controllers/BoMonController.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class BoMonController : Controller
    {
        private readonly IBoMonService _boMonService;
        private readonly IKhoaService _khoaService;
        private readonly IGiaoVienService _giaoVienService;

        public BoMonController(IBoMonService boMonService, IKhoaService khoaService, IGiaoVienService giaoVienService)
        {
            _boMonService = boMonService;
            _khoaService = khoaService;
            _giaoVienService = giaoVienService;
        }

        // GET: BoMon
        public async Task<IActionResult> Index()
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var boMons = await _boMonService.GetAllBoMonAsync();
            return View(boMons);
        }

        // GET: BoMon/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var boMon = await _boMonService.GetBoMonByIdAsync(id);
            if (boMon == null)
            {
                return NotFound();
            }

            return View(boMon);
        }

        // GET: BoMon/Create
        public async Task<IActionResult> Create()
        {
            // Lấy danh sách khoa để hiển thị trong dropdown
            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa");

            // Lấy danh sách giáo viên để hiển thị trong dropdown khi chọn chủ nhiệm bộ môn
            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen");

            return View();
        }

        // POST: BoMon/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(BoMon boMon)
        {
            if (ModelState.IsValid)
            {
                var result = await _boMonService.AddBoMonAsync(boMon);
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

            // Nếu có lỗi, tải lại danh sách khoa và giáo viên
            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa", boMon.MaKhoa);

            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", boMon.MaChuNhiemBM);

            return View(boMon);
        }

        // GET: BoMon/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var boMon = await _boMonService.GetBoMonByIdAsync(id);
            if (boMon == null)
            {
                return NotFound();
            }

            // Lấy danh sách khoa để hiển thị trong dropdown
            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa", boMon.MaKhoa);

            // Lấy danh sách giáo viên để hiển thị trong dropdown khi chọn chủ nhiệm bộ môn
            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", boMon.MaChuNhiemBM);

            return View(boMon);
        }

        // POST: BoMon/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, BoMon boMon)
        {
            if (id != boMon.MaBM)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                var result = await _boMonService.UpdateBoMonAsync(boMon);
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

            // Nếu có lỗi, tải lại danh sách khoa và giáo viên
            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa", boMon.MaKhoa);

            var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", boMon.MaChuNhiemBM);

            return View(boMon);
        }

        // GET: BoMon/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var boMon = await _boMonService.GetBoMonByIdAsync(id);
            if (boMon == null)
            {
                return NotFound();
            }

            return View(boMon);
        }

        // POST: BoMon/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var result = await _boMonService.DeleteBoMonAsync(id);
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

        // GET: BoMon/PhanCongChuNhiem/5
        public async Task<IActionResult> PhanCongChuNhiem(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var boMon = await _boMonService.GetBoMonByIdAsync(id);
            if (boMon == null)
            {
                return NotFound();
            }

            // Lấy danh sách giáo viên thuộc bộ môn để hiển thị trong dropdown
            var giaoViens = await _giaoVienService.SearchGiaoVienAsync(null, id, null);
            ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", boMon.MaChuNhiemBM);

            return View(boMon);
        }

        // POST: BoMon/PhanCongChuNhiem/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PhanCongChuNhiem(string id, string maGV)
        {
            if (id == null)
            {
                return NotFound();
            }

            var result = await _boMonService.PhanCongChuNhiemBoMonAsync(id, maGV);
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