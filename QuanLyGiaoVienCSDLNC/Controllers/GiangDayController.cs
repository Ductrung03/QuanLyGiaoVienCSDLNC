// Controllers/GiangDayController.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.DTOs.TaiGiangDay;
using QuanLyGiaoVienCSDLNC.DTOs.ChiTietGiangDay;
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

        #region TaiGiangDay Actions

        // GET: GiangDay
        public async Task<IActionResult> Index(TaiGiangDaySearchDto searchDto)
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            // Lấy danh sách lookup data
            await PopulateViewBagDataAsync();

            // Tìm kiếm
            var result = await _taiGiangDayService.SearchTaiGiangDayAsync(searchDto);
            if (result.Success)
            {
                ViewBag.SearchDto = searchDto;
                return View(result.Data);
            }
            else
            {
                TempData["ErrorMessage"] = result.Message;
                return View();
            }
        }

        // GET: GiangDay/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            var result = await _taiGiangDayService.GetTaiGiangDayByIdAsync(id);
            if (!result.Success || result.Data == null)
            {
                TempData["ErrorMessage"] = result.Message;
                return RedirectToAction(nameof(Index));
            }

            // Lấy danh sách giáo viên được phân công
            var chiTietResult = await _taiGiangDayService.GetChiTietGiangDayByTaiGiangDayAsync(id);
            ViewBag.ChiTietGiangDay = chiTietResult.Success ? chiTietResult.Data : new List<Models.ChiTietGiangDay>();

            return View(result.Data);
        }

        // GET: GiangDay/Create
        public async Task<IActionResult> Create()
        {
            await PopulateViewBagDataAsync();
            return View(new TaiGiangDayCreateDto());
        }

        // POST: GiangDay/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(TaiGiangDayCreateDto dto)
        {
            if (ModelState.IsValid)
            {
                var result = await _taiGiangDayService.AddTaiGiangDayAsync(dto);
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                    return RedirectToAction(nameof(Index));
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

            await PopulateViewBagDataAsync();
            return View(dto);
        }

        // GET: GiangDay/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            var result = await _taiGiangDayService.GetTaiGiangDayByIdAsync(id);
            if (!result.Success || result.Data == null)
            {
                TempData["ErrorMessage"] = result.Message;
                return RedirectToAction(nameof(Index));
            }

            var dto = new TaiGiangDayUpdateDto
            {
                MaTaiGiangDay = result.Data.MaTaiGiangDay,
                TenHocPhan = result.Data.TenHocPhan,
                SiSo = result.Data.SiSo,
                He = result.Data.He,
                Lop = result.Data.Lop,
                SoTinChi = result.Data.SoTinChi,
                GhiChu = result.Data.GhiChu,
                NamHoc = result.Data.NamHoc,
                MaDoiTuong = result.Data.MaDoiTuong,
                MaThoiGian = result.Data.MaThoiGian,
                MaNgonNgu = result.Data.MaNgonNgu
            };

            await PopulateViewBagDataAsync();
            return View(dto);
        }

        // POST: GiangDay/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(TaiGiangDayUpdateDto dto)
        {
            if (ModelState.IsValid)
            {
                var result = await _taiGiangDayService.UpdateTaiGiangDayAsync(dto);
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                    return RedirectToAction(nameof(Index));
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }
            }

            await PopulateViewBagDataAsync();
            return View(dto);
        }

        // GET: GiangDay/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            var result = await _taiGiangDayService.GetTaiGiangDayByIdAsync(id);
            if (!result.Success || result.Data == null)
            {
                TempData["ErrorMessage"] = result.Message;
                return RedirectToAction(nameof(Index));
            }

            return View(result.Data);
        }

        // POST: GiangDay/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var result = await _taiGiangDayService.DeleteTaiGiangDayAsync(id);
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

        #endregion

        #region ChiTietGiangDay Actions

        // GET: GiangDay/PhanCong/5
        public async Task<IActionResult> PhanCong(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            var taiGiangDayResult = await _taiGiangDayService.GetTaiGiangDayByIdAsync(id);
            if (!taiGiangDayResult.Success || taiGiangDayResult.Data == null)
            {
                TempData["ErrorMessage"] = taiGiangDayResult.Message;
                return RedirectToAction(nameof(Index));
            }

            // Lấy danh sách giáo viên
            var giaoVienResult = await _giaoVienService.GetAllGiaoVienAsync();
            if (giaoVienResult?.Any() == true)
            {
                ViewBag.GiaoViens = new SelectList(giaoVienResult, "MaGV", "HoTen");
            }
            else
            {
                ViewBag.GiaoViens = new SelectList(new List<object>(), "MaGV", "HoTen");
            }

            ViewBag.TaiGiangDay = taiGiangDayResult.Data;

            // Lấy danh sách giáo viên đã được phân công
            var chiTietResult = await _taiGiangDayService.GetChiTietGiangDayByTaiGiangDayAsync(id);
            ViewBag.ChiTietGiangDay = chiTietResult.Success ? chiTietResult.Data : new List<Models.ChiTietGiangDay>();

            return View(new ChiTietGiangDayCreateDto { MaTaiGiangDay = id });
        }

        // POST: GiangDay/PhanCong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PhanCong(ChiTietGiangDayCreateDto dto)
        {
            if (ModelState.IsValid)
            {
                var result = await _taiGiangDayService.PhanCongGiangDayAsync(dto);
                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                    return RedirectToAction(nameof(Details), new { id = dto.MaTaiGiangDay });
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }
            }

            // Reload data for view
            var taiGiangDayResult = await _taiGiangDayService.GetTaiGiangDayByIdAsync(dto.MaTaiGiangDay);
            ViewBag.TaiGiangDay = taiGiangDayResult.Data;

            var giaoVienResult = await _giaoVienService.GetAllGiaoVienAsync();
            if (giaoVienResult?.Any() == true)
            {
                ViewBag.GiaoViens = new SelectList(giaoVienResult, "MaGV", "HoTen", dto.MaGV);
            }

            var chiTietResult = await _taiGiangDayService.GetChiTietGiangDayByTaiGiangDayAsync(dto.MaTaiGiangDay);
            ViewBag.ChiTietGiangDay = chiTietResult.Success ? chiTietResult.Data : new List<Models.ChiTietGiangDay>();

            return View(dto);
        }

        // POST: GiangDay/XoaPhanCong/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> XoaPhanCong(string maChiTietGiangDay, string maTaiGiangDay)
        {
            var result = await _taiGiangDayService.XoaPhanCongGiangDayAsync(maChiTietGiangDay);
            if (result.Success)
            {
                TempData["SuccessMessage"] = result.Message;
            }
            else
            {
                TempData["ErrorMessage"] = result.Message;
            }

            return RedirectToAction(nameof(Details), new { id = maTaiGiangDay });
        }

        // GET: GiangDay/DanhSachGiangDay
        public async Task<IActionResult> DanhSachGiangDay(string maGV = null, string namHoc = null, int pageNumber = 1, int pageSize = 20)
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var result = await _taiGiangDayService.GetDanhSachGiangDayAsync(maGV, namHoc, pageNumber, pageSize);
            if (result.Success)
            {
                // Lấy danh sách giáo viên và năm học cho filter
                var giaoVienResult = await _giaoVienService.GetAllGiaoVienAsync();
                ViewBag.GiaoViens = new SelectList(giaoVienResult ?? new List<Models.GiaoVien>(), "MaGV", "HoTen", maGV);

                var namHocResult = await _taiGiangDayService.GetDistinctNamHocAsync();
                ViewBag.NamHocs = new SelectList(namHocResult.Data ?? new List<string>(), namHoc);

                ViewBag.CurrentMaGV = maGV;
                ViewBag.CurrentNamHoc = namHoc;

                return View(result.Data);
            }
            else
            {
                TempData["ErrorMessage"] = result.Message;
                return View();
            }
        }

        #endregion

        #region API Actions

        [HttpGet]
        public async Task<IActionResult> GetTaiGiangDayJson(TaiGiangDaySearchDto searchDto)
        {
            var result = await _taiGiangDayService.SearchTaiGiangDayAsync(searchDto);
            return Json(result);
        }

        [HttpGet]
        public async Task<IActionResult> GetChiTietGiangDayJson(string maTaiGiangDay)
        {
            var result = await _taiGiangDayService.GetChiTietGiangDayByTaiGiangDayAsync(maTaiGiangDay);
            return Json(result);
        }

        #endregion

        #region Private Methods

        private async Task PopulateViewBagDataAsync()
        {
            try
            {
                // Lấy danh sách đối tượng giảng dạy
                var doiTuongResult = await _taiGiangDayService.GetAllDoiTuongGiangDayAsync();
                ViewBag.DoiTuongs = new SelectList(
                    doiTuongResult.Success ? doiTuongResult.Data : new List<Models.DoiTuongGiangDay>(),
                    "MaDoiTuong", "TenDoiTuong");

                // Lấy danh sách thời gian giảng dạy
                var thoiGianResult = await _taiGiangDayService.GetAllThoiGianGiangDayAsync();
                ViewBag.ThoiGians = new SelectList(
                    thoiGianResult.Success ? thoiGianResult.Data : new List<Models.ThoiGianGiangDay>(),
                    "MaThoiGian", "TenThoiGian");

                // Lấy danh sách ngôn ngữ giảng dạy
                var ngonNguResult = await _taiGiangDayService.GetAllNgonNguGiangDayAsync();
                ViewBag.NgonNgus = new SelectList(
                    ngonNguResult.Success ? ngonNguResult.Data : new List<Models.NgonNguGiangDay>(),
                    "MaNgonNgu", "TenNgonNgu");

                // Lấy danh sách năm học
                var namHocResult = await _taiGiangDayService.GetDistinctNamHocAsync();
                ViewBag.NamHocs = new SelectList(
                    namHocResult.Success ? namHocResult.Data : new List<string>());

                // Lấy danh sách hệ đào tạo
                var heResult = await _taiGiangDayService.GetDistinctHeAsync();
                ViewBag.Hes = new SelectList(
                    heResult.Success ? heResult.Data : new List<string>());
            }
            catch (Exception ex)
            {
                // Log error
                ViewBag.DoiTuongs = new SelectList(new List<object>(), "MaDoiTuong", "TenDoiTuong");
                ViewBag.ThoiGians = new SelectList(new List<object>(), "MaThoiGian", "TenThoiGian");
                ViewBag.NgonNgus = new SelectList(new List<object>(), "MaNgonNgu", "TenNgonNgu");
                ViewBag.NamHocs = new SelectList(new List<string>());
                ViewBag.Hes = new SelectList(new List<string>());
            }
        }

        #endregion
    }
}