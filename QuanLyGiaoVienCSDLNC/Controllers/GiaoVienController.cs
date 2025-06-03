// =============================================
// CONTROLLER LAYER CHO HỆ THỐNG QUẢN LÝ GIÁO VIÊN
// =============================================

// Controllers/GiaoVienController.cs - Hoàn chỉnh với tất cả chức năng
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyGiaoVienCSDLNC.DTOs.GiaoVien;
using QuanLyGiaoVienCSDLNC.DTOs.HocVi;
using QuanLyGiaoVienCSDLNC.DTOs.LyLichKhoaHoc;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;
using System.Text.Json;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class GiaoVienController : Controller
    {
        private readonly IGiaoVienService _giaoVienService;
        private readonly IBoMonService _boMonService;
        private readonly IKhoaService _khoaService;
        private readonly ILogger<GiaoVienController> _logger;

        public GiaoVienController(
            IGiaoVienService giaoVienService,
            IBoMonService boMonService,
            IKhoaService khoaService,
            ILogger<GiaoVienController> logger)
        {
            _giaoVienService = giaoVienService;
            _boMonService = boMonService;
            _khoaService = khoaService;
            _logger = logger;
        }

        #region Index và Search

        // GET: GiaoVien
        public async Task<IActionResult> Index(GiaoVienSearchDto searchDto)
        {
            try
            {
                // Kiểm tra đăng nhập
                if (HttpContext.Session.GetString("UserId") == null)
                {
                    return RedirectToAction("Index", "Login");
                }

                // Thiết lập default values
                if (searchDto.PageNumber <= 0) searchDto.PageNumber = 1;
                if (searchDto.PageSize <= 0) searchDto.PageSize = 20;

                // Lấy danh sách khoa để hiển thị lọc
                var khoas = await _khoaService.GetAllKhoaAsync();
                ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa", searchDto.MaKhoa);

                // Lấy danh sách bộ môn dựa trên khoa được chọn
                List<BoMon> boMons;
                if (!string.IsNullOrEmpty(searchDto.MaKhoa))
                {
                    boMons = await _boMonService.GetBoMonByKhoaIdAsync(searchDto.MaKhoa);
                }
                else
                {
                    boMons = await _boMonService.GetAllBoMonAsync();
                }
                ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM", searchDto.MaBM);

                // Danh sách học vị để lọc
                var hocViList = new List<string> { "Cử nhân", "Thạc sĩ", "Tiến sĩ", "Giáo sư", "Phó Giáo sư" };
                ViewBag.HocViList = new SelectList(hocViList, searchDto.HocVi);

                // Danh sách học hàm để lọc
                var hocHamList = new List<string> { "Giáo sư", "Phó Giáo sư", "Tiến sĩ khoa học" };
                ViewBag.HocHamList = new SelectList(hocHamList, searchDto.HocHam);

                // Tìm kiếm giáo viên
                var result = await _giaoVienService.SearchGiaoVienAsync(searchDto);

                if (!result.Success)
                {
                    TempData["ErrorMessage"] = result.Message;
                    ViewBag.SearchDto = searchDto;
                    return View(new QuanLyGiaoVienCSDLNC.DTOs.Common.PagedResultDto<GiaoVienListItemDto>());
                }

                // Lưu thông tin tìm kiếm
                ViewBag.SearchDto = searchDto;
                ViewBag.TotalPages = result.Data.TotalPages;
                ViewBag.CurrentPage = searchDto.PageNumber;

                return View(result.Data);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien Index");
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải danh sách giáo viên";
                return View(new QuanLyGiaoVienCSDLNC.DTOs.Common.PagedResultDto<GiaoVienListItemDto>());
            }
        }

        // AJAX: Lấy bộ môn theo khoa
        [HttpGet]
        public async Task<IActionResult> GetBoMonByKhoa(string maKhoa)
        {
            try
            {
                List<BoMon> boMons;
                if (string.IsNullOrEmpty(maKhoa))
                {
                    boMons = await _boMonService.GetAllBoMonAsync();
                }
                else
                {
                    boMons = await _boMonService.GetBoMonByKhoaIdAsync(maKhoa);
                }

                var result = boMons.Select(bm => new { maBM = bm.MaBM, tenBM = bm.TenBM }).ToList();
                return Json(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting bo mon by khoa: {MaKhoa}", maKhoa);
                return Json(new List<object>());
            }
        }

        #endregion

        #region Details

        // GET: GiaoVien/Details/5
        public async Task<IActionResult> Details(string id)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var result = await _giaoVienService.GetChiTietGiaoVienAsync(id);
                if (!result.Success || result.Data?.ThongTinCoBan == null)
                {
                    TempData["ErrorMessage"] = result.Message ?? "Không tìm thấy giáo viên";
                    return RedirectToAction(nameof(Index));
                }

                // Lấy thống kê
                var thongKeResult = await _giaoVienService.GetThongKeGiaoVienAsync(id);
                if (thongKeResult.Success)
                {
                    ViewBag.ThongKe = thongKeResult.Data;
                }

                return View(result.Data);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien Details: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải thông tin giáo viên";
                return RedirectToAction(nameof(Index));
            }
        }

        #endregion

        #region Create

        // GET: GiaoVien/Create
        public async Task<IActionResult> Create()
        {
            try
            {
                await LoadCreateViewBagAsync();
                return View(new GiaoVienCreateDto { NgaySinh = DateTime.Today.AddYears(-25) });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien Create GET");
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải trang thêm giáo viên";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: GiaoVien/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(GiaoVienCreateDto dto)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    await LoadCreateViewBagAsync(dto.MaBM);
                    return View(dto);
                }

                var result = await _giaoVienService.AddGiaoVienAsync(dto);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                    return RedirectToAction(nameof(Details), new { id = result.Data });
                }
                else
                {
                    if (result.Errors?.Any() == true)
                    {
                        foreach (var error in result.Errors)
                        {
                            ModelState.AddModelError("", error);
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("", result.Message);
                    }

                    await LoadCreateViewBagAsync(dto.MaBM);
                    return View(dto);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien Create POST: {@Dto}", dto);
                ModelState.AddModelError("", "Có lỗi hệ thống xảy ra. Vui lòng thử lại sau.");
                await LoadCreateViewBagAsync(dto.MaBM);
                return View(dto);
            }
        }

        private async Task LoadCreateViewBagAsync(string selectedMaBM = null)
        {
            var boMons = await _boMonService.GetAllBoMonAsync();
            ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM", selectedMaBM);

            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa");
        }

        #endregion

        #region Edit

        // GET: GiaoVien/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
                if (giaoVien == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy giáo viên";
                    return RedirectToAction(nameof(Index));
                }

                var dto = new GiaoVienUpdateDto
                {
                    MaGV = giaoVien.MaGV,
                    HoTen = giaoVien.HoTen,
                    NgaySinh = giaoVien.NgaySinh,
                    GioiTinh = giaoVien.GioiTinh,
                    QueQuan = giaoVien.QueQuan,
                    DiaChi = giaoVien.DiaChi,
                    SDT = giaoVien.SDT,
                    Email = giaoVien.Email,
                    MaBM = giaoVien.MaBM
                };

                await LoadEditViewBagAsync(dto.MaBM);
                return View(dto);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien Edit GET: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải thông tin giáo viên";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: GiaoVien/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, GiaoVienUpdateDto dto)
        {
            try
            {
                if (id != dto.MaGV)
                {
                    return NotFound();
                }

                if (!ModelState.IsValid)
                {
                    await LoadEditViewBagAsync(dto.MaBM);
                    return View(dto);
                }

                var result = await _giaoVienService.UpdateGiaoVienAsync(dto);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                    return RedirectToAction(nameof(Details), new { id = dto.MaGV });
                }
                else
                {
                    if (result.Errors?.Any() == true)
                    {
                        foreach (var error in result.Errors)
                        {
                            ModelState.AddModelError("", error);
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("", result.Message);
                    }

                    await LoadEditViewBagAsync(dto.MaBM);
                    return View(dto);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien Edit POST: {@Dto}", dto);
                ModelState.AddModelError("", "Có lỗi hệ thống xảy ra. Vui lòng thử lại sau.");
                await LoadEditViewBagAsync(dto.MaBM);
                return View(dto);
            }
        }

        private async Task LoadEditViewBagAsync(string selectedMaBM)
        {
            var boMons = await _boMonService.GetAllBoMonAsync();
            ViewBag.BoMons = new SelectList(boMons, "MaBM", "TenBM", selectedMaBM);

            var khoas = await _khoaService.GetAllKhoaAsync();
            ViewBag.Khoas = new SelectList(khoas, "MaKhoa", "TenKhoa");
        }

        #endregion

        #region Delete

        // GET: GiaoVien/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
                if (giaoVien == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy giáo viên";
                    return RedirectToAction(nameof(Index));
                }

                return View(giaoVien);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien Delete GET: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải thông tin giáo viên";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: GiaoVien/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id, bool forceDelete = false)
        {
            try
            {
                var result = await _giaoVienService.DeleteGiaoVienAsync(id, forceDelete);

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
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien Delete POST: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra khi xóa giáo viên";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: Force Delete với xác nhận
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ForceDelete(string id)
        {
            try
            {
                var result = await _giaoVienService.DeleteGiaoVienAsync(id, true);

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
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in GiaoVien ForceDelete: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra khi xóa giáo viên";
                return RedirectToAction(nameof(Index));
            }
        }

        #endregion

        #region Academic Management

        // GET: GiaoVien/ManageAcademic/5
        public async Task<IActionResult> ManageAcademic(string id)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var result = await _giaoVienService.GetChiTietGiaoVienAsync(id);
                if (!result.Success || result.Data?.ThongTinCoBan == null)
                {
                    TempData["ErrorMessage"] = result.Message ?? "Không tìm thấy giáo viên";
                    return RedirectToAction(nameof(Index));
                }

                ViewBag.MaGV = id;
                ViewBag.HoTen = result.Data.ThongTinCoBan.HoTen;

                return View(result.Data);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ManageAcademic: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải thông tin học thuật";
                return RedirectToAction(nameof(Details), new { id });
            }
        }

        // POST: Cập nhật học vị
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddHocVi(HocViCreateDto dto)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    TempData["ErrorMessage"] = "Dữ liệu không hợp lệ";
                    return RedirectToAction(nameof(ManageAcademic), new { id = dto.MaGV });
                }

                var result = await _giaoVienService.CapNhatHocViAsync(dto);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageAcademic), new { id = dto.MaGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding hoc vi: {@Dto}", dto);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageAcademic), new { id = dto.MaGV });
            }
        }

        // POST: Cập nhật học hàm
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddHocHam(string maGV, string maHocHam, DateTime ngayNhan)
        {
            try
            {
                var result = await _giaoVienService.CapNhatHocHamAsync(maGV, maHocHam, ngayNhan);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageAcademic), new { id = maGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding hoc ham: {MaGV}, {MaHocHam}", maGV, maHocHam);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageAcademic), new { id = maGV });
            }
        }

        // POST: Cập nhật lý lịch khoa học
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateLyLichKhoaHoc(LyLichKhoaHocDto dto)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    TempData["ErrorMessage"] = "Dữ liệu không hợp lệ";
                    return RedirectToAction(nameof(ManageAcademic), new { id = dto.MaGV });
                }

                var result = await _giaoVienService.CapNhatLyLichKhoaHocAsync(dto);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageAcademic), new { id = dto.MaGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating ly lich khoa hoc: {@Dto}", dto);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageAcademic), new { id = dto.MaGV });
            }
        }

        #endregion

        #region Position Management

        // GET: GiaoVien/ManagePosition/5
        public async Task<IActionResult> ManagePosition(string id)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
                if (giaoVien == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy giáo viên";
                    return RedirectToAction(nameof(Index));
                }

                // Load chức vụ available (cần implement ChucVuService)
                ViewBag.MaGV = id;
                ViewBag.HoTen = giaoVien.HoTen;

                return View(giaoVien);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ManagePosition: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải thông tin chức vụ";
                return RedirectToAction(nameof(Details), new { id });
            }
        }

        // POST: Phân công chức vụ
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AssignPosition(string maGV, string maChucVu, DateTime? ngayNhan)
        {
            try
            {
                var result = await _giaoVienService.PhanCongChucVuAsync(maGV, maChucVu, ngayNhan);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManagePosition), new { id = maGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error assigning position: {MaGV}, {MaChucVu}", maGV, maChucVu);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManagePosition), new { id = maGV });
            }
        }

        // POST: Kết thúc chức vụ
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EndPosition(string maGV, string maChucVu, DateTime? ngayKetThuc)
        {
            try
            {
                var result = await _giaoVienService.KetThucChucVuAsync(maGV, maChucVu, ngayKetThuc);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManagePosition), new { id = maGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error ending position: {MaGV}, {MaChucVu}", maGV, maChucVu);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManagePosition), new { id = maGV });
            }
        }

        #endregion

        #region Reports and Statistics

        // GET: GiaoVien/Statistics/5
        public async Task<IActionResult> Statistics(string id, string namHoc = null)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
                if (giaoVien == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy giáo viên";
                    return RedirectToAction(nameof(Index));
                }

                // Lấy thống kê
                var thongKeResult = await _giaoVienService.GetThongKeGiaoVienAsync(id, namHoc);
                var baoCaoGiangDayResult = await _giaoVienService.GetBaoCaoGiangDayAsync(id, namHoc);
                var baoCaoNCKHResult = await _giaoVienService.GetBaoCaoNCKHAsync(id, namHoc);

                ViewBag.GiaoVien = giaoVien;
                ViewBag.ThongKe = thongKeResult.Success ? thongKeResult.Data : new ThongKeGiaoVien();
                ViewBag.BaoCaoGiangDay = baoCaoGiangDayResult.Success ? baoCaoGiangDayResult.Data : null;
                ViewBag.BaoCaoNCKH = baoCaoNCKHResult.Success ? baoCaoNCKHResult.Data : null;
                ViewBag.NamHoc = namHoc ?? DateTime.Now.Year + "-" + (DateTime.Now.Year + 1);

                // Danh sách năm học
                var namHocs = new List<string> { "2022-2023", "2023-2024", "2024-2025" };
                ViewBag.NamHocs = new SelectList(namHocs, ViewBag.NamHoc);

                return View();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in Statistics: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải thống kê";
                return RedirectToAction(nameof(Details), new { id });
            }
        }

        #endregion

        #region Export Functions

        // GET: Export Excel
        public async Task<IActionResult> ExportExcel(string searchData = null)
        {
            try
            {
                GiaoVienSearchDto searchDto = null;

                if (!string.IsNullOrEmpty(searchData))
                {
                    searchDto = JsonSerializer.Deserialize<GiaoVienSearchDto>(searchData);
                }

                var result = await _giaoVienService.ExportGiaoVienToExcelAsync(searchDto);

                if (result.Success)
                {
                    var fileName = $"DanhSachGiaoVien_{DateTime.Now:yyyyMMdd_HHmmss}.xlsx";
                    return File(result.Data, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                    return RedirectToAction(nameof(Index));
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ExportExcel");
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi xuất Excel";
                return RedirectToAction(nameof(Index));
            }
        }

        // GET: Export PDF
        public async Task<IActionResult> ExportPdf(string id)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var result = await _giaoVienService.ExportGiaoVienToPdfAsync(id);

                if (result.Success)
                {
                    var fileName = $"ThongTinGiaoVien_{id}_{DateTime.Now:yyyyMMdd_HHmmss}.pdf";
                    return File(result.Data, "application/pdf", fileName);
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                    return RedirectToAction(nameof(Details), new { id });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ExportPdf: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi xuất PDF";
                return RedirectToAction(nameof(Details), new { id });
            }
        }

        #endregion

        #region AJAX APIs

        // POST: Check Email exists
        [HttpPost]
        public async Task<IActionResult> CheckEmailExists(string email, string excludeMaGV = null)
        {
            try
            {
                var exists = await _giaoVienService.CheckEmailExistsAsync(email, excludeMaGV);
                return Json(new { exists = exists });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking email exists: {Email}", email);
                return Json(new { error = "Có lỗi xảy ra" });
            }
        }

        // POST: Check SDT exists
        [HttpPost]
        public async Task<IActionResult> CheckSDTExists(int sdt, string excludeMaGV = null)
        {
            try
            {
                var exists = await _giaoVienService.CheckSDTExistsAsync(sdt, excludeMaGV);
                return Json(new { exists = exists });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error checking SDT exists: {SDT}", sdt);
                return Json(new { error = "Có lỗi xảy ra" });
            }
        }

        // GET: Get dashboard data for charts
        [HttpGet]
        public async Task<IActionResult> GetDashboardData()
        {
            try
            {
                var result = await _giaoVienService.GetDashboardDataAsync();
                if (result.Success)
                {
                    return Json(result.Data);
                }
                else
                {
                    return Json(new { error = result.Message });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting dashboard data");
                return Json(new { error = "Có lỗi xảy ra" });
            }
        }

        // GET: Get statistics for charts
        [HttpGet]
        public async Task<IActionResult> GetStatisticsData(string maGV, string namHoc = null)
        {
            try
            {
                var result = await _giaoVienService.GetThongKeGiaoVienAsync(maGV, namHoc);
                if (result.Success)
                {
                    return Json(result.Data);
                }
                else
                {
                    return Json(new { error = result.Message });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting statistics data: {MaGV}", maGV);
                return Json(new { error = "Có lỗi xảy ra" });
            }
        }

        #endregion

        #region Bulk Operations

        // POST: Bulk Delete
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BulkDelete(string[] selectedIds, bool forceDelete = false)
        {
            try
            {
                if (selectedIds == null || !selectedIds.Any())
                {
                    TempData["ErrorMessage"] = "Vui lòng chọn ít nhất một giáo viên để xóa";
                    return RedirectToAction(nameof(Index));
                }

                int successCount = 0;
                int errorCount = 0;
                var errors = new List<string>();

                foreach (var id in selectedIds)
                {
                    var result = await _giaoVienService.DeleteGiaoVienAsync(id, forceDelete);
                    if (result.Success)
                    {
                        successCount++;
                    }
                    else
                    {
                        errorCount++;
                        errors.Add($"{id}: {result.Message}");
                    }
                }

                if (successCount > 0)
                {
                    TempData["SuccessMessage"] = $"Đã xóa thành công {successCount} giáo viên";
                }

                if (errorCount > 0)
                {
                    TempData["ErrorMessage"] = $"Có {errorCount} giáo viên không thể xóa. Chi tiết: {string.Join("; ", errors.Take(3))}";
                }

                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in BulkDelete");
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra khi xóa hàng loạt";
                return RedirectToAction(nameof(Index));
            }
        }

        #endregion

        #region Helper Methods

        private void AddModelErrors(List<string> errors)
        {
            foreach (var error in errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        #endregion

        // Thêm các method sau vào class GiaoVienController

        #region Quản lý học vị đầy đủ

        // GET: GiaoVien/ManageHocVi/5
        public async Task<IActionResult> ManageHocVi(string id, int pageNumber = 1, int pageSize = 10)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
                if (giaoVien == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy giáo viên";
                    return RedirectToAction(nameof(Index));
                }

                // Get list of hoc vi for this giao vien
                var hocViResult = await _giaoVienService.TimKiemHocViAsync(id, null, null, null, pageNumber, pageSize);

                ViewBag.GiaoVien = giaoVien;
                ViewBag.CurrentPage = pageNumber;

                if (hocViResult.Success)
                {
                    ViewBag.TotalPages = hocViResult.Data.TotalPages;
                    return View(hocViResult.Data.Data);
                }
                else
                {
                    TempData["ErrorMessage"] = hocViResult.Message;
                    return View(new List<HocVi>());
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ManageHocVi: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải danh sách học vị";
                return RedirectToAction(nameof(Details), new { id });
            }
        }

        // POST: GiaoVien/AddHocVi
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddHocVi(HocVi hocVi)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    TempData["ErrorMessage"] = "Dữ liệu không hợp lệ";
                    return RedirectToAction(nameof(ManageHocVi), new { id = hocVi.MaGV });
                }

                var result = await _giaoVienService.ThemHocViAsync(hocVi);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageHocVi), new { id = hocVi.MaGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding hoc vi: {@HocVi}", hocVi);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageHocVi), new { id = hocVi.MaGV });
            }
        }

        // POST: GiaoVien/UpdateHocVi
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateHocVi(HocVi hocVi)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    TempData["ErrorMessage"] = "Dữ liệu không hợp lệ";
                    return RedirectToAction(nameof(ManageHocVi), new { id = hocVi.MaGV });
                }

                var result = await _giaoVienService.CapNhatHocViAsync(hocVi);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageHocVi), new { id = hocVi.MaGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating hoc vi: {@HocVi}", hocVi);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageHocVi), new { id = hocVi.MaGV });
            }
        }

        // POST: GiaoVien/DeleteHocVi
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteHocVi(string maHocVi, string maGV)
        {
            try
            {
                var result = await _giaoVienService.XoaHocViAsync(maHocVi);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageHocVi), new { id = maGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting hoc vi: {MaHocVi}", maHocVi);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageHocVi), new { id = maGV });
            }
        }

        // GET: GiaoVien/SearchHocVi
        public async Task<IActionResult> SearchHocVi(string maGV = null, string tenHocVi = null, DateTime? tuNgay = null, DateTime? denNgay = null, int pageNumber = 1, int pageSize = 20)
        {
            try
            {
                var result = await _giaoVienService.TimKiemHocViAsync(maGV, tenHocVi, tuNgay, denNgay, pageNumber, pageSize);

                if (result.Success)
                {
                    ViewBag.SearchParams = new { maGV, tenHocVi, tuNgay, denNgay };
                    ViewBag.CurrentPage = pageNumber;
                    ViewBag.TotalPages = result.Data.TotalPages;

                    // Load giáo viên list for search filter
                    var giaoViens = await _giaoVienService.GetAllGiaoVienAsync();
                    ViewBag.GiaoViens = new SelectList(giaoViens, "MaGV", "HoTen", maGV);

                    return View(result.Data.Data);
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                    return View(new List<HocVi>());
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in SearchHocVi");
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tìm kiếm học vị";
                return View(new List<HocVi>());
            }
        }

        #endregion

        #region Quản lý quân hàm

        // GET: GiaoVien/ManageQuanHam/5
        public async Task<IActionResult> ManageQuanHam(string id)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    return NotFound();
                }

                var giaoVien = await _giaoVienService.GetGiaoVienByIdAsync(id);
                if (giaoVien == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy giáo viên";
                    return RedirectToAction(nameof(Index));
                }

                // Get list of quan ham for this giao vien
                var quanHams = await _giaoVienService.GetQuanHamByGiaoVienAsync(id);

                ViewBag.GiaoVien = giaoVien;
                return View(quanHams);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ManageQuanHam: {Id}", id);
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi tải danh sách quân hàm";
                return RedirectToAction(nameof(Details), new { id });
            }
        }

        // POST: GiaoVien/AddQuanHam
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddQuanHam(QuanHam quanHam)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    TempData["ErrorMessage"] = "Dữ liệu không hợp lệ";
                    return RedirectToAction(nameof(ManageQuanHam), new { id = quanHam.MaGV });
                }

                var result = await _giaoVienService.ThemQuanHamAsync(quanHam);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageQuanHam), new { id = quanHam.MaGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding quan ham: {@QuanHam}", quanHam);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageQuanHam), new { id = quanHam.MaGV });
            }
        }

        // POST: GiaoVien/UpdateQuanHam
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateQuanHam(QuanHam quanHam)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    TempData["ErrorMessage"] = "Dữ liệu không hợp lệ";
                    return RedirectToAction(nameof(ManageQuanHam), new { id = quanHam.MaGV });
                }

                var result = await _giaoVienService.CapNhatQuanHamAsync(quanHam);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageQuanHam), new { id = quanHam.MaGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating quan ham: {@QuanHam}", quanHam);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageQuanHam), new { id = quanHam.MaGV });
            }
        }

        // POST: GiaoVien/DeleteQuanHam
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteQuanHam(string maQuanHam, string maGV)
        {
            try
            {
                var result = await _giaoVienService.XoaQuanHamAsync(maQuanHam);

                if (result.Success)
                {
                    TempData["SuccessMessage"] = result.Message;
                }
                else
                {
                    TempData["ErrorMessage"] = result.Message;
                }

                return RedirectToAction(nameof(ManageQuanHam), new { id = maGV });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting quan ham: {MaQuanHam}", maQuanHam);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra";
                return RedirectToAction(nameof(ManageQuanHam), new { id = maGV });
            }
        }

        #endregion

        #region Utility Functions

        // POST: GiaoVien/InitializeSampleData
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> InitializeSampleData()
        {
            try
            {
                var result = await _giaoVienService.KhoiTaoDuLieuMauAsync();

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
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error initializing sample data");
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra khi khởi tạo dữ liệu mẫu";
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: GiaoVien/BackupTable
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BackupTable(string tenBang, string tenBangSaoLuu = null)
        {
            try
            {
                if (string.IsNullOrEmpty(tenBang))
                {
                    TempData["ErrorMessage"] = "Tên bảng không được để trống";
                    return RedirectToAction(nameof(Index));
                }

                var result = await _giaoVienService.SaoLuuBangAsync(tenBang, tenBangSaoLuu);

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
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error backing up table: {TenBang}", tenBang);
                TempData["ErrorMessage"] = "Có lỗi hệ thống xảy ra khi sao lưu bảng";
                return RedirectToAction(nameof(Index));
            }
        }

        // GET: GiaoVien/UtilityTools
        public IActionResult UtilityTools()
        {
            return View();
        }

        #endregion

        #region AJAX APIs cho học vị và quân hàm

        // GET: AJAX API để lấy học vị theo giáo viên
        [HttpGet]
        public async Task<IActionResult> GetHocViByGiaoVien(string maGV)
        {
            try
            {
                var result = await _giaoVienService.TimKiemHocViAsync(maGV, null, null, null, 1, 100);
                if (result.Success)
                {
                    var hocVis = result.Data.Data.Select(hv => new {
                        maHocVi = hv.MaHocVi,
                        tenHocVi = hv.TenHocVi,
                        ngayNhan = hv.NgayNhan.ToString("dd/MM/yyyy")
                    }).ToList();
                    return Json(hocVis);
                }
                else
                {
                    return Json(new { error = result.Message });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting hoc vi by giao vien: {MaGV}", maGV);
                return Json(new { error = "Có lỗi xảy ra" });
            }
        }

        // GET: AJAX API để lấy quân hàm theo giáo viên
        [HttpGet]
        public async Task<IActionResult> GetQuanHamByGiaoVien(string maGV)
        {
            try
            {
                var quanHams = await _giaoVienService.GetQuanHamByGiaoVienAsync(maGV);
                var result = quanHams.Select(qh => new {
                    maQuanHam = qh.MaQuanHam,
                    tenQuanHam = qh.TenQuanHam,
                    ngayNhan = qh.NgayNhan.ToString("dd/MM/yyyy"),
                    ngayKetThuc = qh.NgayKetThuc?.ToString("dd/MM/yyyy"),
                    trangThai = qh.NgayKetThuc.HasValue ? "Đã kết thúc" : "Đang hoạt động"
                }).ToList();
                return Json(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting quan ham by giao vien: {MaGV}", maGV);
                return Json(new { error = "Có lỗi xảy ra" });
            }
        }

        #endregion
    }
}