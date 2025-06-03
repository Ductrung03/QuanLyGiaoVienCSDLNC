using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Services
{
    public class NCKHService : INCKHService
    {
        private readonly INCKHRepository _nckhRepository;
        private readonly IGiaoVienRepository _giaoVienRepository;

        public NCKHService(INCKHRepository nckhRepository, IGiaoVienRepository giaoVienRepository)
        {
            _nckhRepository = nckhRepository;
            _giaoVienRepository = giaoVienRepository;
        }

        #region Quản lý loại NCKH
        public async Task<List<LoaiNCKH>> GetAllLoaiNCKHAsync()
        {
            return await _nckhRepository.GetAllLoaiNCKHAsync();
        }

        public async Task<LoaiNCKH> GetLoaiNCKHByIdAsync(string maLoaiNCKH)
        {
            return await _nckhRepository.GetLoaiNCKHByIdAsync(maLoaiNCKH);
        }

        public async Task<(bool success, string message)> AddLoaiNCKHAsync(LoaiNCKH loaiNCKH)
        {
            if (string.IsNullOrWhiteSpace(loaiNCKH.TenLoaiNCKH))
                return (false, "Tên loại NCKH không được để trống");

            return await _nckhRepository.AddLoaiNCKHAsync(loaiNCKH);
        }

        public async Task<(bool success, string message)> UpdateLoaiNCKHAsync(LoaiNCKH loaiNCKH)
        {
            if (string.IsNullOrWhiteSpace(loaiNCKH.TenLoaiNCKH))
                return (false, "Tên loại NCKH không được để trống");

            return await _nckhRepository.UpdateLoaiNCKHAsync(loaiNCKH);
        }

        public async Task<(bool success, string message)> DeleteLoaiNCKHAsync(string maLoaiNCKH)
        {
            return await _nckhRepository.DeleteLoaiNCKHAsync(maLoaiNCKH);
        }
        #endregion

        #region Quản lý quy đổi giờ chuẩn
        public async Task<List<QuyDoiGioChuanNCKH>> GetAllQuyDoiGioChuanAsync()
        {
            return await _nckhRepository.GetAllQuyDoiGioChuanAsync();
        }

        public async Task<QuyDoiGioChuanNCKH> GetQuyDoiGioChuanByIdAsync(string maQuyDoi)
        {
            return await _nckhRepository.GetQuyDoiGioChuanByIdAsync(maQuyDoi);
        }

        public async Task<(bool success, string message)> AddQuyDoiGioChuanAsync(QuyDoiGioChuanNCKH quyDoi)
        {
            if (quyDoi.QuyRaGioChuan <= 0)
                return (false, "Quy ra giờ chuẩn phải lớn hơn 0");

            return await _nckhRepository.AddQuyDoiGioChuanAsync(quyDoi);
        }

        public async Task<(bool success, string message)> UpdateQuyDoiGioChuanAsync(QuyDoiGioChuanNCKH quyDoi)
        {
            if (quyDoi.QuyRaGioChuan <= 0)
                return (false, "Quy ra giờ chuẩn phải lớn hơn 0");

            return await _nckhRepository.UpdateQuyDoiGioChuanAsync(quyDoi);
        }

        public async Task<(bool success, string message)> DeleteQuyDoiGioChuanAsync(string maQuyDoi)
        {
            return await _nckhRepository.DeleteQuyDoiGioChuanAsync(maQuyDoi);
        }
        #endregion

        #region Quản lý tài NCKH
        public async Task<List<TaiNCKH>> GetAllTaiNCKHAsync()
        {
            return await _nckhRepository.GetAllTaiNCKHAsync();
        }

        public async Task<TaiNCKH> GetTaiNCKHByIdAsync(string maTaiNCKH)
        {
            return await _nckhRepository.GetTaiNCKHByIdAsync(maTaiNCKH);
        }

        public async Task<List<TaiNCKH>> GetTaiNCKHByNamHocAsync(string namHoc)
        {
            return await _nckhRepository.GetTaiNCKHByNamHocAsync(namHoc);
        }

        public async Task<List<TaiNCKH>> SearchTaiNCKHAsync(string searchTerm = null, string namHoc = null, string maLoaiNCKH = null)
        {
            return await _nckhRepository.SearchTaiNCKHAsync(searchTerm, namHoc, maLoaiNCKH);
        }

        public async Task<(bool success, string message, string maTaiNCKH)> AddTaiNCKHAsync(TaiNCKH taiNCKH)
        {
            if (!await ValidateTaiNCKHAsync(taiNCKH, false))
                return (false, "Dữ liệu không hợp lệ", null);

            return await _nckhRepository.AddTaiNCKHAsync(taiNCKH);
        }

        public async Task<(bool success, string message)> UpdateTaiNCKHAsync(TaiNCKH taiNCKH)
        {
            if (!await ValidateTaiNCKHAsync(taiNCKH, true))
                return (false, "Dữ liệu không hợp lệ");

            return await _nckhRepository.UpdateTaiNCKHAsync(taiNCKH);
        }

        public async Task<(bool success, string message)> DeleteTaiNCKHAsync(string maTaiNCKH)
        {
            if (!await CanDeleteTaiNCKHAsync(maTaiNCKH))
                return (false, "Không thể xóa tài NCKH này");

            return await _nckhRepository.DeleteTaiNCKHAsync(maTaiNCKH);
        }
        #endregion

        #region Quản lý chi tiết NCKH
        public async Task<List<ChiTietNCKH>> GetChiTietNCKHByTaiNCKHAsync(string maTaiNCKH)
        {
            return await _nckhRepository.GetChiTietNCKHByTaiNCKHAsync(maTaiNCKH);
        }

        public async Task<List<ChiTietNCKH>> GetChiTietNCKHByGiaoVienAsync(string maGV, string namHoc = null)
        {
            return await _nckhRepository.GetChiTietNCKHByGiaoVienAsync(maGV, namHoc);
        }

        public async Task<ChiTietNCKH> GetChiTietNCKHByIdAsync(string maChiTietNCKH)
        {
            return await _nckhRepository.GetChiTietNCKHByIdAsync(maChiTietNCKH);
        }

        public async Task<(bool success, string message, string maChiTietNCKH)> AddChiTietNCKHAsync(ChiTietNCKH chiTietNCKH)
        {
            if (!await ValidateChiTietNCKHAsync(chiTietNCKH, false))
                return (false, "Dữ liệu không hợp lệ", null);

            if (!await CanAddTacGiaAsync(chiTietNCKH.MaTaiNCKH))
                return (false, "Đã đủ số tác giả cho công trình này", null);

            if (await _nckhRepository.CheckChiTietNCKHExistsAsync(chiTietNCKH.MaGV, chiTietNCKH.MaTaiNCKH))
                return (false, "Giáo viên đã tham gia công trình này", null);

            return await _nckhRepository.AddChiTietNCKHAsync(chiTietNCKH);
        }

        public async Task<(bool success, string message)> UpdateChiTietNCKHAsync(ChiTietNCKH chiTietNCKH)
        {
            if (!await ValidateChiTietNCKHAsync(chiTietNCKH, true))
                return (false, "Dữ liệu không hợp lệ");

            return await _nckhRepository.UpdateChiTietNCKHAsync(chiTietNCKH);
        }

        public async Task<(bool success, string message)> DeleteChiTietNCKHAsync(string maChiTietNCKH)
        {
            return await _nckhRepository.DeleteChiTietNCKHAsync(maChiTietNCKH);
        }
        #endregion

        #region Báo cáo và thống kê
        public async Task<dynamic> GetThongKeNCKHTongQuanAsync(string namHoc = null, string maKhoa = null, string maBM = null)
        {
            return await _nckhRepository.GetThongKeNCKHTongQuanAsync(namHoc, maKhoa, maBM);
        }

        public async Task<List<dynamic>> GetTopGiaoVienNCKHXuatSacAsync(string namHoc = null, int topN = 20, string maKhoa = null)
        {
            return await _nckhRepository.GetTopGiaoVienNCKHXuatSacAsync(namHoc, topN, maKhoa);
        }

        public async Task<List<dynamic>> GetThongKeNCKHTheoKhoaAsync(string namHoc = null)
        {
            return await _nckhRepository.GetThongKeNCKHTheoKhoaAsync(namHoc);
        }

        public async Task<List<dynamic>> GetThongKeNCKHTheoBoMonAsync(string namHoc = null, string maKhoa = null)
        {
            return await _nckhRepository.GetThongKeNCKHTheoBoMonAsync(namHoc, maKhoa);
        }
        #endregion

        #region Tiện ích
        public async Task<List<string>> GetAvailableNamHocAsync()
        {
            return await _nckhRepository.GetAvailableNamHocAsync();
        }

        public async Task<List<string>> GetAvailableVaiTroAsync()
        {
            return new List<string>
            {
                "Chủ nhiệm",
                "Thành viên",
                "Cộng tác viên",
                "Tư vấn"
            };
        }

        public async Task<bool> ValidateTaiNCKHAsync(TaiNCKH taiNCKH, bool isUpdate = false)
        {
            if (string.IsNullOrWhiteSpace(taiNCKH.TenCongTrinhKhoaHoc))
                return false;

            if (string.IsNullOrWhiteSpace(taiNCKH.NamHoc))
                return false;

            if (taiNCKH.SoTacGia <= 0 || taiNCKH.SoTacGia > 20)
                return false;

            if (string.IsNullOrWhiteSpace(taiNCKH.MaLoaiNCKH))
                return false;

            // Kiểm tra loại NCKH có tồn tại không
            var loaiNCKH = await _nckhRepository.GetLoaiNCKHByIdAsync(taiNCKH.MaLoaiNCKH);
            if (loaiNCKH == null)
                return false;

            return true;
        }

        public async Task<bool> ValidateChiTietNCKHAsync(ChiTietNCKH chiTietNCKH, bool isUpdate = false)
        {
            if (string.IsNullOrWhiteSpace(chiTietNCKH.MaGV))
                return false;

            if (string.IsNullOrWhiteSpace(chiTietNCKH.MaTaiNCKH))
                return false;

            if (string.IsNullOrWhiteSpace(chiTietNCKH.VaiTro))
                return false;

            if (chiTietNCKH.SoGio <= 0 || chiTietNCKH.SoGio > 500)
                return false;

            // Kiểm tra giáo viên có tồn tại không
            var giaoVien = await _giaoVienRepository.GetGiaoVienByIdAsync(chiTietNCKH.MaGV);
            if (giaoVien == null)
                return false;

            // Kiểm tra tài NCKH có tồn tại không
            var taiNCKH = await _nckhRepository.GetTaiNCKHByIdAsync(chiTietNCKH.MaTaiNCKH);
            if (taiNCKH == null)
                return false;

            return true;
        }

        public async Task<bool> CanDeleteTaiNCKHAsync(string maTaiNCKH)
        {
            // Kiểm tra có chi tiết NCKH không
            var chiTietList = await _nckhRepository.GetChiTietNCKHByTaiNCKHAsync(maTaiNCKH);
            return chiTietList.Count == 0;
        }

        public async Task<bool> CanAddTacGiaAsync(string maTaiNCKH)
        {
            var taiNCKH = await _nckhRepository.GetTaiNCKHByIdAsync(maTaiNCKH);
            if (taiNCKH == null)
                return false;

            var soTacGiaHienTai = await _nckhRepository.GetSoTacGiaHienTaiAsync(maTaiNCKH);
            return soTacGiaHienTai < taiNCKH.SoTacGia;
        }
        #endregion
    }
}