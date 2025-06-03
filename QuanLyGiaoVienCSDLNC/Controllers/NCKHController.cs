using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.Models;
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

        #region Tài NCKH
        // GET: NCKH
        public async Task<IActionResult> Index(string searchTerm = null, string namHoc = null, string maLoaiNCKH = null)
        {
            try
            {
                var taiNCKHList = await _nckhService.SearchTaiNCKHAsync(searchTerm, namHoc, maLoaiNCKH);

                // Load dropdown data
                await LoadViewData();

                ViewBag.SearchTerm = searchTerm;
                ViewBag.SelectedNamHoc = namHoc;
                ViewBag.SelectedMaLoaiNCKH = maLoaiNCKH;

                return View(taiNCKHList);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi tải danh sách NCKH: {ex.Message}";
                return View(new List<TaiNCKH>());
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

            try
            {
                var taiNCKH = await _nckhService.GetTaiNCKHByIdAsync(id);
                if (taiNCKH == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy tài NCKH";
                    return RedirectToAction(nameof(Index));
                }

                // Lấy danh sách tác giả
                var chiTietList = await _nckhService.GetChiTietNCKHByTaiNCKHAsync(id);
                ViewBag.ChiTietNCKHList = chiTietList;

                return View(taiNCKH);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi lấy thông tin tài NCKH: {ex.Message}";
                return RedirectToAction(nameof(Index));
            }
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
        public async Task<IActionResult> Create(TaiNCKH taiNCKH)
        {
            try
            {
                var (success, message, maTaiNCKH) = await _nckhService.AddTaiNCKHAsync(taiNCKH);

                if (success)
                {
                    TempData["SuccessMessage"] = message;
                    return RedirectToAction(nameof(Details), new { id = maTaiNCKH });
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi thêm tài NCKH: {ex.Message}";
            }

            await LoadViewData();
            return View(taiNCKH);
        }

        // GET: NCKH/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không hợp lệ";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                var taiNCKH = await _nckhService.GetTaiNCKHByIdAsync(id);
                if (taiNCKH == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy tài NCKH";
                    return RedirectToAction(nameof(Index));
                }

                await LoadViewData();
                return View(taiNCKH);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi lấy thông tin tài NCKH: {ex.Message}";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: NCKH/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, TaiNCKH taiNCKH)
        {
            if (id != taiNCKH.MaTaiNCKH)
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không khớp";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                var (success, message) = await _nckhService.UpdateTaiNCKHAsync(taiNCKH);

                if (success)
                {
                    TempData["SuccessMessage"] = message;
                    return RedirectToAction(nameof(Details), new { id = taiNCKH.MaTaiNCKH });
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi cập nhật tài NCKH: {ex.Message}";
            }

            await LoadViewData();
            return View(taiNCKH);
        }

        // GET: NCKH/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không hợp lệ";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                var taiNCKH = await _nckhService.GetTaiNCKHByIdAsync(id);
                if (taiNCKH == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy tài NCKH";
                    return RedirectToAction(nameof(Index));
                }

                return View(taiNCKH);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi lấy thông tin tài NCKH: {ex.Message}";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: NCKH/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            try
            {
                var (success, message) = await _nckhService.DeleteTaiNCKHAsync(id);

                if (success)
                {
                    TempData["SuccessMessage"] = message;
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi xóa tài NCKH: {ex.Message}";
            }

            return RedirectToAction(nameof(Index));
        }
        #endregion

        #region Chi tiết NCKH
        // GET: NCKH/PhanCong/5
        public async Task<IActionResult> PhanCong(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                TempData["ErrorMessage"] = "Mã tài NCKH không hợp lệ";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                var taiNCKH = await _nckhService.GetTaiNCKHByIdAsync(id);
                if (taiNCKH == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy tài NCKH";
                    return RedirectToAction(nameof(Index));
                }

                var chiTietNCKH = new ChiTietNCKH
                {
                    MaTaiNCKH = id
                };

                ViewBag.TaiNCKH = taiNCKH;
                await LoadGiaoVienDropdown();
                ViewBag.VaiTroList = new SelectList(await _nckhService.GetAvailableVaiTroAsync());

                return View(chiTietNCKH);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi tải trang phân công: {ex.Message}";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: NCKH/PhanCong
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PhanCong(ChiTietNCKH chiTietNCKH)
        {
            try
            {
                var (success, message, maChiTietNCKH) = await _nckhService.AddChiTietNCKHAsync(chiTietNCKH);

                if (success)
                {
                    TempData["SuccessMessage"] = message;
                    return RedirectToAction(nameof(Details), new { id = chiTietNCKH.MaTaiNCKH });
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi phân công NCKH: {ex.Message}";
            }

            // Reload data for view
            var taiNCKH = await _nckhService.GetTaiNCKHByIdAsync(chiTietNCKH.MaTaiNCKH);
            ViewBag.TaiNCKH = taiNCKH;
            await LoadGiaoVienDropdown();
            ViewBag.VaiTroList = new SelectList(await _nckhService.GetAvailableVaiTroAsync());

            return View(chiTietNCKH);
        }

        // GET: NCKH/EditChiTiet/5
        public async Task<IActionResult> EditChiTiet(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                TempData["ErrorMessage"] = "Mã chi tiết NCKH không hợp lệ";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                var chiTietNCKH = await _nckhService.GetChiTietNCKHByIdAsync(id);
                if (chiTietNCKH == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy chi tiết NCKH";
                    return RedirectToAction(nameof(Index));
                }

                await LoadGiaoVienDropdown();
                ViewBag.VaiTroList = new SelectList(await _nckhService.GetAvailableVaiTroAsync(), chiTietNCKH.VaiTro);

                return View(chiTietNCKH);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi lấy thông tin chi tiết NCKH: {ex.Message}";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: NCKH/EditChiTiet/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditChiTiet(string id, ChiTietNCKH chiTietNCKH)
        {
            if (id != chiTietNCKH.MaChiTietNCKH)
            {
                TempData["ErrorMessage"] = "Mã chi tiết NCKH không khớp";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                var (success, message) = await _nckhService.UpdateChiTietNCKHAsync(chiTietNCKH);

                if (success)
                {
                    TempData["SuccessMessage"] = message;
                    return RedirectToAction(nameof(Details), new { id = chiTietNCKH.MaTaiNCKH });
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi cập nhật chi tiết NCKH: {ex.Message}";
            }

            await LoadGiaoVienDropdown();
            ViewBag.VaiTroList = new SelectList(await _nckhService.GetAvailableVaiTroAsync(), chiTietNCKH.VaiTro);

            return View(chiTietNCKH);
        }

        // POST: NCKH/DeleteChiTiet
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteChiTiet(string maChiTietNCKH, string maTaiNCKH)
        {
            try
            {
                var (success, message) = await _nckhService.DeleteChiTietNCKHAsync(maChiTietNCKH);

                if (success)
                {
                    TempData["SuccessMessage"] = message;
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi xóa chi tiết NCKH: {ex.Message}";
            }

            return RedirectToAction(nameof(Details), new { id = maTaiNCKH });
        }
        #endregion

        #region Báo cáo và thống kê
        // GET: NCKH/ThongKe
        public async Task<IActionResult> ThongKe(string namHoc = null, string maKhoa = null, string maBM = null)
        {
            try
            {
                var thongKeTongQuan = await _nckhService.GetThongKeNCKHTongQuanAsync(namHoc, maKhoa, maBM);
                var thongKeTheoKhoa = await _nckhService.GetThongKeNCKHTheoKhoaAsync(namHoc);
                var thongKeTheoBoMon = await _nckhService.GetThongKeNCKHTheoBoMonAsync(namHoc, maKhoa);

                ViewBag.ThongKeTongQuan = thongKeTongQuan;
                ViewBag.ThongKeTheoKhoa = thongKeTheoKhoa;
                ViewBag.ThongKeTheoBoMon = thongKeTheoBoMon;

                await LoadKhoaBoMonDropdown();
                ViewBag.AvailableNamHoc = new SelectList(await _nckhService.GetAvailableNamHocAsync(), namHoc);
                ViewBag.SelectedNamHoc = namHoc;
                ViewBag.SelectedMaKhoa = maKhoa;
                ViewBag.SelectedMaBM = maBM;

                return View();
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi lấy thống kê NCKH: {ex.Message}";
                return View();
            }
        }

        // GET: NCKH/TopGiaoVien
        public async Task<IActionResult> TopGiaoVien(string namHoc = null, int topN = 20, string maKhoa = null)
        {
            try
            {
                var topGiaoVien = await _nckhService.GetTopGiaoVienNCKHXuatSacAsync(namHoc, topN, maKhoa);

                await LoadKhoaDropdown();
                ViewBag.AvailableNamHoc = new SelectList(await _nckhService.GetAvailableNamHocAsync(), namHoc);
                ViewBag.SelectedNamHoc = namHoc;
                ViewBag.SelectedTopN = topN;
                ViewBag.SelectedMaKhoa = maKhoa;

                return View(topGiaoVien);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi lấy top giáo viên NCKH: {ex.Message}";
                return View(new List<dynamic>());
            }
        }
        #endregion

        #region Quản lý loại NCKH
        // GET: NCKH/LoaiNCKH
        public async Task<IActionResult> LoaiNCKH()
        {
            try
            {
                var loaiNCKHList = await _nckhService.GetAllLoaiNCKHAsync();
                return View(loaiNCKHList);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi tải danh sách loại NCKH: {ex.Message}";
                return View(new List<LoaiNCKH>());
            }
        }

        // GET: NCKH/CreateLoaiNCKH
        public async Task<IActionResult> CreateLoaiNCKH()
        {
            await LoadQuyDoiDropdown();
            return View();
        }

        // POST: NCKH/CreateLoaiNCKH
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateLoaiNCKH(LoaiNCKH loaiNCKH)
        {
            try
            {
                var (success, message) = await _nckhService.AddLoaiNCKHAsync(loaiNCKH);

                if (success)
                {
                    TempData["SuccessMessage"] = message;
                    return RedirectToAction(nameof(LoaiNCKH));
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi thêm loại NCKH: {ex.Message}";
            }

            await LoadQuyDoiDropdown();
            return View(loaiNCKH);
        }
        #endregion

        #region Helper Methods
        private async Task LoadViewData()
        {
            await LoadLoaiNCKHDropdown();
            await LoadNamHocDropdown();
            await LoadGiaoVienDropdown();
        }

        private async Task LoadLoaiNCKHDropdown()
        {
            var loaiNCKHList = await _nckhService.GetAllLoaiNCKHAsync();
            ViewBag.LoaiNCKHList = new SelectList(loaiNCKHList, "MaLoaiNCKH", "TenLoaiNCKH");
        }

        private async Task LoadNamHocDropdown()
        {
            var namHocList = await _nckhService.GetAvailableNamHocAsync();
            namHocList.Insert(0, ""); // Add empty option
            ViewBag.NamHocList = new SelectList(namHocList);
        }

        private async Task LoadGiaoVienDropdown()
        {
            var giaoVienList = await _giaoVienService.GetAllGiaoVienAsync();
            ViewBag.GiaoVienList = new SelectList(giaoVienList, "MaGV", "HoTenDayDu");
        }

        private async Task LoadKhoaDropdown()
        {
            var khoaList = await _khoaService.GetAllKhoaAsync();
            ViewBag.KhoaList = new SelectList(khoaList, "MaKhoa", "TenKhoa");
        }

        private async Task LoadBoMonDropdown()
        {
            var boMonList = await _boMonService.GetAllBoMonAsync();
            ViewBag.BoMonList = new SelectList(boMonList, "MaBM", "TenBM");
        }

        private async Task LoadKhoaBoMonDropdown()
        {
            await LoadKhoaDropdown();
            await LoadBoMonDropdown();
        }

        private async Task LoadQuyDoiDropdown()
        {
            var quyDoiList = await _nckhService.GetAllQuyDoiGioChuanAsync();
            ViewBag.QuyDoiList = new SelectList(quyDoiList, "MaQuyDoi", "DonViTinh");
        }
        #endregion
    }
}