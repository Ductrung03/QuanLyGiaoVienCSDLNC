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
            // Debug ModelState errors
            if (!ModelState.IsValid)
            {
                var errors = ModelState
                    .Where(x => x.Value.Errors.Count > 0)
                    .Select(x => new { Field = x.Key, Errors = x.Value.Errors.Select(e => e.ErrorMessage) })
                    .ToList();

                foreach (var error in errors)
                {
                    System.Diagnostics.Debug.WriteLine($"Validation Error - Field: {error.Field}, Errors: {string.Join(", ", error.Errors)}");
                }
            }

            // Manual validation check for required fields
            var validationErrors = new List<string>();

            if (string.IsNullOrWhiteSpace(taiGiangDay.TenHocPhan))
                validationErrors.Add("Tên học phần không được để trống");

            if (taiGiangDay.SiSo <= 0 || taiGiangDay.SiSo > 500)
                validationErrors.Add("Sĩ số phải từ 1 đến 500");

            if (string.IsNullOrWhiteSpace(taiGiangDay.He))
                validationErrors.Add("Hệ đào tạo không được để trống");

            if (string.IsNullOrWhiteSpace(taiGiangDay.Lop))
                validationErrors.Add("Lớp không được để trống");

            if (taiGiangDay.SoTinChi <= 0 || taiGiangDay.SoTinChi > 10)
                validationErrors.Add("Số tín chỉ phải từ 1 đến 10");

            if (string.IsNullOrWhiteSpace(taiGiangDay.NamHoc))
                validationErrors.Add("Năm học không được để trống");

            if (string.IsNullOrWhiteSpace(taiGiangDay.MaDoiTuong))
                validationErrors.Add("Đối tượng giảng dạy không được để trống");

            if (string.IsNullOrWhiteSpace(taiGiangDay.MaThoiGian))
                validationErrors.Add("Thời gian giảng dạy không được để trống");

            if (string.IsNullOrWhiteSpace(taiGiangDay.MaNgonNgu))
                validationErrors.Add("Ngôn ngữ giảng dạy không được để trống");

            if (validationErrors.Any())
            {
                TempData["ErrorMessage"] = string.Join("; ", validationErrors);
                await LoadLookupDataAsync();
                return View(taiGiangDay);
            }

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
            // Manual validation for edit
            var validationErrors = new List<string>();

            if (string.IsNullOrWhiteSpace(taiGiangDay.TenHocPhan))
                validationErrors.Add("Tên học phần không được để trống");

            if (taiGiangDay.SiSo <= 0 || taiGiangDay.SiSo > 500)
                validationErrors.Add("Sĩ số phải từ 1 đến 500");

            if (validationErrors.Any())
            {
                TempData["ErrorMessage"] = string.Join("; ", validationErrors);
                await LoadLookupDataAsync();
                return View(taiGiangDay);
            }

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
            // Manual validation
            var validationErrors = new List<string>();

            if (string.IsNullOrWhiteSpace(model.MaGV))
                validationErrors.Add("Vui lòng chọn giáo viên");

            if (model.SoTiet <= 0 || model.SoTiet > 200)
                validationErrors.Add("Số tiết phải từ 1 đến 200");

            if (validationErrors.Any())
            {
                TempData["ErrorMessage"] = string.Join("; ", validationErrors);
            }
            else
            {
                try
                {
                    var result = await _giangDayService.PhanCongGiangDayAsync(
                        model.MaGV,
                        model.MaTaiGiangDay,
                        model.SoTiet,
                        model.GhiChu,
                        model.NoiDungGiangDay, 
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

        // Thay thế method ThongKe trong GiangDayController
        // GET: GiangDay/ThongKe
        public async Task<IActionResult> ThongKe(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            try
            {
                var thongKe = await _giangDayService.GetThongKeGiangDayAsync(maGV, maBM, maKhoa, namHoc);

                // Debug: Log thông tin về thongKe
                System.Diagnostics.Debug.WriteLine($"ThongKe result: {thongKe}");
                System.Diagnostics.Debug.WriteLine($"ThongKe type: {thongKe?.GetType()}");

                // Đảm bảo thongKe không null và có đủ properties
                if (thongKe == null)
                {
                    System.Diagnostics.Debug.WriteLine("ThongKe is null, creating empty result");
                    thongKe = new
                    {
                        TongSoTiet = 0,
                        TongSoTietQuyDoi = 0.0,
                        SoTaiGiangDay = 0,
                        SoGiaoVien = 0,
                        ChiTiet = new List<object>()
                    };
                }

                // Load data cho filter
                try
                {
                    var namHocs = await _giangDayService.GetDistinctNamHocAsync();
                    ViewBag.NamHocs = new SelectList(namHocs, namHoc);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error loading namHocs: {ex.Message}");
                    ViewBag.NamHocs = new SelectList(new List<string>());
                }

                ViewBag.MaGV = maGV ?? "";
                ViewBag.MaBM = maBM ?? "";
                ViewBag.MaKhoa = maKhoa ?? "";
                ViewBag.NamHoc = namHoc ?? "";

                return View(thongKe);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"ThongKe Controller Error: {ex.Message}");
                TempData["ErrorMessage"] = $"Lỗi khi lấy thống kê: {ex.Message}";

                // Trả về object rỗng với cấu trúc đúng
                var emptyModel = new
                {
                    TongSoTiet = 0,
                    TongSoTietQuyDoi = 0.0,
                    SoTaiGiangDay = 0,
                    SoGiaoVien = 0,
                    ChiTiet = new List<object>()
                };

                // Load empty data cho filter để tránh lỗi view
                ViewBag.NamHocs = new SelectList(new List<string>());
                ViewBag.MaGV = maGV ?? "";
                ViewBag.MaBM = maBM ?? "";
                ViewBag.MaKhoa = maKhoa ?? "";
                ViewBag.NamHoc = namHoc ?? "";

                return View(emptyModel);
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