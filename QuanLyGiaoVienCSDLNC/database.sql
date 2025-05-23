create database QLGiaoVienFinal
go
use QLGiaoVienFinal
go

CREATE TABLE DinhMucGiangDay (
    MaDinhMucGiangDay NVARCHAR(50) PRIMARY KEY,
    ChucDanhGiangDay NVARCHAR(100),
    DinhMucGiangDay INT,
    MucGiaoDuKienChatLuong_GiaoDuKienPhong NVARCHAR(100),
    GhiChu NVARCHAR(255),
);

CREATE TABLE DinhMucNghienCuu (
    MaDinhMucNghienCuu NVARCHAR(50) PRIMARY KEY,
    ChucDanhGiangDay NVARCHAR(100),
    DinhMucThoiGianHoatDongNghienCuuKhoaHoc INT,
    DinhMucGioChuanHoatDongNghienCuuKhoaHoc INT,
);

create table Khoa(
	MaKhoa char(15) primary key,
	TenKhoa nvarchar(100),
	DiaChi nvarchar(100),
	MaChuNhiemKhoa char(15)
)
go

create table BoMon(
	MaBM char(15) primary key,
	TenBM nvarchar(100),
	DiaChi nvarchar(100),
	MaKhoa char(15) references Khoa(MaKhoa),
	MaChuNhiemBM char(15)
)
go

create table GiaoVien(
	MaGV char(15) primary key,
	HoTen nvarchar(100),
	NgaySinh date,
	GioiTinh bit,
	QueQuan nvarchar(100),
	DiaChi nvarchar(100),
	SDT int,
	Email nvarchar(100),
	MaBM char(15) references BoMon(MaBM)
)
go

CREATE TABLE NgonNguGiangDay (
    MaNgonNgu CHAR(15) PRIMARY KEY,
    TenNgonNgu NVARCHAR(100),
    HeSoQuyChuan FLOAT,
    MoTa NVARCHAR(200)
);
go

CREATE TABLE DoiTuongGiangDay (
    MaDoiTuong CHAR(15) PRIMARY KEY,
    TenDoiTuong NVARCHAR(100),
    HeSoQuyChuan FLOAT,
    MoTa NVARCHAR(200)
);
go

CREATE TABLE ThoiGianGiangDay (
    MaThoiGian CHAR(15) PRIMARY KEY,
    TenThoiGian NVARCHAR(100),
    HeSoQuyChuan FLOAT,
    MoTa NVARCHAR(200)
);
go

CREATE TABLE TaiGiangDay (
    MaTaiGiangDay CHAR(15) PRIMARY KEY,
    TenHocPhan NVARCHAR(100),
    SiSo INT,
    He NVARCHAR(20),
    Lop NVARCHAR(20),
    SoTinChi INT,
    GhiChu NVARCHAR(200),
    NamHoc NVARCHAR(20),
    MaDoiTuong CHAR(15) REFERENCES DoiTuongGiangDay(MaDoiTuong),
    MaThoiGian CHAR(15) REFERENCES ThoiGianGiangDay(MaThoiGian),
    MaNgonNgu CHAR(15) REFERENCES NgonNguGiangDay(MaNgonNgu)
);
go

CREATE TABLE ChiTietGiangDay (
    MaChiTietGiangDay CHAR(15) PRIMARY KEY,
    SoTiet INT,
    SoTietQuyDoi FLOAT,
    GhiChu NVARCHAR(200),
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV),
    MaTaiGiangDay CHAR(15) REFERENCES TaiGiangDay(MaTaiGiangDay),
    MaNoiDungGiangDay CHAR(15)
);

CREATE TABLE HocHam (
    MaHocHam CHAR(15) PRIMARY KEY,
    TenHocHam NVARCHAR(100),
    MaDinhMucNghienCuu char(15),
    MaDinhMucGiangDay CHAR(15) 
);

CREATE TABLE HocVi (
    MaHocVi CHAR(15) PRIMARY KEY,
    TenHocVi NVARCHAR(100),
    NgayNhan DATE,
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV)
);

CREATE TABLE QuanHam (
    MaQuanHam CHAR(15) PRIMARY KEY,
    TenQuanHam NVARCHAR(100),
    NgayNhan DATE,
    NgayKetThuc DATE,
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV)
);

CREATE TABLE LichSuHocHam (
    MaLSHocHam CHAR(15) PRIMARY KEY,
    TenHocHam NVARCHAR(100),
    NgayNhan DATE,
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV),
    MaHocHam CHAR(15) REFERENCES HocHam(MaHocHam)
);

CREATE TABLE QuyDoiGioChuanNCKH (
    MaQuyDoi CHAR(15) PRIMARY KEY,
    DonViTinh NVARCHAR(50),
    QuyRaGioChuan FLOAT,
    GhiChu NVARCHAR(200),
    NhomCongViec NVARCHAR(100),
    MaNoiDung CHAR(15) -- Có thể liên kết đến bảng "Nội dung công việc" nếu có
);

CREATE TABLE LoaiNCKH (
    MaLoaiNCKH CHAR(15) PRIMARY KEY,
    MoTa NVARCHAR(200),
    TenLoaiNCKH NVARCHAR(100),
    MaQuyDoi CHAR(15) REFERENCES QuyDoiGioChuanNCKH(MaQuyDoi)
);

CREATE TABLE TaiNCKH (
    MaTaiNCKH CHAR(15) PRIMARY KEY,
    TenCongTrinhKhoaHoc NVARCHAR(200),
    NamHoc NVARCHAR(20),
    SoTacGia INT,
    MaLoaiNCKH CHAR(15) REFERENCES LoaiNCKH(MaLoaiNCKH)
);


CREATE TABLE ChiTietNCKH (
    MaChiTietNCKH CHAR(15) PRIMARY KEY,
    VaiTro NVARCHAR(100),
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV),
    MaTaiNCKH CHAR(15) REFERENCES TaiNCKH(MaTaiNCKH),
    SoGio FLOAT
);

CREATE TABLE LoaiCongTacKhaoThi (
    MaLoaiCongTacKhaoThi CHAR(15) PRIMARY KEY,
    TenLoaiCongTacKhaoThi NVARCHAR(100),
    MoTa NVARCHAR(200)
);

CREATE TABLE TaiKhaoThi (
    MaTaiKhaoThi CHAR(15) PRIMARY KEY,
    HocPhan NVARCHAR(100),
    Lop NVARCHAR(50),
    NamHoc NVARCHAR(20),
    GhiChu NVARCHAR(200),
    MaLoaiCongTacKhaoThi CHAR(15) REFERENCES LoaiCongTacKhaoThi(MaLoaiCongTacKhaoThi)
);

CREATE TABLE ChiTietTaiKhaoThi (
    MaChiTietTaiKhaoThi CHAR(15) PRIMARY KEY,
    SoBai INT,
    SoGioQuyChuan FLOAT,
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV),
    MaTaiKhaoThi CHAR(15) REFERENCES TaiKhaoThi(MaTaiKhaoThi)
);

Create table DinhMucMienGiam(
	MaDinhMucMienGiam char(15) primary key,
	DoiTuongMienGiam nvarchar(100),
	TyLeMienGiam float,
	GhiChuMienGiam nvarchar(100)
)

CREATE TABLE ChucVu (
    MaChucVu CHAR(15) PRIMARY KEY,
    TenChucVu NVARCHAR(100),
    MoTa NVARCHAR(200),
    MaDinhMucMienGiam CHAR(15) 
);

CREATE TABLE LichSuChucVu (
    MaLichSuChucVu CHAR(15) PRIMARY KEY,
    NgayNhan DATE,
    NgayKetThuc DATE,
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV),
    MaChucVu CHAR(15) REFERENCES ChucVu(MaChucVu)
);

CREATE TABLE CongTacKhac (
    MaCongTacKhac CHAR(15) PRIMARY KEY,
    NoiDungCongViec NVARCHAR(200),
    NamHoc NVARCHAR(20),
    SoLuong INT,
    GhiChu NVARCHAR(200)
);

CREATE TABLE ChiTietCongTacKhac (
    MaChiTietCongTacKhac CHAR(15) PRIMARY KEY,
    VaiTro NVARCHAR(100),
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV),
    MaCongTacKhac CHAR(15) REFERENCES CongTacKhac(MaCongTacKhac)
);

CREATE TABLE LoaiHoiDong (
    MaLoaiHoiDong CHAR(15) PRIMARY KEY,
    TenLoaiHoiDong NVARCHAR(100),
    MoTa NVARCHAR(200)
);

CREATE TABLE TaiHoiDong (
    MaHoiDong CHAR(15) PRIMARY KEY,
    SoLuong INT,
    NamHoc NVARCHAR(20),
    ThoiGianBatDau DATETIME,
    ThoiGianKetThuc DATETIME,
    GhiChu NVARCHAR(200),
    MaLoaiHoiDong CHAR(15) REFERENCES LoaiHoiDong(MaLoaiHoiDong)
);

CREATE TABLE ThamGia (
    MaThamGia CHAR(15) PRIMARY KEY,
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV),
    MaHoiDong CHAR(15) REFERENCES TaiHoiDong(MaHoiDong),
    SoGio FLOAT
);

CREATE TABLE LoaiHinhHuongDan (
    MaLoaiHinhHuongDan CHAR(15) PRIMARY KEY,
    TenLoaiHinhHuongDan NVARCHAR(100),
    MoTa NVARCHAR(200)
);

CREATE TABLE TaiHuongDan (
    MaHuongDan CHAR(15) PRIMARY KEY,
    HoTenHocVien NVARCHAR(100),
    Lop NVARCHAR(50),
    He NVARCHAR(50),
    NamHoc NVARCHAR(20),
    TenDeTai NVARCHAR(200),
    SoCBHD INT,
    MaLoaiHinhHuongDan CHAR(15) REFERENCES LoaiHinhHuongDan(MaLoaiHinhHuongDan)
);

CREATE TABLE ThamGiaHuongDan (
    MaThamGiaHuongDan CHAR(15) PRIMARY KEY,
    MaGV CHAR(15) REFERENCES GiaoVien(MaGV),
    MaHuongDan CHAR(15) REFERENCES TaiHuongDan(MaHuongDan),
    SoGio FLOAT
);

CREATE TABLE LyLichKhoaHoc (
    MaLyLichKhoaHoc CHAR(15) PRIMARY KEY,

    HeDaoTaoDH NVARCHAR(100),
    NoiDaoTaoDH NVARCHAR(100),

    NganhHocDH NVARCHAR(100),
    NuocDaoTaoDH NVARCHAR(100),
    NamTotNghiepDH INT,

    ThacSiChuyenNganh NVARCHAR(100),
    NamCapBangTS INT,
    NoiDaoTaoTS NVARCHAR(100),

    TenLuanVanTotNghiep NVARCHAR(200),
    TienSiChuyenNganh NVARCHAR(100),

    NamCapBangSauDH INT,
    NoiDaoTaoSauDH NVARCHAR(100),

    TenLuanAnSauDH NVARCHAR(200),
    NguoiKhai NVARCHAR(100),
    NgayKhai DATE,

    MaGV CHAR(15) REFERENCES GiaoVien(MaGV)
);
go


-- Tạo bảng NguoiDung (Người dùng)
CREATE TABLE NguoiDung (
    MaNguoiDung NVARCHAR(50) PRIMARY KEY,
    TenDangNhap NVARCHAR(100),
    MatKhau NVARCHAR(100),
	MaGV char(15),
    FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV)
);

-- Tạo bảng NhomNguoiDung (Nhóm người dùng)
CREATE TABLE NhomNguoiDung (
    MaNhom NVARCHAR(50) PRIMARY KEY,
    TenNhom NVARCHAR(100)
);

-- Tạo bảng NguoiDung_Nhom (Bảng trung gian Người dùng - Nhóm)
CREATE TABLE NguoiDung_Nhom (
    MaNguoiDung NVARCHAR(50),
    MaNhom NVARCHAR(50),
    PRIMARY KEY (MaNguoiDung, MaNhom),
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung),
    FOREIGN KEY (MaNhom) REFERENCES NhomNguoiDung(MaNhom)
);

-- Tạo bảng Quyen (Quyền)
CREATE TABLE Quyen (
    MaQuyen NVARCHAR(50) PRIMARY KEY,
    TenQuyen NVARCHAR(100)
);

-- Tạo bảng Nhom_Quyen (Bảng trung gian Nhóm - Quyền)
CREATE TABLE Nhom_Quyen (
    MaNhom NVARCHAR(50),
    MaQuyen NVARCHAR(50),
    PRIMARY KEY (MaNhom, MaQuyen),
    FOREIGN KEY (MaNhom) REFERENCES NhomNguoiDung(MaNhom),
    FOREIGN KEY (MaQuyen) REFERENCES Quyen(MaQuyen)
);

-- Tạo bảng LichSuDangNhap (Lịch sử đăng nhập)
CREATE TABLE LichSuDangNhap (
    MaLichSu NVARCHAR(50) PRIMARY KEY,
    ThoiDiemDangNhap DATETIME,
    ThoiDiemDangXuat DATETIME,
    MaNguoiDung NVARCHAR(50),
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);

-- Tạo bảng NhatKyThayDoi (Nhật ký thay đổi)
CREATE TABLE NhatKyThayDoi (
    MaNhatKy NVARCHAR(50) PRIMARY KEY,
    MaLichSu NVARCHAR(50),
    ThoiGianThayDoi DATETIME,
    NoiDungThayDoi NVARCHAR(255),
    ThongTinCu NVARCHAR(255),
    ThongTinMoi NVARCHAR(255),
    FOREIGN KEY (MaLichSu) REFERENCES LichSuDangNhap(MaLichSu)
);


-- Script thêm dữ liệu mẫu vào Database QLGiaoVienFinal
USE QLGiaoVienFinal;
GO

-- Thêm dữ liệu bảng SequenceGenerator nếu chưa tồn tại
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'SequenceGenerator')
BEGIN
    CREATE TABLE SequenceGenerator (
        TableName NVARCHAR(50) PRIMARY KEY,
        LastSequence INT NOT NULL DEFAULT 0
    );
END
GO
