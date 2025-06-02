using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class GiangDayController : Controller
    {
        private readonly IGiangDayService _giangDayService;
        private readonly IGiaoVienService _giaoVienService;

        public GiangDayController(IGiangDayService giangDayService, IGiaoVienService giaoVienService)
        {
            _giangDayService = giangDayService;
            _giaoVienService = giaoVienService;
        }

        #region TaiGiangDay Actions

        // GET: GiangDay
        public async Task<IActionResult> Index(string searchTerm = null, string namHoc = null, string he = null, string maDoiTuong = null)
        {
            // Kiểm tra đăng nhập
            if (HttpContext.Session.GetString("UserId") == null)
            {
                return RedirectToAction("Index", "Login");
            }

            try
            {
                var taiGiangDays = await _giangDayService.SearchTaiGiangDayAsync(searchTerm, namHoc, he, maDoiTuong);

                // Load lookup data cho filter
                await LoadLookupDataAsync();

                // Truyền search parameters về view
                ViewBag.SearchTerm = searchTerm;
                ViewBag.NamHoc = namHoc;
                ViewBag.He = he;
                ViewBag.MaDoiTuong = maDoiTuong;

                return View(taiGiangDays);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return View(new List<TaiGiangDay>());
            }
        }

        // GET: GiangDay/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            try
            {
                var taiGiangDay = await _giangDayService.GetTaiGiangDayByIdAsync(id);
                if (taiGiangDay == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy tài giảng dạy";
                    return RedirectToAction(nameof(Index));
                }

                // Lấy danh sách chi tiết giảng dạy
                var chiTietGiangDays = await _giangDayService.GetChiTietGiangDayByTaiGiangDayAsync(id);
                ViewBag.ChiTietGiangDays = chiTietGiangDays;

                return View(taiGiangDay);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction(nameof(Index));
            }
        }

        // GET: GiangDay/Create
        public async Task<IActionResult> Create()
        {
            await LoadLookupDataAsync();
            return View(new TaiGiangDay());
        }

        // POST: GiangDay/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(TaiGiangDay taiGiangDay)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = await _giangDayService.AddTaiGiangDayAsync(taiGiangDay);
                    if (result.success)
                    {
                        TempData["SuccessMessage"] = result.message;
                        return RedirectToAction(nameof(Details), new { id = result.maTaiGiangDay });
                    }
                    else
                    {
                        TempData["ErrorMessage"] = result.message;
                    }
                }
                catch (Exception ex)
                {
                    TempData["ErrorMessage"] = ex.Message;
                }
            }

            await LoadLookupDataAsync();
            return View(taiGiangDay);
        }

        // GET: GiangDay/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            try
            {
                var taiGiangDay = await _giangDayService.GetTaiGiangDayByIdAsync(id);
                if (taiGiangDay == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy tài giảng dạy";
                    return RedirectToAction(nameof(Index));
                }

                await LoadLookupDataAsync();
                return View(taiGiangDay);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: GiangDay/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(TaiGiangDay taiGiangDay)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = await _giangDayService.UpdateTaiGiangDayAsync(taiGiangDay);
                    if (result.success)
                    {
                        TempData["SuccessMessage"] = result.message;
                        return RedirectToAction(nameof(Details), new { id = taiGiangDay.MaTaiGiangDay });
                    }
                    else
                    {
                        TempData["ErrorMessage"] = result.message;
                    }
                }
                catch (Exception ex)
                {
                    TempData["ErrorMessage"] = ex.Message;
                }
            }

            await LoadLookupDataAsync();
            return View(taiGiangDay);
        }

        // GET: GiangDay/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            try
            {
                var taiGiangDay = await _giangDayService.GetTaiGiangDayByIdAsync(id);
                if (taiGiangDay == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy tài giảng dạy";
                    return RedirectToAction(nameof(Index));
                }

                return View(taiGiangDay);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: GiangDay/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            try
            {
                var result = await _giangDayService.DeleteTaiGiangDayAsync(id);
                if (result.success)
                {
                    TempData["SuccessMessage"] = result.message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
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

            try
            {
                var taiGiangDay = await _giangDayService.GetTaiGiangDayByIdAsync(id);
                if (taiGiangDay == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy tài giảng dạy";
                    return RedirectToAction(nameof(Index));
                }

                // Lấy danh sách giáo viên
                var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
                ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen");

                // Lấy danh sách chi tiết giảng dạy hiện tại
                var chiTietGiangDays = await _giangDayService.GetChiTietGiangDayByTaiGiangDayAsync(id);
                ViewBag.ChiTietGiangDays = chiTietGiangDays;

                ViewBag.TaiGiangDay = taiGiangDay;

                // Model cho form phân công
                var model = new ChiTietGiangDay
                {
                    MaTaiGiangDay = id
                };

                return View(model);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: GiangDay/PhanCong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PhanCong(ChiTietGiangDay model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = await _giangDayService.PhanCongGiangDayAsync(
                        model.MaGV,
                        model.MaTaiGiangDay,
                        model.SoTiet,
                        model.GhiChu,
                        model.MaNoiDungGiangDay,
                        true);

                    if (result.success)
                    {
                        TempData["SuccessMessage"] = result.message;
                        return RedirectToAction(nameof(Details), new { id = model.MaTaiGiangDay });
                    }
                    else
                    {
                        TempData["ErrorMessage"] = result.message;
                    }
                }
                catch (Exception ex)
                {
                    TempData["ErrorMessage"] = ex.Message;
                }
            }

            // Reload data for view nếu có lỗi
            try
            {
                var taiGiangDay = await _giangDayService.GetTaiGiangDayByIdAsync(model.MaTaiGiangDay);
                ViewBag.TaiGiangDay = taiGiangDay;

                var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
                ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", model.MaGV);

                var chiTietGiangDays = await _giangDayService.GetChiTietGiangDayByTaiGiangDayAsync(model.MaTaiGiangDay);
                ViewBag.ChiTietGiangDays = chiTietGiangDays;
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction(nameof(Index));
            }

            return View(model);
        }

        // POST: GiangDay/XoaPhanCong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> XoaPhanCong(string maChiTietGiangDay, string maTaiGiangDay)
        {
            try
            {
                var result = await _giangDayService.XoaPhanCongGiangDayAsync(maChiTietGiangDay);
                if (result.success)
                {
                    TempData["SuccessMessage"] = result.message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
            }

            return RedirectToAction(nameof(Details), new { id = maTaiGiangDay });
        }

        // GET: GiangDay/DanhSachGiangDay
        public async Task<IActionResult> DanhSachGiangDay(string maGV = null, string namHoc = null)
        {
            try
            {
                List<ChiTietGiangDay> chiTietGiangDays;

                if (!string.IsNullOrEmpty(maGV))
                {
                    chiTietGiangDays = await _giangDayService.GetChiTietGiangDayByGiaoVienAsync(maGV, namHoc);
                }
                else
                {
                    // Lấy tất cả hoặc theo năm học
                    var allTaiGiangDays = await _giangDayService.SearchTaiGiangDayAsync(null, namHoc);
                    chiTietGiangDays = new List<ChiTietGiangDay>();

                    foreach (var taiGiangDay in allTaiGiangDays)
                    {
                        var chiTiets = await _giangDayService.GetChiTietGiangDayByTaiGiangDayAsync(taiGiangDay.MaTaiGiangDay);
                        chiTietGiangDays.AddRange(chiTiets);
                    }
                }

                // Load lookup data cho filter
                var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
                ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", maGV);

                var namHocs = await _giangDayService.GetDistinctNamHocAsync();
                ViewBag.NamHocs = new SelectList(namHocs, namHoc);

                ViewBag.MaGV = maGV;
                ViewBag.NamHoc = namHoc;

                return View(chiTietGiangDays);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return View(new List<ChiTietGiangDay>());
            }
        }

        // GET: GiangDay/ThongKe
        public async Task<IActionResult> ThongKe(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            try
            {
                var thongKe = await _giangDayService.GetThongKeGiangDayAsync(maGV, maBM, maKhoa, namHoc);

                // Load data cho filter nếu cần
                var namHocs = await _giangDayService.GetDistinctNamHocAsync();
                ViewBag.NamHocs = new SelectList(namHocs, namHoc);

                ViewBag.MaGV = maGV;
                ViewBag.MaBM = maBM;
                ViewBag.MaKhoa = maKhoa;
                ViewBag.NamHoc = namHoc;

                return View(thongKe);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return View();
            }
        }

        #endregion

        #region Private Methods

        private async Task LoadLookupDataAsync()
        {
            try
            {
                var doiTuongs = await _giangDayService.GetAllDoiTuongGiangDayAsync();
                ViewBag.DoiTuongs = new SelectList(doiTuongs, "MaDoiTuong", "TenDoiTuong");

                var thoiGians = await _giangDayService.GetAllThoiGianGiangDayAsync();
                ViewBag.ThoiGians = new SelectList(thoiGians, "MaThoiGian", "TenThoiGian");

                var ngonNgus = await _giangDayService.GetAllNgonNguGiangDayAsync();
                ViewBag.NgonNgus = new SelectList(ngonNgus, "MaNgonNgu", "TenNgonNgu");

                var namHocs = await _giangDayService.GetDistinctNamHocAsync();
                ViewBag.NamHocs = new SelectList(namHocs);

                var hes = await _giangDayService.GetDistinctHeAsync();
                ViewBag.Hes = new SelectList(hes);
            }
            catch (Exception ex)
            {
                // Log error và set empty lists
                ViewBag.DoiTuongs = new SelectList(new List<DoiTuongGiangDay>(), "MaDoiTuong", "TenDoiTuong");
                ViewBag.ThoiGians = new SelectList(new List<ThoiGianGiangDay>(), "MaThoiGian", "TenThoiGian");
                ViewBag.NgonNgus = new SelectList(new List<NgonNguGiangDay>(), "MaNgonNgu", "TenNgonNgu");
                ViewBag.NamHocs = new SelectList(new List<string>());
                ViewBag.Hes = new SelectList(new List<string>());

                TempData["ErrorMessage"] = $"Lỗi khi tải dữ liệu: {ex.Message}";
            }
        }

        #endregion
    }
}