using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.DTOs.NCKH;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class NCKHController : Controller
    {
        private readonly INCKHService _nckhService;
        private readonly IGiaoVienService _giaoVienService;
        private readonly IBoMonService _boMonService;
        private readonly IKhoaService _khoaService;

        public NCKHController(
            INCKHService nckhService,
            IGiaoVienService giaoVienService,
            IBoMonService boMonService,
            IKhoaService khoaService)
        {
            _nckhService = nckhService;
            _giaoVienService = giaoVienService;
            _boMonService = boMonService;
            _khoaService = khoaService;
        }

        // GET: NCKH
        public async Task<IActionResult> Index(TaiNCKHSearchDto searchDto)
        {
            try
            {
                var result = await _nckhService.SearchTaiNCKHAsync(searchDto);

                // Load dropdowns
                await LoadViewData();

                ViewBag.SearchDto = searchDto;
                ViewBag.AvailableNamHoc = await _nckhService.GetAvailableNamHocAsync();

                if (result.Success)
                {
                    return View(result.Data);
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                    return View(new DTOs.Common.PagedResultDto<TaiNCKHListItemDto>());
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi tải danh sách NCKH: {ex.Message}";
                return View(new DTOs.Common.PagedResultDto<TaiNCKHListItemDto>());
            }
        }

        // GET: NCKH/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không hợp lệ";
                return RedirectToAction(nameof(Index));
            }

            var result = await _nckhService.GetTaiNCKHDetailAsync(id);
            if (!result.Success)
            {
                TempData["ErrorMessage"] = result.Message;
                return RedirectToAction(nameof(Index));
            }

            return View(result.Data);
        }

        // GET: NCKH/Create
        public async Task<IActionResult> Create()
        {
            await LoadViewData();
            return View();
        }

        // POST: NCKH/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(TaiNCKHCreateDto dto)
        {
            if (ModelState.IsValid)
            {
                var result = await _nckhService.AddTaiNCKHAsync(dto);
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                    return RedirectToAction(nameof(Details), new { id = result.Data });
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                    if (result.Errors?.Any() == true)
                    {
                        foreach (var error in result.Errors)
                        {
                            ModelState.AddModelError("", error);
                        }
                    }
                }
            }

            await LoadViewData();
            return View(dto);
        }

        // GET: NCKH/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không hợp lệ";
                return RedirectToAction(nameof(Index));
            }

            var result = await _nckhService.GetTaiNCKHByIdAsync(id);
            if (!result.Success)
            {
                TempData["ErrorMessage"] = result.Message;
                return RedirectToAction(nameof(Index));
            }

            var dto = new TaiNCKHUpdateDto
            {
                MaTaiNCKH = result.Data.MaTaiNCKH,
                TenCongTrinhKhoaHoc = result.Data.TenCongTrinhKhoaHoc,
                NamHoc = result.Data.NamHoc,
                SoTacGia = result.Data.SoTacGia,
                MaLoaiNCKH = result.Data.MaLoaiNCKH
            };

            await LoadViewData();
            return View(dto);
        }

        // POST: NCKH/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, TaiNCKHUpdateDto dto)
        {
            if (id != dto.MaTaiNCKH)
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không khớp";
                return RedirectToAction(nameof(Index));
            }

            if (ModelState.IsValid)
            {
                var result = await _nckhService.UpdateTaiNCKHAsync(dto);
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                    return RedirectToAction(nameof(Details), new { id = dto.MaTaiNCKH });
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }
            }

            await LoadViewData();
            return View(dto);
        }

        // GET: NCKH/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không hợp lệ";
                return RedirectToAction(nameof(Index));
            }

            var result = await _nckhService.GetTaiNCKHDetailAsync(id);
            if (!result.Success)
            {
                TempData["ErrorMessage"] = result.Message;
                return RedirectToAction(nameof(Index));
            }

            return View(result.Data);
        }

        // POST: NCKH/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var result = await _nckhService.DeleteTaiNCKHAsync(id);
            if (result.Success)
            {
                TempData["SuccessMessage"] = result.Message;
            }
            else
            {
                TempData["ErrorMessage"] = result.Message;
            }

            return RedirectToAction(nameof(Index));
        }

        // GET: NCKH/PhanCong/5
        public async Task<IActionResult> PhanCong(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không hợp lệ";
                return RedirectToAction(nameof(Index));
            }

            var taiNCKHResult = await _nckhService.GetTaiNCKHDetailAsync(id);
            if (!taiNCKHResult.Success)
            {
                TempData["ErrorMessage"] = taiNCKHResult.Message;
                return RedirectToAction(nameof(Index));
            }

            var dto = new ChiTietNCKHCreateDto
            {
                MaTaiNCKH = id
            };

            ViewBag.TaiNCKH = taiNCKHResult.Data;
            ViewBag.AvailableVaiTro = await _nckhService.GetAvailableVaiTroAsync();
            await LoadGiaoVienDropdown();

            return View(dto);
        }

        // POST: NCKH/PhanCong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PhanCong(ChiTietNCKHCreateDto dto)
        {
            if (ModelState.IsValid)
            {
                var result = await _nckhService.PhanCongNCKHAsync(dto);
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                    return RedirectToAction(nameof(Details), new { id = dto.MaTaiNCKH });
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                    if (result.Errors?.Any() == true)
                    {
                        foreach (var error in result.Errors)
                        {
                            ModelState.AddModelError("", error);
                        }
                    }
                }
            }

            // Reload data for view
            var taiNCKHResult = await _nckhService.GetTaiNCKHDetailAsync(dto.MaTaiNCKH);
            ViewBag.TaiNCKH = taiNCKHResult.Data;
            ViewBag.AvailableVaiTro = await _nckhService.GetAvailableVaiTroAsync();
            await LoadGiaoVienDropdown();

            return View(dto);
        }

        // POST: NCKH/XoaPhanCong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> XoaPhanCong(string maChiTietNCKH, string maTaiNCKH)
        {
            var result = await _nckhService.DeleteChiTietNCKHAsync(maChiTietNCKH);
            if (result.Success)
            {
                TempData["SuccessMessage"] = result.Message;
            }
            else
            {
                TempData["ErrorMessage"] = result.Message;
            }

            return RedirectToAction(nameof(Details), new { id = maTaiNCKH });
        }

        // GET: NCKH/ThongKe
        public async Task<IActionResult> ThongKe(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            try
            {
                object thongKeData = null;

                if (!string.IsNullOrEmpty(maGV))
                {
                    var result = await _nckhService.GetThongKeNCKHByGiaoVienAsync(maGV, namHoc);
                    thongKeData = result.Data;
                }
                else if (!string.IsNullOrEmpty(maBM))
                {
                    var result = await _nckhService.GetThongKeNCKHByBoMonAsync(maBM, namHoc);
                    thongKeData = result.Data;
                }
                else if (!string.IsNullOrEmpty(maKhoa))
                {
                    var result = await _nckhService.GetThongKeNCKHByKhoaAsync(maKhoa, namHoc);
                    thongKeData = result.Data;
                }

                await LoadViewData();
                ViewBag.AvailableNamHoc = await _nckhService.GetAvailableNamHocAsync();
                ViewBag.SelectedMaGV = maGV;
                ViewBag.SelectedMaBM = maBM;
                ViewBag.SelectedMaKhoa = maKhoa;
                ViewBag.SelectedNamHoc = namHoc;

                return View(thongKeData);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi thống kê NCKH: {ex.Message}";
                return View();
            }
        }

        // Private helper methods
        private async Task LoadViewData()
        {
            var loaiNCKHResult = await _nckhService.GetAllLoaiNCKHAsync();
            ViewBag.LoaiNCKHList = loaiNCKHResult.Success
                ? new SelectList(loaiNCKHResult.Data, "MaLoaiNCKH", "TenLoaiNCKH")
                : new SelectList(new List<object>(), "MaLoaiNCKH", "TenLoaiNCKH");

            await LoadGiaoVienDropdown();
            await LoadBoMonDropdown();
            await LoadKhoaDropdown();
        }

        private async Task LoadGiaoVienDropdown()
        {
            var giaoVienList = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoVienList = new SelectList(giaoVienList, "MaGV", "HoTenDayDu");
        }

        private async Task LoadBoMonDropdown()
        {
            var boMonList = await _boMonService.GetAllBoMonAsync();
            ViewBag.BoMonList = new SelectList(boMonList, "MaBM", "TenBM");
        }

        private async Task LoadKhoaDropdown()
        {
            var khoaList = await _khoaService.GetAllKhoaAsync();
            ViewBag.KhoaList = new SelectList(khoaList, "MaKhoa", "TenKhoa");
        }
    }
}