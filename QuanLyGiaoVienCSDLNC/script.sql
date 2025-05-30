USE [QLGiaoVienFinal]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BoMon]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BoMon](
	[MaBM] [char](15) NOT NULL,
	[TenBM] [nvarchar](100) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[MaKhoa] [char](15) NULL,
	[MaChuNhiemBM] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietCongTacKhac]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietCongTacKhac](
	[MaChiTietCongTacKhac] [char](15) NOT NULL,
	[VaiTro] [nvarchar](100) NULL,
	[MaGV] [char](15) NULL,
	[MaCongTacKhac] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietCongTacKhac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietGiangDay](
	[MaChiTietGiangDay] [char](15) NOT NULL,
	[SoTiet] [int] NULL,
	[SoTietQuyDoi] [float] NULL,
	[GhiChu] [nvarchar](200) NULL,
	[MaGV] [char](15) NULL,
	[MaTaiGiangDay] [char](15) NULL,
	[MaNoiDungGiangDay] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietGiangDay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietNCKH]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietNCKH](
	[MaChiTietNCKH] [char](15) NOT NULL,
	[VaiTro] [nvarchar](100) NULL,
	[MaGV] [char](15) NULL,
	[MaTaiNCKH] [char](15) NULL,
	[SoGio] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietNCKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietTaiKhaoThi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietTaiKhaoThi](
	[MaChiTietTaiKhaoThi] [char](15) NOT NULL,
	[SoBai] [int] NULL,
	[SoGioQuyChuan] [float] NULL,
	[MaGV] [char](15) NULL,
	[MaTaiKhaoThi] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietTaiKhaoThi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[MaChucVu] [char](15) NOT NULL,
	[TenChucVu] [nvarchar](100) NULL,
	[MoTa] [nvarchar](200) NULL,
	[MaDinhMucMienGiam] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CongTacKhac]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CongTacKhac](
	[MaCongTacKhac] [char](15) NOT NULL,
	[NoiDungCongViec] [nvarchar](200) NULL,
	[NamHoc] [nvarchar](20) NULL,
	[SoLuong] [int] NULL,
	[GhiChu] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCongTacKhac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucGiangDay](
	[MaDinhMucGiangDay] [nvarchar](50) NOT NULL,
	[ChucDanhGiangDay] [nvarchar](100) NULL,
	[DinhMucGiangDay] [int] NULL,
	[MucGiaoDuKienChatLuong_GiaoDuKienPhong] [nvarchar](100) NULL,
	[GhiChu] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDinhMucGiangDay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DinhMucNghienCuu]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhMucNghienCuu](
	[MaDinhMucNghienCuu] [nvarchar](50) NOT NULL,
	[ChucDanhGiangDay] [nvarchar](100) NULL,
	[DinhMucThoiGianHoatDongNghienCuuKhoaHoc] [int] NULL,
	[DinhMucGioChuanHoatDongNghienCuuKhoaHoc] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDinhMucNghienCuu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoiTuongGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoiTuongGiangDay](
	[MaDoiTuong] [char](15) NOT NULL,
	[TenDoiTuong] [nvarchar](100) NULL,
	[HeSoQuyChuan] [float] NULL,
	[MoTa] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDoiTuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien](
	[MaGV] [char](15) NOT NULL,
	[HoTen] [nvarchar](100) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[QueQuan] [nvarchar](100) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SDT] [int] NULL,
	[Email] [nvarchar](100) NULL,
	[MaBM] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocHam]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocHam](
	[MaHocHam] [char](15) NOT NULL,
	[TenHocHam] [nvarchar](100) NULL,
	[MaDinhMucNghienCuu] [char](15) NULL,
	[MaDinhMucGiangDay] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHocHam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocVi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocVi](
	[MaHocVi] [char](15) NOT NULL,
	[TenHocVi] [nvarchar](100) NULL,
	[NgayNhan] [date] NULL,
	[MaGV] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHocVi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [char](15) NOT NULL,
	[TenKhoa] [nvarchar](100) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[MaChuNhiemKhoa] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichSuChucVu]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichSuChucVu](
	[MaLichSuChucVu] [char](15) NOT NULL,
	[NgayNhan] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[MaGV] [char](15) NULL,
	[MaChucVu] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLichSuChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichSuDangNhap]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichSuDangNhap](
	[MaLichSu] [nvarchar](50) NOT NULL,
	[ThoiDiemDangNhap] [datetime] NULL,
	[ThoiDiemDangXuat] [datetime] NULL,
	[MaNguoiDung] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLichSu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichSuHocHam]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichSuHocHam](
	[MaLSHocHam] [char](15) NOT NULL,
	[TenHocHam] [nvarchar](100) NULL,
	[NgayNhan] [date] NULL,
	[MaGV] [char](15) NULL,
	[MaHocHam] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLSHocHam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiCongTacKhaoThi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiCongTacKhaoThi](
	[MaLoaiCongTacKhaoThi] [char](15) NOT NULL,
	[TenLoaiCongTacKhaoThi] [nvarchar](100) NULL,
	[MoTa] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiCongTacKhaoThi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiHinhHuongDan]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHinhHuongDan](
	[MaLoaiHinhHuongDan] [char](15) NOT NULL,
	[TenLoaiHinhHuongDan] [nvarchar](100) NULL,
	[MoTa] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiHinhHuongDan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiHoiDong]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHoiDong](
	[MaLoaiHoiDong] [char](15) NOT NULL,
	[TenLoaiHoiDong] [nvarchar](100) NULL,
	[MoTa] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiHoiDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiNCKH]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiNCKH](
	[MaLoaiNCKH] [char](15) NOT NULL,
	[MoTa] [nvarchar](200) NULL,
	[TenLoaiNCKH] [nvarchar](100) NULL,
	[MaQuyDoi] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiNCKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LyLichKhoaHoc]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LyLichKhoaHoc](
	[MaLyLichKhoaHoc] [char](15) NOT NULL,
	[HeDaoTaoDH] [nvarchar](100) NULL,
	[NoiDaoTaoDH] [nvarchar](100) NULL,
	[NganhHocDH] [nvarchar](100) NULL,
	[NuocDaoTaoDH] [nvarchar](100) NULL,
	[NamTotNghiepDH] [int] NULL,
	[ThacSiChuyenNganh] [nvarchar](100) NULL,
	[NamCapBangTS] [int] NULL,
	[NoiDaoTaoTS] [nvarchar](100) NULL,
	[TenLuanVanTotNghiep] [nvarchar](200) NULL,
	[TienSiChuyenNganh] [nvarchar](100) NULL,
	[NamCapBangSauDH] [int] NULL,
	[NoiDaoTaoSauDH] [nvarchar](100) NULL,
	[TenLuanAnSauDH] [nvarchar](200) NULL,
	[NguoiKhai] [nvarchar](100) NULL,
	[NgayKhai] [date] NULL,
	[MaGV] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLyLichKhoaHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NgonNguGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NgonNguGiangDay](
	[MaNgonNgu] [char](15) NOT NULL,
	[TenNgonNgu] [nvarchar](100) NULL,
	[HeSoQuyChuan] [float] NULL,
	[MoTa] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNgonNgu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[MaNguoiDung] [nvarchar](50) NOT NULL,
	[TenDangNhap] [nvarchar](100) NULL,
	[MatKhau] [nvarchar](100) NULL,
	[MaGV] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguoiDung_Nhom]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung_Nhom](
	[MaNguoiDung] [nvarchar](50) NOT NULL,
	[MaNhom] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNguoiDung] ASC,
	[MaNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhatKyThayDoi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhatKyThayDoi](
	[MaNhatKy] [nvarchar](50) NOT NULL,
	[MaLichSu] [nvarchar](50) NULL,
	[ThoiGianThayDoi] [datetime] NULL,
	[NoiDungThayDoi] [nvarchar](255) NULL,
	[ThongTinCu] [nvarchar](255) NULL,
	[ThongTinMoi] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhatKy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nhom_Quyen]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nhom_Quyen](
	[MaNhom] [nvarchar](50) NOT NULL,
	[MaQuyen] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhom] ASC,
	[MaQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhomNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomNguoiDung](
	[MaNhom] [nvarchar](50) NOT NULL,
	[TenNhom] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuanHam]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanHam](
	[MaQuanHam] [char](15) NOT NULL,
	[TenQuanHam] [nvarchar](100) NULL,
	[NgayNhan] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[MaGV] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaQuanHam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuyDoiGioChuanNCKH]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuyDoiGioChuanNCKH](
	[MaQuyDoi] [char](15) NOT NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[QuyRaGioChuan] [float] NULL,
	[GhiChu] [nvarchar](200) NULL,
	[NhomCongViec] [nvarchar](100) NULL,
	[MaNoiDung] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaQuyDoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quyen]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quyen](
	[MaQuyen] [nvarchar](50) NOT NULL,
	[TenQuyen] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SequenceGenerator]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SequenceGenerator](
	[TableName] [nvarchar](50) NOT NULL,
	[LastSequence] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TableName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiGiangDay](
	[MaTaiGiangDay] [char](15) NOT NULL,
	[TenHocPhan] [nvarchar](100) NULL,
	[SiSo] [int] NULL,
	[He] [nvarchar](20) NULL,
	[Lop] [nvarchar](20) NULL,
	[SoTinChi] [int] NULL,
	[GhiChu] [nvarchar](200) NULL,
	[NamHoc] [nvarchar](20) NULL,
	[MaDoiTuong] [char](15) NULL,
	[MaThoiGian] [char](15) NULL,
	[MaNgonNgu] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTaiGiangDay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiHoiDong]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiHoiDong](
	[MaHoiDong] [char](15) NOT NULL,
	[SoLuong] [int] NULL,
	[NamHoc] [nvarchar](20) NULL,
	[ThoiGianBatDau] [datetime] NULL,
	[ThoiGianKetThuc] [datetime] NULL,
	[GhiChu] [nvarchar](200) NULL,
	[MaLoaiHoiDong] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHoiDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiHuongDan]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiHuongDan](
	[MaHuongDan] [char](15) NOT NULL,
	[HoTenHocVien] [nvarchar](100) NULL,
	[Lop] [nvarchar](50) NULL,
	[He] [nvarchar](50) NULL,
	[NamHoc] [nvarchar](20) NULL,
	[TenDeTai] [nvarchar](200) NULL,
	[SoCBHD] [int] NULL,
	[MaLoaiHinhHuongDan] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHuongDan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhaoThi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhaoThi](
	[MaTaiKhaoThi] [char](15) NOT NULL,
	[HocPhan] [nvarchar](100) NULL,
	[Lop] [nvarchar](50) NULL,
	[NamHoc] [nvarchar](20) NULL,
	[GhiChu] [nvarchar](200) NULL,
	[MaLoaiCongTacKhaoThi] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTaiKhaoThi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiNCKH]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiNCKH](
	[MaTaiNCKH] [char](15) NOT NULL,
	[TenCongTrinhKhoaHoc] [nvarchar](200) NULL,
	[NamHoc] [nvarchar](20) NULL,
	[SoTacGia] [int] NULL,
	[MaLoaiNCKH] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTaiNCKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThamGia]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThamGia](
	[MaThamGia] [char](15) NOT NULL,
	[MaGV] [char](15) NULL,
	[MaHoiDong] [char](15) NULL,
	[SoGio] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaThamGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThamGiaHuongDan]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThamGiaHuongDan](
	[MaThamGiaHuongDan] [char](15) NOT NULL,
	[MaGV] [char](15) NULL,
	[MaHuongDan] [char](15) NULL,
	[SoGio] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaThamGiaHuongDan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThoiGianGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThoiGianGiangDay](
	[MaThoiGian] [char](15) NOT NULL,
	[TenThoiGian] [nvarchar](100) NULL,
	[HeSoQuyChuan] [float] NULL,
	[MoTa] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaThoiGian] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [DiaChi], [MaKhoa], [MaChuNhiemBM]) VALUES (N'BM001          ', N'Công nghệ phần mềm', N'Tòa nhà A, Tầng 2, Phòng 202', N'KHOA001        ', N'GV0009         ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [DiaChi], [MaKhoa], [MaChuNhiemBM]) VALUES (N'BM002          ', N'Mạng máy tính', N'Tòa nhà A, Tầng 2, Phòng 203', N'KHOA001        ', N'GV0003         ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [DiaChi], [MaKhoa], [MaChuNhiemBM]) VALUES (N'BM003          ', N'Hệ thống thông tin', N'Tòa nhà A, Tầng 2, Phòng 204', N'KHOA001        ', N'GV0004         ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [DiaChi], [MaKhoa], [MaChuNhiemBM]) VALUES (N'BM004          ', N'Toán ứng dụng', N'Tòa nhà A, Tầng 3, Phòng 302', N'KHOA002        ', N'GV0005         ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [DiaChi], [MaKhoa], [MaChuNhiemBM]) VALUES (N'BM005          ', N'Vật lý ứng dụng', N'Tòa nhà B, Tầng 1, Phòng 102', N'KHOA003        ', N'GV0006         ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [DiaChi], [MaKhoa], [MaChuNhiemBM]) VALUES (N'BM006          ', N'Hóa phân tích', N'Tòa nhà B, Tầng 2, Phòng 202', N'KHOA004        ', N'GV0007         ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [DiaChi], [MaKhoa], [MaChuNhiemBM]) VALUES (N'BM007          ', N'Kinh tế lượng', N'Tòa nhà C, Tầng 1, Phòng 102', N'KHOA005        ', N'GV0008         ')
GO
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD001        ', 45, 45, N'Lý thuyết', N'GV0001         ', N'TGD001         ', N'NDGD001        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD002        ', 30, 30, N'Thực hành', N'GV0002         ', N'TGD001         ', N'NDGD002        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD003        ', 45, 45, N'Lý thuyết', N'GV0003         ', N'TGD002         ', N'NDGD001        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD004        ', 30, 30, N'Thực hành', N'GV0004         ', N'TGD002         ', N'NDGD002        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD005        ', 45, 45, N'Lý thuyết', N'GV0001         ', N'TGD003         ', N'NDGD001        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD006        ', 30, 30, N'Thực hành', N'GV0002         ', N'TGD003         ', N'NDGD002        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD007        ', 45, 45, N'Lý thuyết', N'GV0003         ', N'TGD004         ', N'NDGD001        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD008        ', 30, 30, N'Thực hành', N'GV0004         ', N'TGD004         ', N'NDGD002        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD009        ', 45, 45, N'Lý thuyết', N'GV0005         ', N'TGD005         ', N'NDGD001        ')
INSERT [dbo].[ChiTietGiangDay] ([MaChiTietGiangDay], [SoTiet], [SoTietQuyDoi], [GhiChu], [MaGV], [MaTaiGiangDay], [MaNoiDungGiangDay]) VALUES (N'CTGD010        ', 30, 30, N'Thực hành', N'GV0006         ', N'TGD005         ', N'NDGD002        ')
GO
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH001      ', N'Chủ nhiệm', N'GV0001         ', N'TNCKH001       ', 100)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH002      ', N'Thành viên', N'GV0002         ', N'TNCKH001       ', 50)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH003      ', N'Thành viên', N'GV0003         ', N'TNCKH001       ', 50)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH004      ', N'Chủ nhiệm', N'GV0003         ', N'TNCKH002       ', 80)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH005      ', N'Thành viên', N'GV0004         ', N'TNCKH002       ', 40)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH006      ', N'Chủ nhiệm', N'GV0004         ', N'TNCKH003       ', 90)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH007      ', N'Thành viên', N'GV0005         ', N'TNCKH003       ', 45)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH008      ', N'Thành viên', N'GV0006         ', N'TNCKH003       ', 45)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH009      ', N'Thành viên', N'GV0007         ', N'TNCKH003       ', 45)
INSERT [dbo].[ChiTietNCKH] ([MaChiTietNCKH], [VaiTro], [MaGV], [MaTaiNCKH], [SoGio]) VALUES (N'CTNCKH010      ', N'Chủ nhiệm', N'GV0005         ', N'TNCKH004       ', 70)
GO
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT001        ', 30, 15, N'GV0001         ', N'KT001          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT002        ', 25, 12.5, N'GV0003         ', N'KT002          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT003        ', 28, 14, N'GV0001         ', N'KT003          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT004        ', 22, 11, N'GV0003         ', N'KT004          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT005        ', 20, 10, N'GV0005         ', N'KT005          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT006        ', 30, 15, N'GV0002         ', N'KT006          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT007        ', 25, 12.5, N'GV0004         ', N'KT007          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT008        ', 28, 14, N'GV0006         ', N'KT008          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT009        ', 22, 11, N'GV0008         ', N'KT009          ')
INSERT [dbo].[ChiTietTaiKhaoThi] ([MaChiTietTaiKhaoThi], [SoBai], [SoGioQuyChuan], [MaGV], [MaTaiKhaoThi]) VALUES (N'CTKT010        ', 20, 10, N'GV0010         ', N'KT010          ')
GO
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [MoTa], [MaDinhMucMienGiam]) VALUES (N'CV001          ', N'Hiệu trưởng', N'Lãnh đạo nhà trường', N'DMMG001        ')
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [MoTa], [MaDinhMucMienGiam]) VALUES (N'CV002          ', N'Phó Hiệu trưởng', N'Phó lãnh đạo nhà trường', N'DMMG002        ')
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [MoTa], [MaDinhMucMienGiam]) VALUES (N'CV003          ', N'Trưởng khoa', N'Lãnh đạo khoa', N'DMMG003        ')
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [MoTa], [MaDinhMucMienGiam]) VALUES (N'CV004          ', N'Phó Trưởng khoa', N'Phó lãnh đạo khoa', N'DMMG004        ')
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [MoTa], [MaDinhMucMienGiam]) VALUES (N'CV005          ', N'Trưởng bộ môn', N'Lãnh đạo bộ môn', N'DMMG005        ')
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [MoTa], [MaDinhMucMienGiam]) VALUES (N'CV006          ', N'Phó Trưởng bộ môn', N'Phó lãnh đạo bộ môn', N'DMMG006        ')
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [MoTa], [MaDinhMucMienGiam]) VALUES (N'CV007          ', N'Giảng viên', N'Giảng dạy', N'DMMG007        ')
INSERT [dbo].[ChucVu] ([MaChucVu], [TenChucVu], [MoTa], [MaDinhMucMienGiam]) VALUES (N'CV008          ', N'Trợ giảng', N'Hỗ trợ giảng dạy', N'DMMG008        ')
GO
INSERT [dbo].[DinhMucGiangDay] ([MaDinhMucGiangDay], [ChucDanhGiangDay], [DinhMucGiangDay], [MucGiaoDuKienChatLuong_GiaoDuKienPhong], [GhiChu]) VALUES (N'DMGD001', N'Giáo sư', 240, N'120 giờ', N'Giáo sư có học hàm cao nhất')
INSERT [dbo].[DinhMucGiangDay] ([MaDinhMucGiangDay], [ChucDanhGiangDay], [DinhMucGiangDay], [MucGiaoDuKienChatLuong_GiaoDuKienPhong], [GhiChu]) VALUES (N'DMGD002', N'Phó Giáo sư', 280, N'150 giờ', N'Phó Giáo sư có thâm niên')
INSERT [dbo].[DinhMucGiangDay] ([MaDinhMucGiangDay], [ChucDanhGiangDay], [DinhMucGiangDay], [MucGiaoDuKienChatLuong_GiaoDuKienPhong], [GhiChu]) VALUES (N'DMGD003', N'Tiến sĩ', 320, N'180 giờ', N'Tiến sĩ có thâm niên')
INSERT [dbo].[DinhMucGiangDay] ([MaDinhMucGiangDay], [ChucDanhGiangDay], [DinhMucGiangDay], [MucGiaoDuKienChatLuong_GiaoDuKienPhong], [GhiChu]) VALUES (N'DMGD004', N'Thạc sĩ', 360, N'200 giờ', N'Thạc sĩ có thâm niên')
INSERT [dbo].[DinhMucGiangDay] ([MaDinhMucGiangDay], [ChucDanhGiangDay], [DinhMucGiangDay], [MucGiaoDuKienChatLuong_GiaoDuKienPhong], [GhiChu]) VALUES (N'DMGD005', N'Đại học', 400, N'240 giờ', N'Giảng viên đại học')
GO
INSERT [dbo].[DinhMucNghienCuu] ([MaDinhMucNghienCuu], [ChucDanhGiangDay], [DinhMucThoiGianHoatDongNghienCuuKhoaHoc], [DinhMucGioChuanHoatDongNghienCuuKhoaHoc]) VALUES (N'DMNC001', N'Giáo sư', 150, 500)
INSERT [dbo].[DinhMucNghienCuu] ([MaDinhMucNghienCuu], [ChucDanhGiangDay], [DinhMucThoiGianHoatDongNghienCuuKhoaHoc], [DinhMucGioChuanHoatDongNghienCuuKhoaHoc]) VALUES (N'DMNC002', N'Phó Giáo sư', 120, 400)
INSERT [dbo].[DinhMucNghienCuu] ([MaDinhMucNghienCuu], [ChucDanhGiangDay], [DinhMucThoiGianHoatDongNghienCuuKhoaHoc], [DinhMucGioChuanHoatDongNghienCuuKhoaHoc]) VALUES (N'DMNC003', N'Tiến sĩ', 90, 300)
INSERT [dbo].[DinhMucNghienCuu] ([MaDinhMucNghienCuu], [ChucDanhGiangDay], [DinhMucThoiGianHoatDongNghienCuuKhoaHoc], [DinhMucGioChuanHoatDongNghienCuuKhoaHoc]) VALUES (N'DMNC004', N'Thạc sĩ', 60, 200)
INSERT [dbo].[DinhMucNghienCuu] ([MaDinhMucNghienCuu], [ChucDanhGiangDay], [DinhMucThoiGianHoatDongNghienCuuKhoaHoc], [DinhMucGioChuanHoatDongNghienCuuKhoaHoc]) VALUES (N'DMNC005', N'Đại học', 30, 100)
GO
INSERT [dbo].[DoiTuongGiangDay] ([MaDoiTuong], [TenDoiTuong], [HeSoQuyChuan], [MoTa]) VALUES (N'DT001          ', N'Sinh viên đại học', 1, N'Chương trình cử nhân')
INSERT [dbo].[DoiTuongGiangDay] ([MaDoiTuong], [TenDoiTuong], [HeSoQuyChuan], [MoTa]) VALUES (N'DT002          ', N'Học viên cao học', 1.2, N'Chương trình thạc sĩ')
INSERT [dbo].[DoiTuongGiangDay] ([MaDoiTuong], [TenDoiTuong], [HeSoQuyChuan], [MoTa]) VALUES (N'DT003          ', N'Nghiên cứu sinh', 1.5, N'Chương trình tiến sĩ')
INSERT [dbo].[DoiTuongGiangDay] ([MaDoiTuong], [TenDoiTuong], [HeSoQuyChuan], [MoTa]) VALUES (N'DT004          ', N'Đào tạo từ xa', 1.1, N'Chương trình từ xa')
INSERT [dbo].[DoiTuongGiangDay] ([MaDoiTuong], [TenDoiTuong], [HeSoQuyChuan], [MoTa]) VALUES (N'DT005          ', N'Đào tạo quốc tế', 1.3, N'Chương trình liên kết')
GO
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0001         ', N'Nguyễn Văn An', CAST(N'1975-05-10' AS Date), 1, N'Hà Nội', N'Số 23, Đường Trần Phú, Hà Nội', 912345678, N'nguyenvanan@school.edu.vn', N'BM001          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0002         ', N'Trần Thị Bình', CAST(N'1980-03-15' AS Date), 0, N'Hải Phòng', N'Số 45, Đường Lê Lợi, Hải Phòng', 987654321, N'tranthib@school.edu.vn', N'BM001          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0003         ', N'Lê Văn Chính', CAST(N'1978-11-20' AS Date), 1, N'Đà Nẵng', N'Số 67, Đường Nguyễn Huệ, Đà Nẵng', 963852741, N'levc@school.edu.vn', N'BM002          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0004         ', N'Phạm Thị Dung', CAST(N'1985-07-25' AS Date), 0, N'Huế', N'Số 89, Đường Lê Duẩn, Huế', 914725836, N'phamthid@school.edu.vn', N'BM003          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0005         ', N'Hoàng Văn Minh', CAST(N'1982-04-30' AS Date), 1, N'Nghệ An', N'Số 101, Đường Trần Hưng Đạo, Vinh', 925836147, N'hoangvm@school.edu.vn', N'BM004          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0006         ', N'Ngô Thị Lan', CAST(N'1983-09-05' AS Date), 0, N'Thanh Hóa', N'Số 234, Đường Lê Lợi, Thanh Hóa', 935791246, N'ngotl@school.edu.vn', N'BM005          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0007         ', N'Vũ Văn Hải', CAST(N'1976-12-15' AS Date), 1, N'Quảng Ninh', N'Số 456, Đường Trần Phú, Hạ Long', 946825713, N'vuvh@school.edu.vn', N'BM006          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0008         ', N'Đặng Thị Kim', CAST(N'1988-02-20' AS Date), 0, N'Hà Tĩnh', N'Số 567, Đường Nguyễn Du, Hà Tĩnh', 957138642, N'dangthik@school.edu.vn', N'BM007          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0009         ', N'Bùi Văn Long', CAST(N'1977-10-25' AS Date), 1, N'Nam Định', N'Số 789, Đường Trần Hưng Đạo, Nam Định', 968247531, N'buivl@school.edu.vn', N'BM001          ')
INSERT [dbo].[GiaoVien] ([MaGV], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [DiaChi], [SDT], [Email], [MaBM]) VALUES (N'GV0010         ', N'Trịnh Thị Mai', CAST(N'1986-08-30' AS Date), 0, N'Thái Bình', N'Số 890, Đường Lê Lợi, Thái Bình', 979358624, N'trinhtm@school.edu.vn', N'BM002          ')
GO
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucNghienCuu], [MaDinhMucGiangDay]) VALUES (N'HH001          ', N'Giáo sư', N'DMNC001        ', N'DMGD001        ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucNghienCuu], [MaDinhMucGiangDay]) VALUES (N'HH002          ', N'Phó giáo sư', N'DMNC002        ', N'DMGD002        ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucNghienCuu], [MaDinhMucGiangDay]) VALUES (N'HH003          ', N'Tiến sĩ', N'DMNC003        ', N'DMGD003        ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucNghienCuu], [MaDinhMucGiangDay]) VALUES (N'HH004          ', N'Thạc sĩ', N'DMNC004        ', N'DMGD004        ')
INSERT [dbo].[HocHam] ([MaHocHam], [TenHocHam], [MaDinhMucNghienCuu], [MaDinhMucGiangDay]) VALUES (N'HH005          ', N'Cử nhân', N'DMNC005        ', N'DMGD005        ')
GO
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV001          ', N'Tiến sĩ', CAST(N'2010-05-15' AS Date), N'GV0001         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV002          ', N'Thạc sĩ', CAST(N'2005-08-20' AS Date), N'GV0002         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV003          ', N'Tiến sĩ', CAST(N'2012-07-10' AS Date), N'GV0003         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV004          ', N'Thạc sĩ', CAST(N'2008-09-25' AS Date), N'GV0004         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV005          ', N'Tiến sĩ', CAST(N'2011-11-30' AS Date), N'GV0005         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV006          ', N'Thạc sĩ', CAST(N'2007-06-05' AS Date), N'GV0006         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV007          ', N'Tiến sĩ', CAST(N'2013-04-15' AS Date), N'GV0007         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV008          ', N'Thạc sĩ', CAST(N'2009-03-20' AS Date), N'GV0008         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV009          ', N'Tiến sĩ', CAST(N'2014-02-25' AS Date), N'GV0009         ')
INSERT [dbo].[HocVi] ([MaHocVi], [TenHocVi], [NgayNhan], [MaGV]) VALUES (N'HV010          ', N'Thạc sĩ', CAST(N'2006-12-30' AS Date), N'GV0010         ')
GO
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [MaChuNhiemKhoa]) VALUES (N'KHOA001        ', N'Công nghệ thông tin', N'Tòa nhà A, Tầng 2, Phòng 201', N'GV0001         ')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [MaChuNhiemKhoa]) VALUES (N'KHOA002        ', N'Toán - Tin học', N'Tòa nhà A, Tầng 3, Phòng 301', N'GV0005         ')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [MaChuNhiemKhoa]) VALUES (N'KHOA003        ', N'Vật lý kỹ thuật', N'Tòa nhà B, Tầng 1, Phòng 101', N'GV0006         ')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [MaChuNhiemKhoa]) VALUES (N'KHOA004        ', N'Hóa học', N'Tòa nhà B, Tầng 2, Phòng 201', N'GV0007         ')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [MaChuNhiemKhoa]) VALUES (N'KHOA005        ', N'Kinh tế', N'Tòa nhà C, Tầng 1, Phòng 101', N'GV0008         ')
GO
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV001        ', CAST(N'2015-01-01' AS Date), CAST(N'2020-01-01' AS Date), N'GV0001         ', N'CV005          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV002        ', CAST(N'2020-01-01' AS Date), NULL, N'GV0001         ', N'CV003          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV003        ', CAST(N'2016-01-01' AS Date), CAST(N'2021-01-01' AS Date), N'GV0003         ', N'CV006          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV004        ', CAST(N'2021-01-01' AS Date), NULL, N'GV0003         ', N'CV005          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV005        ', CAST(N'2017-01-01' AS Date), NULL, N'GV0005         ', N'CV004          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV006        ', CAST(N'2018-01-01' AS Date), NULL, N'GV0007         ', N'CV005          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV007        ', CAST(N'2019-01-01' AS Date), NULL, N'GV0009         ', N'CV006          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV008        ', CAST(N'2020-01-01' AS Date), NULL, N'GV0002         ', N'CV007          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV009        ', CAST(N'2020-01-01' AS Date), NULL, N'GV0004         ', N'CV007          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV010        ', CAST(N'2020-01-01' AS Date), NULL, N'GV0006         ', N'CV007          ')
INSERT [dbo].[LichSuChucVu] ([MaLichSuChucVu], [NgayNhan], [NgayKetThuc], [MaGV], [MaChucVu]) VALUES (N'LSCV011        ', CAST(N'2025-05-12' AS Date), NULL, N'GV0009         ', N'CV005          ')
GO
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS001', CAST(N'2023-01-10T08:30:00.000' AS DateTime), CAST(N'2023-01-10T11:45:00.000' AS DateTime), N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS002', CAST(N'2023-01-10T09:15:00.000' AS DateTime), CAST(N'2023-01-10T12:30:00.000' AS DateTime), N'ND002')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS003', CAST(N'2023-01-10T10:00:00.000' AS DateTime), CAST(N'2023-01-10T14:20:00.000' AS DateTime), N'ND003')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS004', CAST(N'2023-01-11T08:45:00.000' AS DateTime), CAST(N'2023-01-11T16:15:00.000' AS DateTime), N'ND004')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS005', CAST(N'2023-01-11T09:30:00.000' AS DateTime), CAST(N'2023-01-11T15:45:00.000' AS DateTime), N'ND005')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS006', CAST(N'2023-01-12T08:00:00.000' AS DateTime), CAST(N'2023-01-12T11:30:00.000' AS DateTime), N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS007', CAST(N'2023-01-12T10:15:00.000' AS DateTime), CAST(N'2023-01-12T14:45:00.000' AS DateTime), N'ND002')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS008', CAST(N'2023-01-13T09:00:00.000' AS DateTime), CAST(N'2023-01-13T16:00:00.000' AS DateTime), N'ND003')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS009', CAST(N'2023-01-13T10:30:00.000' AS DateTime), CAST(N'2023-01-13T15:15:00.000' AS DateTime), N'ND004')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS010', CAST(N'2023-01-14T08:15:00.000' AS DateTime), CAST(N'2023-01-14T12:30:00.000' AS DateTime), N'ND005')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS011', CAST(N'2025-05-12T09:33:49.820' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS012', CAST(N'2025-05-12T09:47:32.533' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS013', CAST(N'2025-05-12T09:49:57.993' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS014', CAST(N'2025-05-12T09:58:09.570' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS015', CAST(N'2025-05-12T10:01:09.777' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS016', CAST(N'2025-05-12T10:02:47.717' AS DateTime), NULL, N'ND002')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS017', CAST(N'2025-05-12T10:06:14.547' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS018', CAST(N'2025-05-12T10:56:21.887' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS019', CAST(N'2025-05-12T11:10:47.687' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS020', CAST(N'2025-05-12T11:16:22.223' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS021', CAST(N'2025-05-12T13:34:17.693' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS022', CAST(N'2025-05-12T13:35:36.830' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS023', CAST(N'2025-05-12T13:39:13.120' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS024', CAST(N'2025-05-12T13:42:02.030' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS025', CAST(N'2025-05-12T13:43:28.990' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS026', CAST(N'2025-05-12T13:51:59.000' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS027', CAST(N'2025-05-12T14:12:52.163' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS028', CAST(N'2025-05-12T14:19:47.140' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS029', CAST(N'2025-05-12T14:29:42.500' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS030', CAST(N'2025-05-12T14:35:29.090' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS031', CAST(N'2025-05-12T14:43:26.990' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS032', CAST(N'2025-05-12T14:49:35.017' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS033', CAST(N'2025-05-12T15:12:13.163' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS034', CAST(N'2025-05-12T15:19:52.423' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS035', CAST(N'2025-05-12T15:21:32.587' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS036', CAST(N'2025-05-12T15:23:28.690' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS037', CAST(N'2025-05-12T15:24:12.823' AS DateTime), NULL, N'ND001')
INSERT [dbo].[LichSuDangNhap] ([MaLichSu], [ThoiDiemDangNhap], [ThoiDiemDangXuat], [MaNguoiDung]) VALUES (N'LS038', CAST(N'2025-05-12T16:16:29.050' AS DateTime), NULL, N'ND001')
GO
INSERT [dbo].[LichSuHocHam] ([MaLSHocHam], [TenHocHam], [NgayNhan], [MaGV], [MaHocHam]) VALUES (N'LSHH001        ', N'Phó giáo sư', CAST(N'2015-05-20' AS Date), N'GV0001         ', N'HH002          ')
INSERT [dbo].[LichSuHocHam] ([MaLSHocHam], [TenHocHam], [NgayNhan], [MaGV], [MaHocHam]) VALUES (N'LSHH002        ', N'Giảng viên', CAST(N'2010-07-15' AS Date), N'GV0002         ', N'HH004          ')
INSERT [dbo].[LichSuHocHam] ([MaLSHocHam], [TenHocHam], [NgayNhan], [MaGV], [MaHocHam]) VALUES (N'LSHH003        ', N'Phó giáo sư', CAST(N'2017-08-10' AS Date), N'GV0003         ', N'HH002          ')
INSERT [dbo].[LichSuHocHam] ([MaLSHocHam], [TenHocHam], [NgayNhan], [MaGV], [MaHocHam]) VALUES (N'LSHH004        ', N'Giảng viên', CAST(N'2012-09-25' AS Date), N'GV0004         ', N'HH004          ')
INSERT [dbo].[LichSuHocHam] ([MaLSHocHam], [TenHocHam], [NgayNhan], [MaGV], [MaHocHam]) VALUES (N'LSHH005        ', N'Phó giáo sư', CAST(N'2016-11-30' AS Date), N'GV0005         ', N'HH002          ')
GO
INSERT [dbo].[LoaiCongTacKhaoThi] ([MaLoaiCongTacKhaoThi], [TenLoaiCongTacKhaoThi], [MoTa]) VALUES (N'LKT01          ', N'Ra đề thi', N'Ra đề thi học phần')
INSERT [dbo].[LoaiCongTacKhaoThi] ([MaLoaiCongTacKhaoThi], [TenLoaiCongTacKhaoThi], [MoTa]) VALUES (N'LKT02          ', N'Coi thi', N'Coi thi học phần')
INSERT [dbo].[LoaiCongTacKhaoThi] ([MaLoaiCongTacKhaoThi], [TenLoaiCongTacKhaoThi], [MoTa]) VALUES (N'LKT03          ', N'Chấm thi', N'Chấm thi học phần')
INSERT [dbo].[LoaiCongTacKhaoThi] ([MaLoaiCongTacKhaoThi], [TenLoaiCongTacKhaoThi], [MoTa]) VALUES (N'LKT04          ', N'Phản biện đề thi', N'Phản biện đề thi học phần')
INSERT [dbo].[LoaiCongTacKhaoThi] ([MaLoaiCongTacKhaoThi], [TenLoaiCongTacKhaoThi], [MoTa]) VALUES (N'LKT05          ', N'Chấm phúc khảo', N'Chấm phúc khảo bài thi')
GO
INSERT [dbo].[LoaiHinhHuongDan] ([MaLoaiHinhHuongDan], [TenLoaiHinhHuongDan], [MoTa]) VALUES (N'LHD001         ', N'Hướng dẫn đồ án tốt nghiệp đại học', N'Hướng dẫn sinh viên đại học làm đồ án tốt nghiệp')
INSERT [dbo].[LoaiHinhHuongDan] ([MaLoaiHinhHuongDan], [TenLoaiHinhHuongDan], [MoTa]) VALUES (N'LHD002         ', N'Hướng dẫn luận văn thạc sĩ', N'Hướng dẫn học viên cao học làm luận văn thạc sĩ')
INSERT [dbo].[LoaiHinhHuongDan] ([MaLoaiHinhHuongDan], [TenLoaiHinhHuongDan], [MoTa]) VALUES (N'LHD003         ', N'Hướng dẫn luận án tiến sĩ', N'Hướng dẫn nghiên cứu sinh làm luận án tiến sĩ')
INSERT [dbo].[LoaiHinhHuongDan] ([MaLoaiHinhHuongDan], [TenLoaiHinhHuongDan], [MoTa]) VALUES (N'LHD004         ', N'Hướng dẫn đồ án môn học', N'Hướng dẫn sinh viên làm đồ án môn học')
INSERT [dbo].[LoaiHinhHuongDan] ([MaLoaiHinhHuongDan], [TenLoaiHinhHuongDan], [MoTa]) VALUES (N'LHD005         ', N'Hướng dẫn thực tập tốt nghiệp', N'Hướng dẫn sinh viên thực tập tốt nghiệp')
GO
INSERT [dbo].[LoaiHoiDong] ([MaLoaiHoiDong], [TenLoaiHoiDong], [MoTa]) VALUES (N'LHD001         ', N'Hội đồng khoa học cấp khoa', N'Xét duyệt đề tài NCKH cấp khoa')
INSERT [dbo].[LoaiHoiDong] ([MaLoaiHoiDong], [TenLoaiHoiDong], [MoTa]) VALUES (N'LHD002         ', N'Hội đồng khoa học cấp trường', N'Xét duyệt đề tài NCKH cấp trường')
INSERT [dbo].[LoaiHoiDong] ([MaLoaiHoiDong], [TenLoaiHoiDong], [MoTa]) VALUES (N'LHD003         ', N'Hội đồng thi tốt nghiệp', N'Tổ chức thi và đánh giá kết quả tốt nghiệp')
INSERT [dbo].[LoaiHoiDong] ([MaLoaiHoiDong], [TenLoaiHoiDong], [MoTa]) VALUES (N'LHD004         ', N'Hội đồng bảo vệ luận văn thạc sĩ', N'Đánh giá luận văn cao học')
INSERT [dbo].[LoaiHoiDong] ([MaLoaiHoiDong], [TenLoaiHoiDong], [MoTa]) VALUES (N'LHD005         ', N'Hội đồng bảo vệ luận án tiến sĩ', N'Đánh giá luận án tiến sĩ')
GO
INSERT [dbo].[LoaiNCKH] ([MaLoaiNCKH], [MoTa], [TenLoaiNCKH], [MaQuyDoi]) VALUES (N'LNCKH001       ', N'Công bố trên các tạp chí quốc tế', N'Bài báo quốc tế', N'QD001          ')
INSERT [dbo].[LoaiNCKH] ([MaLoaiNCKH], [MoTa], [TenLoaiNCKH], [MaQuyDoi]) VALUES (N'LNCKH002       ', N'Công bố trên các tạp chí trong nước', N'Bài báo trong nước', N'QD005          ')
INSERT [dbo].[LoaiNCKH] ([MaLoaiNCKH], [MoTa], [TenLoaiNCKH], [MaQuyDoi]) VALUES (N'LNCKH003       ', N'Báo cáo tại hội thảo quốc tế', N'Hội thảo quốc tế', N'QD006          ')
INSERT [dbo].[LoaiNCKH] ([MaLoaiNCKH], [MoTa], [TenLoaiNCKH], [MaQuyDoi]) VALUES (N'LNCKH004       ', N'Báo cáo tại hội thảo quốc gia', N'Hội thảo quốc gia', N'QD007          ')
INSERT [dbo].[LoaiNCKH] ([MaLoaiNCKH], [MoTa], [TenLoaiNCKH], [MaQuyDoi]) VALUES (N'LNCKH005       ', N'Viết sách chuyên khảo quốc tế', N'Sách chuyên khảo quốc tế', N'QD008          ')
INSERT [dbo].[LoaiNCKH] ([MaLoaiNCKH], [MoTa], [TenLoaiNCKH], [MaQuyDoi]) VALUES (N'LNCKH006       ', N'Viết sách chuyên khảo trong nước', N'Sách chuyên khảo trong nước', N'QD009          ')
INSERT [dbo].[LoaiNCKH] ([MaLoaiNCKH], [MoTa], [TenLoaiNCKH], [MaQuyDoi]) VALUES (N'LNCKH007       ', N'Viết giáo trình đại học', N'Giáo trình', N'QD010          ')
GO
INSERT [dbo].[LyLichKhoaHoc] ([MaLyLichKhoaHoc], [HeDaoTaoDH], [NoiDaoTaoDH], [NganhHocDH], [NuocDaoTaoDH], [NamTotNghiepDH], [ThacSiChuyenNganh], [NamCapBangTS], [NoiDaoTaoTS], [TenLuanVanTotNghiep], [TienSiChuyenNganh], [NamCapBangSauDH], [NoiDaoTaoSauDH], [TenLuanAnSauDH], [NguoiKhai], [NgayKhai], [MaGV]) VALUES (N'LLKH001        ', N'Chính quy', N'Đại học Bách Khoa Hà Nội', N'Khoa học máy tính', N'Việt Nam', 2000, N'Khoa học máy tính', 2002, N'Đại học Bách Khoa Hà Nội', N'Các thuật toán tối ưu trong tìm kiếm', N'Khoa học máy tính', 2010, N'Đại học Quốc gia Hà Nội', N'Nghiên cứu và áp dụng học máy trong xử lý ảnh', N'Nguyễn Văn An', CAST(N'2023-01-15' AS Date), N'GV0001         ')
INSERT [dbo].[LyLichKhoaHoc] ([MaLyLichKhoaHoc], [HeDaoTaoDH], [NoiDaoTaoDH], [NganhHocDH], [NuocDaoTaoDH], [NamTotNghiepDH], [ThacSiChuyenNganh], [NamCapBangTS], [NoiDaoTaoTS], [TenLuanVanTotNghiep], [TienSiChuyenNganh], [NamCapBangSauDH], [NoiDaoTaoSauDH], [TenLuanAnSauDH], [NguoiKhai], [NgayKhai], [MaGV]) VALUES (N'LLKH002        ', N'Chính quy', N'Đại học Quốc gia Hà Nội', N'Công nghệ thông tin', N'Việt Nam', 2003, N'Công nghệ thông tin', 2005, N'Đại học Quốc gia Hà Nội', N'Phát triển hệ thống quản lý thông tin trực tuyến', NULL, NULL, NULL, NULL, N'Trần Thị Bình', CAST(N'2023-01-16' AS Date), N'GV0002         ')
INSERT [dbo].[LyLichKhoaHoc] ([MaLyLichKhoaHoc], [HeDaoTaoDH], [NoiDaoTaoDH], [NganhHocDH], [NuocDaoTaoDH], [NamTotNghiepDH], [ThacSiChuyenNganh], [NamCapBangTS], [NoiDaoTaoTS], [TenLuanVanTotNghiep], [TienSiChuyenNganh], [NamCapBangSauDH], [NoiDaoTaoSauDH], [TenLuanAnSauDH], [NguoiKhai], [NgayKhai], [MaGV]) VALUES (N'LLKH003        ', N'Chính quy', N'Đại học Bách Khoa Hà Nội', N'Mạng máy tính', N'Việt Nam', 2001, N'Mạng máy tính và truyền thông', 2003, N'Đại học Bách Khoa Hà Nội', N'Bảo mật hệ thống mạng không dây', N'An ninh mạng', 2012, N'Đại học Kỹ thuật Sydney', N'Phát hiện tấn công mạng sử dụng học sâu', N'Lê Văn Chính', CAST(N'2023-01-17' AS Date), N'GV0003         ')
INSERT [dbo].[LyLichKhoaHoc] ([MaLyLichKhoaHoc], [HeDaoTaoDH], [NoiDaoTaoDH], [NganhHocDH], [NuocDaoTaoDH], [NamTotNghiepDH], [ThacSiChuyenNganh], [NamCapBangTS], [NoiDaoTaoTS], [TenLuanVanTotNghiep], [TienSiChuyenNganh], [NamCapBangSauDH], [NoiDaoTaoSauDH], [TenLuanAnSauDH], [NguoiKhai], [NgayKhai], [MaGV]) VALUES (N'LLKH004        ', N'Chính quy', N'Đại học Quốc gia TP. HCM', N'Hệ thống thông tin', N'Việt Nam', 2005, N'Hệ thống thông tin', 2008, N'Đại học Quốc gia TP. HCM', N'Phân tích và thiết kế hệ thống thông tin quản lý', NULL, NULL, NULL, NULL, N'Phạm Thị Dung', CAST(N'2023-01-18' AS Date), N'GV0004         ')
INSERT [dbo].[LyLichKhoaHoc] ([MaLyLichKhoaHoc], [HeDaoTaoDH], [NoiDaoTaoDH], [NganhHocDH], [NuocDaoTaoDH], [NamTotNghiepDH], [ThacSiChuyenNganh], [NamCapBangTS], [NoiDaoTaoTS], [TenLuanVanTotNghiep], [TienSiChuyenNganh], [NamCapBangSauDH], [NoiDaoTaoSauDH], [TenLuanAnSauDH], [NguoiKhai], [NgayKhai], [MaGV]) VALUES (N'LLKH005        ', N'Chính quy', N'Đại học Sư phạm Hà Nội', N'Toán Tin', N'Việt Nam', 2002, N'Toán ứng dụng', 2004, N'Đại học Sư phạm Hà Nội', N'Các mô hình toán học trong tài chính', N'Toán ứng dụng', 2011, N'Đại học Paris-Saclay', N'Mô hình hóa quá trình tối ưu trong kinh tế', N'Hoàng Văn Minh', CAST(N'2023-01-19' AS Date), N'GV0005         ')
GO
INSERT [dbo].[NgonNguGiangDay] ([MaNgonNgu], [TenNgonNgu], [HeSoQuyChuan], [MoTa]) VALUES (N'NN001          ', N'Tiếng Việt', 1, N'Ngôn ngữ chính thức')
INSERT [dbo].[NgonNguGiangDay] ([MaNgonNgu], [TenNgonNgu], [HeSoQuyChuan], [MoTa]) VALUES (N'NN002          ', N'Tiếng Anh', 1.5, N'Ngôn ngữ quốc tế')
INSERT [dbo].[NgonNguGiangDay] ([MaNgonNgu], [TenNgonNgu], [HeSoQuyChuan], [MoTa]) VALUES (N'NN003          ', N'Tiếng Pháp', 1.5, N'Ngôn ngữ quốc tế')
INSERT [dbo].[NgonNguGiangDay] ([MaNgonNgu], [TenNgonNgu], [HeSoQuyChuan], [MoTa]) VALUES (N'NN004          ', N'Tiếng Nga', 1.5, N'Ngôn ngữ quốc tế')
INSERT [dbo].[NgonNguGiangDay] ([MaNgonNgu], [TenNgonNgu], [HeSoQuyChuan], [MoTa]) VALUES (N'NN005          ', N'Tiếng Nhật', 1.7, N'Ngôn ngữ châu Á')
GO
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND001', N'admin', N'admin123', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND002', N'nguyenvanan', N'password123', N'GV0001         ')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND003', N'tranthib', N'password123', N'GV0002         ')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND004', N'levc', N'password123', N'GV0003         ')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND005', N'phamthid', N'password123', N'GV0004         ')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND006', N'hoangvm', N'password123', N'GV0005         ')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND007', N'ngotl', N'password123', N'GV0006         ')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND008', N'vuvh', N'password123', N'GV0007         ')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND009', N'dangthik', N'password123', N'GV0008         ')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [MaGV]) VALUES (N'ND010', N'buivl', N'password123', N'GV0009         ')
GO
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND001', N'NHOM001')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND002', N'NHOM002')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND002', N'NHOM003')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND003', N'NHOM004')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND004', N'NHOM003')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND005', N'NHOM003')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND006', N'NHOM002')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND007', N'NHOM004')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND008', N'NHOM004')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND009', N'NHOM004')
INSERT [dbo].[NguoiDung_Nhom] ([MaNguoiDung], [MaNhom]) VALUES (N'ND010', N'NHOM004')
GO
INSERT [dbo].[NhatKyThayDoi] ([MaNhatKy], [MaLichSu], [ThoiGianThayDoi], [NoiDungThayDoi], [ThongTinCu], [ThongTinMoi]) VALUES (N'NK001', N'LS001', CAST(N'2023-01-10T09:15:00.000' AS DateTime), N'Cập nhật thông tin giáo viên', N'Email: old@school.edu.vn', N'Email: new@school.edu.vn')
INSERT [dbo].[NhatKyThayDoi] ([MaNhatKy], [MaLichSu], [ThoiGianThayDoi], [NoiDungThayDoi], [ThongTinCu], [ThongTinMoi]) VALUES (N'NK002', N'LS002', CAST(N'2023-01-10T10:00:00.000' AS DateTime), N'Thêm giáo viên mới', N'', N'GV0011: Lý Văn Tân')
INSERT [dbo].[NhatKyThayDoi] ([MaNhatKy], [MaLichSu], [ThoiGianThayDoi], [NoiDungThayDoi], [ThongTinCu], [ThongTinMoi]) VALUES (N'NK003', N'LS001', CAST(N'2023-01-10T10:30:00.000' AS DateTime), N'Cập nhật thông tin bộ môn', N'Tên BM: Công nghệ phần mềm', N'Tên BM: Kỹ thuật phần mềm')
INSERT [dbo].[NhatKyThayDoi] ([MaNhatKy], [MaLichSu], [ThoiGianThayDoi], [NoiDungThayDoi], [ThongTinCu], [ThongTinMoi]) VALUES (N'NK004', N'LS004', CAST(N'2023-01-11T09:30:00.000' AS DateTime), N'Thêm tài khoản người dùng', N'', N'ND011: lyvt')
INSERT [dbo].[NhatKyThayDoi] ([MaNhatKy], [MaLichSu], [ThoiGianThayDoi], [NoiDungThayDoi], [ThongTinCu], [ThongTinMoi]) VALUES (N'NK005', N'LS005', CAST(N'2023-01-11T11:15:00.000' AS DateTime), N'Phân quyền người dùng', N'Nhóm: Giảng viên', N'Nhóm: Quản lý bộ môn')
INSERT [dbo].[NhatKyThayDoi] ([MaNhatKy], [MaLichSu], [ThoiGianThayDoi], [NoiDungThayDoi], [ThongTinCu], [ThongTinMoi]) VALUES (N'NK006', N'LS006', CAST(N'2023-01-12T09:00:00.000' AS DateTime), N'Xóa giáo viên', N'GV0011: Lý Văn Tân', N'')
INSERT [dbo].[NhatKyThayDoi] ([MaNhatKy], [MaLichSu], [ThoiGianThayDoi], [NoiDungThayDoi], [ThongTinCu], [ThongTinMoi]) VALUES (N'NK007', N'LS007', CAST(N'2023-01-12T11:30:00.000' AS DateTime), N'Cập nhật thông tin khoa', N'Địa chỉ: Tầng 2, Tòa A', N'Địa chỉ: Tầng 3, Tòa A')
GO
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN001')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN002')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN003')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN004')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN005')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN006')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN007')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN008')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM001', N'QUYEN009')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM002', N'QUYEN002')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM002', N'QUYEN003')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM002', N'QUYEN004')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM002', N'QUYEN009')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM003', N'QUYEN003')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM003', N'QUYEN004')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM003', N'QUYEN005')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM003', N'QUYEN009')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM004', N'QUYEN005')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM004', N'QUYEN006')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM004', N'QUYEN009')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM004', N'QUYEN010')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM005', N'QUYEN009')
INSERT [dbo].[Nhom_Quyen] ([MaNhom], [MaQuyen]) VALUES (N'NHOM005', N'QUYEN010')
GO
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (N'NHOM001', N'Quản trị viên')
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (N'NHOM002', N'Quản lý khoa')
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (N'NHOM003', N'Quản lý bộ môn')
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (N'NHOM004', N'Giảng viên')
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (N'NHOM005', N'Nhân viên')
GO
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD001          ', N'Bài báo quốc tế', 100, N'ISI/Scopus Q1', N'Công bố quốc tế', N'ND001          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD002          ', N'Bài báo quốc tế', 80, N'ISI/Scopus Q2', N'Công bố quốc tế', N'ND001          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD003          ', N'Bài báo quốc tế', 60, N'ISI/Scopus Q3', N'Công bố quốc tế', N'ND001          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD004          ', N'Bài báo quốc tế', 40, N'ISI/Scopus Q4', N'Công bố quốc tế', N'ND001          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD005          ', N'Bài báo trong nước', 20, N'Tạp chí uy tín', N'Công bố trong nước', N'ND002          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD006          ', N'Hội thảo quốc tế', 50, N'Full paper', N'Hội thảo', N'ND003          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD007          ', N'Hội thảo quốc gia', 20, N'Full paper', N'Hội thảo', N'ND003          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD008          ', N'Sách chuyên khảo', 200, N'Nhà xuất bản quốc tế', N'Xuất bản sách', N'ND004          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD009          ', N'Sách chuyên khảo', 100, N'Nhà xuất bản trong nước', N'Xuất bản sách', N'ND004          ')
INSERT [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi], [DonViTinh], [QuyRaGioChuan], [GhiChu], [NhomCongViec], [MaNoiDung]) VALUES (N'QD010          ', N'Giáo trình', 80, N'Nhà xuất bản trong nước', N'Xuất bản sách', N'ND004          ')
GO
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN001', N'Quản lý hệ thống')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN002', N'Quản lý khoa')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN003', N'Quản lý bộ môn')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN004', N'Quản lý giáo viên')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN005', N'Quản lý giảng dạy')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN006', N'Quản lý nghiên cứu')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN007', N'Quản lý khảo thí')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN008', N'Quản lý hội đồng')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN009', N'Xem báo cáo')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (N'QUYEN010', N'Cập nhật thông tin cá nhân')
GO
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD001         ', N'Lập trình cơ bản', 60, N'Đại học', N'CNTT01', 3, N'Học phần bắt buộc', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD002         ', N'Cấu trúc dữ liệu và giải thuật', 50, N'Đại học', N'CNTT02', 4, N'Học phần bắt buộc', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD003         ', N'Cơ sở dữ liệu', 55, N'Đại học', N'CNTT03', 3, N'Học phần bắt buộc', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD004         ', N'Lập trình hướng đối tượng', 45, N'Đại học', N'CNTT02', 4, N'Học phần bắt buộc', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD005         ', N'Phát triển ứng dụng web', 40, N'Đại học', N'CNTT03', 3, N'Học phần tự chọn', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD006         ', N'Trí tuệ nhân tạo', 35, N'Đại học', N'CNTT04', 3, N'Học phần tự chọn', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD007         ', N'Phân tích thiết kế hệ thống', 30, N'Đại học', N'CNTT03', 3, N'Học phần bắt buộc', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD008         ', N'Mạng máy tính', 50, N'Đại học', N'CNTT02', 3, N'Học phần bắt buộc', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD009         ', N'Hệ điều hành', 45, N'Đại học', N'CNTT02', 3, N'Học phần bắt buộc', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
INSERT [dbo].[TaiGiangDay] ([MaTaiGiangDay], [TenHocPhan], [SiSo], [He], [Lop], [SoTinChi], [GhiChu], [NamHoc], [MaDoiTuong], [MaThoiGian], [MaNgonNgu]) VALUES (N'TGD010         ', N'Tin học đại cương', 70, N'Đại học', N'KT01', 2, N'Học phần cơ bản', N'2023-2024', N'DT001          ', N'TG001          ', N'NN001          ')
GO
INSERT [dbo].[TaiHoiDong] ([MaHoiDong], [SoLuong], [NamHoc], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [MaLoaiHoiDong]) VALUES (N'HD001          ', 5, N'2023-2024', CAST(N'2023-10-15T08:00:00.000' AS DateTime), CAST(N'2023-10-15T12:00:00.000' AS DateTime), N'Xét duyệt đề tài NCKH học kỳ I', N'LHD001         ')
INSERT [dbo].[TaiHoiDong] ([MaHoiDong], [SoLuong], [NamHoc], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [MaLoaiHoiDong]) VALUES (N'HD002          ', 7, N'2023-2024', CAST(N'2023-11-20T08:00:00.000' AS DateTime), CAST(N'2023-11-20T16:00:00.000' AS DateTime), N'Xét duyệt đề tài NCKH học kỳ I', N'LHD002         ')
INSERT [dbo].[TaiHoiDong] ([MaHoiDong], [SoLuong], [NamHoc], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [MaLoaiHoiDong]) VALUES (N'HD003          ', 5, N'2023-2024', CAST(N'2024-01-10T08:00:00.000' AS DateTime), CAST(N'2024-01-12T16:00:00.000' AS DateTime), N'Thi tốt nghiệp học kỳ I', N'LHD003         ')
INSERT [dbo].[TaiHoiDong] ([MaHoiDong], [SoLuong], [NamHoc], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [MaLoaiHoiDong]) VALUES (N'HD004          ', 5, N'2023-2024', CAST(N'2024-02-25T08:00:00.000' AS DateTime), CAST(N'2024-02-25T16:00:00.000' AS DateTime), N'Bảo vệ luận văn thạc sĩ đợt 1', N'LHD004         ')
INSERT [dbo].[TaiHoiDong] ([MaHoiDong], [SoLuong], [NamHoc], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [MaLoaiHoiDong]) VALUES (N'HD005          ', 7, N'2023-2024', CAST(N'2024-03-15T08:00:00.000' AS DateTime), CAST(N'2024-03-15T16:00:00.000' AS DateTime), N'Bảo vệ luận án tiến sĩ đợt 1', N'LHD005         ')
GO
INSERT [dbo].[TaiHuongDan] ([MaHuongDan], [HoTenHocVien], [Lop], [He], [NamHoc], [TenDeTai], [SoCBHD], [MaLoaiHinhHuongDan]) VALUES (N'HD001          ', N'Nguyễn Văn Học', N'CNTT01', N'Đại học', N'2023-2024', N'Xây dựng ứng dụng di động quản lý học tập', 1, N'LHD001         ')
INSERT [dbo].[TaiHuongDan] ([MaHuongDan], [HoTenHocVien], [Lop], [He], [NamHoc], [TenDeTai], [SoCBHD], [MaLoaiHinhHuongDan]) VALUES (N'HD002          ', N'Trần Thị Sinh', N'CNTT02', N'Đại học', N'2023-2024', N'Phát triển website thương mại điện tử', 1, N'LHD001         ')
INSERT [dbo].[TaiHuongDan] ([MaHuongDan], [HoTenHocVien], [Lop], [He], [NamHoc], [TenDeTai], [SoCBHD], [MaLoaiHinhHuongDan]) VALUES (N'HD003          ', N'Lê Văn Cao', N'CH01', N'Cao học', N'2023-2024', N'Nghiên cứu ứng dụng trí tuệ nhân tạo trong nhận diện khuôn mặt', 2, N'LHD002         ')
INSERT [dbo].[TaiHuongDan] ([MaHuongDan], [HoTenHocVien], [Lop], [He], [NamHoc], [TenDeTai], [SoCBHD], [MaLoaiHinhHuongDan]) VALUES (N'HD004          ', N'Phạm Thị Học', N'CH02', N'Cao học', N'2023-2024', N'Áp dụng blockchain trong quản lý chuỗi cung ứng', 2, N'LHD002         ')
INSERT [dbo].[TaiHuongDan] ([MaHuongDan], [HoTenHocVien], [Lop], [He], [NamHoc], [TenDeTai], [SoCBHD], [MaLoaiHinhHuongDan]) VALUES (N'HD005          ', N'Hoàng Văn Nghiên', N'NCS01', N'Nghiên cứu sinh', N'2023-2024', N'Mô hình học sâu trong xử lý ngôn ngữ tự nhiên', 2, N'LHD003         ')
GO
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT001          ', N'Lập trình cơ bản', N'CNTT01', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT01          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT002          ', N'Cấu trúc dữ liệu và giải thuật', N'CNTT02', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT01          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT003          ', N'Cơ sở dữ liệu', N'CNTT03', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT01          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT004          ', N'Lập trình hướng đối tượng', N'CNTT02', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT01          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT005          ', N'Phát triển ứng dụng web', N'CNTT03', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT01          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT006          ', N'Lập trình cơ bản', N'CNTT01', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT02          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT007          ', N'Cấu trúc dữ liệu và giải thuật', N'CNTT02', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT02          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT008          ', N'Cơ sở dữ liệu', N'CNTT03', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT02          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT009          ', N'Lập trình hướng đối tượng', N'CNTT02', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT02          ')
INSERT [dbo].[TaiKhaoThi] ([MaTaiKhaoThi], [HocPhan], [Lop], [NamHoc], [GhiChu], [MaLoaiCongTacKhaoThi]) VALUES (N'KT010          ', N'Phát triển ứng dụng web', N'CNTT03', N'2023-2024', N'Kỳ thi cuối kỳ', N'LKT02          ')
GO
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH001       ', N'Phương pháp học máy trong phân tích dữ liệu lớn', N'2023-2024', 3, N'LNCKH001       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH002       ', N'Ứng dụng AI trong y tế', N'2023-2024', 2, N'LNCKH001       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH003       ', N'Phát triển hệ thống IoT thông minh', N'2023-2024', 4, N'LNCKH002       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH004       ', N'Kỹ thuật lập trình hiện đại', N'2023-2024', 2, N'LNCKH002       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH005       ', N'Bảo mật mạng trong thời đại số', N'2023-2024', 3, N'LNCKH003       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH006       ', N'Trí tuệ nhân tạo trong giáo dục', N'2023-2024', 2, N'LNCKH003       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH007       ', N'Công nghệ Blockchain và ứng dụng', N'2023-2024', 4, N'LNCKH004       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH008       ', N'Phát triển ứng dụng di động', N'2023-2024', 2, N'LNCKH004       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH009       ', N'Điện toán đám mây và dữ liệu lớn', N'2023-2024', 3, N'LNCKH005       ')
INSERT [dbo].[TaiNCKH] ([MaTaiNCKH], [TenCongTrinhKhoaHoc], [NamHoc], [SoTacGia], [MaLoaiNCKH]) VALUES (N'TNCKH010       ', N'Tối ưu hóa hệ thống thông tin', N'2023-2024', 2, N'LNCKH006       ')
GO
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG001          ', N'GV0001         ', N'HD001          ', 4)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG002          ', N'GV0003         ', N'HD001          ', 4)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG003          ', N'GV0005         ', N'HD001          ', 4)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG004          ', N'GV0007         ', N'HD001          ', 4)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG005          ', N'GV0009         ', N'HD001          ', 4)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG006          ', N'GV0001         ', N'HD002          ', 8)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG007          ', N'GV0002         ', N'HD002          ', 8)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG008          ', N'GV0003         ', N'HD002          ', 8)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG009          ', N'GV0004         ', N'HD002          ', 8)
INSERT [dbo].[ThamGia] ([MaThamGia], [MaGV], [MaHoiDong], [SoGio]) VALUES (N'TG010          ', N'GV0005         ', N'HD002          ', 8)
GO
INSERT [dbo].[ThamGiaHuongDan] ([MaThamGiaHuongDan], [MaGV], [MaHuongDan], [SoGio]) VALUES (N'TGHD001        ', N'GV0001         ', N'HD001          ', 30)
INSERT [dbo].[ThamGiaHuongDan] ([MaThamGiaHuongDan], [MaGV], [MaHuongDan], [SoGio]) VALUES (N'TGHD002        ', N'GV0003         ', N'HD002          ', 30)
INSERT [dbo].[ThamGiaHuongDan] ([MaThamGiaHuongDan], [MaGV], [MaHuongDan], [SoGio]) VALUES (N'TGHD003        ', N'GV0001         ', N'HD003          ', 60)
INSERT [dbo].[ThamGiaHuongDan] ([MaThamGiaHuongDan], [MaGV], [MaHuongDan], [SoGio]) VALUES (N'TGHD004        ', N'GV0005         ', N'HD003          ', 30)
INSERT [dbo].[ThamGiaHuongDan] ([MaThamGiaHuongDan], [MaGV], [MaHuongDan], [SoGio]) VALUES (N'TGHD005        ', N'GV0003         ', N'HD004          ', 60)
INSERT [dbo].[ThamGiaHuongDan] ([MaThamGiaHuongDan], [MaGV], [MaHuongDan], [SoGio]) VALUES (N'TGHD006        ', N'GV0007         ', N'HD004          ', 30)
INSERT [dbo].[ThamGiaHuongDan] ([MaThamGiaHuongDan], [MaGV], [MaHuongDan], [SoGio]) VALUES (N'TGHD007        ', N'GV0001         ', N'HD005          ', 90)
INSERT [dbo].[ThamGiaHuongDan] ([MaThamGiaHuongDan], [MaGV], [MaHuongDan], [SoGio]) VALUES (N'TGHD008        ', N'GV0003         ', N'HD005          ', 45)
GO
INSERT [dbo].[ThoiGianGiangDay] ([MaThoiGian], [TenThoiGian], [HeSoQuyChuan], [MoTa]) VALUES (N'TG001          ', N'Giờ hành chính', 1, N'8:00 - 17:00')
INSERT [dbo].[ThoiGianGiangDay] ([MaThoiGian], [TenThoiGian], [HeSoQuyChuan], [MoTa]) VALUES (N'TG002          ', N'Buổi tối', 1.2, N'18:00 - 21:00')
INSERT [dbo].[ThoiGianGiangDay] ([MaThoiGian], [TenThoiGian], [HeSoQuyChuan], [MoTa]) VALUES (N'TG003          ', N'Cuối tuần', 1.3, N'Thứ 7, Chủ nhật')
INSERT [dbo].[ThoiGianGiangDay] ([MaThoiGian], [TenThoiGian], [HeSoQuyChuan], [MoTa]) VALUES (N'TG004          ', N'Dịp nghỉ lễ', 1.5, N'Các ngày nghỉ lễ')
INSERT [dbo].[ThoiGianGiangDay] ([MaThoiGian], [TenThoiGian], [HeSoQuyChuan], [MoTa]) VALUES (N'TG005          ', N'Học kỳ hè', 1.2, N'Tháng 6 - Tháng 8')
GO
ALTER TABLE [dbo].[SequenceGenerator] ADD  DEFAULT ((0)) FOR [LastSequence]
GO
ALTER TABLE [dbo].[BoMon]  WITH CHECK ADD FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[ChiTietCongTacKhac]  WITH CHECK ADD FOREIGN KEY([MaCongTacKhac])
REFERENCES [dbo].[CongTacKhac] ([MaCongTacKhac])
GO
ALTER TABLE [dbo].[ChiTietCongTacKhac]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[ChiTietGiangDay]  WITH CHECK ADD FOREIGN KEY([MaTaiGiangDay])
REFERENCES [dbo].[TaiGiangDay] ([MaTaiGiangDay])
GO
ALTER TABLE [dbo].[ChiTietGiangDay]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[ChiTietNCKH]  WITH CHECK ADD FOREIGN KEY([MaTaiNCKH])
REFERENCES [dbo].[TaiNCKH] ([MaTaiNCKH])
GO
ALTER TABLE [dbo].[ChiTietNCKH]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[ChiTietTaiKhaoThi]  WITH CHECK ADD FOREIGN KEY([MaTaiKhaoThi])
REFERENCES [dbo].[TaiKhaoThi] ([MaTaiKhaoThi])
GO
ALTER TABLE [dbo].[ChiTietTaiKhaoThi]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[GiaoVien]  WITH CHECK ADD FOREIGN KEY([MaBM])
REFERENCES [dbo].[BoMon] ([MaBM])
GO
ALTER TABLE [dbo].[HocVi]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[LichSuChucVu]  WITH CHECK ADD FOREIGN KEY([MaChucVu])
REFERENCES [dbo].[ChucVu] ([MaChucVu])
GO
ALTER TABLE [dbo].[LichSuChucVu]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[LichSuDangNhap]  WITH CHECK ADD FOREIGN KEY([MaNguoiDung])
REFERENCES [dbo].[NguoiDung] ([MaNguoiDung])
GO
ALTER TABLE [dbo].[LichSuHocHam]  WITH CHECK ADD FOREIGN KEY([MaHocHam])
REFERENCES [dbo].[HocHam] ([MaHocHam])
GO
ALTER TABLE [dbo].[LichSuHocHam]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[LoaiNCKH]  WITH CHECK ADD FOREIGN KEY([MaQuyDoi])
REFERENCES [dbo].[QuyDoiGioChuanNCKH] ([MaQuyDoi])
GO
ALTER TABLE [dbo].[LyLichKhoaHoc]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[NguoiDung_Nhom]  WITH CHECK ADD FOREIGN KEY([MaNguoiDung])
REFERENCES [dbo].[NguoiDung] ([MaNguoiDung])
GO
ALTER TABLE [dbo].[NguoiDung_Nhom]  WITH CHECK ADD FOREIGN KEY([MaNhom])
REFERENCES [dbo].[NhomNguoiDung] ([MaNhom])
GO
ALTER TABLE [dbo].[NhatKyThayDoi]  WITH CHECK ADD FOREIGN KEY([MaLichSu])
REFERENCES [dbo].[LichSuDangNhap] ([MaLichSu])
GO
ALTER TABLE [dbo].[Nhom_Quyen]  WITH CHECK ADD FOREIGN KEY([MaNhom])
REFERENCES [dbo].[NhomNguoiDung] ([MaNhom])
GO
ALTER TABLE [dbo].[Nhom_Quyen]  WITH CHECK ADD FOREIGN KEY([MaQuyen])
REFERENCES [dbo].[Quyen] ([MaQuyen])
GO
ALTER TABLE [dbo].[QuanHam]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[TaiGiangDay]  WITH CHECK ADD FOREIGN KEY([MaDoiTuong])
REFERENCES [dbo].[DoiTuongGiangDay] ([MaDoiTuong])
GO
ALTER TABLE [dbo].[TaiGiangDay]  WITH CHECK ADD FOREIGN KEY([MaNgonNgu])
REFERENCES [dbo].[NgonNguGiangDay] ([MaNgonNgu])
GO
ALTER TABLE [dbo].[TaiGiangDay]  WITH CHECK ADD FOREIGN KEY([MaThoiGian])
REFERENCES [dbo].[ThoiGianGiangDay] ([MaThoiGian])
GO
ALTER TABLE [dbo].[TaiHoiDong]  WITH CHECK ADD FOREIGN KEY([MaLoaiHoiDong])
REFERENCES [dbo].[LoaiHoiDong] ([MaLoaiHoiDong])
GO
ALTER TABLE [dbo].[TaiHuongDan]  WITH CHECK ADD FOREIGN KEY([MaLoaiHinhHuongDan])
REFERENCES [dbo].[LoaiHinhHuongDan] ([MaLoaiHinhHuongDan])
GO
ALTER TABLE [dbo].[TaiKhaoThi]  WITH CHECK ADD FOREIGN KEY([MaLoaiCongTacKhaoThi])
REFERENCES [dbo].[LoaiCongTacKhaoThi] ([MaLoaiCongTacKhaoThi])
GO
ALTER TABLE [dbo].[TaiNCKH]  WITH CHECK ADD FOREIGN KEY([MaLoaiNCKH])
REFERENCES [dbo].[LoaiNCKH] ([MaLoaiNCKH])
GO
ALTER TABLE [dbo].[ThamGia]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
ALTER TABLE [dbo].[ThamGia]  WITH CHECK ADD FOREIGN KEY([MaHoiDong])
REFERENCES [dbo].[TaiHoiDong] ([MaHoiDong])
GO
ALTER TABLE [dbo].[ThamGiaHuongDan]  WITH CHECK ADD FOREIGN KEY([MaHuongDan])
REFERENCES [dbo].[TaiHuongDan] ([MaHuongDan])
GO
ALTER TABLE [dbo].[ThamGiaHuongDan]  WITH CHECK ADD FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiaoVien] ([MaGV])
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_ChiTietGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 12.3. Báo cáo chi tiết giảng dạy
CREATE   PROCEDURE [dbo].[sp_BaoCao_ChiTietGiangDay]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        TGD.TenHocPhan,
        TGD.Lop,
        TGD.SiSo,
        TGD.SoTinChi,
        TGD.He,
        TGD.NamHoc,
        DT.TenDoiTuong,
        TG.TenThoiGian,
        NN.TenNgonNgu,
        CTGD.SoTiet,
        CTGD.SoTietQuyDoi,
        DT.HeSoQuyChuan AS HeSoDoiTuong,
        TG.HeSoQuyChuan AS HeSoThoiGian,
        NN.HeSoQuyChuan AS HeSoNgonNgu,
        CTGD.GhiChu
    FROM ChiTietGiangDay CTGD
    INNER JOIN GiaoVien GV ON CTGD.MaGV = GV.MaGV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    INNER JOIN DoiTuongGiangDay DT ON TGD.MaDoiTuong = DT.MaDoiTuong
    INNER JOIN ThoiGianGiangDay TG ON TGD.MaThoiGian = TG.MaThoiGian
    INNER JOIN NgonNguGiangDay NN ON TGD.MaNgonNgu = NN.MaNgonNgu
    WHERE (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    ORDER BY K.TenKhoa, BM.TenBM, GV.HoTen, TGD.TenHocPhan;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_ChiTietNCKH]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 12.4. Báo cáo chi tiết NCKH
CREATE   PROCEDURE [dbo].[sp_BaoCao_ChiTietNCKH]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        TNCKH.TenCongTrinhKhoaHoc,
        TNCKH.NamHoc,
        TNCKH.SoTacGia,
        LNCKH.TenLoaiNCKH,
        CTNCKH.VaiTro,
        CTNCKH.SoGio,
        QD.DonViTinh,
        QD.QuyRaGioChuan,
        QD.NhomCongViec,
        LNCKH.MoTa
    FROM ChiTietNCKH CTNCKH
    INNER JOIN GiaoVien GV ON CTNCKH.MaGV = GV.MaGV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    INNER JOIN LoaiNCKH LNCKH ON TNCKH.MaLoaiNCKH = LNCKH.MaLoaiNCKH
    INNER JOIN QuyDoiGioChuanNCKH QD ON LNCKH.MaQuyDoi = QD.MaQuyDoi
    WHERE (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    ORDER BY K.TenKhoa, BM.TenBM, GV.HoTen, TNCKH.TenCongTrinhKhoaHoc;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_ThongKeTheoKhoa]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 12.2. Báo cáo thống kê theo khoa
CREATE   PROCEDURE [dbo].[sp_BaoCao_ThongKeTheoKhoa]
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        K.MaKhoa,
        K.TenKhoa,
        COUNT(DISTINCT BM.MaBM) AS SoBoMon,
        COUNT(DISTINCT GV.MaGV) AS SoGiaoVien,
        COUNT(DISTINCT CASE WHEN HV.TenHocVi = N'Tiến sĩ' THEN GV.MaGV END) AS SoTienSi,
        COUNT(DISTINCT CASE WHEN HV.TenHocVi = N'Thạc sĩ' THEN GV.MaGV END) AS SoThacSi,
        COUNT(DISTINCT CASE WHEN LSHH.TenHocHam IN (N'Giáo sư', N'Phó giáo sư') THEN GV.MaGV END) AS SoGSPGS,
        ISNULL(SUM(CTGD.SoTietQuyDoi), 0) AS TongGioGiangDay,
        ISNULL(SUM(CTNCKH.SoGio), 0) AS TongGioNCKH,
        COUNT(DISTINCT TGD.MaTaiGiangDay) AS SoHocPhan,
        COUNT(DISTINCT TNCKH.MaTaiNCKH) AS SoCongTrinhNCKH
    FROM Khoa K
    LEFT JOIN BoMon BM ON K.MaKhoa = BM.MaKhoa
    LEFT JOIN GiaoVien GV ON BM.MaBM = GV.MaBM
    LEFT JOIN HocVi HV ON GV.MaGV = HV.MaGV
    LEFT JOIN LichSuHocHam LSHH ON GV.MaGV = LSHH.MaGV
    LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
    LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
    LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    GROUP BY K.MaKhoa, K.TenKhoa
    ORDER BY K.TenKhoa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_TongHopKhoiLuongCongTac]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 12: BÁO CÁO VÀ THỐNG KÊ
-- =============================================

-- 12.1. Báo cáo tổng hợp khối lượng công tác
CREATE   PROCEDURE [dbo].[sp_BaoCao_TongHopKhoiLuongCongTac]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH GiangDayStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTGD.SoTietQuyDoi), 0) AS TongGioGiangDay
        FROM GiaoVien GV
        LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
        LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE @NamHoc IS NULL OR TGD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    NCKHStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTNCKH.SoGio), 0) AS TongGioNCKH
        FROM GiaoVien GV
        LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
        LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        WHERE @NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    KhaoThiStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTKT.SoGioQuyChuan), 0) AS TongGioKhaoThi
        FROM GiaoVien GV
        LEFT JOIN ChiTietTaiKhaoThi CTKT ON GV.MaGV = CTKT.MaGV
        LEFT JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
        WHERE @NamHoc IS NULL OR TKT.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    HoiDongStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(TG.SoGio), 0) AS TongGioHoiDong
        FROM GiaoVien GV
        LEFT JOIN ThamGia TG ON GV.MaGV = TG.MaGV
        LEFT JOIN TaiHoiDong THD ON TG.MaHoiDong = THD.MaHoiDong
        WHERE @NamHoc IS NULL OR THD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    HuongDanStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(TGHD.SoGio), 0) AS TongGioHuongDan
        FROM GiaoVien GV
        LEFT JOIN ThamGiaHuongDan TGHD ON GV.MaGV = TGHD.MaGV
        LEFT JOIN TaiHuongDan THD ON TGHD.MaHuongDan = THD.MaHuongDan
        WHERE @NamHoc IS NULL OR THD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    DinhMucStats AS (
        SELECT 
            GV.MaGV,
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
    )
    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        GD.TongGioGiangDay,
        NC.TongGioNCKH,
        KT.TongGioKhaoThi,
        HD.TongGioHoiDong,
        HDan.TongGioHuongDan,
        GD.TongGioGiangDay + NC.TongGioNCKH + KT.TongGioKhaoThi + 
        HD.TongGioHoiDong + HDan.TongGioHuongDan AS TongGioQuyChuan,
        DM.DinhMucGiangDay,
        DM.DinhMucNCKH,
        CAST(GD.TongGioGiangDay * 100.0 / NULLIF(DM.DinhMucGiangDay, 0) AS DECIMAL(10,2)) AS PhanTramGiangDay,
        CAST(NC.TongGioNCKH * 100.0 / NULLIF(DM.DinhMucNCKH, 0) AS DECIMAL(10,2)) AS PhanTramNCKH,
        CASE 
            WHEN GD.TongGioGiangDay >= DM.DinhMucGiangDay AND NC.TongGioNCKH >= DM.DinhMucNCKH THEN N'Đạt'
            ELSE N'Chưa đạt'
        END AS TrangThai
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN GiangDayStats GD ON GV.MaGV = GD.MaGV
    LEFT JOIN NCKHStats NC ON GV.MaGV = NC.MaGV
    LEFT JOIN KhaoThiStats KT ON GV.MaGV = KT.MaGV
    LEFT JOIN HoiDongStats HD ON GV.MaGV = HD.MaGV
    LEFT JOIN HuongDanStats HDan ON GV.MaGV = HDan.MaGV
    LEFT JOIN DinhMucStats DM ON GV.MaGV = DM.MaGV
    WHERE (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
    ORDER BY K.TenKhoa, BM.TenBM, GV.HoTen;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCao_XepLoaiGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 12.5. Báo cáo xếp loại giáo viên
CREATE   PROCEDURE [dbo].[sp_BaoCao_XepLoaiGiaoVien]
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH ThongKe AS (
        SELECT 
            GV.MaGV,
            GV.HoTen,
            BM.TenBM,
            K.TenKhoa,
            -- Giảng dạy
            ISNULL((
                SELECT SUM(CTGD.SoTietQuyDoi)
                FROM ChiTietGiangDay CTGD
                INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
            ), 0) AS TongGioGiangDay,
            -- NCKH
            ISNULL((
                SELECT SUM(CTNCKH.SoGio)
                FROM ChiTietNCKH CTNCKH
                INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
                WHERE CTNCKH.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
            ), 0) AS TongGioNCKH,
            -- Định mức
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
        INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    )
    SELECT 
        MaGV,
        HoTen,
        TenBM,
        TenKhoa,
        TongGioGiangDay,
        DinhMucGiangDay,
        CAST(TongGioGiangDay * 100.0 / NULLIF(DinhMucGiangDay, 0) AS DECIMAL(10,2)) AS PhanTramGiangDay,
        TongGioNCKH,
        DinhMucNCKH,
        CAST(TongGioNCKH * 100.0 / NULLIF(DinhMucNCKH, 0) AS DECIMAL(10,2)) AS PhanTramNCKH,
        CASE 
            WHEN TongGioGiangDay >= DinhMucGiangDay * 1.5 AND TongGioNCKH >= DinhMucNCKH * 1.5 THEN N'Xuất sắc'
            WHEN TongGioGiangDay >= DinhMucGiangDay * 1.2 AND TongGioNCKH >= DinhMucNCKH * 1.2 THEN N'Tốt'
            WHEN TongGioGiangDay >= DinhMucGiangDay AND TongGioNCKH >= DinhMucNCKH THEN N'Khá'
            WHEN TongGioGiangDay >= DinhMucGiangDay * 0.8 OR TongGioNCKH >= DinhMucNCKH * 0.8 THEN N'Trung bình'
            ELSE N'Yếu'
        END AS XepLoai
    FROM ThongKe
    ORDER BY 
        CASE 
            WHEN TongGioGiangDay >= DinhMucGiangDay * 1.5 AND TongGioNCKH >= DinhMucNCKH * 1.5 THEN 1
            WHEN TongGioGiangDay >= DinhMucGiangDay * 1.2 AND TongGioNCKH >= DinhMucNCKH * 1.2 THEN 2
            WHEN TongGioGiangDay >= DinhMucGiangDay AND TongGioNCKH >= DinhMucNCKH THEN 3
            WHEN TongGioGiangDay >= DinhMucGiangDay * 0.8 OR TongGioNCKH >= DinhMucNCKH * 0.8 THEN 4
            ELSE 5
        END,
        TenKhoa, TenBM, HoTen;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoChiTietGiangDayTheoGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. Báo cáo chi tiết công tác giảng dạy theo giáo viên
CREATE   PROCEDURE [dbo].[sp_BaoCaoChiTietGiangDayTheoGiaoVien]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        TGD.MaTaiGiangDay,
        TGD.TenHocPhan,
        TGD.SiSo,
        TGD.He,
        TGD.Lop,
        TGD.SoTinChi,
        TGD.NamHoc,
        CTGD.SoTiet,
        CTGD.SoTietQuyDoi,
        DT.TenDoiTuong,
        DT.HeSoQuyChuan AS HeSoDoiTuong,
        TG.TenThoiGian,
        TG.HeSoQuyChuan AS HeSoThoiGian,
        NN.TenNgonNgu,
        NN.HeSoQuyChuan AS HeSoNgonNgu,
        CTGD.GhiChu
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    INNER JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
    INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    INNER JOIN DoiTuongGiangDay DT ON TGD.MaDoiTuong = DT.MaDoiTuong
    INNER JOIN ThoiGianGiangDay TG ON TGD.MaThoiGian = TG.MaThoiGian
    INNER JOIN NgonNguGiangDay NN ON TGD.MaNgonNgu = NN.MaNgonNgu
    WHERE 
        (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    ORDER BY GV.HoTen, TGD.NamHoc, TGD.TenHocPhan;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoChiTietKhaoThiTheoGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 6. Báo cáo chi tiết công tác khảo thí theo giáo viên
CREATE   PROCEDURE [dbo].[sp_BaoCaoChiTietKhaoThiTheoGiaoVien]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        TKT.MaTaiKhaoThi,
        TKT.HocPhan,
        TKT.Lop,
        TKT.NamHoc,
        LCTKT.TenLoaiCongTacKhaoThi,
        CTKT.SoBai,
        CTKT.SoGioQuyChuan,
        TKT.GhiChu
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    INNER JOIN ChiTietTaiKhaoThi CTKT ON GV.MaGV = CTKT.MaGV
    INNER JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
    INNER JOIN LoaiCongTacKhaoThi LCTKT ON TKT.MaLoaiCongTacKhaoThi = LCTKT.MaLoaiCongTacKhaoThi
    WHERE 
        (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TKT.NamHoc = @NamHoc)
    ORDER BY GV.HoTen, TKT.NamHoc, TKT.HocPhan;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoChiTietNCKHTheoGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 5. Báo cáo chi tiết công tác NCKH theo giáo viên
CREATE   PROCEDURE [dbo].[sp_BaoCaoChiTietNCKHTheoGiaoVien]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        TNCKH.MaTaiNCKH,
        TNCKH.TenCongTrinhKhoaHoc,
        TNCKH.NamHoc,
        TNCKH.SoTacGia,
        LNCKH.TenLoaiNCKH,
        CTNCKH.VaiTro,
        CTNCKH.SoGio,
        QD.DonViTinh,
        QD.QuyRaGioChuan,
        QD.NhomCongViec
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    INNER JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
    INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    INNER JOIN LoaiNCKH LNCKH ON TNCKH.MaLoaiNCKH = LNCKH.MaLoaiNCKH
    INNER JOIN QuyDoiGioChuanNCKH QD ON LNCKH.MaQuyDoi = QD.MaQuyDoi
    WHERE 
        (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    ORDER BY GV.HoTen, TNCKH.NamHoc, TNCKH.TenCongTrinhKhoaHoc;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoDanhGiaXepLoaiGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 8. Báo cáo đánh giá xếp loại giáo viên
CREATE   PROCEDURE [dbo].[sp_BaoCaoDanhGiaXepLoaiGiaoVien]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    WITH GiaoVienStats AS (
        SELECT 
            GV.MaGV,
            GV.HoTen,
            BM.TenBM,
            K.TenKhoa,
            -- Giảng dạy
            ISNULL((
                SELECT SUM(CTGD.SoTietQuyDoi) 
                FROM ChiTietGiangDay CTGD 
                INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
            ), 0) AS TongSoTietGiangDay,
            -- NCKH
            ISNULL((
                SELECT SUM(CTNCKH.SoGio) 
                FROM ChiTietNCKH CTNCKH 
                INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
                WHERE CTNCKH.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
            ), 0) AS TongSoGioNCKH,
            -- Định mức
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM HocHam HH
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM HocHam HH
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
        INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
        WHERE 
            (@MaGV IS NULL OR GV.MaGV = @MaGV)
            AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
            AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
    )
    SELECT 
        MaGV,
        HoTen,
        TenBM,
        TenKhoa,
        TongSoTietGiangDay,
        DinhMucGiangDay,
        CAST(TongSoTietGiangDay * 100.0 / DinhMucGiangDay AS DECIMAL(10, 2)) AS PhanTramHoanThanhGiangDay,
        TongSoGioNCKH,
        DinhMucNCKH,
        CAST(TongSoGioNCKH * 100.0 / DinhMucNCKH AS DECIMAL(10, 2)) AS PhanTramHoanThanhNCKH,
        CASE 
            WHEN TongSoTietGiangDay >= DinhMucGiangDay * 1.2 AND TongSoGioNCKH >= DinhMucNCKH * 1.2 THEN N'Xuất sắc'
            WHEN TongSoTietGiangDay >= DinhMucGiangDay AND TongSoGioNCKH >= DinhMucNCKH THEN N'Tốt'
            WHEN TongSoTietGiangDay >= DinhMucGiangDay * 0.8 AND TongSoGioNCKH >= DinhMucNCKH * 0.8 THEN N'Khá'
            WHEN TongSoTietGiangDay >= DinhMucGiangDay * 0.5 AND TongSoGioNCKH >= DinhMucNCKH * 0.5 THEN N'Trung bình'
            ELSE N'Yếu'
        END AS XepLoai
    FROM GiaoVienStats
    ORDER BY TenKhoa, TenBM, HoTen;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoGiangDayTheoKhoaBoMon]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Báo cáo tổng hợp giờ giảng dạy theo khoa và bộ môn
CREATE   PROCEDURE [dbo].[sp_BaoCaoGiangDayTheoKhoaBoMon]
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Báo cáo theo khoa
    SELECT 
        K.MaKhoa,
        K.TenKhoa,
        COUNT(DISTINCT GV.MaGV) AS SoLuongGiaoVien,
        COUNT(DISTINCT TGD.MaTaiGiangDay) AS SoLuongHocPhan,
        SUM(CTGD.SoTiet) AS TongSoTiet,
        SUM(CTGD.SoTietQuyDoi) AS TongSoTietQuyDoi,
        AVG(CTGD.SoTietQuyDoi) AS TrungBinhSoTietQuyDoiMoiGiaoVien
    FROM Khoa K
    LEFT JOIN BoMon BM ON K.MaKhoa = BM.MaKhoa
    LEFT JOIN GiaoVien GV ON BM.MaBM = GV.MaBM
    LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
    LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    GROUP BY K.MaKhoa, K.TenKhoa
    ORDER BY K.TenKhoa;

    -- Báo cáo theo bộ môn
    SELECT 
        K.MaKhoa,
        K.TenKhoa,
        BM.MaBM,
        BM.TenBM,
        COUNT(DISTINCT GV.MaGV) AS SoLuongGiaoVien,
        COUNT(DISTINCT TGD.MaTaiGiangDay) AS SoLuongHocPhan,
        SUM(CTGD.SoTiet) AS TongSoTiet,
        SUM(CTGD.SoTietQuyDoi) AS TongSoTietQuyDoi,
        AVG(CTGD.SoTietQuyDoi) AS TrungBinhSoTietQuyDoiMoiGiaoVien
    FROM Khoa K
    LEFT JOIN BoMon BM ON K.MaKhoa = BM.MaKhoa
    LEFT JOIN GiaoVien GV ON BM.MaBM = GV.MaBM
    LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
    LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    GROUP BY K.MaKhoa, K.TenKhoa, BM.MaBM, BM.TenBM
    ORDER BY K.TenKhoa, BM.TenBM;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoHoanThanhDinhMucTheoKhoaBoMon]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Báo cáo thống kê hoàn thành định mức theo khoa và bộ môn
CREATE   PROCEDURE [dbo].[sp_BaoCaoHoanThanhDinhMucTheoKhoaBoMon]
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    WITH GiaoVienDinhMuc AS (
        SELECT 
            GV.MaGV,
            GV.HoTen,
            BM.MaBM,
            BM.TenBM,
            K.MaKhoa,
            K.TenKhoa,
            -- Giảng dạy
            ISNULL((
                SELECT SUM(CTGD.SoTietQuyDoi) 
                FROM ChiTietGiangDay CTGD 
                INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
            ), 0) AS TongSoTietGiangDay,
            -- NCKH
            ISNULL((
                SELECT SUM(CTNCKH.SoGio) 
                FROM ChiTietNCKH CTNCKH 
                INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
                WHERE CTNCKH.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
            ), 0) AS TongSoGioNCKH,
            -- Định mức
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM HocHam HH
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM HocHam HH
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
        INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    ),
    GiaoVienHoanThanh AS (
        SELECT 
            MaGV,
            HoTen,
            MaBM,
            TenBM,
            MaKhoa,
            TenKhoa,
            TongSoTietGiangDay,
            DinhMucGiangDay,
            CASE 
                WHEN TongSoTietGiangDay >= DinhMucGiangDay THEN 1
                ELSE 0
            END AS HoanThanhGiangDay,
            TongSoGioNCKH,
            DinhMucNCKH,
            CASE 
                WHEN TongSoGioNCKH >= DinhMucNCKH THEN 1
                ELSE 0
            END AS HoanThanhNCKH,
            CASE 
                WHEN TongSoTietGiangDay >= DinhMucGiangDay AND TongSoGioNCKH >= DinhMucNCKH THEN 1
                ELSE 0
            END AS HoanThanhTongThe
        FROM GiaoVienDinhMuc
    )

    -- Báo cáo theo khoa
    SELECT 
        MaKhoa,
        TenKhoa,
        COUNT(MaGV) AS TongSoGiaoVien,
        SUM(HoanThanhGiangDay) AS SoGVHoanThanhGiangDay,
        CAST(SUM(HoanThanhGiangDay) * 100.0 / COUNT(MaGV) AS DECIMAL(10, 2)) AS PhanTramHoanThanhGiangDay,
        SUM(HoanThanhNCKH) AS SoGVHoanThanhNCKH,
        CAST(SUM(HoanThanhNCKH) * 100.0 / COUNT(MaGV) AS DECIMAL(10, 2)) AS PhanTramHoanThanhNCKH,
        SUM(HoanThanhTongThe) AS SoGVHoanThanhTongThe,
        CAST(SUM(HoanThanhTongThe) * 100.0 / COUNT(MaGV) AS DECIMAL(10, 2)) AS PhanTramHoanThanhTongThe
    FROM GiaoVienHoanThanh
    GROUP BY MaKhoa, TenKhoa
    ORDER BY TenKhoa;

    -- Báo cáo theo bộ môn
    SELECT 
        MaKhoa,
        TenKhoa,
        MaBM,
        TenBM,
        COUNT(MaGV) AS TongSoGiaoVien,
        SUM(HoanThanhGiangDay) AS SoGVHoanThanhGiangDay,
        CAST(SUM(HoanThanhGiangDay) * 100.0 / COUNT(MaGV) AS DECIMAL(10, 2)) AS PhanTramHoanThanhGiangDay,
        SUM(HoanThanhNCKH) AS SoGVHoanThanhNCKH,
        CAST(SUM(HoanThanhNCKH) * 100.0 / COUNT(MaGV) AS DECIMAL(10, 2)) AS PhanTramHoanThanhNCKH,
        SUM(HoanThanhTongThe) AS SoGVHoanThanhTongThe,
        CAST(SUM(HoanThanhTongThe) * 100.0 / COUNT(MaGV) AS DECIMAL(10, 2)) AS PhanTramHoanThanhTongThe
    FROM GiaoVienHoanThanh
    GROUP BY MaKhoa, TenKhoa, MaBM, TenBM
    ORDER BY TenKhoa, TenBM;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoHoatDongNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 11. Procedure tiện ích: Tạo báo cáo hoạt động của người dùng
CREATE   PROCEDURE [dbo].[sp_BaoCaoHoatDongNguoiDung]
    @NgayBatDau DATE = NULL,
    @NgayKetThuc DATE = NULL,
    @MaNguoiDung NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @NgayBatDau IS NULL
        SET @NgayBatDau = DATEADD(DAY, -30, GETDATE());
    
    IF @NgayKetThuc IS NULL
        SET @NgayKetThuc = GETDATE();

    -- Thống kê số lần đăng nhập
    SELECT 
        ND.MaNguoiDung,
        ND.TenDangNhap,
        GV.HoTen AS HoTenGiaoVien,
        COUNT(LSDN.MaLichSu) AS SoLanDangNhap,
        MIN(LSDN.ThoiDiemDangNhap) AS LanDangNhapDauTien,
        MAX(LSDN.ThoiDiemDangNhap) AS LanDangNhapGanNhat,
        AVG(DATEDIFF(MINUTE, LSDN.ThoiDiemDangNhap, ISNULL(LSDN.ThoiDiemDangXuat, GETDATE()))) AS ThoiGianTrungBinhPhienDangNhap
    FROM NguoiDung ND
    LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
    LEFT JOIN LichSuDangNhap LSDN ON ND.MaNguoiDung = LSDN.MaNguoiDung
        AND CAST(LSDN.ThoiDiemDangNhap AS DATE) BETWEEN @NgayBatDau AND @NgayKetThuc
    WHERE @MaNguoiDung IS NULL OR ND.MaNguoiDung = @MaNguoiDung
    GROUP BY ND.MaNguoiDung, ND.TenDangNhap, GV.HoTen
    ORDER BY SoLanDangNhap DESC;

    -- Thống kê số thao tác thay đổi
    SELECT 
        ND.MaNguoiDung,
        ND.TenDangNhap,
        GV.HoTen AS HoTenGiaoVien,
        COUNT(NKT.MaNhatKy) AS SoLanThayDoi,
        MIN(NKT.ThoiGianThayDoi) AS ThaoTacDauTien,
        MAX(NKT.ThoiGianThayDoi) AS ThaoTacGanNhat
    FROM NguoiDung ND
    LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
    LEFT JOIN LichSuDangNhap LSDN ON ND.MaNguoiDung = LSDN.MaNguoiDung
    LEFT JOIN NhatKyThayDoi NKT ON LSDN.MaLichSu = NKT.MaLichSu
        AND CAST(NKT.ThoiGianThayDoi AS DATE) BETWEEN @NgayBatDau AND @NgayKetThuc
    WHERE @MaNguoiDung IS NULL OR ND.MaNguoiDung = @MaNguoiDung
    GROUP BY ND.MaNguoiDung, ND.TenDangNhap, GV.HoTen
    HAVING COUNT(NKT.MaNhatKy) > 0
    ORDER BY SoLanThayDoi DESC;

    -- Chi tiết thao tác thay đổi
    SELECT 
        ND.MaNguoiDung,
        ND.TenDangNhap,
        GV.HoTen AS HoTenGiaoVien,
        LSDN.MaLichSu,
        LSDN.ThoiDiemDangNhap,
        NKT.MaNhatKy,
        NKT.ThoiGianThayDoi,
        NKT.NoiDungThayDoi,
        NKT.ThongTinCu,
        NKT.ThongTinMoi
    FROM NguoiDung ND
    LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
    INNER JOIN LichSuDangNhap LSDN ON ND.MaNguoiDung = LSDN.MaNguoiDung
    INNER JOIN NhatKyThayDoi NKT ON LSDN.MaLichSu = NKT.MaLichSu
    WHERE (@MaNguoiDung IS NULL OR ND.MaNguoiDung = @MaNguoiDung)
        AND CAST(NKT.ThoiGianThayDoi AS DATE) BETWEEN @NgayBatDau AND @NgayKetThuc
    ORDER BY NKT.ThoiGianThayDoi DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoNCKHTheoKhoaBoMon]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Báo cáo tổng hợp giờ NCKH theo khoa và bộ môn
CREATE   PROCEDURE [dbo].[sp_BaoCaoNCKHTheoKhoaBoMon]
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Báo cáo theo khoa
    SELECT 
        K.MaKhoa,
        K.TenKhoa,
        COUNT(DISTINCT GV.MaGV) AS SoLuongGiaoVien,
        COUNT(DISTINCT TNCKH.MaTaiNCKH) AS SoLuongCongTrinh,
        SUM(CTNCKH.SoGio) AS TongSoGio,
        AVG(CTNCKH.SoGio) AS TrungBinhSoGioMoiGiaoVien
    FROM Khoa K
    LEFT JOIN BoMon BM ON K.MaKhoa = BM.MaKhoa
    LEFT JOIN GiaoVien GV ON BM.MaBM = GV.MaBM
    LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
    LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    WHERE (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    GROUP BY K.MaKhoa, K.TenKhoa
    ORDER BY K.TenKhoa;

    -- Báo cáo theo bộ môn
    SELECT 
        K.MaKhoa,
        K.TenKhoa,
        BM.MaBM,
        BM.TenBM,
        COUNT(DISTINCT GV.MaGV) AS SoLuongGiaoVien,
        COUNT(DISTINCT TNCKH.MaTaiNCKH) AS SoLuongCongTrinh,
        SUM(CTNCKH.SoGio) AS TongSoGio,
        AVG(CTNCKH.SoGio) AS TrungBinhSoGioMoiGiaoVien
    FROM Khoa K
    LEFT JOIN BoMon BM ON K.MaKhoa = BM.MaKhoa
    LEFT JOIN GiaoVien GV ON BM.MaBM = GV.MaBM
    LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
    LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    WHERE (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    GROUP BY K.MaKhoa, K.TenKhoa, BM.MaBM, BM.TenBM
    ORDER BY K.TenKhoa, BM.TenBM;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoTongHopToanDienTheoGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 7. Báo cáo tổng hợp toàn diện theo giáo viên
CREATE   PROCEDURE [dbo].[sp_BaoCaoTongHopToanDienTheoGiaoVien]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    WITH GiangDayStats AS (
        SELECT 
            GV.MaGV,
            SUM(CTGD.SoTiet) AS TongSoTiet,
            SUM(CTGD.SoTietQuyDoi) AS TongSoTietQuyDoi,
            COUNT(DISTINCT TGD.MaTaiGiangDay) AS SoLuongHocPhan
        FROM GiaoVien GV
        LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
        LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    NCKHStats AS (
        SELECT 
            GV.MaGV,
            SUM(CTNCKH.SoGio) AS TongSoGioNCKH,
            COUNT(DISTINCT TNCKH.MaTaiNCKH) AS SoLuongCongTrinh
        FROM GiaoVien GV
        LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
        LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        WHERE (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    KhaoThiStats AS (
        SELECT 
            GV.MaGV,
            SUM(CTKT.SoBai) AS TongSoBai,
            SUM(CTKT.SoGioQuyChuan) AS TongSoGioKhaoThi,
            COUNT(DISTINCT TKT.MaTaiKhaoThi) AS SoLuongCongTacKhaoThi
        FROM GiaoVien GV
        LEFT JOIN ChiTietTaiKhaoThi CTKT ON GV.MaGV = CTKT.MaGV
        LEFT JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
        WHERE (@NamHoc IS NULL OR TKT.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    HoiDongStats AS (
        SELECT 
            GV.MaGV,
            SUM(TG.SoGio) AS TongSoGioHoiDong,
            COUNT(DISTINCT THD.MaHoiDong) AS SoLuongHoiDong
        FROM GiaoVien GV
        LEFT JOIN ThamGia TG ON GV.MaGV = TG.MaGV
        LEFT JOIN TaiHoiDong THD ON TG.MaHoiDong = THD.MaHoiDong
        WHERE (@NamHoc IS NULL OR THD.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    HuongDanStats AS (
        SELECT 
            GV.MaGV,
            SUM(TGHD.SoGio) AS TongSoGioHuongDan,
            COUNT(DISTINCT THD.MaHuongDan) AS SoLuongHocVienHuongDan
        FROM GiaoVien GV
        LEFT JOIN ThamGiaHuongDan TGHD ON GV.MaGV = TGHD.MaGV
        LEFT JOIN TaiHuongDan THD ON TGHD.MaHuongDan = THD.MaHuongDan
        WHERE (@NamHoc IS NULL OR THD.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    DinhMucStats AS (
        SELECT 
            GV.MaGV,
            -- Định mức giảng dạy
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM HocHam HH
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            -- Định mức NCKH
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM HocHam HH
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
        GROUP BY GV.MaGV
    )
    SELECT 
        GV.MaGV,
        GV.HoTen,
        GV.NgaySinh,
        CASE GV.GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
        GV.Email,
        BM.TenBM,
        K.TenKhoa,
        -- Học vị cao nhất
        (
            SELECT TOP 1 HV.TenHocVi
            FROM HocVi HV
            WHERE HV.MaGV = GV.MaGV
            ORDER BY HV.NgayNhan DESC
        ) AS HocViCaoNhat,
        -- Học hàm cao nhất
        (
            SELECT TOP 1 LSHH.TenHocHam
            FROM LichSuHocHam LSHH
            WHERE LSHH.MaGV = GV.MaGV
            ORDER BY LSHH.NgayNhan DESC
        ) AS HocHamCaoNhat,
        -- Chức vụ hiện tại
        (
            SELECT TOP 1 CV.TenChucVu
            FROM LichSuChucVu LSCV
            INNER JOIN ChucVu CV ON LSCV.MaChucVu = CV.MaChucVu
            WHERE LSCV.MaGV = GV.MaGV AND (LSCV.NgayKetThuc IS NULL OR LSCV.NgayKetThuc > GETDATE())
            ORDER BY LSCV.NgayNhan DESC
        ) AS ChucVuHienTai,
        -- Thông tin giảng dạy
        ISNULL(GD.TongSoTiet, 0) AS TongSoTiet,
        ISNULL(GD.TongSoTietQuyDoi, 0) AS TongSoTietQuyDoi,
        ISNULL(GD.SoLuongHocPhan, 0) AS SoLuongHocPhan,
        DM.DinhMucGiangDay,
        CAST(ISNULL(GD.TongSoTietQuyDoi, 0) * 100.0 / DM.DinhMucGiangDay AS DECIMAL(10, 2)) AS PhanTramHoanThanhGiangDay,
        -- Thông tin NCKH
        ISNULL(NC.TongSoGioNCKH, 0) AS TongSoGioNCKH,
        ISNULL(NC.SoLuongCongTrinh, 0) AS SoLuongCongTrinh,
        DM.DinhMucNCKH,
        CAST(ISNULL(NC.TongSoGioNCKH, 0) * 100.0 / DM.DinhMucNCKH AS DECIMAL(10, 2)) AS PhanTramHoanThanhNCKH,
        -- Thông tin khảo thí
        ISNULL(KT.TongSoBai, 0) AS TongSoBaiKhaoThi,
        ISNULL(KT.TongSoGioKhaoThi, 0) AS TongSoGioKhaoThi,
        ISNULL(KT.SoLuongCongTacKhaoThi, 0) AS SoLuongCongTacKhaoThi,
        -- Thông tin hội đồng
        ISNULL(HD.TongSoGioHoiDong, 0) AS TongSoGioHoiDong,
        ISNULL(HD.SoLuongHoiDong, 0) AS SoLuongHoiDong,
        -- Thông tin hướng dẫn
        ISNULL(HDan.TongSoGioHuongDan, 0) AS TongSoGioHuongDan,
        ISNULL(HDan.SoLuongHocVienHuongDan, 0) AS SoLuongHocVienHuongDan,
        -- Tổng hợp
        ISNULL(GD.TongSoTietQuyDoi, 0) + ISNULL(NC.TongSoGioNCKH, 0) + ISNULL(KT.TongSoGioKhaoThi, 0) + 
        ISNULL(HD.TongSoGioHoiDong, 0) + ISNULL(HDan.TongSoGioHuongDan, 0) AS TongSoGioQuyChuan,
        CASE 
            WHEN ISNULL(GD.TongSoTietQuyDoi, 0) >= DM.DinhMucGiangDay AND ISNULL(NC.TongSoGioNCKH, 0) >= DM.DinhMucNCKH THEN N'Đạt'
            ELSE N'Chưa đạt'
        END AS TrangThaiHoanThanhDinhMuc
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN GiangDayStats GD ON GV.MaGV = GD.MaGV
    LEFT JOIN NCKHStats NC ON GV.MaGV = NC.MaGV
    LEFT JOIN KhaoThiStats KT ON GV.MaGV = KT.MaGV
    LEFT JOIN HoiDongStats HD ON GV.MaGV = HD.MaGV
    LEFT JOIN HuongDanStats HDan ON GV.MaGV = HDan.MaGV
    LEFT JOIN DinhMucStats DM ON GV.MaGV = DM.MaGV
    WHERE 
        (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
    ORDER BY K.TenKhoa, BM.TenBM, GV.HoTen;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BaoCaoTongQuatDatabase]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10. Procedure tiện ích: Tạo báo cáo tổng quát về database
CREATE   PROCEDURE [dbo].[sp_BaoCaoTongQuatDatabase]
AS
BEGIN
    SET NOCOUNT ON;

    -- Thống kê số lượng bản ghi
    SELECT 'SoLuongGiaoVien' AS ThongKe, COUNT(*) AS SoLuong FROM GiaoVien
    UNION ALL
    SELECT 'SoLuongKhoa', COUNT(*) FROM Khoa
    UNION ALL
    SELECT 'SoLuongBoMon', COUNT(*) FROM BoMon
    UNION ALL
    SELECT 'SoLuongNguoiDung', COUNT(*) FROM NguoiDung
    UNION ALL
    SELECT 'SoLuongTaiGiangDay', COUNT(*) FROM TaiGiangDay
    UNION ALL
    SELECT 'SoLuongChiTietGiangDay', COUNT(*) FROM ChiTietGiangDay
    UNION ALL
    SELECT 'SoLuongTaiNCKH', COUNT(*) FROM TaiNCKH
    UNION ALL
    SELECT 'SoLuongChiTietNCKH', COUNT(*) FROM ChiTietNCKH
    UNION ALL
    SELECT 'SoLuongTaiKhaoThi', COUNT(*) FROM TaiKhaoThi
    UNION ALL
    SELECT 'SoLuongChiTietTaiKhaoThi', COUNT(*) FROM ChiTietTaiKhaoThi;

    -- Thống kê giáo viên theo khoa và bộ môn
    SELECT 
        K.MaKhoa,
        K.TenKhoa,
        BM.MaBM,
        BM.TenBM,
        COUNT(GV.MaGV) AS SoLuongGiaoVien
    FROM Khoa K
    LEFT JOIN BoMon BM ON K.MaKhoa = BM.MaKhoa
    LEFT JOIN GiaoVien GV ON BM.MaBM = GV.MaBM
    GROUP BY K.MaKhoa, K.TenKhoa, BM.MaBM, BM.TenBM
    ORDER BY K.TenKhoa, BM.TenBM;

    -- Thống kê giáo viên theo học vị
    SELECT 
        HV.TenHocVi,
        COUNT(DISTINCT GV.MaGV) AS SoLuongGiaoVien
    FROM HocVi HV
    INNER JOIN GiaoVien GV ON HV.MaGV = GV.MaGV
    GROUP BY HV.TenHocVi
    ORDER BY HV.TenHocVi;

    -- Thống kê giáo viên theo học hàm
    SELECT 
        HH.TenHocHam,
        COUNT(DISTINCT LSHH.MaGV) AS SoLuongGiaoVien
    FROM HocHam HH
    INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
    WHERE LSHH.NgayNhan = (
        SELECT MAX(LSHH2.NgayNhan)
        FROM LichSuHocHam LSHH2
        WHERE LSHH2.MaGV = LSHH.MaGV
    )
    GROUP BY HH.TenHocHam
    ORDER BY HH.TenHocHam;

    -- Thống kê số lượng tài khoản theo nhóm
    SELECT 
        NND.TenNhom,
        COUNT(DISTINCT NDN.MaNguoiDung) AS SoLuongTaiKhoan
    FROM NhomNguoiDung NND
    LEFT JOIN NguoiDung_Nhom NDN ON NND.MaNhom = NDN.MaNhom
    GROUP BY NND.TenNhom
    ORDER BY NND.TenNhom;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_BoMon_ThemMoi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.4. Thêm mới bộ môn
CREATE   PROCEDURE [dbo].[sp_BoMon_ThemMoi]
    @TenBM NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaKhoa CHAR(15),
    @MaChuNhiemBM CHAR(15) = NULL,
    @MaBM CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50060, N'Mã khoa không tồn tại', 1;
            
        IF EXISTS (SELECT 1 FROM BoMon WHERE TenBM = @TenBM AND MaKhoa = @MaKhoa)
            THROW 50061, N'Tên bộ môn đã tồn tại trong khoa', 1;
            
        IF @MaChuNhiemBM IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemBM)
            THROW 50062, N'Mã chủ nhiệm bộ môn không tồn tại', 1;
        
        -- Generate MaBM
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM BoMon;
        SET @MaBM = 'BM' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO BoMon (MaBM, TenBM, DiaChi, MaKhoa, MaChuNhiemBM)
        VALUES (@MaBM, @TenBM, @DiaChi, @MaKhoa, @MaChuNhiemBM);
        
        -- Update ChucVu if needed
        IF @MaChuNhiemBM IS NOT NULL
        BEGIN
            EXEC sp_ChucVu_PhanCong @MaChuNhiemBM, 'CV005', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Thêm bộ môn thành công. Mã bộ môn: ' + @MaBM;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaBM = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CapQuyenChoNhom]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 12. Cấp quyền cho nhóm
CREATE   PROCEDURE [dbo].[sp_CapQuyenChoNhom]
    @MaNhom NVARCHAR(50),
    @MaQuyen NVARCHAR(50),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaNhom IS NULL OR LTRIM(RTRIM(@MaNhom)) = ''
        BEGIN
            THROW 70111, N'Mã nhóm không được để trống.', 1;
        END

        IF @MaQuyen IS NULL OR LTRIM(RTRIM(@MaQuyen)) = ''
        BEGIN
            THROW 70112, N'Mã quyền không được để trống.', 1;
        END

        -- Check if NhomNguoiDung exists
        IF NOT EXISTS (SELECT 1 FROM NhomNguoiDung WITH (UPDLOCK) WHERE MaNhom = @MaNhom)
        BEGIN
            THROW 70113, N'Mã nhóm không tồn tại.', 1;
        END

        -- Check if Quyen exists
        IF NOT EXISTS (SELECT 1 FROM Quyen WITH (UPDLOCK) WHERE MaQuyen = @MaQuyen)
        BEGIN
            THROW 70114, N'Mã quyền không tồn tại.', 1;
        END

        -- Check if the permission is already assigned to the group
        IF EXISTS (SELECT 1 FROM Nhom_Quyen WHERE MaNhom = @MaNhom AND MaQuyen = @MaQuyen)
        BEGIN
            THROW 70115, N'Quyền đã được cấp cho nhóm này.', 1;
        END

        -- Insert the new record
        INSERT INTO Nhom_Quyen (MaNhom, MaQuyen)
        VALUES (@MaNhom, @MaQuyen);

        -- Set success message
        SET @ErrorMessage = N'Cấp quyền cho nhóm thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi cấp quyền cho nhóm: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ChucVu_KetThuc]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 9.2. Kết thúc chức vụ
CREATE   PROCEDURE [dbo].[sp_ChucVu_KetThuc]
    @MaGV CHAR(15),
    @MaChucVu CHAR(15),
    @NgayKetThuc DATE = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @NgayKetThuc IS NULL
            SET @NgayKetThuc = GETDATE();
        
        -- Update
        UPDATE LichSuChucVu
        SET NgayKetThuc = @NgayKetThuc
        WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL;
        
        IF @@ROWCOUNT = 0
            THROW 50200, N'Không tìm thấy chức vụ đang hoạt động', 1;
        
        SET @ErrorMessage = N'Kết thúc chức vụ thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ChucVu_PhanCong]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 9: QUẢN LÝ CHỨC VỤ
-- =============================================

-- 9.1. Phân công chức vụ
CREATE   PROCEDURE [dbo].[sp_ChucVu_PhanCong]
    @MaGV CHAR(15),
    @MaChucVu CHAR(15),
    @NgayNhan DATE = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50190, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM ChucVu WHERE MaChucVu = @MaChucVu)
            THROW 50191, N'Mã chức vụ không tồn tại', 1;
            
        IF @NgayNhan IS NULL
            SET @NgayNhan = GETDATE();
        
        -- Check if already has this position
        IF EXISTS (
            SELECT 1 FROM LichSuChucVu 
            WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL
        )
            THROW 50192, N'Giáo viên đang giữ chức vụ này', 1;
        
        -- Generate MaLichSuChucVu
        DECLARE @MaLichSuChucVu CHAR(15);
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuChucVu;
        SET @MaLichSuChucVu = 'LSCV' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO LichSuChucVu (MaLichSuChucVu, NgayNhan, NgayKetThuc, MaGV, MaChucVu)
        VALUES (@MaLichSuChucVu, @NgayNhan, NULL, @MaGV, @MaChucVu);
        
        SET @ErrorMessage = N'Phân công chức vụ thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DangNhap]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 14. Đăng nhập
CREATE   PROCEDURE [dbo].[sp_DangNhap]
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaLichSu NVARCHAR(50) OUTPUT,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaNguoiDung NVARCHAR(50);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @TenDangNhap IS NULL OR LTRIM(RTRIM(@TenDangNhap)) = ''
        BEGIN
            THROW 70131, N'Tên đăng nhập không được để trống.', 1;
        END

        IF @MatKhau IS NULL OR LTRIM(RTRIM(@MatKhau)) = ''
        BEGIN
            THROW 70132, N'Mật khẩu không được để trống.', 1;
        END

        -- Check if TenDangNhap exists and password matches
        SELECT @MaNguoiDung = MaNguoiDung
        FROM NguoiDung WITH (UPDLOCK)
        WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau; -- Replace with proper hashing check in production

        IF @MaNguoiDung IS NULL
        BEGIN
            THROW 70133, N'Tên đăng nhập hoặc mật khẩu không đúng.', 1;
        END

        -- Generate a new MaLichSu
        SELECT @MaLichSu = 'LS' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM LichSuDangNhap;

        -- Insert the new login record
        INSERT INTO LichSuDangNhap (MaLichSu, ThoiDiemDangNhap, ThoiDiemDangXuat, MaNguoiDung)
        VALUES (@MaLichSu, GETDATE(), NULL, @MaNguoiDung);

        -- Set success message
        SET @ErrorMessage = N'Đăng nhập thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi đăng nhập: ' + ERROR_MESSAGE();
        SET @MaLichSu = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DangXuat]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 15. Đăng xuất
CREATE   PROCEDURE [dbo].[sp_DangXuat]
    @MaLichSu NVARCHAR(50),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaLichSu IS NULL OR LTRIM(RTRIM(@MaLichSu)) = ''
        BEGIN
            THROW 70141, N'Mã lịch sử không được để trống.', 1;
        END

        -- Check if MaLichSu exists
        IF NOT EXISTS (SELECT 1 FROM LichSuDangNhap WITH (UPDLOCK) WHERE MaLichSu = @MaLichSu)
        BEGIN
            THROW 70142, N'Mã lịch sử không tồn tại.', 1;
        END

        -- Check if already logged out
        IF EXISTS (SELECT 1 FROM LichSuDangNhap WHERE MaLichSu = @MaLichSu AND ThoiDiemDangXuat IS NOT NULL)
        BEGIN
            THROW 70143, N'Phiên đăng nhập này đã được đăng xuất.', 1;
        END

        -- Update the logout time
        UPDATE LichSuDangNhap
        SET ThoiDiemDangXuat = GETDATE()
        WHERE MaLichSu = @MaLichSu;

        -- Set success message
        SET @ErrorMessage = N'Đăng xuất thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi đăng xuất: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Dashboard_GiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 13.2. Dashboard cho giáo viên
CREATE   PROCEDURE [dbo].[sp_Dashboard_GiaoVien]
    @MaGV CHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Thông tin cá nhân
    SELECT 
        GV.MaGV,
        GV.HoTen,
        GV.NgaySinh,
        CASE GV.GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
        GV.Email,
        GV.SDT,
        BM.TenBM,
        K.TenKhoa,
        (SELECT TOP 1 TenHocVi FROM HocVi WHERE MaGV = GV.MaGV ORDER BY NgayNhan DESC) AS HocViCaoNhat,
        (SELECT TOP 1 TenHocHam FROM LichSuHocHam WHERE MaGV = GV.MaGV ORDER BY NgayNhan DESC) AS HocHamCaoNhat,
        (SELECT TOP 1 CV.TenChucVu 
         FROM LichSuChucVu LSCV 
         INNER JOIN ChucVu CV ON LSCV.MaChucVu = CV.MaChucVu
         WHERE LSCV.MaGV = GV.MaGV AND LSCV.NgayKetThuc IS NULL
         ORDER BY LSCV.NgayNhan DESC) AS ChucVuHienTai
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    WHERE GV.MaGV = @MaGV;
    
    -- Thống kê khối lượng năm hiện tại
    DECLARE @NamHocHienTai NVARCHAR(20);
    SELECT TOP 1 @NamHocHienTai = NamHoc FROM TaiGiangDay ORDER BY NamHoc DESC;
    
    SELECT 
        ISNULL((
            SELECT SUM(CTGD.SoTietQuyDoi)
            FROM ChiTietGiangDay CTGD
            INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
            WHERE CTGD.MaGV = @MaGV AND TGD.NamHoc = @NamHocHienTai
        ), 0) AS TongGioGiangDay,
        ISNULL((
            SELECT SUM(CTNCKH.SoGio)
            FROM ChiTietNCKH CTNCKH
            INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
            WHERE CTNCKH.MaGV = @MaGV AND TNCKH.NamHoc = @NamHocHienTai
        ), 0) AS TongGioNCKH,
        ISNULL((
            SELECT SUM(CTKT.SoGioQuyChuan)
            FROM ChiTietTaiKhaoThi CTKT
            INNER JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
            WHERE CTKT.MaGV = @MaGV AND TKT.NamHoc = @NamHocHienTai
        ), 0) AS TongGioKhaoThi,
        ISNULL((
            SELECT SUM(TG.SoGio)
            FROM ThamGia TG
            INNER JOIN TaiHoiDong THD ON TG.MaHoiDong = THD.MaHoiDong
            WHERE TG.MaGV = @MaGV AND THD.NamHoc = @NamHocHienTai
        ), 0) AS TongGioHoiDong,
        ISNULL((
            SELECT SUM(TGHD.SoGio)
            FROM ThamGiaHuongDan TGHD
            INNER JOIN TaiHuongDan THD ON TGHD.MaHuongDan = THD.MaHuongDan
            WHERE TGHD.MaGV = @MaGV AND THD.NamHoc = @NamHocHienTai
        ), 0) AS TongGioHuongDan;
    
    -- Danh sách học phần đang giảng dạy
    SELECT 
        TGD.TenHocPhan,
        TGD.Lop,
        TGD.SoTinChi,
        CTGD.SoTiet,
        CTGD.SoTietQuyDoi
    FROM ChiTietGiangDay CTGD
    INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE CTGD.MaGV = @MaGV AND TGD.NamHoc = @NamHocHienTai
    ORDER BY TGD.TenHocPhan;
    
    -- Danh sách công trình NCKH
    SELECT 
        TNCKH.TenCongTrinhKhoaHoc,
        LNCKH.TenLoaiNCKH,
        CTNCKH.VaiTro,
        CTNCKH.SoGio
    FROM ChiTietNCKH CTNCKH
    INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    INNER JOIN LoaiNCKH LNCKH ON TNCKH.MaLoaiNCKH = LNCKH.MaLoaiNCKH
    WHERE CTNCKH.MaGV = @MaGV AND TNCKH.NamHoc = @NamHocHienTai
    ORDER BY TNCKH.TenCongTrinhKhoaHoc;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Dashboard_TongQuan]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 13: DASHBOARD VÀ TỔNG QUAN
-- =============================================

-- 13.1. Dashboard tổng quan
CREATE   PROCEDURE [dbo].[sp_Dashboard_TongQuan]
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Thống kê tổng quan
    SELECT 
        (SELECT COUNT(*) FROM GiaoVien) AS TongGiaoVien,
        (SELECT COUNT(*) FROM Khoa) AS TongKhoa,
        (SELECT COUNT(*) FROM BoMon) AS TongBoMon,
        (SELECT COUNT(*) FROM NguoiDung) AS TongNguoiDung;
    
    -- Thống kê giáo viên theo học vị
    SELECT 
        HV.TenHocVi,
        COUNT(DISTINCT HV.MaGV) AS SoLuong
    FROM HocVi HV
    GROUP BY HV.TenHocVi
    ORDER BY SoLuong DESC;
    
    -- Thống kê giáo viên theo học hàm
    SELECT 
        LSHH.TenHocHam,
        COUNT(DISTINCT LSHH.MaGV) AS SoLuong
    FROM LichSuHocHam LSHH
    WHERE LSHH.NgayNhan = (
        SELECT MAX(LSHH2.NgayNhan)
        FROM LichSuHocHam LSHH2
        WHERE LSHH2.MaGV = LSHH.MaGV
    )
    GROUP BY LSHH.TenHocHam
    ORDER BY SoLuong DESC;
    
    -- Top 10 giáo viên giảng dạy nhiều nhất năm hiện tại
    SELECT TOP 10
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        SUM(CTGD.SoTietQuyDoi) AS TongGioGiangDay
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
    INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE TGD.NamHoc = (SELECT TOP 1 NamHoc FROM TaiGiangDay ORDER BY NamHoc DESC)
    GROUP BY GV.MaGV, GV.HoTen, BM.TenBM
    ORDER BY TongGioGiangDay DESC;
    
    -- Top 10 giáo viên NCKH nhiều nhất năm hiện tại
    SELECT TOP 10
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        COUNT(DISTINCT TNCKH.MaTaiNCKH) AS SoCongTrinh,
        SUM(CTNCKH.SoGio) AS TongGioNCKH
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
    INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    WHERE TNCKH.NamHoc = (SELECT TOP 1 NamHoc FROM TaiNCKH ORDER BY NamHoc DESC)
    GROUP BY GV.MaGV, GV.HoTen, BM.TenBM
    ORDER BY TongGioNCKH DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DinhMuc_TinhToan]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 16.2. Tính toán định mức thực tế
CREATE   PROCEDURE [dbo].[sp_DinhMuc_TinhToan]
    @MaGV CHAR(15),
    @DinhMucGiangDay INT OUTPUT,
    @DinhMucNCKH INT OUTPUT,
    @TyLeMienGiam FLOAT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Get base quotas
    SELECT 
        @DinhMucGiangDay = ISNULL((
            SELECT TOP 1 DMGD.DinhMucGiangDay
            FROM LichSuHocHam LSHH
            INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
            INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
            WHERE LSHH.MaGV = @MaGV
            ORDER BY LSHH.NgayNhan DESC
        ), 320),
        @DinhMucNCKH = ISNULL((
            SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
            FROM LichSuHocHam LSHH
            INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
            INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
            WHERE LSHH.MaGV = @MaGV
            ORDER BY LSHH.NgayNhan DESC
        ), 300);
    
    -- Get reduction rate
    SET @TyLeMienGiam = ISNULL((
        SELECT TOP 1 DMMG.TyLeMienGiam
        FROM LichSuChucVu LSCV
        INNER JOIN ChucVu CV ON LSCV.MaChucVu = CV.MaChucVu
        INNER JOIN DinhMucMienGiam DMMG ON CV.MaDinhMucMienGiam = DMMG.MaDinhMucMienGiam
        WHERE LSCV.MaGV = @MaGV AND LSCV.NgayKetThuc IS NULL
        ORDER BY DMMG.TyLeMienGiam DESC
    ), 0);
    
    -- Apply reduction
    SET @DinhMucGiangDay = @DinhMucGiangDay * (1 - @TyLeMienGiam);
    SET @DinhMucNCKH = @DinhMucNCKH * (1 - @TyLeMienGiam);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DinhMucMienGiam_CapNhat]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 16: ĐỊNH MỨC VÀ MIỄN GIẢM
-- =============================================

-- 16.1. Cập nhật định mức miễn giảm
CREATE   PROCEDURE [dbo].[sp_DinhMucMienGiam_CapNhat]
    @MaChucVu CHAR(15),
    @MaDinhMucMienGiam CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM ChucVu WHERE MaChucVu = @MaChucVu)
            THROW 50270, N'Mã chức vụ không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM DinhMucMienGiam WHERE MaDinhMucMienGiam = @MaDinhMucMienGiam)
            THROW 50271, N'Mã định mức miễn giảm không tồn tại', 1;
        
        -- Update
        UPDATE ChucVu
        SET MaDinhMucMienGiam = @MaDinhMucMienGiam
        WHERE MaChucVu = @MaChucVu;
        
        SET @ErrorMessage = N'Cập nhật định mức miễn giảm thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ExportCSV]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 13. Procedure tiện ích: Export dữ liệu ra dạng CSV
CREATE   PROCEDURE [dbo].[sp_ExportCSV]
    @TableName NVARCHAR(100),
    @WhereClause NVARCHAR(MAX) = NULL,
    @OrderByClause NVARCHAR(MAX) = NULL,
    @CSV NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @ColumnNames NVARCHAR(MAX) = '';
    DECLARE @ColumnList NVARCHAR(MAX) = '';

    -- Lấy danh sách các cột
    SELECT 
        @ColumnNames = @ColumnNames + QUOTENAME(c.name) + ', ',
        @ColumnList = @ColumnList + 'ISNULL(CAST(' + QUOTENAME(c.name) + ' AS NVARCHAR(MAX)), '''') + '';'' + '
    FROM sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
    WHERE t.name = @TableName
    ORDER BY c.column_id;

    -- Xóa dấu phẩy cuối cùng
    SET @ColumnNames = LEFT(@ColumnNames, LEN(@ColumnNames) - 1);
    SET @ColumnList = LEFT(@ColumnList, LEN(@ColumnList) - 10);

    -- Tạo tiêu đề
    SET @CSV = @ColumnNames + CHAR(13) + CHAR(10);

    -- Tạo câu lệnh SQL để lấy dữ liệu
    SET @SQL = 'SELECT @CSV = @CSV + ' + @ColumnList + ' + CHAR(13) + CHAR(10) FROM ' + QUOTENAME(@TableName);
    
    -- Thêm điều kiện WHERE nếu có
    IF @WhereClause IS NOT NULL AND LEN(@WhereClause) > 0
        SET @SQL = @SQL + ' WHERE ' + @WhereClause;
    
    -- Thêm sắp xếp nếu có
    IF @OrderByClause IS NOT NULL AND LEN(@OrderByClause) > 0
        SET @SQL = @SQL + ' ORDER BY ' + @OrderByClause;

    -- Thực thi câu lệnh SQL
    EXEC sp_executesql @SQL, N'@CSV NVARCHAR(MAX) OUTPUT', @CSV OUTPUT;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GhiNhatKyThayDoi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 17. Ghi nhật ký thay đổi
CREATE   PROCEDURE [dbo].[sp_GhiNhatKyThayDoi]
    @MaLichSu NVARCHAR(50),
    @NoiDungThayDoi NVARCHAR(255),
    @ThongTinCu NVARCHAR(255),
    @ThongTinMoi NVARCHAR(255),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaNhatKy NVARCHAR(50);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaLichSu IS NULL OR LTRIM(RTRIM(@MaLichSu)) = ''
        BEGIN
            THROW 70151, N'Mã lịch sử không được để trống.', 1;
        END

        IF @NoiDungThayDoi IS NULL OR LTRIM(RTRIM(@NoiDungThayDoi)) = ''
        BEGIN
            THROW 70152, N'Nội dung thay đổi không được để trống.', 1;
        END

        -- Check if MaLichSu exists
        IF NOT EXISTS (SELECT 1 FROM LichSuDangNhap WITH (UPDLOCK) WHERE MaLichSu = @MaLichSu)
        BEGIN
            THROW 70153, N'Mã lịch sử không tồn tại.', 1;
        END

        -- Generate a new MaNhatKy
        SELECT @MaNhatKy = 'NK' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM NhatKyThayDoi;

        -- Insert the new record
        INSERT INTO NhatKyThayDoi (MaNhatKy, MaLichSu, ThoiGianThayDoi, NoiDungThayDoi, ThongTinCu, ThongTinMoi)
        VALUES (@MaNhatKy, @MaLichSu, GETDATE(), @NoiDungThayDoi, @ThongTinCu, @ThongTinMoi);

        -- Set success message
        SET @ErrorMessage = N'Ghi nhật ký thay đổi thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi ghi nhật ký thay đổi: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GiangDay_KiemTraLichTrung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3.3. Kiểm tra lịch trùng giảng dạy
CREATE   PROCEDURE [dbo].[sp_GiangDay_KiemTraLichTrung]
    @MaGV CHAR(15),
    @MaThoiGian CHAR(15),
    @NamHoc NVARCHAR(20),
    @HasConflict BIT OUTPUT,
    @ConflictDetails NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SET @HasConflict = 0;
    SET @ConflictDetails = '';
    
    IF EXISTS (
        SELECT 1 FROM ChiTietGiangDay CTGD
        INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE CTGD.MaGV = @MaGV 
            AND TGD.MaThoiGian = @MaThoiGian 
            AND TGD.NamHoc = @NamHoc
    )
    BEGIN
        SET @HasConflict = 1;
        
        SELECT @ConflictDetails = STRING_AGG(
            TGD.TenHocPhan + ' - ' + TGD.Lop + ' (' + CAST(CTGD.SoTiet AS NVARCHAR(10)) + ' tiết)', 
            '; '
        )
        FROM ChiTietGiangDay CTGD
        INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE CTGD.MaGV = @MaGV 
            AND TGD.MaThoiGian = @MaThoiGian 
            AND TGD.NamHoc = @NamHoc;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GiangDay_PhanCong]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3.2. Phân công giảng dạy với kiểm tra lịch trùng
CREATE   PROCEDURE [dbo].[sp_GiangDay_PhanCong]
    @MaGV CHAR(15),
    @MaTaiGiangDay CHAR(15),
    @SoTiet INT,
    @GhiChu NVARCHAR(200),
    @MaNoiDungGiangDay CHAR(15),
    @CheckConflict BIT = 1,
    @MaChiTietGiangDay CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50080, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiGiangDay WHERE MaTaiGiangDay = @MaTaiGiangDay)
            THROW 50081, N'Mã tài giảng dạy không tồn tại', 1;
            
        IF @SoTiet <= 0 OR @SoTiet > 200
            THROW 50082, N'Số tiết không hợp lệ (1-200)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WHERE MaGV = @MaGV AND MaTaiGiangDay = @MaTaiGiangDay)
            THROW 50083, N'Giáo viên đã được phân công cho học phần này', 1;
        
        -- Check schedule conflict
        IF @CheckConflict = 1
        BEGIN
            DECLARE @MaThoiGian CHAR(15), @NamHoc NVARCHAR(20);
            SELECT @MaThoiGian = MaThoiGian, @NamHoc = NamHoc 
            FROM TaiGiangDay WHERE MaTaiGiangDay = @MaTaiGiangDay;
            
            IF EXISTS (
                SELECT 1 FROM ChiTietGiangDay CTGD
                INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = @MaGV 
                    AND TGD.MaThoiGian = @MaThoiGian 
                    AND TGD.NamHoc = @NamHoc
                    AND TGD.MaTaiGiangDay != @MaTaiGiangDay
            )
                THROW 50084, N'Giáo viên có lịch trùng trong thời gian này', 1;
        END
        
        -- Calculate SoTietQuyDoi
        DECLARE @HeSoDoiTuong FLOAT = 1, @HeSoThoiGian FLOAT = 1, @HeSoNgonNgu FLOAT = 1;
        
        SELECT 
            @HeSoDoiTuong = DT.HeSoQuyChuan,
            @HeSoThoiGian = TG.HeSoQuyChuan,
            @HeSoNgonNgu = NN.HeSoQuyChuan
        FROM TaiGiangDay TGD
        INNER JOIN DoiTuongGiangDay DT ON TGD.MaDoiTuong = DT.MaDoiTuong
        INNER JOIN ThoiGianGiangDay TG ON TGD.MaThoiGian = TG.MaThoiGian
        INNER JOIN NgonNguGiangDay NN ON TGD.MaNgonNgu = NN.MaNgonNgu
        WHERE TGD.MaTaiGiangDay = @MaTaiGiangDay;
        
        DECLARE @SoTietQuyDoi FLOAT = @SoTiet * @HeSoDoiTuong * @HeSoThoiGian * @HeSoNgonNgu;
        
        -- Generate MaChiTietGiangDay
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietGiangDay;
        SET @MaChiTietGiangDay = 'CTGD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietGiangDay (MaChiTietGiangDay, SoTiet, SoTietQuyDoi, GhiChu, 
                                    MaGV, MaTaiGiangDay, MaNoiDungGiangDay)
        VALUES (@MaChiTietGiangDay, @SoTiet, @SoTietQuyDoi, @GhiChu, 
                @MaGV, @MaTaiGiangDay, @MaNoiDungGiangDay);
        
        SET @ErrorMessage = N'Phân công giảng dạy thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietGiangDay = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GiangDay_ThemTai]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 3: QUẢN LÝ GIẢNG DẠY
-- =============================================

-- 3.1. Thêm mới tài giảng dạy
CREATE   PROCEDURE [dbo].[sp_GiangDay_ThemTai]
    @TenHocPhan NVARCHAR(100),
    @SiSo INT,
    @He NVARCHAR(20),
    @Lop NVARCHAR(20),
    @SoTinChi INT,
    @GhiChu NVARCHAR(200),
    @NamHoc NVARCHAR(20),
    @MaDoiTuong CHAR(15),
    @MaThoiGian CHAR(15),
    @MaNgonNgu CHAR(15),
    @MaTaiGiangDay CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SiSo <= 0 OR @SiSo > 500
            THROW 50070, N'Sĩ số không hợp lệ (1-500)', 1;
            
        IF @SoTinChi <= 0 OR @SoTinChi > 10
            THROW 50071, N'Số tín chỉ không hợp lệ (1-10)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM DoiTuongGiangDay WHERE MaDoiTuong = @MaDoiTuong)
            THROW 50072, N'Mã đối tượng giảng dạy không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM ThoiGianGiangDay WHERE MaThoiGian = @MaThoiGian)
            THROW 50073, N'Mã thời gian giảng dạy không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM NgonNguGiangDay WHERE MaNgonNgu = @MaNgonNgu)
            THROW 50074, N'Mã ngôn ngữ giảng dạy không tồn tại', 1;
        
        -- Generate MaTaiGiangDay
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiGiangDay;
        SET @MaTaiGiangDay = 'TGD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiGiangDay (MaTaiGiangDay, TenHocPhan, SiSo, He, Lop, SoTinChi, 
                                GhiChu, NamHoc, MaDoiTuong, MaThoiGian, MaNgonNgu)
        VALUES (@MaTaiGiangDay, @TenHocPhan, @SiSo, @He, @Lop, @SoTinChi, 
                @GhiChu, @NamHoc, @MaDoiTuong, @MaThoiGian, @MaNgonNgu);
        
        SET @ErrorMessage = N'Thêm tài giảng dạy thành công. Mã: ' + @MaTaiGiangDay;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiGiangDay = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GiaoVien_CapNhat]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1.2. Cập nhật thông tin giáo viên
CREATE   PROCEDURE [dbo].[sp_GiaoVien_CapNhat]
    @MaGV CHAR(15),
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh BIT,
    @QueQuan NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @SDT INT,
    @Email NVARCHAR(100),
    @MaBM CHAR(15),
    @MaNguoiCapNhat NVARCHAR(50) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50010, N'Mã giáo viên không tồn tại', 1;
            
        -- Validate
        IF @Email NOT LIKE '%_@__%.__%'
            THROW 50011, N'Email không đúng định dạng', 1;
            
        IF EXISTS (SELECT 1 FROM GiaoVien WHERE Email = @Email AND MaGV != @MaGV)
            THROW 50012, N'Email đã được sử dụng bởi giáo viên khác', 1;
            
        IF NOT EXISTS (SELECT 1 FROM BoMon WHERE MaBM = @MaBM)
            THROW 50013, N'Mã bộ môn không tồn tại', 1;
        
        -- Store old data for audit
        DECLARE @OldData NVARCHAR(MAX);
        SELECT @OldData = (
            SELECT MaGV, HoTen, NgaySinh, GioiTinh, Email, MaBM
            FROM GiaoVien WHERE MaGV = @MaGV
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        
        -- Update
        UPDATE GiaoVien
        SET HoTen = @HoTen,
            NgaySinh = @NgaySinh,
            GioiTinh = @GioiTinh,
            QueQuan = @QueQuan,
            DiaChi = @DiaChi,
            SDT = @SDT,
            Email = @Email,
            MaBM = @MaBM
        WHERE MaGV = @MaGV;
        
        -- Log change if user provided
        IF @MaNguoiCapNhat IS NOT NULL
        BEGIN
            DECLARE @MaLichSu NVARCHAR(50);
            SELECT TOP 1 @MaLichSu = MaLichSu 
            FROM LichSuDangNhap 
            WHERE MaNguoiDung = @MaNguoiCapNhat 
                AND ThoiDiemDangXuat IS NULL
            ORDER BY ThoiDiemDangNhap DESC;
            
            IF @MaLichSu IS NOT NULL
                EXEC sp_NhatKy_GhiLog @MaLichSu, N'Cập nhật thông tin giáo viên', @OldData, NULL, NULL;
        END
        
        SET @ErrorMessage = N'Cập nhật thông tin giáo viên thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GiaoVien_ThemMoi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 1: QUẢN LÝ GIÁO VIÊN
-- =============================================

-- 1.1. Thêm mới giáo viên với đầy đủ validation
CREATE   PROCEDURE [dbo].[sp_GiaoVien_ThemMoi]
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh BIT,
    @QueQuan NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @SDT INT,
    @Email NVARCHAR(100),
    @MaBM CHAR(15),
    @MaGV CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate inputs
        IF @HoTen IS NULL OR LTRIM(RTRIM(@HoTen)) = ''
            THROW 50001, N'Họ tên không được để trống', 1;
            
        IF @NgaySinh > GETDATE() OR @NgaySinh < DATEADD(YEAR, -70, GETDATE())
            THROW 50002, N'Ngày sinh không hợp lệ', 1;
            
        IF @Email NOT LIKE '%_@__%.__%'
            THROW 50003, N'Email không đúng định dạng', 1;
            
        IF EXISTS (SELECT 1 FROM GiaoVien WHERE Email = @Email)
            THROW 50004, N'Email đã tồn tại trong hệ thống', 1;
            
        IF @SDT < 100000000 OR @SDT > 999999999
            THROW 50005, N'Số điện thoại phải có 9 chữ số', 1;
            
        IF NOT EXISTS (SELECT 1 FROM BoMon WHERE MaBM = @MaBM)
            THROW 50006, N'Mã bộ môn không tồn tại', 1;
        
        -- Generate MaGV
        DECLARE @NextId INT;
        UPDATE SequenceGenerator 
        SET @NextId = LastSequence = LastSequence + 1
        WHERE TableName = 'GiaoVien';
        
        SET @MaGV = 'GV' + RIGHT('0000' + CAST(@NextId AS VARCHAR(4)), 4);
        
        -- Insert
        INSERT INTO GiaoVien (MaGV, HoTen, NgaySinh, GioiTinh, QueQuan, DiaChi, SDT, Email, MaBM)
        VALUES (@MaGV, @HoTen, @NgaySinh, @GioiTinh, @QueQuan, @DiaChi, @SDT, @Email, @MaBM);
        
        SET @ErrorMessage = N'Thêm giáo viên thành công. Mã GV: ' + @MaGV;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaGV = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GiaoVien_TimKiem]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1.3. Xóa giáo viên (soft delete)
--CREATE OR ALTER PROCEDURE sp_GiaoVien_Xoa
--    @MaGV CHAR(15),
--    @ForceDelete BIT = 0,
--    @MaNguoiXoa NVARCHAR(50) = NULL,
--    @ErrorMessage NVARCHAR(500) OUTPUT
--AS
--BEGIN
--    SET NOCOUNT ON;
--    SET XACT_ABORT ON;
    
--    BEGIN TRY
--        BEGIN TRANSACTION;
        
--        -- Check existence
--        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
--            THROW 50020, N'Mã giáo viên không tồn tại', 1;
        
--        -- Check dependencies
--        DECLARE @Dependencies NVARCHAR(MAX) = '';
        
--        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WHERE MaGV = @MaGV)
--            SET @Dependencies = @Dependencies + N'Giảng dạy, ';
            
--        IF EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV)
--            SET @Dependencies = @Dependencies + N'NCKH, ';
            
--        IF EXISTS (SELECT 1 FROM Khoa WHERE MaChuNhiemKhoa = @MaGV)
--            SET @Dependencies = @Dependencies + N'Chủ nhiệm khoa, ';
            
--        IF EXISTS (SELECT 1 FROM BoMon WHERE MaChuNhiemBM = @MaGV)
--            SET @Dependencies = @Dependencies + N'Chủ nhiệm bộ môn, ';
        
--        IF LEN(@Dependencies) > 0 AND @ForceDelete = 0
--        BEGIN
--            SET @Dependencies = LEFT(@Dependencies, LEN(@Dependencies) - 1);
--            THROW 50021, N'Không thể xóa vì giáo viên đang có liên kết: ' + @Dependencies, 1;
--        END
        
--        IF @ForceDelete = 1
--        BEGIN
--            -- Remove all dependencies
--            UPDATE Khoa SET MaChuNhiemKhoa = NULL WHERE MaChuNhiemKhoa = @MaGV;
--            UPDATE BoMon SET MaChuNhiemBM = NULL WHERE MaChuNhiemBM = @MaGV;
--            DELETE FROM ChiTietGiangDay WHERE MaGV = @MaGV;
--            DELETE FROM ChiTietNCKH WHERE MaGV = @MaGV;
--            DELETE FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV;
--            DELETE FROM ThamGia WHERE MaGV = @MaGV;
--            DELETE FROM ThamGiaHuongDan WHERE MaGV = @MaGV;
--            DELETE FROM NguoiDung WHERE MaGV = @MaGV;
--        END
        
--        DELETE FROM GiaoVien WHERE MaGV = @MaGV;
        
--        SET @ErrorMessage = N'Xóa giáo viên thành công';
        
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;
            
--        SET @ErrorMessage = ERROR_MESSAGE();
--        THROW;
--    END CATCH
--END;
--GO

-- 1.4. Tìm kiếm giáo viên nâng cao
CREATE   PROCEDURE [dbo].[sp_GiaoVien_TimKiem]
    @SearchText NVARCHAR(100) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @HocVi NVARCHAR(100) = NULL,
    @HocHam NVARCHAR(100) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @TotalRecords INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Count total records
    SELECT @TotalRecords = COUNT(DISTINCT GV.MaGV)
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN HocVi HV ON GV.MaGV = HV.MaGV
    LEFT JOIN LichSuHocHam LSHH ON GV.MaGV = LSHH.MaGV
    WHERE (@SearchText IS NULL OR 
           GV.HoTen LIKE N'%' + @SearchText + '%' OR 
           GV.Email LIKE '%' + @SearchText + '%' OR
           GV.MaGV LIKE '%' + @SearchText + '%')
      AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
      AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
      AND (@HocVi IS NULL OR HV.TenHocVi = @HocVi)
      AND (@HocHam IS NULL OR LSHH.TenHocHam = @HocHam);
    
    -- Return paginated results
    WITH CTE AS (
        SELECT DISTINCT
            GV.MaGV,
            GV.HoTen,
            GV.NgaySinh,
            CASE GV.GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
            GV.Email,
            GV.SDT,
            GV.DiaChi,
            BM.TenBM,
            K.TenKhoa,
            STRING_AGG(HV.TenHocVi, ', ') WITHIN GROUP (ORDER BY HV.NgayNhan DESC) AS DanhSachHocVi,
            (SELECT TOP 1 TenHocHam FROM LichSuHocHam WHERE MaGV = GV.MaGV ORDER BY NgayNhan DESC) AS HocHamCaoNhat,
            ROW_NUMBER() OVER (ORDER BY GV.HoTen) AS RowNum
        FROM GiaoVien GV
        INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
        LEFT JOIN HocVi HV ON GV.MaGV = HV.MaGV
        LEFT JOIN LichSuHocHam LSHH ON GV.MaGV = LSHH.MaGV
        WHERE (@SearchText IS NULL OR 
               GV.HoTen LIKE N'%' + @SearchText + '%' OR 
               GV.Email LIKE '%' + @SearchText + '%' OR
               GV.MaGV LIKE '%' + @SearchText + '%')
          AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
          AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
          AND (@HocVi IS NULL OR HV.TenHocVi = @HocVi)
          AND (@HocHam IS NULL OR LSHH.TenHocHam = @HocHam)
        GROUP BY GV.MaGV, GV.HoTen, GV.NgaySinh, GV.GioiTinh, GV.Email, 
                 GV.SDT, GV.DiaChi, BM.TenBM, K.TenKhoa
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GiaoVien_Xoa]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1.3. Xóa giáo viên (soft delete)
CREATE   PROCEDURE [dbo].[sp_GiaoVien_Xoa]
    @MaGV CHAR(15),
    @ForceDelete BIT = 0,
    @MaNguoiXoa NVARCHAR(50) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50020, N'Mã giáo viên không tồn tại', 1;
        
        -- Check dependencies
        DECLARE @Dependencies NVARCHAR(MAX) = '';
        
        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WHERE MaGV = @MaGV)
            SET @Dependencies = @Dependencies + N'Giảng dạy, ';
            
        IF EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV)
            SET @Dependencies = @Dependencies + N'NCKH, ';
            
        IF EXISTS (SELECT 1 FROM Khoa WHERE MaChuNhiemKhoa = @MaGV)
            SET @Dependencies = @Dependencies + N'Chủ nhiệm khoa, ';
            
        IF EXISTS (SELECT 1 FROM BoMon WHERE MaChuNhiemBM = @MaGV)
            SET @Dependencies = @Dependencies + N'Chủ nhiệm bộ môn, ';
        
        IF LEN(@Dependencies) > 0 AND @ForceDelete = 0
        BEGIN
            SET @Dependencies = LEFT(@Dependencies, LEN(@Dependencies) - 2); -- Loại bỏ dấu phẩy và khoảng trắng cuối
            DECLARE @ErrorMsg NVARCHAR(500) = N'Không thể xóa vì giáo viên đang có liên kết: ' + @Dependencies;
            THROW 50021, @ErrorMsg, 1;
        END
        
        IF @ForceDelete = 1
        BEGIN
            -- Remove all dependencies
            UPDATE Khoa SET MaChuNhiemKhoa = NULL WHERE MaChuNhiemKhoa = @MaGV;
            UPDATE BoMon SET MaChuNhiemBM = NULL WHERE MaChuNhiemBM = @MaGV;
            DELETE FROM ChiTietGiangDay WHERE MaGV = @MaGV;
            DELETE FROM ChiTietNCKH WHERE MaGV = @MaGV;
            DELETE FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV;
            DELETE FROM ThamGia WHERE MaGV = @MaGV;
            DELETE FROM ThamGiaHuongDan WHERE MaGV = @MaGV;
            DELETE FROM NguoiDung WHERE MaGV = @MaGV;
        END
        
        DELETE FROM GiaoVien WHERE MaGV = @MaGV;
        
        SET @ErrorMessage = N'Xóa giáo viên thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_HocHam_CapNhat]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 8.2. Cập nhật học hàm
CREATE   PROCEDURE [dbo].[sp_HocHam_CapNhat]
    @MaGV CHAR(15),
    @MaHocHam CHAR(15),
    @NgayNhan DATE,
    @MaLSHocHam CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50180, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM HocHam WHERE MaHocHam = @MaHocHam)
            THROW 50181, N'Mã học hàm không tồn tại', 1;
            
        IF @NgayNhan > GETDATE()
            THROW 50182, N'Ngày nhận không thể trong tương lai', 1;
        
        -- Check if already has this title
        IF EXISTS (
            SELECT 1 FROM LichSuHocHam 
            WHERE MaGV = @MaGV AND MaHocHam = @MaHocHam
        )
            THROW 50183, N'Giáo viên đã có học hàm này', 1;
        
        -- Get TenHocHam
        DECLARE @TenHocHam NVARCHAR(100);
        SELECT @TenHocHam = TenHocHam FROM HocHam WHERE MaHocHam = @MaHocHam;
        
        -- Generate MaLSHocHam
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuHocHam;
        SET @MaLSHocHam = 'LSHH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO LichSuHocHam (MaLSHocHam, TenHocHam, NgayNhan, MaGV, MaHocHam)
        VALUES (@MaLSHocHam, @TenHocHam, @NgayNhan, @MaGV, @MaHocHam);
        
        SET @ErrorMessage = N'Cập nhật học hàm thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaLSHocHam = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_HocVi_CapNhat]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 8: QUẢN LÝ HỌC HÀM HỌC VỊ
-- =============================================

-- 8.1. Cập nhật học vị
CREATE   PROCEDURE [dbo].[sp_HocVi_CapNhat]
    @MaGV CHAR(15),
    @TenHocVi NVARCHAR(100),
    @NgayNhan DATE,
    @MaHocVi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50170, N'Mã giáo viên không tồn tại', 1;
            
        IF @NgayNhan > GETDATE()
            THROW 50171, N'Ngày nhận không thể trong tương lai', 1;
        
        -- Check if same degree already exists
        IF EXISTS (SELECT 1 FROM HocVi WHERE MaGV = @MaGV AND TenHocVi = @TenHocVi)
            THROW 50172, N'Giáo viên đã có học vị này', 1;
        
        -- Generate MaHocVi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM HocVi;
        SET @MaHocVi = 'HV' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO HocVi (MaHocVi, TenHocVi, NgayNhan, MaGV)
        VALUES (@MaHocVi, @TenHocVi, @NgayNhan, @MaGV);
        
        SET @ErrorMessage = N'Cập nhật học vị thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHocVi = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_HoiDong_ThemMoi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 6: QUẢN LÝ HỘI ĐỒNG
-- =============================================

-- 6.1. Thêm mới hội đồng
CREATE   PROCEDURE [dbo].[sp_HoiDong_ThemMoi]
    @SoLuong INT,
    @NamHoc NVARCHAR(20),
    @ThoiGianBatDau DATETIME,
    @ThoiGianKetThuc DATETIME,
    @GhiChu NVARCHAR(200),
    @MaLoaiHoiDong CHAR(15),
    @MaHoiDong CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoLuong <= 0 OR @SoLuong > 20
            THROW 50130, N'Số lượng thành viên không hợp lệ (1-20)', 1;
            
        IF @ThoiGianBatDau >= @ThoiGianKetThuc
            THROW 50131, N'Thời gian kết thúc phải sau thời gian bắt đầu', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiHoiDong WHERE MaLoaiHoiDong = @MaLoaiHoiDong)
            THROW 50132, N'Mã loại hội đồng không tồn tại', 1;
        
        -- Generate MaHoiDong
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiHoiDong;
        SET @MaHoiDong = 'HD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiHoiDong (MaHoiDong, SoLuong, NamHoc, ThoiGianBatDau, ThoiGianKetThuc, GhiChu, MaLoaiHoiDong)
        VALUES (@MaHoiDong, @SoLuong, @NamHoc, @ThoiGianBatDau, @ThoiGianKetThuc, @GhiChu, @MaLoaiHoiDong);
        
        SET @ErrorMessage = N'Thêm hội đồng thành công. Mã: ' + @MaHoiDong;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHoiDong = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_HoiDong_ThemThanhVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 6.2. Thêm thành viên hội đồng
CREATE   PROCEDURE [dbo].[sp_HoiDong_ThemThanhVien]
    @MaGV CHAR(15),
    @MaHoiDong CHAR(15),
    @SoGio FLOAT,
    @MaThamGia CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50140, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiHoiDong WHERE MaHoiDong = @MaHoiDong)
            THROW 50141, N'Mã hội đồng không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 100
            THROW 50142, N'Số giờ không hợp lệ (1-100)', 1;
        
        -- Check if already member
        IF EXISTS (SELECT 1 FROM ThamGia WHERE MaGV = @MaGV AND MaHoiDong = @MaHoiDong)
            THROW 50143, N'Giáo viên đã là thành viên của hội đồng này', 1;
        
        -- Check max members
        DECLARE @SoLuong INT, @SoThanhVienHienTai INT;
        SELECT @SoLuong = SoLuong FROM TaiHoiDong WHERE MaHoiDong = @MaHoiDong;
        SELECT @SoThanhVienHienTai = COUNT(*) FROM ThamGia WHERE MaHoiDong = @MaHoiDong;
        
        IF @SoThanhVienHienTai >= @SoLuong
            THROW 50144, N'Hội đồng đã đủ số lượng thành viên', 1;
        
        -- Generate MaThamGia
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ThamGia;
        SET @MaThamGia = 'TG' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ThamGia (MaThamGia, MaGV, MaHoiDong, SoGio)
        VALUES (@MaThamGia, @MaGV, @MaHoiDong, @SoGio);
        
        SET @ErrorMessage = N'Thêm thành viên hội đồng thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaThamGia = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_HuongDan_PhanCong]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 7.2. Phân công hướng dẫn
CREATE   PROCEDURE [dbo].[sp_HuongDan_PhanCong]
    @MaGV CHAR(15),
    @MaHuongDan CHAR(15),
    @SoGio FLOAT,
    @MaThamGiaHuongDan CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50160, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiHuongDan WHERE MaHuongDan = @MaHuongDan)
            THROW 50161, N'Mã tài hướng dẫn không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 200
            THROW 50162, N'Số giờ không hợp lệ (1-200)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ThamGiaHuongDan WHERE MaGV = @MaGV AND MaHuongDan = @MaHuongDan)
            THROW 50163, N'Giáo viên đã được phân công hướng dẫn này', 1;
        
        -- Check max advisors
        DECLARE @SoCBHD INT, @SoCBHDHienTai INT;
        SELECT @SoCBHD = SoCBHD FROM TaiHuongDan WHERE MaHuongDan = @MaHuongDan;
        SELECT @SoCBHDHienTai = COUNT(*) FROM ThamGiaHuongDan WHERE MaHuongDan = @MaHuongDan;
        
        IF @SoCBHDHienTai >= @SoCBHD
            THROW 50164, N'Đã đủ số cán bộ hướng dẫn', 1;
        
        -- Generate MaThamGiaHuongDan
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ThamGiaHuongDan;
        SET @MaThamGiaHuongDan = 'TGHD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ThamGiaHuongDan (MaThamGiaHuongDan, MaGV, MaHuongDan, SoGio)
        VALUES (@MaThamGiaHuongDan, @MaGV, @MaHuongDan, @SoGio);
        
        SET @ErrorMessage = N'Phân công hướng dẫn thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaThamGiaHuongDan = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_HuongDan_ThemTai]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 7: QUẢN LÝ HƯỚNG DẪN
-- =============================================

-- 7.1. Thêm mới tài hướng dẫn
CREATE   PROCEDURE [dbo].[sp_HuongDan_ThemTai]
    @HoTenHocVien NVARCHAR(100),
    @Lop NVARCHAR(50),
    @He NVARCHAR(50),
    @NamHoc NVARCHAR(20),
    @TenDeTai NVARCHAR(200),
    @SoCBHD INT,
    @MaLoaiHinhHuongDan CHAR(15),
    @MaHuongDan CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoCBHD <= 0 OR @SoCBHD > 5
            THROW 50150, N'Số cán bộ hướng dẫn không hợp lệ (1-5)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiHinhHuongDan WHERE MaLoaiHinhHuongDan = @MaLoaiHinhHuongDan)
            THROW 50151, N'Mã loại hình hướng dẫn không tồn tại', 1;
        
        -- Generate MaHuongDan
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiHuongDan;
        SET @MaHuongDan = 'HD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiHuongDan (MaHuongDan, HoTenHocVien, Lop, He, NamHoc, TenDeTai, SoCBHD, MaLoaiHinhHuongDan)
        VALUES (@MaHuongDan, @HoTenHocVien, @Lop, @He, @NamHoc, @TenDeTai, @SoCBHD, @MaLoaiHinhHuongDan);
        
        SET @ErrorMessage = N'Thêm tài hướng dẫn thành công. Mã: ' + @MaHuongDan;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHuongDan = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_KhaoThi_PhanCong]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 5.2. Phân công khảo thí
CREATE   PROCEDURE [dbo].[sp_KhaoThi_PhanCong]
    @MaGV CHAR(15),
    @MaTaiKhaoThi CHAR(15),
    @SoBai INT,
    @MaChiTietTaiKhaoThi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50120, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiKhaoThi WHERE MaTaiKhaoThi = @MaTaiKhaoThi)
            THROW 50121, N'Mã tài khảo thí không tồn tại', 1;
            
        IF @SoBai <= 0 OR @SoBai > 1000
            THROW 50122, N'Số bài không hợp lệ (1-1000)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV AND MaTaiKhaoThi = @MaTaiKhaoThi)
            THROW 50123, N'Giáo viên đã được phân công cho công tác khảo thí này', 1;
        
        -- Calculate SoGioQuyChuan based on type
        DECLARE @MaLoaiCongTacKhaoThi CHAR(15), @SoGioQuyChuan FLOAT;
        SELECT @MaLoaiCongTacKhaoThi = MaLoaiCongTacKhaoThi FROM TaiKhaoThi WHERE MaTaiKhaoThi = @MaTaiKhaoThi;
        
        SET @SoGioQuyChuan = CASE 
            WHEN @MaLoaiCongTacKhaoThi = 'LKT01' THEN @SoBai * 0.5  -- Ra đề
            WHEN @MaLoaiCongTacKhaoThi = 'LKT02' THEN @SoBai * 0.3  -- Coi thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT03' THEN @SoBai * 0.4  -- Chấm thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT04' THEN @SoBai * 0.2  -- Phản biện
            WHEN @MaLoaiCongTacKhaoThi = 'LKT05' THEN @SoBai * 0.3  -- Phúc khảo
            ELSE @SoBai * 0.3
        END;
        
        -- Generate MaChiTietTaiKhaoThi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietTaiKhaoThi;
        SET @MaChiTietTaiKhaoThi = 'CTKT' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietTaiKhaoThi (MaChiTietTaiKhaoThi, SoBai, SoGioQuyChuan, MaGV, MaTaiKhaoThi)
        VALUES (@MaChiTietTaiKhaoThi, @SoBai, @SoGioQuyChuan, @MaGV, @MaTaiKhaoThi);
        
        SET @ErrorMessage = N'Phân công khảo thí thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietTaiKhaoThi = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_KhaoThi_ThemTai]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 5: QUẢN LÝ KHẢO THÍ
-- =============================================

-- 5.1. Thêm mới tài khảo thí
CREATE   PROCEDURE [dbo].[sp_KhaoThi_ThemTai]
    @HocPhan NVARCHAR(100),
    @Lop NVARCHAR(50),
    @NamHoc NVARCHAR(20),
    @GhiChu NVARCHAR(200),
    @MaLoaiCongTacKhaoThi CHAR(15),
    @MaTaiKhaoThi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM LoaiCongTacKhaoThi WHERE MaLoaiCongTacKhaoThi = @MaLoaiCongTacKhaoThi)
            THROW 50110, N'Mã loại công tác khảo thí không tồn tại', 1;
        
        -- Generate MaTaiKhaoThi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiKhaoThi;
        SET @MaTaiKhaoThi = 'KT' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiKhaoThi (MaTaiKhaoThi, HocPhan, Lop, NamHoc, GhiChu, MaLoaiCongTacKhaoThi)
        VALUES (@MaTaiKhaoThi, @HocPhan, @Lop, @NamHoc, @GhiChu, @MaLoaiCongTacKhaoThi);
        
        SET @ErrorMessage = N'Thêm tài khảo thí thành công. Mã: ' + @MaTaiKhaoThi;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiKhaoThi = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Khoa_CapNhat]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.2. Cập nhật khoa
CREATE   PROCEDURE [dbo].[sp_Khoa_CapNhat]
    @MaKhoa CHAR(15),
    @TenKhoa NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaChuNhiemKhoa CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50040, N'Mã khoa không tồn tại', 1;
            
        -- Validate
        IF EXISTS (SELECT 1 FROM Khoa WHERE TenKhoa = @TenKhoa AND MaKhoa != @MaKhoa)
            THROW 50041, N'Tên khoa đã tồn tại', 1;
            
        IF @MaChuNhiemKhoa IS NOT NULL 
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemKhoa)
                THROW 50042, N'Mã chủ nhiệm khoa không tồn tại', 1;
                
            -- Check if teacher belongs to this faculty
            IF NOT EXISTS (
                SELECT 1 FROM GiaoVien GV
                INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
                WHERE GV.MaGV = @MaChuNhiemKhoa AND BM.MaKhoa = @MaKhoa
            )
                THROW 50043, N'Giáo viên không thuộc khoa này', 1;
        END
        
        -- Get old dean
        DECLARE @OldChuNhiem CHAR(15);
        SELECT @OldChuNhiem = MaChuNhiemKhoa FROM Khoa WHERE MaKhoa = @MaKhoa;
        
        -- Update
        UPDATE Khoa
        SET TenKhoa = @TenKhoa,
            DiaChi = @DiaChi,
            MaChuNhiemKhoa = @MaChuNhiemKhoa
        WHERE MaKhoa = @MaKhoa;
        
        -- Update ChucVu
        IF @OldChuNhiem != @MaChuNhiemKhoa
        BEGIN
            IF @OldChuNhiem IS NOT NULL
                EXEC sp_ChucVu_KetThuc @OldChuNhiem, 'CV003', NULL;
                
            IF @MaChuNhiemKhoa IS NOT NULL
                EXEC sp_ChucVu_PhanCong @MaChuNhiemKhoa, 'CV003', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Cập nhật khoa thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Khoa_ThemMoi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 2: QUẢN LÝ KHOA VÀ BỘ MÔN
-- =============================================

-- 2.1. Thêm mới khoa
CREATE   PROCEDURE [dbo].[sp_Khoa_ThemMoi]
    @TenKhoa NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaChuNhiemKhoa CHAR(15) = NULL,
    @MaKhoa CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF EXISTS (SELECT 1 FROM Khoa WHERE TenKhoa = @TenKhoa)
            THROW 50030, N'Tên khoa đã tồn tại', 1;
            
        IF @MaChuNhiemKhoa IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemKhoa)
            THROW 50031, N'Mã chủ nhiệm khoa không tồn tại', 1;
        
        -- Generate MaKhoa
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM Khoa;
        SET @MaKhoa = 'KHOA' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO Khoa (MaKhoa, TenKhoa, DiaChi, MaChuNhiemKhoa)
        VALUES (@MaKhoa, @TenKhoa, @DiaChi, @MaChuNhiemKhoa);
        
        -- Update ChucVu if needed
        IF @MaChuNhiemKhoa IS NOT NULL
        BEGIN
            EXEC sp_ChucVu_PhanCong @MaChuNhiemKhoa, 'CV003', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Thêm khoa thành công. Mã khoa: ' + @MaKhoa;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaKhoa = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Khoa_Xoa]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.3. Xóa khoa
CREATE   PROCEDURE [dbo].[sp_Khoa_Xoa]
    @MaKhoa CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50050, N'Mã khoa không tồn tại', 1;
            
        -- Check dependencies
        IF EXISTS (SELECT 1 FROM BoMon WHERE MaKhoa = @MaKhoa)
            THROW 50051, N'Không thể xóa khoa vì còn bộ môn trực thuộc', 1;
        
        DELETE FROM Khoa WHERE MaKhoa = @MaKhoa;
        
        SET @ErrorMessage = N'Xóa khoa thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_KiemTraHoanThanhDinhMuc]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 11. Kiểm tra hoàn thành định mức
CREATE   PROCEDURE [dbo].[sp_KiemTraHoanThanhDinhMuc]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    WITH TongKhoiLuong AS (
        SELECT 
            GV.MaGV,
            GV.HoTen,
            BM.TenBM,
            K.TenKhoa,
            -- Giảng dạy
            ISNULL((
                SELECT SUM(CTGD.SoTietQuyDoi) 
                FROM ChiTietGiangDay CTGD 
                INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
            ), 0) AS TongSoTietGiangDay,
            -- NCKH
            ISNULL((
                SELECT SUM(CTNCKH.SoGio) 
                FROM ChiTietNCKH CTNCKH 
                INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
                WHERE CTNCKH.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
            ), 0) AS TongSoGioNCKH,
            -- Khao Thi
            ISNULL((
                SELECT SUM(CTKT.SoGioQuyChuan) 
                FROM ChiTietTaiKhaoThi CTKT 
                INNER JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
                WHERE CTKT.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TKT.NamHoc = @NamHoc)
            ), 0) AS TongSoGioKhaoThi,
            -- Trường hợp có Học hàm thì lấy định mức, nếu không thì lấy định mức mặc định
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM HocHam HH
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM HocHam HH
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                INNER JOIN LichSuHocHam LSHH ON HH.MaHocHam = LSHH.MaHocHam
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
        INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
        WHERE 
            (@MaGV IS NULL OR GV.MaGV = @MaGV)
            AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
            AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
    )
    SELECT 
        MaGV,
        HoTen,
        TenBM,
        TenKhoa,
        TongSoTietGiangDay,
        DinhMucGiangDay,
        CASE 
            WHEN TongSoTietGiangDay >= DinhMucGiangDay THEN N'Đạt'
            ELSE N'Chưa đạt'
        END AS TrangThaiGiangDay,
        CAST(TongSoTietGiangDay * 100.0 / DinhMucGiangDay AS DECIMAL(10, 2)) AS PhanTramHoanThanhGiangDay,
        TongSoGioNCKH,
        DinhMucNCKH,
        CASE 
            WHEN TongSoGioNCKH >= DinhMucNCKH THEN N'Đạt'
            ELSE N'Chưa đạt'
        END AS TrangThaiNCKH,
        CAST(TongSoGioNCKH * 100.0 / DinhMucNCKH AS DECIMAL(10, 2)) AS PhanTramHoanThanhNCKH,
        TongSoGioKhaoThi,
        CASE 
            WHEN TongSoTietGiangDay >= DinhMucGiangDay AND TongSoGioNCKH >= DinhMucNCKH THEN N'Đạt'
            ELSE N'Chưa đạt'
        END AS TrangThaiTong
    FROM TongKhoiLuong
    ORDER BY TenKhoa, TenBM, HoTen;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_KiemTraQuyen]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 16. Kiểm tra quyền
CREATE   PROCEDURE [dbo].[sp_KiemTraQuyen]
    @MaNguoiDung NVARCHAR(50),
    @MaQuyen NVARCHAR(50),
    @CoQuyen BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @CoQuyen = 0;

    -- Check if the user has the permission through any group
    IF EXISTS (
        SELECT 1
        FROM NguoiDung_Nhom ND_N
        INNER JOIN Nhom_Quyen N_Q ON ND_N.MaNhom = N_Q.MaNhom
        WHERE ND_N.MaNguoiDung = @MaNguoiDung AND N_Q.MaQuyen = @MaQuyen
    )
    BEGIN
        SET @CoQuyen = 1;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_KiemTraTrungLichGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 12. Procedure tiện ích: Kiểm tra trùng lịch giảng dạy của giáo viên
CREATE   PROCEDURE [dbo].[sp_KiemTraTrungLichGiangDay]
    @MaGV CHAR(15),
    @MaThoiGian CHAR(15),
    @NamHoc NVARCHAR(20),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        -- Lấy danh sách các học phần đã được phân công cho giáo viên với thời gian giảng dạy trùng nhau
        SELECT 
            TGD1.MaTaiGiangDay,
            TGD1.TenHocPhan,
            TGD1.Lop,
            TG.TenThoiGian
        FROM ChiTietGiangDay CTGD1
        INNER JOIN TaiGiangDay TGD1 ON CTGD1.MaTaiGiangDay = TGD1.MaTaiGiangDay
        INNER JOIN ThoiGianGiangDay TG ON TGD1.MaThoiGian = TG.MaThoiGian
        WHERE CTGD1.MaGV = @MaGV
            AND TGD1.MaThoiGian = @MaThoiGian
            AND TGD1.NamHoc = @NamHoc;

        -- Đếm số lượng trùng lịch
        DECLARE @SoLuongTrungLich INT;
        SELECT @SoLuongTrungLich = COUNT(*)
        FROM ChiTietGiangDay CTGD1
        INNER JOIN TaiGiangDay TGD1 ON CTGD1.MaTaiGiangDay = TGD1.MaTaiGiangDay
        WHERE CTGD1.MaGV = @MaGV
            AND TGD1.MaThoiGian = @MaThoiGian
            AND TGD1.NamHoc = @NamHoc;

        -- Trả về thông báo
        IF @SoLuongTrungLich > 0
            SET @ErrorMessage = N'Giáo viên đã có ' + CAST(@SoLuongTrungLich AS NVARCHAR(10)) + N' học phần trùng lịch trong thời gian này.';
        ELSE
            SET @ErrorMessage = N'Không có trùng lịch giảng dạy.';
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = N'Lỗi khi kiểm tra trùng lịch giảng dạy: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_LayChiTietGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 5. Lấy chi tiết giáo viên
CREATE   PROCEDURE [dbo].[sp_LayChiTietGiaoVien]
    @MaGV CHAR(15)
AS
BEGIN
    SET NOCOUNT ON;

    -- Lấy thông tin cơ bản của giáo viên
    SELECT 
        GV.MaGV,
        GV.HoTen,
        GV.NgaySinh,
        GV.GioiTinh,
        GV.QueQuan,
        GV.DiaChi,
        GV.SDT,
        GV.Email,
        BM.MaBM,
        BM.TenBM,
        K.MaKhoa,
        K.TenKhoa
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    WHERE GV.MaGV = @MaGV;

    -- Lấy thông tin học vị
    SELECT HV.MaHocVi, HV.TenHocVi, HV.NgayNhan
    FROM HocVi HV
    WHERE HV.MaGV = @MaGV;

    -- Lấy lịch sử học hàm
    SELECT LSHH.MaLSHocHam, LSHH.TenHocHam, LSHH.NgayNhan, HH.TenHocHam AS TenHocHamHienTai
    FROM LichSuHocHam LSHH
    INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
    WHERE LSHH.MaGV = @MaGV
    ORDER BY LSHH.NgayNhan DESC;

    -- Lấy lịch sử chức vụ
    SELECT LSCV.MaLichSuChucVu, CV.TenChucVu, LSCV.NgayNhan, LSCV.NgayKetThuc
    FROM LichSuChucVu LSCV
    INNER JOIN ChucVu CV ON LSCV.MaChucVu = CV.MaChucVu
    WHERE LSCV.MaGV = @MaGV
    ORDER BY LSCV.NgayNhan DESC;

    -- Lấy thông tin lý lịch khoa học
    SELECT 
        LLKH.MaLyLichKhoaHoc,
        LLKH.HeDaoTaoDH,
        LLKH.NoiDaoTaoDH,
        LLKH.NganhHocDH,
        LLKH.NuocDaoTaoDH,
        LLKH.NamTotNghiepDH,
        LLKH.ThacSiChuyenNganh,
        LLKH.NamCapBangTS,
        LLKH.NoiDaoTaoTS,
        LLKH.TenLuanVanTotNghiep,
        LLKH.TienSiChuyenNganh,
        LLKH.NamCapBangSauDH,
        LLKH.NoiDaoTaoSauDH,
        LLKH.TenLuanAnSauDH,
        LLKH.NgayKhai
    FROM LyLichKhoaHoc LLKH
    WHERE LLKH.MaGV = @MaGV;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_LayDanhSachQuyenCuaNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 18. Lấy danh sách quyền của người dùng
CREATE   PROCEDURE [dbo].[sp_LayDanhSachQuyenCuaNguoiDung]
    @MaNguoiDung NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT Q.MaQuyen, Q.TenQuyen
    FROM NguoiDung ND
    INNER JOIN NguoiDung_Nhom ND_N ON ND.MaNguoiDung = ND_N.MaNguoiDung
    INNER JOIN Nhom_Quyen N_Q ON ND_N.MaNhom = N_Q.MaNhom
    INNER JOIN Quyen Q ON N_Q.MaQuyen = Q.MaQuyen
    WHERE ND.MaNguoiDung = @MaNguoiDung
    ORDER BY Q.TenQuyen;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_LayThongTinNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 19. Lấy thông tin người dùng
CREATE   PROCEDURE [dbo].[sp_LayThongTinNguoiDung]
    @MaNguoiDung NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Lấy thông tin cơ bản của người dùng
    SELECT 
        ND.MaNguoiDung,
        ND.TenDangNhap,
        ND.MaGV,
        CASE WHEN ND.MaGV IS NOT NULL THEN GV.HoTen ELSE NULL END AS HoTenGiaoVien
    FROM NguoiDung ND
    LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
    WHERE ND.MaNguoiDung = @MaNguoiDung;

    -- Lấy danh sách nhóm của người dùng
    SELECT 
        NN.MaNhom,
        NN.TenNhom
    FROM NguoiDung_Nhom ND_N
    INNER JOIN NhomNguoiDung NN ON ND_N.MaNhom = NN.MaNhom
    WHERE ND_N.MaNguoiDung = @MaNguoiDung
    ORDER BY NN.TenNhom;

    -- Lấy danh sách quyền của người dùng
    SELECT DISTINCT Q.MaQuyen, Q.TenQuyen
    FROM NguoiDung_Nhom ND_N
    INNER JOIN Nhom_Quyen N_Q ON ND_N.MaNhom = N_Q.MaNhom
    INNER JOIN Quyen Q ON N_Q.MaQuyen = Q.MaQuyen
    WHERE ND_N.MaNguoiDung = @MaNguoiDung
    ORDER BY Q.TenQuyen;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_LyLichKhoaHoc_CapNhat]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 15: LÝ LỊCH KHOA HỌC
-- =============================================

-- 15.1. Cập nhật lý lịch khoa học
CREATE   PROCEDURE [dbo].[sp_LyLichKhoaHoc_CapNhat]
    @MaGV CHAR(15),
    @HeDaoTaoDH NVARCHAR(100),
    @NoiDaoTaoDH NVARCHAR(100),
    @NganhHocDH NVARCHAR(100),
    @NuocDaoTaoDH NVARCHAR(100),
    @NamTotNghiepDH INT,
    @ThacSiChuyenNganh NVARCHAR(100) = NULL,
    @NamCapBangTS INT = NULL,
    @NoiDaoTaoTS NVARCHAR(100) = NULL,
    @TenLuanVanTotNghiep NVARCHAR(200) = NULL,
    @TienSiChuyenNganh NVARCHAR(100) = NULL,
    @NamCapBangSauDH INT = NULL,
    @NoiDaoTaoSauDH NVARCHAR(100) = NULL,
    @TenLuanAnSauDH NVARCHAR(200) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50260, N'Mã giáo viên không tồn tại', 1;
            
        IF @NamTotNghiepDH < 1950 OR @NamTotNghiepDH > YEAR(GETDATE())
            THROW 50261, N'Năm tốt nghiệp đại học không hợp lệ', 1;
        
        -- Check if record exists
        IF EXISTS (SELECT 1 FROM LyLichKhoaHoc WHERE MaGV = @MaGV)
        BEGIN
            -- Update existing
            UPDATE LyLichKhoaHoc
            SET HeDaoTaoDH = @HeDaoTaoDH,
                NoiDaoTaoDH = @NoiDaoTaoDH,
                NganhHocDH = @NganhHocDH,
                NuocDaoTaoDH = @NuocDaoTaoDH,
                NamTotNghiepDH = @NamTotNghiepDH,
                ThacSiChuyenNganh = @ThacSiChuyenNganh,
                NamCapBangTS = @NamCapBangTS,
                NoiDaoTaoTS = @NoiDaoTaoTS,
                TenLuanVanTotNghiep = @TenLuanVanTotNghiep,
                TienSiChuyenNganh = @TienSiChuyenNganh,
                NamCapBangSauDH = @NamCapBangSauDH,
                NoiDaoTaoSauDH = @NoiDaoTaoSauDH,
                TenLuanAnSauDH = @TenLuanAnSauDH,
                NgayKhai = GETDATE()
            WHERE MaGV = @MaGV;
        END
        ELSE
        BEGIN
            -- Generate MaLyLichKhoaHoc
            DECLARE @MaLyLichKhoaHoc CHAR(15);
            DECLARE @Count INT;
            SELECT @Count = COUNT(*) + 1 FROM LyLichKhoaHoc;
            SET @MaLyLichKhoaHoc = 'LLKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
            
            -- Get teacher name
            DECLARE @NguoiKhai NVARCHAR(100);
            SELECT @NguoiKhai = HoTen FROM GiaoVien WHERE MaGV = @MaGV;
            
            -- Insert new
            INSERT INTO LyLichKhoaHoc (
                MaLyLichKhoaHoc, HeDaoTaoDH, NoiDaoTaoDH, NganhHocDH, NuocDaoTaoDH, 
                NamTotNghiepDH, ThacSiChuyenNganh, NamCapBangTS, NoiDaoTaoTS, 
                TenLuanVanTotNghiep, TienSiChuyenNganh, NamCapBangSauDH, NoiDaoTaoSauDH, 
                TenLuanAnSauDH, NguoiKhai, NgayKhai, MaGV
            )
            VALUES (
                @MaLyLichKhoaHoc, @HeDaoTaoDH, @NoiDaoTaoDH, @NganhHocDH, @NuocDaoTaoDH,
                @NamTotNghiepDH, @ThacSiChuyenNganh, @NamCapBangTS, @NoiDaoTaoTS,
                @TenLuanVanTotNghiep, @TienSiChuyenNganh, @NamCapBangSauDH, @NoiDaoTaoSauDH,
                @TenLuanAnSauDH, @NguoiKhai, GETDATE(), @MaGV
            );
        END
        
        SET @ErrorMessage = N'Cập nhật lý lịch khoa học thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NCKH_PhanCong]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4.2. Phân công NCKH với validation số tác giả
CREATE   PROCEDURE [dbo].[sp_NCKH_PhanCong]
    @MaGV CHAR(15),
    @MaTaiNCKH CHAR(15),
    @VaiTro NVARCHAR(100),
    @SoGio FLOAT,
    @MaChiTietNCKH CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50100, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiNCKH WHERE MaTaiNCKH = @MaTaiNCKH)
            THROW 50101, N'Mã tài NCKH không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 500
            THROW 50102, N'Số giờ không hợp lệ (1-500)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV AND MaTaiNCKH = @MaTaiNCKH)
            THROW 50103, N'Giáo viên đã được phân công cho công trình này', 1;
        
        -- Check number of authors
        DECLARE @SoTacGia INT, @SoTacGiaHienTai INT;
        SELECT @SoTacGia = SoTacGia FROM TaiNCKH WHERE MaTaiNCKH = @MaTaiNCKH;
        SELECT @SoTacGiaHienTai = COUNT(*) FROM ChiTietNCKH WHERE MaTaiNCKH = @MaTaiNCKH;
        
        IF @SoTacGiaHienTai >= @SoTacGia
            THROW 50104, N'Đã đủ số tác giả cho công trình này', 1;
        
        -- Check role
        IF @VaiTro = N'Chủ nhiệm' AND EXISTS (
            SELECT 1 FROM ChiTietNCKH 
            WHERE MaTaiNCKH = @MaTaiNCKH AND VaiTro = N'Chủ nhiệm'
        )
            THROW 50105, N'Đã có chủ nhiệm cho công trình này', 1;
        
        -- Generate MaChiTietNCKH
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietNCKH;
        SET @MaChiTietNCKH = 'CTNCKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietNCKH (MaChiTietNCKH, VaiTro, MaGV, MaTaiNCKH, SoGio)
        VALUES (@MaChiTietNCKH, @VaiTro, @MaGV, @MaTaiNCKH, @SoGio);
        
        SET @ErrorMessage = N'Phân công NCKH thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietNCKH = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NCKH_ThemTai]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 4: QUẢN LÝ NGHIÊN CỨU KHOA HỌC
-- =============================================

-- 4.1. Thêm mới tài NCKH
CREATE   PROCEDURE [dbo].[sp_NCKH_ThemTai]
    @TenCongTrinhKhoaHoc NVARCHAR(200),
    @NamHoc NVARCHAR(20),
    @SoTacGia INT,
    @MaLoaiNCKH CHAR(15),
    @MaTaiNCKH CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoTacGia <= 0 OR @SoTacGia > 20
            THROW 50090, N'Số tác giả không hợp lệ (1-20)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiNCKH WHERE MaLoaiNCKH = @MaLoaiNCKH)
            THROW 50091, N'Mã loại NCKH không tồn tại', 1;
        
        -- Generate MaTaiNCKH
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiNCKH;
        SET @MaTaiNCKH = 'TNCKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiNCKH (MaTaiNCKH, TenCongTrinhKhoaHoc, NamHoc, SoTacGia, MaLoaiNCKH)
        VALUES (@MaTaiNCKH, @TenCongTrinhKhoaHoc, @NamHoc, @SoTacGia, @MaLoaiNCKH);
        
        SET @ErrorMessage = N'Thêm tài NCKH thành công. Mã: ' + @MaTaiNCKH;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiNCKH = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_DangNhap]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10.3. Đăng nhập
CREATE   PROCEDURE [dbo].[sp_NguoiDung_DangNhap]
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaNguoiDung NVARCHAR(50) OUTPUT,
    @MaLichSu NVARCHAR(50) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Hash password
        DECLARE @HashedPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhau);
        
        -- Check credentials
        SELECT @MaNguoiDung = MaNguoiDung
        FROM NguoiDung
        WHERE TenDangNhap = @TenDangNhap AND MatKhau = @HashedPassword;
        
        IF @MaNguoiDung IS NULL
            THROW 50230, N'Tên đăng nhập hoặc mật khẩu không chính xác', 1;
        
        -- Generate MaLichSu
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuDangNhap;
        SET @MaLichSu = 'LS' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Log login
        INSERT INTO LichSuDangNhap (MaLichSu, ThoiDiemDangNhap, ThoiDiemDangXuat, MaNguoiDung)
        VALUES (@MaLichSu, GETDATE(), NULL, @MaNguoiDung);
        
        SET @ErrorMessage = N'Đăng nhập thành công';
        
        COMMIT TRANSACTION;
        
        -- Return user info
        SELECT 
            ND.MaNguoiDung,
            ND.TenDangNhap,
            GV.HoTen,
            GV.Email,
            STRING_AGG(NND.TenNhom, ', ') AS DanhSachNhom
        FROM NguoiDung ND
        LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
        LEFT JOIN NguoiDung_Nhom NDN ON ND.MaNguoiDung = NDN.MaNguoiDung
        LEFT JOIN NhomNguoiDung NND ON NDN.MaNhom = NND.MaNhom
        WHERE ND.MaNguoiDung = @MaNguoiDung
        GROUP BY ND.MaNguoiDung, ND.TenDangNhap, GV.HoTen, GV.Email;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaNguoiDung = NULL;
        SET @MaLichSu = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_DangXuat]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10.4. Đăng xuất
CREATE   PROCEDURE [dbo].[sp_NguoiDung_DangXuat]
    @MaLichSu NVARCHAR(50),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE LichSuDangNhap
        SET ThoiDiemDangXuat = GETDATE()
        WHERE MaLichSu = @MaLichSu AND ThoiDiemDangXuat IS NULL;
        
        IF @@ROWCOUNT = 0
            THROW 50240, N'Phiên đăng nhập không tồn tại hoặc đã kết thúc', 1;
        
        SET @ErrorMessage = N'Đăng xuất thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_DoiMatKhau]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10.2. Đổi mật khẩu
CREATE   PROCEDURE [dbo].[sp_NguoiDung_DoiMatKhau]
    @MaNguoiDung NVARCHAR(50),
    @MatKhauCu NVARCHAR(100),
    @MatKhauMoi NVARCHAR(100),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate old password
        DECLARE @HashedOldPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhauCu);
        
        IF NOT EXISTS (
            SELECT 1 FROM NguoiDung 
            WHERE MaNguoiDung = @MaNguoiDung AND MatKhau = @HashedOldPassword
        )
            THROW 50220, N'Mật khẩu cũ không chính xác', 1;
        
        -- Validate new password
        IF LEN(@MatKhauMoi) < 6
            THROW 50221, N'Mật khẩu mới phải có ít nhất 6 ký tự', 1;
        
        -- Update password
        DECLARE @HashedNewPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhauMoi);
        
        UPDATE NguoiDung
        SET MatKhau = @HashedNewPassword
        WHERE MaNguoiDung = @MaNguoiDung;
        
        SET @ErrorMessage = N'Đổi mật khẩu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_KiemTraQuyen]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10.5. Kiểm tra quyền
CREATE   PROCEDURE [dbo].[sp_NguoiDung_KiemTraQuyen]
    @MaNguoiDung NVARCHAR(50),
    @MaQuyen NVARCHAR(50),
    @CoQuyen BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SET @CoQuyen = 0;
    
    IF EXISTS (
        SELECT 1
        FROM NguoiDung_Nhom NDN
        INNER JOIN Nhom_Quyen NQ ON NDN.MaNhom = NQ.MaNhom
        WHERE NDN.MaNguoiDung = @MaNguoiDung AND NQ.MaQuyen = @MaQuyen
    )
        SET @CoQuyen = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NguoiDung_TaoTaiKhoan]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 10: QUẢN LÝ NGƯỜI DÙNG VÀ PHÂN QUYỀN
-- =============================================

-- 10.1. Tạo tài khoản người dùng
CREATE   PROCEDURE [dbo].[sp_NguoiDung_TaoTaiKhoan]
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaGV CHAR(15) = NULL,
    @MaNhom NVARCHAR(50) = NULL,
    @MaNguoiDung NVARCHAR(50) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF EXISTS (SELECT 1 FROM NguoiDung WHERE TenDangNhap = @TenDangNhap)
            THROW 50210, N'Tên đăng nhập đã tồn tại', 1;
            
        IF @MaGV IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
                THROW 50211, N'Mã giáo viên không tồn tại', 1;
                
            IF EXISTS (SELECT 1 FROM NguoiDung WHERE MaGV = @MaGV)
                THROW 50212, N'Giáo viên đã có tài khoản', 1;
        END
        
        -- Hash password (in production, use proper hashing)
        DECLARE @HashedPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhau);
        
        -- Generate MaNguoiDung
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM NguoiDung;
        SET @MaNguoiDung = 'ND' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert user
        INSERT INTO NguoiDung (MaNguoiDung, TenDangNhap, MatKhau, MaGV)
        VALUES (@MaNguoiDung, @TenDangNhap, @HashedPassword, @MaGV);
        
        -- Add to group if specified
        IF @MaNhom IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM NhomNguoiDung WHERE MaNhom = @MaNhom)
                THROW 50213, N'Mã nhóm không tồn tại', 1;
                
            INSERT INTO NguoiDung_Nhom (MaNguoiDung, MaNhom)
            VALUES (@MaNguoiDung, @MaNhom);
        END
        
        SET @ErrorMessage = N'Tạo tài khoản thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaNguoiDung = NULL;
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NhatKy_GhiLog]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 11: NHẬT KÝ VÀ AUDIT
-- =============================================

-- 11.1. Ghi nhật ký thay đổi
CREATE   PROCEDURE [dbo].[sp_NhatKy_GhiLog]
    @MaLichSu NVARCHAR(50),
    @NoiDungThayDoi NVARCHAR(255),
    @ThongTinCu NVARCHAR(255),
    @ThongTinMoi NVARCHAR(255),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM LichSuDangNhap WHERE MaLichSu = @MaLichSu)
            THROW 50250, N'Mã lịch sử không tồn tại', 1;
        
        -- Generate MaNhatKy
        DECLARE @MaNhatKy NVARCHAR(50);
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM NhatKyThayDoi;
        SET @MaNhatKy = 'NK' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO NhatKyThayDoi (MaNhatKy, MaLichSu, ThoiGianThayDoi, NoiDungThayDoi, ThongTinCu, ThongTinMoi)
        VALUES (@MaNhatKy, @MaLichSu, GETDATE(), @NoiDungThayDoi, @ThongTinCu, @ThongTinMoi);
        
        SET @ErrorMessage = N'Ghi nhật ký thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_NhatKy_XemLichSu]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 11.2. Xem lịch sử hoạt động
CREATE   PROCEDURE [dbo].[sp_NhatKy_XemLichSu]
    @MaNguoiDung NVARCHAR(50) = NULL,
    @TuNgay DATE = NULL,
    @DenNgay DATE = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @TuNgay IS NULL
        SET @TuNgay = DATEADD(DAY, -30, GETDATE());
        
    IF @DenNgay IS NULL
        SET @DenNgay = GETDATE();
    
    WITH CTE AS (
        SELECT 
            NK.MaNhatKy,
            NK.ThoiGianThayDoi,
            NK.NoiDungThayDoi,
            NK.ThongTinCu,
            NK.ThongTinMoi,
            LS.MaNguoiDung,
            ND.TenDangNhap,
            GV.HoTen,
            ROW_NUMBER() OVER (ORDER BY NK.ThoiGianThayDoi DESC) AS RowNum
        FROM NhatKyThayDoi NK
        INNER JOIN LichSuDangNhap LS ON NK.MaLichSu = LS.MaLichSu
        INNER JOIN NguoiDung ND ON LS.MaNguoiDung = ND.MaNguoiDung
        LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
        WHERE (@MaNguoiDung IS NULL OR LS.MaNguoiDung = @MaNguoiDung)
            AND CAST(NK.ThoiGianThayDoi AS DATE) BETWEEN @TuNgay AND @DenNgay
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_PhanCongChuNhiemBoMon]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 13. Phân công chủ nhiệm bộ môn
CREATE   PROCEDURE [dbo].[sp_PhanCongChuNhiemBoMon]
    @MaBM CHAR(15),
    @MaGV CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if BoMon exists
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE MaBM = @MaBM)
        BEGIN
            THROW 53011, N'Mã bộ môn không tồn tại.', 1;
        END

        -- Check if GiaoVien exists
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 53012, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Check if GiaoVien belongs to the BoMon
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV AND MaBM = @MaBM)
        BEGIN
            THROW 53013, N'Giáo viên không thuộc bộ môn này.', 1;
        END

        -- Update the record
        UPDATE BoMon
        SET MaChuNhiemBM = @MaGV
        WHERE MaBM = @MaBM;

        -- Check if there's a corresponding ChucVu record
        DECLARE @MaChucVu CHAR(15);
        SELECT @MaChucVu = MaChucVu FROM ChucVu WHERE TenChucVu = N'Trưởng bộ môn';

        IF @MaChucVu IS NOT NULL
        BEGIN
            -- Check if there's an existing record for this GiaoVien as Trưởng bộ môn
            DECLARE @MaLichSuChucVu CHAR(15);
            SELECT @MaLichSuChucVu = MaLichSuChucVu 
            FROM LichSuChucVu 
            WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL;

            IF @MaLichSuChucVu IS NULL
            BEGIN
                -- End any existing Trưởng bộ môn role for this BoMon
                UPDATE LichSuChucVu
                SET NgayKetThuc = GETDATE()
                FROM LichSuChucVu LSCV
                INNER JOIN GiaoVien GV ON LSCV.MaGV = GV.MaGV
                WHERE LSCV.MaChucVu = @MaChucVu 
                    AND LSCV.NgayKetThuc IS NULL
                    AND GV.MaBM = @MaBM;

                -- Generate a new MaLichSuChucVu
                SELECT @MaLichSuChucVu = 'LSCV' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
                FROM LichSuChucVu;

                -- Insert a new record for the new Trưởng bộ môn
                INSERT INTO LichSuChucVu (MaLichSuChucVu, NgayNhan, NgayKetThuc, MaGV, MaChucVu)
                VALUES (@MaLichSuChucVu, GETDATE(), NULL, @MaGV, @MaChucVu);
            END
        END

        -- Set success message
        SET @ErrorMessage = N'Phân công chủ nhiệm bộ môn thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi phân công chủ nhiệm bộ môn: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_PhanCongChuNhiemKhoa]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 12. Phân công chủ nhiệm khoa
CREATE   PROCEDURE [dbo].[sp_PhanCongChuNhiemKhoa]
    @MaKhoa CHAR(15),
    @MaGV CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if Khoa exists
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE MaKhoa = @MaKhoa)
        BEGIN
            THROW 53001, N'Mã khoa không tồn tại.', 1;
        END

        -- Check if GiaoVien exists
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 53002, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Update the record
        UPDATE Khoa
        SET MaChuNhiemKhoa = @MaGV
        WHERE MaKhoa = @MaKhoa;

        -- Check if there's a corresponding ChucVu record
        DECLARE @MaChucVu CHAR(15);
        SELECT @MaChucVu = MaChucVu FROM ChucVu WHERE TenChucVu = N'Trưởng khoa';

        IF @MaChucVu IS NOT NULL
        BEGIN
            -- Check if there's an existing record for this GiaoVien as Trưởng khoa
            DECLARE @MaLichSuChucVu CHAR(15);
            SELECT @MaLichSuChucVu = MaLichSuChucVu 
            FROM LichSuChucVu 
            WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL;

            IF @MaLichSuChucVu IS NULL
            BEGIN
                -- End any existing Trưởng khoa role for this Khoa
                UPDATE LichSuChucVu
                SET NgayKetThuc = GETDATE()
                FROM LichSuChucVu LSCV
                INNER JOIN GiaoVien GV ON LSCV.MaGV = GV.MaGV
                INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
                WHERE LSCV.MaChucVu = @MaChucVu 
                    AND LSCV.NgayKetThuc IS NULL
                    AND BM.MaKhoa = @MaKhoa;

                -- Generate a new MaLichSuChucVu
                SELECT @MaLichSuChucVu = 'LSCV' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
                FROM LichSuChucVu;

                -- Insert a new record for the new Trưởng khoa
                INSERT INTO LichSuChucVu (MaLichSuChucVu, NgayNhan, NgayKetThuc, MaGV, MaChucVu)
                VALUES (@MaLichSuChucVu, GETDATE(), NULL, @MaGV, @MaChucVu);
            END
        END

        -- Set success message
        SET @ErrorMessage = N'Phân công chủ nhiệm khoa thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi phân công chủ nhiệm khoa: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_PhanCongGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Phân công giảng dạy
CREATE   PROCEDURE [dbo].[sp_PhanCongGiangDay]
    @MaGV CHAR(15),
    @MaTaiGiangDay CHAR(15),
    @SoTiet INT,
    @GhiChu NVARCHAR(200),
    @MaNoiDungGiangDay CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaChiTietGiangDay CHAR(15);
    DECLARE @SoTietQuyDoi FLOAT;
    DECLARE @HeSoDoiTuong FLOAT = 1.0;
    DECLARE @HeSoThoiGian FLOAT = 1.0;
    DECLARE @HeSoNgonNgu FLOAT = 1.0;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @SoTiet <= 0
        BEGIN
            THROW 61001, N'Số tiết phải lớn hơn 0.', 1;
        END

        -- Check if GiaoVien exists
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 61002, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Check if TaiGiangDay exists
        IF NOT EXISTS (SELECT 1 FROM TaiGiangDay WITH (UPDLOCK) WHERE MaTaiGiangDay = @MaTaiGiangDay)
        BEGIN
            THROW 61003, N'Mã công tác giảng dạy không tồn tại.', 1;
        END

        -- Get the HeSoQuyChuan values for calculating SoTietQuyDoi
        SELECT @HeSoDoiTuong = DT.HeSoQuyChuan
        FROM TaiGiangDay TGD
        INNER JOIN DoiTuongGiangDay DT ON TGD.MaDoiTuong = DT.MaDoiTuong
        WHERE TGD.MaTaiGiangDay = @MaTaiGiangDay;

        SELECT @HeSoThoiGian = TG.HeSoQuyChuan
        FROM TaiGiangDay TGD
        INNER JOIN ThoiGianGiangDay TG ON TGD.MaThoiGian = TG.MaThoiGian
        WHERE TGD.MaTaiGiangDay = @MaTaiGiangDay;

        SELECT @HeSoNgonNgu = NN.HeSoQuyChuan
        FROM TaiGiangDay TGD
        INNER JOIN NgonNguGiangDay NN ON TGD.MaNgonNgu = NN.MaNgonNgu
        WHERE TGD.MaTaiGiangDay = @MaTaiGiangDay;

        -- Calculate SoTietQuyDoi
        SET @SoTietQuyDoi = @SoTiet * @HeSoDoiTuong * @HeSoThoiGian * @HeSoNgonNgu;

        -- Generate a new MaChiTietGiangDay
        SELECT @MaChiTietGiangDay = 'CTGD' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM ChiTietGiangDay;

        -- Insert the new record
        INSERT INTO ChiTietGiangDay (MaChiTietGiangDay, SoTiet, SoTietQuyDoi, GhiChu, MaGV, MaTaiGiangDay, MaNoiDungGiangDay)
        VALUES (@MaChiTietGiangDay, @SoTiet, @SoTietQuyDoi, @GhiChu, @MaGV, @MaTaiGiangDay, @MaNoiDungGiangDay);

        -- Set success message
        SET @ErrorMessage = N'Phân công giảng dạy thành công. Mã chi tiết: ' + @MaChiTietGiangDay;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi phân công giảng dạy: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_PhanCongKhaoThi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 6. Phân công khảo thí
CREATE   PROCEDURE [dbo].[sp_PhanCongKhaoThi]
    @MaGV CHAR(15),
    @MaTaiKhaoThi CHAR(15),
    @SoBai INT,
    @SoGioQuyChuan FLOAT,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaChiTietTaiKhaoThi CHAR(15);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @SoBai <= 0
        BEGIN
            THROW 65001, N'Số bài phải lớn hơn 0.', 1;
        END

        IF @SoGioQuyChuan <= 0
        BEGIN
            THROW 65002, N'Số giờ quy chuẩn phải lớn hơn 0.', 1;
        END

        -- Check if GiaoVien exists
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 65003, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Check if TaiKhaoThi exists
        IF NOT EXISTS (SELECT 1 FROM TaiKhaoThi WITH (UPDLOCK) WHERE MaTaiKhaoThi = @MaTaiKhaoThi)
        BEGIN
            THROW 65004, N'Mã công tác khảo thí không tồn tại.', 1;
        END

        -- Check if the GiaoVien is already assigned to this TaiKhaoThi
        IF EXISTS (SELECT 1 FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV AND MaTaiKhaoThi = @MaTaiKhaoThi)
        BEGIN
            THROW 65005, N'Giáo viên đã được phân công cho công tác khảo thí này.', 1;
        END

        -- Generate a new MaChiTietTaiKhaoThi
        SELECT @MaChiTietTaiKhaoThi = 'CTKT' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM ChiTietTaiKhaoThi;

        -- Insert the new record
        INSERT INTO ChiTietTaiKhaoThi (MaChiTietTaiKhaoThi, SoBai, SoGioQuyChuan, MaGV, MaTaiKhaoThi)
        VALUES (@MaChiTietTaiKhaoThi, @SoBai, @SoGioQuyChuan, @MaGV, @MaTaiKhaoThi);

        -- Set success message
        SET @ErrorMessage = N'Phân công khảo thí thành công. Mã chi tiết: ' + @MaChiTietTaiKhaoThi;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi phân công khảo thí: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_PhanCongNCKH]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. Phân công NCKH
CREATE   PROCEDURE [dbo].[sp_PhanCongNCKH]
    @MaGV CHAR(15),
    @MaTaiNCKH CHAR(15),
    @VaiTro NVARCHAR(100),
    @SoGio FLOAT,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaChiTietNCKH CHAR(15);
    DECLARE @SoTacGiaDangKy INT = 0;
    DECLARE @SoTacGia INT = 0;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @SoGio <= 0
        BEGIN
            THROW 63001, N'Số giờ phải lớn hơn 0.', 1;
        END

        -- Check if GiaoVien exists
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 63002, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Check if TaiNCKH exists
        IF NOT EXISTS (SELECT 1 FROM TaiNCKH WITH (UPDLOCK) WHERE MaTaiNCKH = @MaTaiNCKH)
        BEGIN
            THROW 63003, N'Mã công tác NCKH không tồn tại.', 1;
        END

        -- Check if the GiaoVien is already assigned to this TaiNCKH
        IF EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV AND MaTaiNCKH = @MaTaiNCKH)
        BEGIN
            THROW 63004, N'Giáo viên đã được phân công cho công tác NCKH này.', 1;
        END

        -- Get the SoTacGia from TaiNCKH
        SELECT @SoTacGia = SoTacGia FROM TaiNCKH WHERE MaTaiNCKH = @MaTaiNCKH;

        -- Count how many GiaoVien are already assigned to this TaiNCKH
        SELECT @SoTacGiaDangKy = COUNT(*) FROM ChiTietNCKH WHERE MaTaiNCKH = @MaTaiNCKH;

        -- Check if the number of assigned GiaoVien exceeds SoTacGia
        IF @SoTacGiaDangKy >= @SoTacGia
        BEGIN
            THROW 63005, N'Đã đạt đủ số lượng tác giả cho công tác NCKH này.', 1;
        END

        -- Generate a new MaChiTietNCKH
        SELECT @MaChiTietNCKH = 'CTNCKH' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM ChiTietNCKH;

        -- Insert the new record
        INSERT INTO ChiTietNCKH (MaChiTietNCKH, VaiTro, MaGV, MaTaiNCKH, SoGio)
        VALUES (@MaChiTietNCKH, @VaiTro, @MaGV, @MaTaiNCKH, @SoGio);

        -- Set success message
        SET @ErrorMessage = N'Phân công NCKH thành công. Mã chi tiết: ' + @MaChiTietNCKH;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi phân công NCKH: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaBoMon]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10. Cập nhật thông tin bộ môn
CREATE   PROCEDURE [dbo].[sp_SuaBoMon]
    @MaBM CHAR(15),
    @TenBM NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaKhoa CHAR(15),
    @MaChuNhiemBM CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaBM IS NULL OR LTRIM(RTRIM(@MaBM)) = ''
        BEGIN
            THROW 52011, N'Mã bộ môn không được để trống.', 1;
        END

        IF @TenBM IS NULL OR LTRIM(RTRIM(@TenBM)) = ''
        BEGIN
            THROW 52012, N'Tên bộ môn không được để trống.', 1;
        END

        -- Check if BoMon exists
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE MaBM = @MaBM)
        BEGIN
            THROW 52013, N'Mã bộ môn không tồn tại.', 1;
        END

        -- Check if Khoa exists
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE MaKhoa = @MaKhoa)
        BEGIN
            THROW 52014, N'Mã khoa không tồn tại.', 1;
        END

        -- Check if TenBM already exists for other BoMon in the same Khoa
        IF EXISTS (SELECT 1 FROM BoMon WHERE TenBM = @TenBM AND MaKhoa = @MaKhoa AND MaBM <> @MaBM)
        BEGIN
            THROW 52015, N'Tên bộ môn đã tồn tại trong khoa.', 1;
        END

        -- Check if GiaoVien exists for MaChuNhiemBM
        IF @MaChuNhiemBM IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaChuNhiemBM)
        BEGIN
            THROW 52016, N'Mã chủ nhiệm bộ môn không tồn tại.', 1;
        END

        -- Update the record
        UPDATE BoMon
        SET TenBM = @TenBM,
            DiaChi = @DiaChi,
            MaKhoa = @MaKhoa,
            MaChuNhiemBM = @MaChuNhiemBM
        WHERE MaBM = @MaBM;

        -- Set success message
        SET @ErrorMessage = N'Cập nhật bộ môn thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi cập nhật bộ môn: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Cập nhật thông tin giáo viên
CREATE   PROCEDURE [dbo].[sp_SuaGiaoVien]
    @MaGV CHAR(15),
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh BIT,
    @QueQuan NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @SDT INT,
    @Email NVARCHAR(100),
    @MaBM CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaGV IS NULL OR LTRIM(RTRIM(@MaGV)) = ''
        BEGIN
            THROW 50011, N'Mã giáo viên không được để trống.', 1;
        END

        IF @HoTen IS NULL OR LTRIM(RTRIM(@HoTen)) = ''
        BEGIN
            THROW 50012, N'Họ tên không được để trống.', 1;
        END

        IF @NgaySinh IS NULL OR @NgaySinh > GETDATE()
        BEGIN
            THROW 50013, N'Ngày sinh không hợp lệ.', 1;
        END

        IF @SDT IS NULL OR @SDT < 100000000 OR @SDT > 999999999
        BEGIN
            THROW 50014, N'Số điện thoại không hợp lệ.', 1;
        END

        IF @Email IS NULL OR @Email NOT LIKE '%_@__%.__%'
        BEGIN
            THROW 50015, N'Email không hợp lệ.', 1;
        END

        -- Check if GiaoVien exists
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 50016, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Check if BoMon exists
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE MaBM = @MaBM)
        BEGIN
            THROW 50017, N'Mã bộ môn không tồn tại.', 1;
        END

        -- Update the record
        UPDATE GiaoVien
        SET HoTen = @HoTen,
            NgaySinh = @NgaySinh,
            GioiTinh = @GioiTinh,
            QueQuan = @QueQuan,
            DiaChi = @DiaChi,
            SDT = @SDT,
            Email = @Email,
            MaBM = @MaBM
        WHERE MaGV = @MaGV;

        -- Set success message
        SET @ErrorMessage = N'Cập nhật giáo viên thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi cập nhật giáo viên: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaKhoa]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 7. Cập nhật thông tin khoa
CREATE   PROCEDURE [dbo].[sp_SuaKhoa]
    @MaKhoa CHAR(15),
    @TenKhoa NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaChuNhiemKhoa CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaKhoa IS NULL OR LTRIM(RTRIM(@MaKhoa)) = ''
        BEGIN
            THROW 51011, N'Mã khoa không được để trống.', 1;
        END

        IF @TenKhoa IS NULL OR LTRIM(RTRIM(@TenKhoa)) = ''
        BEGIN
            THROW 51012, N'Tên khoa không được để trống.', 1;
        END

        -- Check if Khoa exists
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE MaKhoa = @MaKhoa)
        BEGIN
            THROW 51013, N'Mã khoa không tồn tại.', 1;
        END

        -- Check if TenKhoa already exists for other Khoa
        IF EXISTS (SELECT 1 FROM Khoa WHERE TenKhoa = @TenKhoa AND MaKhoa <> @MaKhoa)
        BEGIN
            THROW 51014, N'Tên khoa đã tồn tại.', 1;
        END

        -- Check if GiaoVien exists for MaChuNhiemKhoa
        IF @MaChuNhiemKhoa IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaChuNhiemKhoa)
        BEGIN
            THROW 51015, N'Mã chủ nhiệm khoa không tồn tại.', 1;
        END

        -- Update the record
        UPDATE Khoa
        SET TenKhoa = @TenKhoa,
            DiaChi = @DiaChi,
            MaChuNhiemKhoa = @MaChuNhiemKhoa
        WHERE MaKhoa = @MaKhoa;

        -- Set success message
        SET @ErrorMessage = N'Cập nhật khoa thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi cập nhật khoa: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Cập nhật người dùng
CREATE   PROCEDURE [dbo].[sp_SuaNguoiDung]
    @MaNguoiDung NVARCHAR(50),
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100) = NULL,
    @MaGV CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaNguoiDung IS NULL OR LTRIM(RTRIM(@MaNguoiDung)) = ''
        BEGIN
            THROW 70011, N'Mã người dùng không được để trống.', 1;
        END

        IF @TenDangNhap IS NULL OR LTRIM(RTRIM(@TenDangNhap)) = ''
        BEGIN
            THROW 70012, N'Tên đăng nhập không được để trống.', 1;
        END

        -- Check if NguoiDung exists
        IF NOT EXISTS (SELECT 1 FROM NguoiDung WITH (UPDLOCK) WHERE MaNguoiDung = @MaNguoiDung)
        BEGIN
            THROW 70013, N'Mã người dùng không tồn tại.', 1;
        END

        -- Check if TenDangNhap already exists for other NguoiDung
        IF EXISTS (SELECT 1 FROM NguoiDung WHERE TenDangNhap = @TenDangNhap AND MaNguoiDung <> @MaNguoiDung)
        BEGIN
            THROW 70014, N'Tên đăng nhập đã tồn tại.', 1;
        END

        -- Check if MaGV exists (if provided)
        IF @MaGV IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 70015, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Check if MaGV already has an account (other than the current one)
        IF @MaGV IS NOT NULL AND EXISTS (SELECT 1 FROM NguoiDung WHERE MaGV = @MaGV AND MaNguoiDung <> @MaNguoiDung)
        BEGIN
            THROW 70016, N'Giáo viên này đã có tài khoản khác.', 1;
        END

        -- Hash the password if provided (simplified hash for demo - in production use proper encryption)
        DECLARE @HashedPassword NVARCHAR(100);
        IF @MatKhau IS NOT NULL
        BEGIN
            SET @HashedPassword = @MatKhau; -- Replace with proper hashing in production
        END

        -- Update the record
        IF @MatKhau IS NULL
        BEGIN
            UPDATE NguoiDung
            SET TenDangNhap = @TenDangNhap,
                MaGV = @MaGV
            WHERE MaNguoiDung = @MaNguoiDung;
        END
        ELSE
        BEGIN
            UPDATE NguoiDung
            SET TenDangNhap = @TenDangNhap,
                MatKhau = @HashedPassword,
                MaGV = @MaGV
            WHERE MaNguoiDung = @MaNguoiDung;
        END

        -- Set success message
        SET @ErrorMessage = N'Cập nhật người dùng thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi cập nhật người dùng: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaNhomNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 5. Cập nhật nhóm người dùng
CREATE   PROCEDURE [dbo].[sp_SuaNhomNguoiDung]
    @MaNhom NVARCHAR(50),
    @TenNhom NVARCHAR(100),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaNhom IS NULL OR LTRIM(RTRIM(@MaNhom)) = ''
        BEGIN
            THROW 70041, N'Mã nhóm không được để trống.', 1;
        END

        IF @TenNhom IS NULL OR LTRIM(RTRIM(@TenNhom)) = ''
        BEGIN
            THROW 70042, N'Tên nhóm không được để trống.', 1;
        END

        -- Check if NhomNguoiDung exists
        IF NOT EXISTS (SELECT 1 FROM NhomNguoiDung WITH (UPDLOCK) WHERE MaNhom = @MaNhom)
        BEGIN
            THROW 70043, N'Mã nhóm không tồn tại.', 1;
        END

        -- Check if TenNhom already exists for other NhomNguoiDung
        IF EXISTS (SELECT 1 FROM NhomNguoiDung WHERE TenNhom = @TenNhom AND MaNhom <> @MaNhom)
        BEGIN
            THROW 70044, N'Tên nhóm đã tồn tại.', 1;
        END

        -- Update the record
        UPDATE NhomNguoiDung
        SET TenNhom = @TenNhom
        WHERE MaNhom = @MaNhom;

        -- Set success message
        SET @ErrorMessage = N'Cập nhật nhóm người dùng thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi cập nhật nhóm người dùng: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaQuyen]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10. Cập nhật quyền
CREATE   PROCEDURE [dbo].[sp_SuaQuyen]
    @MaQuyen NVARCHAR(50),
    @TenQuyen NVARCHAR(100),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaQuyen IS NULL OR LTRIM(RTRIM(@MaQuyen)) = ''
        BEGIN
            THROW 70091, N'Mã quyền không được để trống.', 1;
        END

        IF @TenQuyen IS NULL OR LTRIM(RTRIM(@TenQuyen)) = ''
        BEGIN
            THROW 70092, N'Tên quyền không được để trống.', 1;
        END

        -- Check if Quyen exists
        IF NOT EXISTS (SELECT 1 FROM Quyen WITH (UPDLOCK) WHERE MaQuyen = @MaQuyen)
        BEGIN
            THROW 70093, N'Mã quyền không tồn tại.', 1;
        END

        -- Check if TenQuyen already exists for other Quyen
        IF EXISTS (SELECT 1 FROM Quyen WHERE TenQuyen = @TenQuyen AND MaQuyen <> @MaQuyen)
        BEGIN
            THROW 70094, N'Tên quyền đã tồn tại.', 1;
        END

        -- Update the record
        UPDATE Quyen
        SET TenQuyen = @TenQuyen
        WHERE MaQuyen = @MaQuyen;

        -- Set success message
        SET @ErrorMessage = N'Cập nhật quyền thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi cập nhật quyền: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_TaoDuLieuMau]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 9. Procedure tiện ích: Tự tạo dữ liệu mẫu để test
CREATE   PROCEDURE [dbo].[sp_TaoDuLieuMau]
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Tạo thêm giáo viên mẫu
        DECLARE @i INT = 11;
        DECLARE @MaGV CHAR(15);
        DECLARE @HoTen NVARCHAR(100);
        DECLARE @NgaySinh DATE;
        DECLARE @GioiTinh BIT;
        DECLARE @QueQuan NVARCHAR(100);
        DECLARE @DiaChi NVARCHAR(100);
        DECLARE @SDT INT;
        DECLARE @Email NVARCHAR(100);
        DECLARE @MaBM CHAR(15);
        
        WHILE @i <= 50
        BEGIN
            SET @MaGV = 'GV' + RIGHT('0000' + CAST(@i AS VARCHAR(4)), 4);
            SET @HoTen = N'Giáo viên mẫu ' + CAST(@i AS NVARCHAR(10));
            SET @NgaySinh = DATEADD(DAY, -CAST(RAND() * 10000 + 10000 AS INT), GETDATE());
            SET @GioiTinh = CAST(ROUND(RAND(), 0) AS BIT);
            SET @QueQuan = N'Địa điểm mẫu ' + CAST(@i AS NVARCHAR(10));
            SET @DiaChi = N'Địa chỉ mẫu ' + CAST(@i AS NVARCHAR(10));
            SET @SDT = 900000000 + @i;
            SET @Email = 'gv' + CAST(@i AS VARCHAR(10)) + '@school.edu.vn';
            SET @MaBM = 'BM00' + CAST((@i % 7) + 1 AS VARCHAR(1));
            
            INSERT INTO GiaoVien (MaGV, HoTen, NgaySinh, GioiTinh, QueQuan, DiaChi, SDT, Email, MaBM)
            VALUES (@MaGV, @HoTen, @NgaySinh, @GioiTinh, @QueQuan, @DiaChi, @SDT, @Email, @MaBM);
            
            SET @i = @i + 1;
        END

        -- Cập nhật lại SequenceGenerator
        UPDATE SequenceGenerator SET LastSequence = 50 WHERE TableName = 'GiaoVien';

        -- Tạo dữ liệu học vị cho giáo viên mẫu
        SET @i = 11;
        DECLARE @MaHocVi CHAR(15);
        
        WHILE @i <= 50
        BEGIN
            SET @MaGV = 'GV' + RIGHT('0000' + CAST(@i AS VARCHAR(4)), 4);
            SET @MaHocVi = 'HV' + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3);
            
            -- Chọn ngẫu nhiên học vị (Thạc sĩ hoặc Tiến sĩ)
            DECLARE @TenHocVi NVARCHAR(100) = CASE WHEN @i % 3 = 0 THEN N'Tiến sĩ' ELSE N'Thạc sĩ' END;
            SET @NgaySinh = DATEADD(DAY, -CAST(RAND() * 5000 AS INT), GETDATE());
            
            INSERT INTO HocVi (MaHocVi, TenHocVi, NgayNhan, MaGV)
            VALUES (@MaHocVi, @TenHocVi, @NgaySinh, @MaGV);
            
            SET @i = @i + 1;
        END

        -- Tạo dữ liệu lịch sử học hàm cho một số giáo viên
        SET @i = 11;
        DECLARE @MaLSHocHam CHAR(15);
        DECLARE @MaHocHam CHAR(15);
        
        WHILE @i <= 20
        BEGIN
            SET @MaGV = 'GV' + RIGHT('0000' + CAST(@i AS VARCHAR(4)), 4);
            SET @MaLSHocHam = 'LSHH' + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3);
            
            -- Chọn học hàm dựa trên chỉ số
            SET @MaHocHam = CASE 
                WHEN @i % 5 = 0 THEN 'HH001' -- Giáo sư
                WHEN @i % 5 = 1 THEN 'HH002' -- Phó giáo sư
                ELSE 'HH003' -- Tiến sĩ
            END;
            
            SET @NgaySinh = DATEADD(DAY, -CAST(RAND() * 3000 AS INT), GETDATE());
            
            INSERT INTO LichSuHocHam (MaLSHocHam, TenHocHam, NgayNhan, MaGV, MaHocHam)
            VALUES (@MaLSHocHam, CASE 
                        WHEN @MaHocHam = 'HH001' THEN N'Giáo sư' 
                        WHEN @MaHocHam = 'HH002' THEN N'Phó giáo sư'
                        ELSE N'Tiến sĩ'
                    END, @NgaySinh, @MaGV, @MaHocHam);
            
            SET @i = @i + 1;
        END

        -- Tạo dữ liệu giảng dạy mẫu
        SET @i = 11;
        DECLARE @MaTaiGiangDay CHAR(15);
        DECLARE @MaChiTietGiangDay CHAR(15);
        DECLARE @SoTiet INT;
        
        WHILE @i <= 30
        BEGIN
            SET @MaTaiGiangDay = 'TGD' + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3);
            
            INSERT INTO TaiGiangDay (MaTaiGiangDay, TenHocPhan, SiSo, He, Lop, SoTinChi, GhiChu, NamHoc, MaDoiTuong, MaThoiGian, MaNgonNgu)
            VALUES (
                @MaTaiGiangDay, 
                N'Học phần mẫu ' + CAST(@i AS NVARCHAR(10)),
                30 + (@i % 30), -- Sĩ số từ 30-60
                N'Đại học',
                N'Lớp ' + CAST(@i AS NVARCHAR(10)),
                2 + (@i % 4), -- Số tín chỉ từ 2-5
                N'Ghi chú mẫu',
                N'2023-2024',
                'DT00' + CAST((@i % 5) + 1 AS VARCHAR(1)),
                'TG00' + CAST((@i % 5) + 1 AS VARCHAR(1)),
                'NN00' + CAST((@i % 5) + 1 AS VARCHAR(1))
            );
            
            -- Tạo chi tiết giảng dạy cho 2 giáo viên khác nhau
            DECLARE @j INT = 1;
            WHILE @j <= 2
            BEGIN
                SET @MaChiTietGiangDay = 'CTGD' + RIGHT('000' + CAST((@i * 10 + @j) AS VARCHAR(4)), 4);
                SET @MaGV = 'GV' + RIGHT('0000' + CAST((@i * 2 + @j) % 50 + 1 AS VARCHAR(4)), 4);
                SET @SoTiet = 30 + (@i % 15) * 2; -- Số tiết từ 30-60
                
                INSERT INTO ChiTietGiangDay (MaChiTietGiangDay, SoTiet, SoTietQuyDoi, GhiChu, MaGV, MaTaiGiangDay, MaNoiDungGiangDay)
                VALUES (
                    @MaChiTietGiangDay,
                    @SoTiet,
                    @SoTiet * (1 + (@j * 0.1)), -- Quy đổi với hệ số
                    N'Chi tiết giảng dạy mẫu',
                    @MaGV,
                    @MaTaiGiangDay,
                    'NDGD00' + CAST((@j % 2) + 1 AS VARCHAR(1)) -- Nội dung giảng dạy
                );
                
                SET @j = @j + 1;
            END
            
            SET @i = @i + 1;
        END

        -- Tạo dữ liệu NCKH mẫu
        SET @i = 11;
        DECLARE @MaTaiNCKH CHAR(15);
        DECLARE @MaChiTietNCKH CHAR(15);
        
        WHILE @i <= 30
        BEGIN
            SET @MaTaiNCKH = 'TNCKH' + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3);
            
            INSERT INTO TaiNCKH (MaTaiNCKH, TenCongTrinhKhoaHoc, NamHoc, SoTacGia, MaLoaiNCKH)
            VALUES (
                @MaTaiNCKH, 
                N'Công trình NCKH mẫu ' + CAST(@i AS NVARCHAR(10)),
                N'2023-2024',
                2 + (@i % 3), -- Số tác giả từ 2-4
                'LNCKH00' + CAST((@i % 7) + 1 AS VARCHAR(1))
            );
            
            -- Tạo chi tiết NCKH cho từng tác giả
            DECLARE @SoTacGia INT = 2 + (@i % 3);
            SET @j = 1;
            WHILE @j <= @SoTacGia
            BEGIN
                SET @MaChiTietNCKH = 'CTNCKH' + RIGHT('000' + CAST((@i * 10 + @j) AS VARCHAR(4)), 4);
                SET @MaGV = 'GV' + RIGHT('0000' + CAST((@i * 3 + @j) % 50 + 1 AS VARCHAR(4)), 4);
                
                INSERT INTO ChiTietNCKH (MaChiTietNCKH, VaiTro, MaGV, MaTaiNCKH, SoGio)
                VALUES (
                    @MaChiTietNCKH,
                    CASE WHEN @j = 1 THEN N'Chủ nhiệm' ELSE N'Thành viên' END,
                    @MaGV,
                    @MaTaiNCKH,
                    CASE WHEN @j = 1 THEN 60 + (@i % 20) ELSE 30 + (@i % 10) END -- Số giờ chủ nhiệm nhiều hơn thành viên
                );
                
                SET @j = @j + 1;
            END
            
            SET @i = @i + 1;
        END

        -- Tạo dữ liệu khảo thí mẫu
        SET @i = 11;
        DECLARE @MaTaiKhaoThi CHAR(15);
        DECLARE @MaChiTietTaiKhaoThi CHAR(15);
        
        WHILE @i <= 30
        BEGIN
            SET @MaTaiKhaoThi = 'KT' + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3);
            
            INSERT INTO TaiKhaoThi (MaTaiKhaoThi, HocPhan, Lop, NamHoc, GhiChu, MaLoaiCongTacKhaoThi)
            VALUES (
                @MaTaiKhaoThi, 
                N'Học phần khảo thí ' + CAST(@i AS NVARCHAR(10)),
                N'Lớp khảo thí ' + CAST(@i AS NVARCHAR(10)),
                N'2023-2024',
                N'Ghi chú khảo thí mẫu',
                'LKT0' + CAST((@i % 5) + 1 AS VARCHAR(1))
            );
            
            -- Tạo chi tiết khảo thí cho 1-2 giáo viên
            SET @j = 1;
            WHILE @j <= 1 + (@i % 2)
            BEGIN
                SET @MaChiTietTaiKhaoThi = 'CTKT' + RIGHT('000' + CAST((@i * 10 + @j) AS VARCHAR(4)), 4);
                SET @MaGV = 'GV' + RIGHT('0000' + CAST((@i * 3 + @j * 2) % 50 + 1 AS VARCHAR(4)), 4);
                
                INSERT INTO ChiTietTaiKhaoThi (MaChiTietTaiKhaoThi, SoBai, SoGioQuyChuan, MaGV, MaTaiKhaoThi)
                VALUES (
                    @MaChiTietTaiKhaoThi,
                    20 + (@i % 30), -- Số bài từ 20-50
                    10 + (@i % 15), -- Số giờ quy chuẩn từ 10-25
                    @MaGV,
                    @MaTaiKhaoThi
                );
                
                SET @j = @j + 1;
            END
            
            SET @i = @i + 1;
        END

        -- Tạo dữ liệu người dùng
        SET @i = 11;
        DECLARE @MaNguoiDung NVARCHAR(50);
        
        WHILE @i <= 30
        BEGIN
            SET @MaNguoiDung = 'ND' + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3);
            SET @MaGV = 'GV' + RIGHT('0000' + CAST(@i AS VARCHAR(4)), 4);
            
            INSERT INTO NguoiDung (MaNguoiDung, TenDangNhap, MatKhau, MaGV)
            VALUES (
                @MaNguoiDung,
                'user' + CAST(@i AS VARCHAR(10)),
                'password' + CAST(@i AS VARCHAR(10)),
                @MaGV
            );
            
            -- Thêm người dùng vào nhóm
            INSERT INTO NguoiDung_Nhom (MaNguoiDung, MaNhom)
            VALUES (
                @MaNguoiDung,
                CASE 
                    WHEN @i <= 15 THEN 'NHOM004' -- Giảng viên
                    WHEN @i <= 20 THEN 'NHOM003' -- Quản lý bộ môn
                    WHEN @i <= 25 THEN 'NHOM002' -- Quản lý khoa
                    ELSE 'NHOM005' -- Nhân viên
                END
            );
            
            SET @i = @i + 1;
        END

        SET @ErrorMessage = N'Tạo dữ liệu mẫu thành công!';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi tạo dữ liệu mẫu: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemBoMon]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 9. Thêm mới bộ môn
CREATE   PROCEDURE [dbo].[sp_ThemBoMon]
    @TenBM NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaKhoa CHAR(15),
    @MaChuNhiemBM CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaBM CHAR(15);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @TenBM IS NULL OR LTRIM(RTRIM(@TenBM)) = ''
        BEGIN
            THROW 52001, N'Tên bộ môn không được để trống.', 1;
        END

        -- Check if Khoa exists
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE MaKhoa = @MaKhoa)
        BEGIN
            THROW 52002, N'Mã khoa không tồn tại.', 1;
        END

        -- Check if BoMon already exists
        IF EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE TenBM = @TenBM AND MaKhoa = @MaKhoa)
        BEGIN
            THROW 52003, N'Tên bộ môn đã tồn tại trong khoa.', 1;
        END

        -- Check if GiaoVien exists for MaChuNhiemBM
        IF @MaChuNhiemBM IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaChuNhiemBM)
        BEGIN
            THROW 52004, N'Mã chủ nhiệm bộ môn không tồn tại.', 1;
        END

        -- Generate a new MaBM
        SELECT @MaBM = 'BM' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM BoMon;

        -- Insert the new record
        INSERT INTO BoMon (MaBM, TenBM, DiaChi, MaKhoa, MaChuNhiemBM)
        VALUES (@MaBM, @TenBM, @DiaChi, @MaKhoa, @MaChuNhiemBM);

        -- Set success message
        SET @ErrorMessage = N'Thêm bộ môn thành công. Mã bộ môn: ' + @MaBM;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm bộ môn: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemCongTacKhaoThi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 5. Thêm mới công tác khảo thí
CREATE   PROCEDURE [dbo].[sp_ThemCongTacKhaoThi]
    @MaTaiKhaoThi CHAR(15),
    @HocPhan NVARCHAR(100),
    @Lop NVARCHAR(50),
    @NamHoc NVARCHAR(20),
    @GhiChu NVARCHAR(200),
    @MaLoaiCongTacKhaoThi CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaTaiKhaoThi IS NULL OR LTRIM(RTRIM(@MaTaiKhaoThi)) = ''
        BEGIN
            THROW 64001, N'Mã công tác khảo thí không được để trống.', 1;
        END

        IF @HocPhan IS NULL OR LTRIM(RTRIM(@HocPhan)) = ''
        BEGIN
            THROW 64002, N'Học phần không được để trống.', 1;
        END

        IF @NamHoc IS NULL OR LTRIM(RTRIM(@NamHoc)) = ''
        BEGIN
            THROW 64003, N'Năm học không được để trống.', 1;
        END

        -- Check if TaiKhaoThi already exists
        IF EXISTS (SELECT 1 FROM TaiKhaoThi WITH (UPDLOCK) WHERE MaTaiKhaoThi = @MaTaiKhaoThi)
        BEGIN
            THROW 64004, N'Mã công tác khảo thí đã tồn tại.', 1;
        END

        -- Check if LoaiCongTacKhaoThi exists
        IF NOT EXISTS (SELECT 1 FROM LoaiCongTacKhaoThi WITH (UPDLOCK) WHERE MaLoaiCongTacKhaoThi = @MaLoaiCongTacKhaoThi)
        BEGIN
            THROW 64005, N'Mã loại công tác khảo thí không tồn tại.', 1;
        END

        -- Insert the new record
        INSERT INTO TaiKhaoThi (MaTaiKhaoThi, HocPhan, Lop, NamHoc, GhiChu, MaLoaiCongTacKhaoThi)
        VALUES (@MaTaiKhaoThi, @HocPhan, @Lop, @NamHoc, @GhiChu, @MaLoaiCongTacKhaoThi);

        -- Set success message
        SET @ErrorMessage = N'Thêm công tác khảo thí thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm công tác khảo thí: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Thêm mới giáo viên
CREATE   PROCEDURE [dbo].[sp_ThemGiaoVien]
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh BIT,
    @QueQuan NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @SDT INT,
    @Email NVARCHAR(100),
    @MaBM CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaGV CHAR(15);
    DECLARE @NextId INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @HoTen IS NULL OR LTRIM(RTRIM(@HoTen)) = ''
        BEGIN
            THROW 50001, N'Họ tên không được để trống.', 1;
        END

        IF @NgaySinh IS NULL OR @NgaySinh > GETDATE()
        BEGIN
            THROW 50002, N'Ngày sinh không hợp lệ.', 1;
        END

        IF @SDT IS NULL OR @SDT < 100000000 OR @SDT > 999999999
        BEGIN
            THROW 50003, N'Số điện thoại không hợp lệ.', 1;
        END

        IF @Email IS NULL OR @Email NOT LIKE '%_@__%.__%'
        BEGIN
            THROW 50004, N'Email không hợp lệ.', 1;
        END

        -- Check if bộ môn exists
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE MaBM = @MaBM)
        BEGIN
            THROW 50005, N'Mã bộ môn không tồn tại.', 1;
        END

        -- Get the next sequence number
        UPDATE SequenceGenerator WITH (UPDLOCK)
        SET LastSequence = LastSequence + 1,
            @NextId = LastSequence + 1
        WHERE TableName = 'GiaoVien';

        -- Format the MaGV
        SET @MaGV = 'GV' + RIGHT('0000' + CAST(@NextId AS VARCHAR(4)), 4);

        -- Check if MaGV already exists
        IF EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
        BEGIN
            THROW 50006, N'Mã giáo viên đã tồn tại.', 1;
        END

        -- Insert the new record
        INSERT INTO GiaoVien (MaGV, HoTen, NgaySinh, GioiTinh, QueQuan, DiaChi, SDT, Email, MaBM)
        VALUES (@MaGV, @HoTen, @NgaySinh, @GioiTinh, @QueQuan, @DiaChi, @SDT, @Email, @MaBM);

        -- Set success message
        SET @ErrorMessage = N'Thêm giáo viên thành công. Mã giáo viên: ' + @MaGV;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm giáo viên: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemKhoa]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 6. Thêm mới khoa
CREATE   PROCEDURE [dbo].[sp_ThemKhoa]
    @TenKhoa NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaChuNhiemKhoa CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaKhoa CHAR(15);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @TenKhoa IS NULL OR LTRIM(RTRIM(@TenKhoa)) = ''
        BEGIN
            THROW 51001, N'Tên khoa không được để trống.', 1;
        END

        -- Check if Khoa already exists
        IF EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE TenKhoa = @TenKhoa)
        BEGIN
            THROW 51002, N'Tên khoa đã tồn tại.', 1;
        END

        -- Check if GiaoVien exists for MaChuNhiemKhoa
        IF @MaChuNhiemKhoa IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaChuNhiemKhoa)
        BEGIN
            THROW 51003, N'Mã chủ nhiệm khoa không tồn tại.', 1;
        END

        -- Generate a new MaKhoa
        SELECT @MaKhoa = 'KHOA' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM Khoa;

        -- Insert the new record
        INSERT INTO Khoa (MaKhoa, TenKhoa, DiaChi, MaChuNhiemKhoa)
        VALUES (@MaKhoa, @TenKhoa, @DiaChi, @MaChuNhiemKhoa);

        -- Set success message
        SET @ErrorMessage = N'Thêm khoa thành công. Mã khoa: ' + @MaKhoa;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm khoa: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Thêm mới người dùng
CREATE   PROCEDURE [dbo].[sp_ThemNguoiDung]
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaGV CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaNguoiDung NVARCHAR(50);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @TenDangNhap IS NULL OR LTRIM(RTRIM(@TenDangNhap)) = ''
        BEGIN
            THROW 70001, N'Tên đăng nhập không được để trống.', 1;
        END

        IF @MatKhau IS NULL OR LTRIM(RTRIM(@MatKhau)) = ''
        BEGIN
            THROW 70002, N'Mật khẩu không được để trống.', 1;
        END

        -- Check if TenDangNhap already exists
        IF EXISTS (SELECT 1 FROM NguoiDung WITH (UPDLOCK) WHERE TenDangNhap = @TenDangNhap)
        BEGIN
            THROW 70003, N'Tên đăng nhập đã tồn tại.', 1;
        END

        -- Check if MaGV exists (if provided)
        IF @MaGV IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 70004, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Check if MaGV already has an account
        IF @MaGV IS NOT NULL AND EXISTS (SELECT 1 FROM NguoiDung WHERE MaGV = @MaGV)
        BEGIN
            THROW 70005, N'Giáo viên này đã có tài khoản.', 1;
        END

        -- Generate a new MaNguoiDung
        SELECT @MaNguoiDung = 'ND' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM NguoiDung;

        -- Hash the password (simplified hash for demo - in production use proper encryption)
        DECLARE @HashedPassword NVARCHAR(100);
        SET @HashedPassword = @MatKhau; -- Replace with proper hashing in production

        -- Insert the new record
        INSERT INTO NguoiDung (MaNguoiDung, TenDangNhap, MatKhau, MaGV)
        VALUES (@MaNguoiDung, @TenDangNhap, @HashedPassword, @MaGV);

        -- Set success message
        SET @ErrorMessage = N'Thêm người dùng thành công. Mã người dùng: ' + @MaNguoiDung;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm người dùng: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemNguoiDungVaoNhom]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 7. Thêm người dùng vào nhóm
CREATE   PROCEDURE [dbo].[sp_ThemNguoiDungVaoNhom]
    @MaNguoiDung NVARCHAR(50),
    @MaNhom NVARCHAR(50),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaNguoiDung IS NULL OR LTRIM(RTRIM(@MaNguoiDung)) = ''
        BEGIN
            THROW 70061, N'Mã người dùng không được để trống.', 1;
        END

        IF @MaNhom IS NULL OR LTRIM(RTRIM(@MaNhom)) = ''
        BEGIN
            THROW 70062, N'Mã nhóm không được để trống.', 1;
        END

        -- Check if NguoiDung exists
        IF NOT EXISTS (SELECT 1 FROM NguoiDung WITH (UPDLOCK) WHERE MaNguoiDung = @MaNguoiDung)
        BEGIN
            THROW 70063, N'Mã người dùng không tồn tại.', 1;
        END

        -- Check if NhomNguoiDung exists
        IF NOT EXISTS (SELECT 1 FROM NhomNguoiDung WITH (UPDLOCK) WHERE MaNhom = @MaNhom)
        BEGIN
            THROW 70064, N'Mã nhóm không tồn tại.', 1;
        END

        -- Check if the user is already in the group
        IF EXISTS (SELECT 1 FROM NguoiDung_Nhom WHERE MaNguoiDung = @MaNguoiDung AND MaNhom = @MaNhom)
        BEGIN
            THROW 70065, N'Người dùng đã thuộc nhóm này.', 1;
        END

        -- Insert the new record
        INSERT INTO NguoiDung_Nhom (MaNguoiDung, MaNhom)
        VALUES (@MaNguoiDung, @MaNhom);

        -- Set success message
        SET @ErrorMessage = N'Thêm người dùng vào nhóm thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm người dùng vào nhóm: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemNhomNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. Thêm mới nhóm người dùng
CREATE   PROCEDURE [dbo].[sp_ThemNhomNguoiDung]
    @TenNhom NVARCHAR(100),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaNhom NVARCHAR(50);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @TenNhom IS NULL OR LTRIM(RTRIM(@TenNhom)) = ''
        BEGIN
            THROW 70031, N'Tên nhóm không được để trống.', 1;
        END

        -- Check if TenNhom already exists
        IF EXISTS (SELECT 1 FROM NhomNguoiDung WITH (UPDLOCK) WHERE TenNhom = @TenNhom)
        BEGIN
            THROW 70032, N'Tên nhóm đã tồn tại.', 1;
        END

        -- Generate a new MaNhom
        SELECT @MaNhom = 'NHOM' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM NhomNguoiDung;

        -- Insert the new record
        INSERT INTO NhomNguoiDung (MaNhom, TenNhom)
        VALUES (@MaNhom, @TenNhom);

        -- Set success message
        SET @ErrorMessage = N'Thêm nhóm người dùng thành công. Mã nhóm: ' + @MaNhom;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm nhóm người dùng: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemQuyen]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 9. Thêm mới quyền
CREATE   PROCEDURE [dbo].[sp_ThemQuyen]
    @TenQuyen NVARCHAR(100),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaQuyen NVARCHAR(50);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @TenQuyen IS NULL OR LTRIM(RTRIM(@TenQuyen)) = ''
        BEGIN
            THROW 70081, N'Tên quyền không được để trống.', 1;
        END

        -- Check if TenQuyen already exists
        IF EXISTS (SELECT 1 FROM Quyen WITH (UPDLOCK) WHERE TenQuyen = @TenQuyen)
        BEGIN
            THROW 70082, N'Tên quyền đã tồn tại.', 1;
        END

        -- Generate a new MaQuyen
        SELECT @MaQuyen = 'QUYEN' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM Quyen;

        -- Insert the new record
        INSERT INTO Quyen (MaQuyen, TenQuyen)
        VALUES (@MaQuyen, @TenQuyen);

        -- Set success message
        SET @ErrorMessage = N'Thêm quyền thành công. Mã quyền: ' + @MaQuyen;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm quyền: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemTaiGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Thêm mới công tác giảng dạy
CREATE   PROCEDURE [dbo].[sp_ThemTaiGiangDay]
    @TenHocPhan NVARCHAR(100),
    @SiSo INT,
    @He NVARCHAR(20),
    @Lop NVARCHAR(20),
    @SoTinChi INT,
    @GhiChu NVARCHAR(200),
    @NamHoc NVARCHAR(20),
    @MaDoiTuong CHAR(15),
    @MaThoiGian CHAR(15),
    @MaNgonNgu CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaTaiGiangDay CHAR(15);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @TenHocPhan IS NULL OR LTRIM(RTRIM(@TenHocPhan)) = ''
        BEGIN
            THROW 60001, N'Tên học phần không được để trống.', 1;
        END

        IF @SiSo <= 0
        BEGIN
            THROW 60002, N'Sĩ số phải lớn hơn 0.', 1;
        END

        IF @SoTinChi <= 0
        BEGIN
            THROW 60003, N'Số tín chỉ phải lớn hơn 0.', 1;
        END

        IF @NamHoc IS NULL OR LTRIM(RTRIM(@NamHoc)) = ''
        BEGIN
            THROW 60004, N'Năm học không được để trống.', 1;
        END

        -- Check if foreign keys exist
        IF NOT EXISTS (SELECT 1 FROM DoiTuongGiangDay WITH (UPDLOCK) WHERE MaDoiTuong = @MaDoiTuong)
        BEGIN
            THROW 60005, N'Mã đối tượng giảng dạy không tồn tại.', 1;
        END

        IF NOT EXISTS (SELECT 1 FROM ThoiGianGiangDay WITH (UPDLOCK) WHERE MaThoiGian = @MaThoiGian)
        BEGIN
            THROW 60006, N'Mã thời gian giảng dạy không tồn tại.', 1;
        END

        IF NOT EXISTS (SELECT 1 FROM NgonNguGiangDay WITH (UPDLOCK) WHERE MaNgonNgu = @MaNgonNgu)
        BEGIN
            THROW 60007, N'Mã ngôn ngữ giảng dạy không tồn tại.', 1;
        END

        -- Generate a new MaTaiGiangDay
        SELECT @MaTaiGiangDay = 'TGD' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM TaiGiangDay;

        -- Insert the new record
        INSERT INTO TaiGiangDay (MaTaiGiangDay, TenHocPhan, SiSo, He, Lop, SoTinChi, GhiChu, NamHoc, MaDoiTuong, MaThoiGian, MaNgonNgu)
        VALUES (@MaTaiGiangDay, @TenHocPhan, @SiSo, @He, @Lop, @SoTinChi, @GhiChu, @NamHoc, @MaDoiTuong, @MaThoiGian, @MaNgonNgu);

        -- Set success message
        SET @ErrorMessage = N'Thêm công tác giảng dạy thành công. Mã công tác: ' + @MaTaiGiangDay;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm công tác giảng dạy: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemTaiNCKH]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Thêm mới công tác NCKH
CREATE   PROCEDURE [dbo].[sp_ThemTaiNCKH]
    @TenCongTrinhKhoaHoc NVARCHAR(200),
    @NamHoc NVARCHAR(20),
    @SoTacGia INT,
    @MaLoaiNCKH CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    DECLARE @MaTaiNCKH CHAR(15);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @TenCongTrinhKhoaHoc IS NULL OR LTRIM(RTRIM(@TenCongTrinhKhoaHoc)) = ''
        BEGIN
            THROW 62001, N'Tên công trình khoa học không được để trống.', 1;
        END

        IF @NamHoc IS NULL OR LTRIM(RTRIM(@NamHoc)) = ''
        BEGIN
            THROW 62002, N'Năm học không được để trống.', 1;
        END

        IF @SoTacGia <= 0
        BEGIN
            THROW 62003, N'Số tác giả phải lớn hơn 0.', 1;
        END

        -- Check if LoaiNCKH exists
        IF NOT EXISTS (SELECT 1 FROM LoaiNCKH WITH (UPDLOCK) WHERE MaLoaiNCKH = @MaLoaiNCKH)
        BEGIN
            THROW 62004, N'Mã loại NCKH không tồn tại.', 1;
        END

        -- Generate a new MaTaiNCKH
        SELECT @MaTaiNCKH = 'TNCKH' + RIGHT('000' + CAST(COUNT(*) + 1 AS VARCHAR(3)), 3)
        FROM TaiNCKH;

        -- Insert the new record
        INSERT INTO TaiNCKH (MaTaiNCKH, TenCongTrinhKhoaHoc, NamHoc, SoTacGia, MaLoaiNCKH)
        VALUES (@MaTaiNCKH, @TenCongTrinhKhoaHoc, @NamHoc, @SoTacGia, @MaLoaiNCKH);

        -- Set success message
        SET @ErrorMessage = N'Thêm công tác NCKH thành công. Mã công tác: ' + @MaTaiNCKH;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thêm công tác NCKH: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongKeSoGioGiangDay]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 7. Thống kê số giờ giảng dạy theo giáo viên
CREATE   PROCEDURE [dbo].[sp_ThongKeSoGioGiangDay]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        SUM(CTGD.SoTiet) AS TongSoTiet,
        SUM(CTGD.SoTietQuyDoi) AS TongSoTietQuyDoi,
        COUNT(DISTINCT TGD.MaTaiGiangDay) AS SoLuongHocPhan
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
    LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE 
        (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    GROUP BY GV.MaGV, GV.HoTen, BM.TenBM, K.TenKhoa
    ORDER BY TongSoTietQuyDoi DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongKeSoGioKhaoThi]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 9. Thống kê số giờ khảo thí theo giáo viên
CREATE   PROCEDURE [dbo].[sp_ThongKeSoGioKhaoThi]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        SUM(CTKT.SoGioQuyChuan) AS TongSoGioQuyChuan,
        SUM(CTKT.SoBai) AS TongSoBai,
        COUNT(DISTINCT TKT.MaTaiKhaoThi) AS SoLuongCongTac
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN ChiTietTaiKhaoThi CTKT ON GV.MaGV = CTKT.MaGV
    LEFT JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
    WHERE 
        (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TKT.NamHoc = @NamHoc)
    GROUP BY GV.MaGV, GV.HoTen, BM.TenBM, K.TenKhoa
    ORDER BY TongSoGioQuyChuan DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongKeSoGioNCKH]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 8. Thống kê số giờ NCKH theo giáo viên
CREATE   PROCEDURE [dbo].[sp_ThongKeSoGioNCKH]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        SUM(CTNCKH.SoGio) AS TongSoGio,
        COUNT(DISTINCT TNCKH.MaTaiNCKH) AS SoLuongCongTrinh
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
    LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    WHERE 
        (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    GROUP BY GV.MaGV, GV.HoTen, BM.TenBM, K.TenKhoa
    ORDER BY TongSoGio DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThuHoiQuyenTuNhom]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 13. Thu hồi quyền từ nhóm
CREATE   PROCEDURE [dbo].[sp_ThuHoiQuyenTuNhom]
    @MaNhom NVARCHAR(50),
    @MaQuyen NVARCHAR(50),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaNhom IS NULL OR LTRIM(RTRIM(@MaNhom)) = ''
        BEGIN
            THROW 70121, N'Mã nhóm không được để trống.', 1;
        END

        IF @MaQuyen IS NULL OR LTRIM(RTRIM(@MaQuyen)) = ''
        BEGIN
            THROW 70122, N'Mã quyền không được để trống.', 1;
        END

        -- Check if the permission is assigned to the group
        IF NOT EXISTS (SELECT 1 FROM Nhom_Quyen WITH (UPDLOCK) WHERE MaNhom = @MaNhom AND MaQuyen = @MaQuyen)
        BEGIN
            THROW 70123, N'Quyền chưa được cấp cho nhóm này.', 1;
        END

        -- Delete the record
        DELETE FROM Nhom_Quyen
        WHERE MaNhom = @MaNhom AND MaQuyen = @MaQuyen;

        -- Set success message
        SET @ErrorMessage = N'Thu hồi quyền từ nhóm thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi thu hồi quyền từ nhóm: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_TimKiemGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. Tìm kiếm giáo viên
CREATE   PROCEDURE [dbo].[sp_TimKiemGiaoVien]
    @TimKiem NVARCHAR(100),
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        GV.MaGV,
        GV.HoTen,
        GV.NgaySinh,
        GV.GioiTinh,
        GV.QueQuan,
        GV.DiaChi,
        GV.SDT,
        GV.Email,
        BM.MaBM,
        BM.TenBM,
        K.MaKhoa,
        K.TenKhoa
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    WHERE 
        (@TimKiem IS NULL OR GV.HoTen LIKE N'%' + @TimKiem + N'%' OR GV.Email LIKE N'%' + @TimKiem + N'%')
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
    ORDER BY GV.HoTen;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_TongHopKhoiLuongCongTac]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10. Tổng hợp khối lượng công tác của giáo viên
CREATE   PROCEDURE [dbo].[sp_TongHopKhoiLuongCongTac]
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    WITH GiangDayStats AS (
        SELECT 
            GV.MaGV,
            SUM(CTGD.SoTietQuyDoi) AS TongSoTietQuyDoi
        FROM GiaoVien GV
        LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
        LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    NCKHStats AS (
        SELECT 
            GV.MaGV,
            SUM(CTNCKH.SoGio) AS TongSoGioNCKH
        FROM GiaoVien GV
        LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
        LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        WHERE (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    KhaoThiStats AS (
        SELECT 
            GV.MaGV,
            SUM(CTKT.SoGioQuyChuan) AS TongSoGioKhaoThi
        FROM GiaoVien GV
        LEFT JOIN ChiTietTaiKhaoThi CTKT ON GV.MaGV = CTKT.MaGV
        LEFT JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
        WHERE (@NamHoc IS NULL OR TKT.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    HoiDongStats AS (
        SELECT 
            GV.MaGV,
            SUM(TG.SoGio) AS TongSoGioHoiDong
        FROM GiaoVien GV
        LEFT JOIN ThamGia TG ON GV.MaGV = TG.MaGV
        LEFT JOIN TaiHoiDong THD ON TG.MaHoiDong = THD.MaHoiDong
        WHERE (@NamHoc IS NULL OR THD.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    ),
    HuongDanStats AS (
        SELECT 
            GV.MaGV,
            SUM(TGHD.SoGio) AS TongSoGioHuongDan
        FROM GiaoVien GV
        LEFT JOIN ThamGiaHuongDan TGHD ON GV.MaGV = TGHD.MaGV
        LEFT JOIN TaiHuongDan THD ON TGHD.MaHuongDan = THD.MaHuongDan
        WHERE (@NamHoc IS NULL OR THD.NamHoc = @NamHoc)
        GROUP BY GV.MaGV
    )
    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        ISNULL(GD.TongSoTietQuyDoi, 0) AS TongSoTietGiangDay,
        ISNULL(NCKH.TongSoGioNCKH, 0) AS TongSoGioNCKH,
        ISNULL(KT.TongSoGioKhaoThi, 0) AS TongSoGioKhaoThi,
        ISNULL(HD.TongSoGioHoiDong, 0) AS TongSoGioHoiDong,
        ISNULL(HDan.TongSoGioHuongDan, 0) AS TongSoGioHuongDan,
        ISNULL(GD.TongSoTietQuyDoi, 0) + ISNULL(NCKH.TongSoGioNCKH, 0) + ISNULL(KT.TongSoGioKhaoThi, 0) + 
        ISNULL(HD.TongSoGioHoiDong, 0) + ISNULL(HDan.TongSoGioHuongDan, 0) AS TongSoGioQuyChuan
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN GiangDayStats GD ON GV.MaGV = GD.MaGV
    LEFT JOIN NCKHStats NCKH ON GV.MaGV = NCKH.MaGV
    LEFT JOIN KhaoThiStats KT ON GV.MaGV = KT.MaGV
    LEFT JOIN HoiDongStats HD ON GV.MaGV = HD.MaGV
    LEFT JOIN HuongDanStats HDan ON GV.MaGV = HDan.MaGV
    WHERE 
        (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR GV.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
    ORDER BY TongSoGioQuyChuan DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Utility_BackupData]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 14.2. Backup dữ liệu
CREATE   PROCEDURE [dbo].[sp_Utility_BackupData]
    @TableName NVARCHAR(100),
    @BackupTableName NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Generate backup table name if not provided
        IF @BackupTableName IS NULL
            SET @BackupTableName = @TableName + '_Backup_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');
        
        -- Create backup table
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = 'SELECT * INTO ' + QUOTENAME(@BackupTableName) + ' FROM ' + QUOTENAME(@TableName);
        
        EXEC sp_executesql @SQL;
        
        -- Get row count
        DECLARE @RowCount INT;
        SET @SQL = 'SELECT @Count = COUNT(*) FROM ' + QUOTENAME(@BackupTableName);
        EXEC sp_executesql @SQL, N'@Count INT OUTPUT', @Count = @RowCount OUTPUT;
        
        PRINT N'Backup thành công. Tên bảng: ' + @BackupTableName + ', Số dòng: ' + CAST(@RowCount AS NVARCHAR(10));
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Utility_KiemTraDatabase]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- SECTION 14: UTILITIES VÀ HELPER PROCEDURES
-- =============================================

-- 14.1. Kiểm tra tình trạng database
CREATE   PROCEDURE [dbo].[sp_Utility_KiemTraDatabase]
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Kiểm tra số lượng bản ghi trong các bảng chính
    SELECT 
        'GiaoVien' AS TenBang,
        COUNT(*) AS SoBanGhi,
        CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END AS TrangThai
    FROM GiaoVien
    UNION ALL
    SELECT 'Khoa', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM Khoa
    UNION ALL
    SELECT 'BoMon', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM BoMon
    UNION ALL
    SELECT 'NguoiDung', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM NguoiDung
    UNION ALL
    SELECT 'TaiGiangDay', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM TaiGiangDay
    UNION ALL
    SELECT 'TaiNCKH', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM TaiNCKH
    ORDER BY TenBang;
    
    -- Kiểm tra các foreign key constraint
    SELECT 
        fk.name AS ForeignKeyName,
        tp.name AS ParentTable,
        cp.name AS ParentColumn,
        tr.name AS ReferencedTable,
        cr.name AS ReferencedColumn,
        CASE fk.is_disabled WHEN 0 THEN N'Hoạt động' ELSE N'Vô hiệu' END AS TrangThai
    FROM sys.foreign_keys fk
    INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
    INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
    INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
    INNER JOIN sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id
    ORDER BY tp.name, fk.name;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Utility_TaoDuLieuMau]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 14.3. Khởi tạo dữ liệu mẫu cho demo
CREATE   PROCEDURE [dbo].[sp_Utility_TaoDuLieuMau]
    @SoLuongGiaoVien INT = 10,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DECLARE @i INT = 1;
        DECLARE @MaGV CHAR(15);
        DECLARE @MaKhoa CHAR(15);
        DECLARE @MaBM CHAR(15);
        
        -- Tạo giáo viên mẫu
        WHILE @i <= @SoLuongGiaoVien
        BEGIN
            -- Get random BoMon
            SELECT TOP 1 @MaBM = MaBM FROM BoMon ORDER BY NEWID();
            
            -- Create teacher
            EXEC sp_GiaoVien_ThemMoi
                @HoTen = N'Giáo viên mẫu',
                @NgaySinh = '1980-01-01',
                @GioiTinh = 1,
                @QueQuan = N'Hà Nội',
                @DiaChi = N'Địa chỉ mẫu',
                @SDT = 900000000,
                @Email = 'demo@school.edu.vn',
                @MaBM = @MaBM,
                @MaGV = @MaGV OUTPUT,
                @ErrorMessage = @ErrorMessage OUTPUT;
            
            -- Update name and email
            UPDATE GiaoVien 
            SET HoTen = N'Giáo viên mẫu ' + CAST(@i AS NVARCHAR(10)),
                Email = 'demo' + CAST(@i AS VARCHAR(10)) + '@school.edu.vn',
                SDT = 900000000 + @i
            WHERE MaGV = @MaGV;
            
            -- Create user account
            EXEC sp_NguoiDung_TaoTaiKhoan
                @TenDangNhap = 'demo',
                @MatKhau = 'demo123',
                @MaGV = @MaGV,
                @MaNhom = 'NHOM004',
                @MaNguoiDung = NULL,
                @ErrorMessage = @ErrorMessage;
            
            -- Update username
            UPDATE NguoiDung 
            SET TenDangNhap = 'demo' + CAST(@i AS VARCHAR(10))
            WHERE MaGV = @MaGV;
            
            SET @i = @i + 1;
        END
        
        SET @ErrorMessage = N'Tạo dữ liệu mẫu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Utility_XoaDuLieuMau]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 14.4. Xóa dữ liệu mẫu
CREATE   PROCEDURE [dbo].[sp_Utility_XoaDuLieuMau]
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Delete demo data
        DELETE FROM NguoiDung WHERE TenDangNhap LIKE 'demo%';
        DELETE FROM ChiTietGiangDay WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM ChiTietNCKH WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM ChiTietTaiKhaoThi WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM ThamGia WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM ThamGiaHuongDan WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn';
        
        SET @ErrorMessage = N'Xóa dữ liệu mẫu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaBoMon]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 11. Xóa bộ môn
CREATE   PROCEDURE [dbo].[sp_XoaBoMon]
    @MaBM CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if BoMon exists
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE MaBM = @MaBM)
        BEGIN
            THROW 52021, N'Mã bộ môn không tồn tại.', 1;
        END

        -- Check if BoMon is referenced by GiaoVien
        IF EXISTS (SELECT 1 FROM GiaoVien WHERE MaBM = @MaBM)
        BEGIN
            THROW 52022, N'Không thể xóa bộ môn vì đã có giáo viên thuộc bộ môn này.', 1;
        END

        -- Delete the record
        DELETE FROM BoMon WHERE MaBM = @MaBM;

        -- Set success message
        SET @ErrorMessage = N'Xóa bộ môn thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi xóa bộ môn: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaGiaoVien]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Xóa giáo viên
CREATE   PROCEDURE [dbo].[sp_XoaGiaoVien]
    @MaGV CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if GiaoVien exists
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            THROW 50021, N'Mã giáo viên không tồn tại.', 1;
        END

        -- Check if GiaoVien is referenced by other tables
        IF EXISTS (SELECT 1 FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM ThamGia WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM ThamGiaHuongDan WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM ChiTietGiangDay WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM HocVi WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM QuanHam WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM LichSuHocHam WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM LichSuChucVu WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM ChiTietCongTacKhac WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM LyLichKhoaHoc WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM NguoiDung WHERE MaGV = @MaGV)
            OR EXISTS (SELECT 1 FROM Khoa WHERE MaChuNhiemKhoa = @MaGV)
            OR EXISTS (SELECT 1 FROM BoMon WHERE MaChuNhiemBM = @MaGV)
        BEGIN
            THROW 50022, N'Không thể xóa giáo viên vì đã tham gia các hoạt động khác hoặc đang giữ chức vụ quản lý.', 1;
        END

        -- Delete the record
        DELETE FROM GiaoVien WHERE MaGV = @MaGV;

        -- Set success message
        SET @ErrorMessage = N'Xóa giáo viên thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi xóa giáo viên: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaKhoa]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 8. Xóa khoa
CREATE   PROCEDURE [dbo].[sp_XoaKhoa]
    @MaKhoa CHAR(15),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if Khoa exists
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE MaKhoa = @MaKhoa)
        BEGIN
            THROW 51021, N'Mã khoa không tồn tại.', 1;
        END

        -- Check if Khoa is referenced by BoMon
        IF EXISTS (SELECT 1 FROM BoMon WHERE MaKhoa = @MaKhoa)
        BEGIN
            THROW 51022, N'Không thể xóa khoa vì đã có bộ môn thuộc khoa này.', 1;
        END

        -- Delete the record
        DELETE FROM Khoa WHERE MaKhoa = @MaKhoa;

        -- Set success message
        SET @ErrorMessage = N'Xóa khoa thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi xóa khoa: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Xóa người dùng
CREATE   PROCEDURE [dbo].[sp_XoaNguoiDung]
    @MaNguoiDung NVARCHAR(50),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaNguoiDung IS NULL OR LTRIM(RTRIM(@MaNguoiDung)) = ''
        BEGIN
            THROW 70021, N'Mã người dùng không được để trống.', 1;
        END

        -- Check if NguoiDung exists
        IF NOT EXISTS (SELECT 1 FROM NguoiDung WITH (UPDLOCK) WHERE MaNguoiDung = @MaNguoiDung)
        BEGIN
            THROW 70022, N'Mã người dùng không tồn tại.', 1;
        END

        -- Delete from NguoiDung_Nhom first
        DELETE FROM NguoiDung_Nhom
        WHERE MaNguoiDung = @MaNguoiDung;

        -- Delete from LichSuDangNhap and NhatKyThayDoi (cascade delete)
        DELETE FROM NhatKyThayDoi
        WHERE MaLichSu IN (SELECT MaLichSu FROM LichSuDangNhap WHERE MaNguoiDung = @MaNguoiDung);

        DELETE FROM LichSuDangNhap
        WHERE MaNguoiDung = @MaNguoiDung;

        -- Delete the NguoiDung record
        DELETE FROM NguoiDung
        WHERE MaNguoiDung = @MaNguoiDung;

        -- Set success message
        SET @ErrorMessage = N'Xóa người dùng thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi xóa người dùng: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaNguoiDungKhoiNhom]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 8. Xóa người dùng khỏi nhóm
CREATE   PROCEDURE [dbo].[sp_XoaNguoiDungKhoiNhom]
    @MaNguoiDung NVARCHAR(50),
    @MaNhom NVARCHAR(50),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaNguoiDung IS NULL OR LTRIM(RTRIM(@MaNguoiDung)) = ''
        BEGIN
            THROW 70071, N'Mã người dùng không được để trống.', 1;
        END

        IF @MaNhom IS NULL OR LTRIM(RTRIM(@MaNhom)) = ''
        BEGIN
            THROW 70072, N'Mã nhóm không được để trống.', 1;
        END

        -- Check if the user is in the group
        IF NOT EXISTS (SELECT 1 FROM NguoiDung_Nhom WITH (UPDLOCK) WHERE MaNguoiDung = @MaNguoiDung AND MaNhom = @MaNhom)
        BEGIN
            THROW 70073, N'Người dùng không thuộc nhóm này.', 1;
        END

        -- Delete the record
        DELETE FROM NguoiDung_Nhom
        WHERE MaNguoiDung = @MaNguoiDung AND MaNhom = @MaNhom;

        -- Set success message
        SET @ErrorMessage = N'Xóa người dùng khỏi nhóm thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi xóa người dùng khỏi nhóm: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaNhomNguoiDung]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 6. Xóa nhóm người dùng
CREATE   PROCEDURE [dbo].[sp_XoaNhomNguoiDung]
    @MaNhom NVARCHAR(50),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaNhom IS NULL OR LTRIM(RTRIM(@MaNhom)) = ''
        BEGIN
            THROW 70051, N'Mã nhóm không được để trống.', 1;
        END

        -- Check if NhomNguoiDung exists
        IF NOT EXISTS (SELECT 1 FROM NhomNguoiDung WITH (UPDLOCK) WHERE MaNhom = @MaNhom)
        BEGIN
            THROW 70052, N'Mã nhóm không tồn tại.', 1;
        END

        -- Delete from NguoiDung_Nhom first
        DELETE FROM NguoiDung_Nhom
        WHERE MaNhom = @MaNhom;

        -- Delete from Nhom_Quyen
        DELETE FROM Nhom_Quyen
        WHERE MaNhom = @MaNhom;

        -- Delete the NhomNguoiDung record
        DELETE FROM NhomNguoiDung
        WHERE MaNhom = @MaNhom;

        -- Set success message
        SET @ErrorMessage = N'Xóa nhóm người dùng thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi xóa nhóm người dùng: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaQuyen]    Script Date: 5/23/2025 9:23:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 11. Xóa quyền
CREATE   PROCEDURE [dbo].[sp_XoaQuyen]
    @MaQuyen NVARCHAR(50),
    @ErrorMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT OFF;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate input
        IF @MaQuyen IS NULL OR LTRIM(RTRIM(@MaQuyen)) = ''
        BEGIN
            THROW 70101, N'Mã quyền không được để trống.', 1;
        END

        -- Check if Quyen exists
        IF NOT EXISTS (SELECT 1 FROM Quyen WITH (UPDLOCK) WHERE MaQuyen = @MaQuyen)
        BEGIN
            THROW 70102, N'Mã quyền không tồn tại.', 1;
        END

        -- Delete from Nhom_Quyen first
        DELETE FROM Nhom_Quyen
        WHERE MaQuyen = @MaQuyen;

        -- Delete the Quyen record
        DELETE FROM Quyen
        WHERE MaQuyen = @MaQuyen;

        -- Set success message
        SET @ErrorMessage = N'Xóa quyền thành công.';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @ErrorMessage = N'Lỗi khi xóa quyền: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
