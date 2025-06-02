using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class GiangDayService : IGiangDayService
    {
        private readonly IGiangDayRepository _giangDayRepository;
        private readonly IGiaoVienRepository _giaoVienRepository;

        public GiangDayService(IGiangDayRepository giangDayRepository, IGiaoVienRepository giaoVienRepository)
        {
            _giangDayRepository = giangDayRepository;
            _giaoVienRepository = giaoVienRepository;
        }

        #region TaiGiangDay Operations

        public async Task<List<TaiGiangDay>> GetAllTaiGiangDayAsync()
        {
            try
            {
                return await _giangDayRepository.GetAllTaiGiangDayAsync();
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy danh sách tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<TaiGiangDay> GetTaiGiangDayByIdAsync(string maTaiGiangDay)
        {
            if (string.IsNullOrEmpty(maTaiGiangDay))
            {
                throw new ArgumentException("Mã tài giảng dạy không được để trống");
            }

            try
            {
                return await _giangDayRepository.GetTaiGiangDayByIdAsync(maTaiGiangDay);
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy thông tin tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<List<TaiGiangDay>> SearchTaiGiangDayAsync(string searchTerm = null, string namHoc = null, string he = null, string maDoiTuong = null)
        {
            try
            {
                return await _giangDayRepository.SearchTaiGiangDayAsync(searchTerm, namHoc, he, maDoiTuong);
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi tìm kiếm tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<(bool success, string message, string maTaiGiangDay)> AddTaiGiangDayAsync(TaiGiangDay taiGiangDay)
        {
            // Validation
            var validationResult = await ValidateTaiGiangDayAsync(taiGiangDay, false);
            if (!validationResult.isValid)
            {
                return (false, string.Join("; ", validationResult.errors), null);
            }

            try
            {
                return await _giangDayRepository.AddTaiGiangDayAsync(taiGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi thêm tài giảng dạy: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateTaiGiangDayAsync(TaiGiangDay taiGiangDay)
        {
            if (string.IsNullOrEmpty(taiGiangDay.MaTaiGiangDay))
            {
                return (false, "Mã tài giảng dạy không được để trống");
            }

            // Validation
            var validationResult = await ValidateTaiGiangDayAsync(taiGiangDay, true);
            if (!validationResult.isValid)
            {
                return (false, string.Join("; ", validationResult.errors));
            }

            try
            {
                return await _giangDayRepository.UpdateTaiGiangDayAsync(taiGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật tài giảng dạy: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> DeleteTaiGiangDayAsync(string maTaiGiangDay)
        {
            if (string.IsNullOrEmpty(maTaiGiangDay))
            {
                return (false, "Mã tài giảng dạy không được để trống");
            }

            try
            {
                return await _giangDayRepository.DeleteTaiGiangDayAsync(maTaiGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa tài giảng dạy: {ex.Message}");
            }
        }

        #endregion

        #region ChiTietGiangDay Operations

        public async Task<List<ChiTietGiangDay>> GetChiTietGiangDayByTaiGiangDayAsync(string maTaiGiangDay)
        {
            if (string.IsNullOrEmpty(maTaiGiangDay))
            {
                throw new ArgumentException("Mã tài giảng dạy không được để trống");
            }

            try
            {
                return await _giangDayRepository.GetChiTietGiangDayByTaiGiangDayAsync(maTaiGiangDay);
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy chi tiết giảng dạy: {ex.Message}");
            }
        }

        public async Task<List<ChiTietGiangDay>> GetChiTietGiangDayByGiaoVienAsync(string maGV, string namHoc = null)
        {
            if (string.IsNullOrEmpty(maGV))
            {
                throw new ArgumentException("Mã giáo viên không được để trống");
            }

            try
            {
                return await _giangDayRepository.GetChiTietGiangDayByGiaoVienAsync(maGV, namHoc);
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy danh sách giảng dạy của giáo viên: {ex.Message}");
            }
        }

        public async Task<(bool success, string message, string maChiTietGiangDay)> PhanCongGiangDayAsync(string maGV, string maTaiGiangDay, int soTiet, string ghiChu = null, string noiDungGiangDay = null, bool checkConflict = true)
        {
            // Validation
            var validationResult = await ValidatePhanCongAsync(maGV, maTaiGiangDay, soTiet, checkConflict);
            if (!validationResult.isValid)
            {
                return (false, string.Join("; ", validationResult.errors), null);
            }

            try
            {
                return await _giangDayRepository.PhanCongGiangDayAsync(maGV, maTaiGiangDay, soTiet, ghiChu, noiDungGiangDay, checkConflict);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi phân công giảng dạy: {ex.Message}", null);
            }
        }

        public async Task<(bool success, string message)> UpdateChiTietGiangDayAsync(string maChiTietGiangDay, int soTiet, string ghiChu)
        {
            if (string.IsNullOrEmpty(maChiTietGiangDay))
            {
                return (false, "Mã chi tiết giảng dạy không được để trống");
            }

            if (soTiet <= 0 || soTiet > 200)
            {
                return (false, "Số tiết phải từ 1 đến 200");
            }

            try
            {
                return await _giangDayRepository.UpdateChiTietGiangDayAsync(maChiTietGiangDay, soTiet, ghiChu);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi cập nhật chi tiết giảng dạy: {ex.Message}");
            }
        }

        public async Task<(bool success, string message)> XoaPhanCongGiangDayAsync(string maChiTietGiangDay)
        {
            if (string.IsNullOrEmpty(maChiTietGiangDay))
            {
                return (false, "Mã chi tiết giảng dạy không được để trống");
            }

            try
            {
                return await _giangDayRepository.XoaPhanCongGiangDayAsync(maChiTietGiangDay);
            }
            catch (Exception ex)
            {
                return (false, $"Lỗi khi xóa phân công giảng dạy: {ex.Message}");
            }
        }

        #endregion

        #region Lookup Data

        public async Task<List<DoiTuongGiangDay>> GetAllDoiTuongGiangDayAsync()
        {
            try
            {
                return await _giangDayRepository.GetAllDoiTuongGiangDayAsync();
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy danh sách đối tượng giảng dạy: {ex.Message}");
            }
        }

        public async Task<List<ThoiGianGiangDay>> GetAllThoiGianGiangDayAsync()
        {
            try
            {
                return await _giangDayRepository.GetAllThoiGianGiangDayAsync();
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy danh sách thời gian giảng dạy: {ex.Message}");
            }
        }

        public async Task<List<NgonNguGiangDay>> GetAllNgonNguGiangDayAsync()
        {
            try
            {
                return await _giangDayRepository.GetAllNgonNguGiangDayAsync();
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy danh sách ngôn ngữ giảng dạy: {ex.Message}");
            }
        }

        public async Task<List<string>> GetDistinctNamHocAsync()
        {
            try
            {
                return await _giangDayRepository.GetDistinctNamHocAsync();
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy danh sách năm học: {ex.Message}");
            }
        }

        public async Task<List<string>> GetDistinctHeAsync()
        {
            try
            {
                return await _giangDayRepository.GetDistinctHeAsync();
            }
            catch (Exception ex)
            {
                throw new Exception($"Lỗi khi lấy danh sách hệ đào tạo: {ex.Message}");
            }
        }

        #endregion

        #region Statistics

        public async Task<object> GetThongKeGiangDayAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            try
            {
                var result = await _giangDayRepository.GetThongKeGiangDayAsync(maGV, maBM, maKhoa, namHoc);

                // Đảm bảo result không null và có cấu trúc đúng
                if (result == null)
                {
                    return new
                    {
                        TongSoTiet = 0,
                        TongSoTietQuyDoi = 0.0,
                        SoTaiGiangDay = 0,
                        SoGiaoVien = 0,
                        ChiTiet = new List<object>()
                    };
                }

                return result;
            }
            catch (Exception ex)
            {
                // Log error nếu cần
                Console.WriteLine($"Error in GetThongKeGiangDayAsync: {ex.Message}");

                // Trả về object mặc định với thông báo lỗi
                return new
                {
                    TongSoTiet = 0,
                    TongSoTietQuyDoi = 0.0,
                    SoTaiGiangDay = 0,
                    SoGiaoVien = 0,
                    ChiTiet = new List<object>(),
                    ErrorMessage = $"Lỗi khi lấy thống kê giảng dạy: {ex.Message}"
                };
            }
        }
        #endregion

        #region Validation

        public async Task<(bool isValid, List<string> errors)> ValidateTaiGiangDayAsync(TaiGiangDay taiGiangDay, bool isUpdate = false)
        {
            var errors = new List<string>();

            // Validate required fields
            if (string.IsNullOrEmpty(taiGiangDay.TenHocPhan))
                errors.Add("Tên học phần không được để trống");

            if (taiGiangDay.SiSo <= 0 || taiGiangDay.SiSo > 500)
                errors.Add("Sĩ số phải từ 1 đến 500");

            if (taiGiangDay.SoTinChi <= 0 || taiGiangDay.SoTinChi > 10)
                errors.Add("Số tín chỉ phải từ 1 đến 10");

            if (string.IsNullOrEmpty(taiGiangDay.He))
                errors.Add("Hệ đào tạo không được để trống");

            if (string.IsNullOrEmpty(taiGiangDay.Lop))
                errors.Add("Lớp không được để trống");

            if (string.IsNullOrEmpty(taiGiangDay.NamHoc))
                errors.Add("Năm học không được để trống");

            // Validate foreign keys
            try
            {
                var doiTuongList = await _giangDayRepository.GetAllDoiTuongGiangDayAsync();
                if (!doiTuongList.Any(d => d.MaDoiTuong == taiGiangDay.MaDoiTuong))
                    errors.Add("Đối tượng giảng dạy không tồn tại");

                var thoiGianList = await _giangDayRepository.GetAllThoiGianGiangDayAsync();
                if (!thoiGianList.Any(t => t.MaThoiGian == taiGiangDay.MaThoiGian))
                    errors.Add("Thời gian giảng dạy không tồn tại");

                var ngonNguList = await _giangDayRepository.GetAllNgonNguGiangDayAsync();
                if (!ngonNguList.Any(n => n.MaNgonNgu == taiGiangDay.MaNgonNgu))
                    errors.Add("Ngôn ngữ giảng dạy không tồn tại");
            }
            catch (Exception ex)
            {
                errors.Add($"Lỗi khi kiểm tra dữ liệu: {ex.Message}");
            }

            return (errors.Count == 0, errors);
        }

        public async Task<(bool isValid, List<string> errors)> ValidatePhanCongAsync(string maGV, string maTaiGiangDay, int soTiet, bool checkConflict = true)
        {
            var errors = new List<string>();

            // Validate required fields
            if (string.IsNullOrEmpty(maGV))
                errors.Add("Mã giáo viên không được để trống");

            if (string.IsNullOrEmpty(maTaiGiangDay))
                errors.Add("Mã tài giảng dạy không được để trống");

            if (soTiet <= 0 || soTiet > 200)
                errors.Add("Số tiết phải từ 1 đến 200");

            // Validate existence
            try
            {
                var giaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(maGV);
                if (giaoVien == null)
                    errors.Add("Giáo viên không tồn tại");

                var taiGiangDay = await _giangDayRepository.GetTaiGiangDayByIdAsync(maTaiGiangDay);
                if (taiGiangDay == null)
                    errors.Add("Tài giảng dạy không tồn tại");

                // Check if already assigned
                if (giaoVien != null && taiGiangDay != null)
                {
                    var existingAssignment = taiGiangDay.ChiTietGiangDays?.FirstOrDefault(c => c.MaGV == maGV);
                    if (existingAssignment != null)
                        errors.Add("Giáo viên đã được phân công cho tài giảng dạy này");
                }
            }
            catch (Exception ex)
            {
                errors.Add($"Lỗi khi kiểm tra dữ liệu: {ex.Message}");
            }

            return (errors.Count == 0, errors);
        }

        #endregion
    }
}