using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace QuanLyGiaoVienCSDLNC.Migrations
{
    /// <inheritdoc />
    public partial class NoiDungGiangDay : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "MaNoiDungGiangDay",
                table: "ChiTietGiangDay");

            migrationBuilder.AlterColumn<double>(
                name: "SoTietQuyDoi",
                table: "ChiTietGiangDay",
                type: "float",
                nullable: false,
                oldClrType: typeof(float),
                oldType: "real");

            migrationBuilder.AddColumn<string>(
                name: "NoiDungGiangDay",
                table: "ChiTietGiangDay",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "CongTacKhac",
                columns: table => new
                {
                    MaCongTacKhac = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    NoiDungCongViec = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    NamHoc = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    SoLuong = table.Column<int>(type: "int", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CongTacKhac", x => x.MaCongTacKhac);
                });

            migrationBuilder.CreateTable(
                name: "DinhMucMienGiam",
                columns: table => new
                {
                    MaDinhMucMienGiam = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    DoiTuongMienGiam = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    TyLeMienGiam = table.Column<float>(type: "real", nullable: false),
                    GhiChuMienGiam = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DinhMucMienGiam", x => x.MaDinhMucMienGiam);
                });

            migrationBuilder.CreateTable(
                name: "DoiTuongGiangDay",
                columns: table => new
                {
                    MaDoiTuong = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenDoiTuong = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    HeSoQuyChuan = table.Column<double>(type: "float", nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DoiTuongGiangDay", x => x.MaDoiTuong);
                });

            migrationBuilder.CreateTable(
                name: "LichSuDangNhap",
                columns: table => new
                {
                    MaLichSu = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    ThoiDiemDangNhap = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ThoiDiemDangXuat = table.Column<DateTime>(type: "datetime2", nullable: true),
                    MaNguoiDung = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LichSuDangNhap", x => x.MaLichSu);
                    table.ForeignKey(
                        name: "FK_LichSuDangNhap_NguoiDung_MaNguoiDung",
                        column: x => x.MaNguoiDung,
                        principalTable: "NguoiDung",
                        principalColumn: "MaNguoiDung",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LoaiCongTacKhaoThi",
                columns: table => new
                {
                    MaLoaiCongTacKhaoThi = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenLoaiCongTacKhaoThi = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LoaiCongTacKhaoThi", x => x.MaLoaiCongTacKhaoThi);
                });

            migrationBuilder.CreateTable(
                name: "LoaiHinhHuongDan",
                columns: table => new
                {
                    MaLoaiHinhHuongDan = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenLoaiHinhHuongDan = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LoaiHinhHuongDan", x => x.MaLoaiHinhHuongDan);
                });

            migrationBuilder.CreateTable(
                name: "LoaiHoiDong",
                columns: table => new
                {
                    MaLoaiHoiDong = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenLoaiHoiDong = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LoaiHoiDong", x => x.MaLoaiHoiDong);
                });

            migrationBuilder.CreateTable(
                name: "LyLichKhoaHoc",
                columns: table => new
                {
                    MaLyLichKhoaHoc = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    HeDaoTaoDH = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NoiDaoTaoDH = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NganhHocDH = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NuocDaoTaoDH = table.Column<int>(type: "int", nullable: true),
                    NamTotNghiepDH = table.Column<int>(type: "int", nullable: true),
                    ThacSiChuyenNganh = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NamCapBangTS = table.Column<int>(type: "int", nullable: true),
                    NoiDaoTaoTS = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    TenLuanVanTotNghiep = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    TienSiChuyenNganh = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NamCapBangSauDH = table.Column<int>(type: "int", nullable: true),
                    NoiDaoTaoSauDH = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    TenLuanAnSauDH = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    NgayKhai = table.Column<DateTime>(type: "datetime2", nullable: true),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LyLichKhoaHoc", x => x.MaLyLichKhoaHoc);
                    table.ForeignKey(
                        name: "FK_LyLichKhoaHoc_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "NgonNguGiangDay",
                columns: table => new
                {
                    MaNgonNgu = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenNgonNgu = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    HeSoQuyChuan = table.Column<double>(type: "float", nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NgonNguGiangDay", x => x.MaNgonNgu);
                });

            migrationBuilder.CreateTable(
                name: "QuanHam",
                columns: table => new
                {
                    MaQuanHam = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenQuanHam = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NgayNhan = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NgayKetThuc = table.Column<DateTime>(type: "datetime2", nullable: true),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_QuanHam", x => x.MaQuanHam);
                    table.ForeignKey(
                        name: "FK_QuanHam_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "QuyDoiGioChuanNCKH",
                columns: table => new
                {
                    MaQuyDoi = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    DonViTinh = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    QuyRaGioChuan = table.Column<double>(type: "float", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    NhomCongViec = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaNoiDung = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_QuyDoiGioChuanNCKH", x => x.MaQuyDoi);
                });

            migrationBuilder.CreateTable(
                name: "SequenceGenerator",
                columns: table => new
                {
                    TableName = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LastSequence = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SequenceGenerator", x => x.TableName);
                });

            migrationBuilder.CreateTable(
                name: "ThoiGianGiangDay",
                columns: table => new
                {
                    MaThoiGian = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenThoiGian = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    HeSoQuyChuan = table.Column<double>(type: "float", nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ThoiGianGiangDay", x => x.MaThoiGian);
                });

            migrationBuilder.CreateTable(
                name: "ChiTietCongTacKhac",
                columns: table => new
                {
                    MaChiTietCongTacKhac = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    VaiTro = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaCongTacKhac = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChiTietCongTacKhac", x => x.MaChiTietCongTacKhac);
                    table.ForeignKey(
                        name: "FK_ChiTietCongTacKhac_CongTacKhac_MaCongTacKhac",
                        column: x => x.MaCongTacKhac,
                        principalTable: "CongTacKhac",
                        principalColumn: "MaCongTacKhac",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ChiTietCongTacKhac_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ChucVu",
                columns: table => new
                {
                    MaChucVu = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenChucVu = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    MaDinhMucMienGiam = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChucVu", x => x.MaChucVu);
                    table.ForeignKey(
                        name: "FK_ChucVu_DinhMucMienGiam_MaDinhMucMienGiam",
                        column: x => x.MaDinhMucMienGiam,
                        principalTable: "DinhMucMienGiam",
                        principalColumn: "MaDinhMucMienGiam",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "NhatKyThayDoi",
                columns: table => new
                {
                    MaNhatKy = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    MaLichSu = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    ThoiGianThayDoi = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NoiDungThayDoi = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    ThongTinCu = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    ThongTinMoi = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NhatKyThayDoi", x => x.MaNhatKy);
                    table.ForeignKey(
                        name: "FK_NhatKyThayDoi_LichSuDangNhap_MaLichSu",
                        column: x => x.MaLichSu,
                        principalTable: "LichSuDangNhap",
                        principalColumn: "MaLichSu",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TaiKhaoThi",
                columns: table => new
                {
                    MaTaiKhaoThi = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    HocPhan = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Lop = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    NamHoc = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    MaLoaiCongTacKhaoThi = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TaiKhaoThi", x => x.MaTaiKhaoThi);
                    table.ForeignKey(
                        name: "FK_TaiKhaoThi_LoaiCongTacKhaoThi_MaLoaiCongTacKhaoThi",
                        column: x => x.MaLoaiCongTacKhaoThi,
                        principalTable: "LoaiCongTacKhaoThi",
                        principalColumn: "MaLoaiCongTacKhaoThi",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TaiHuongDan",
                columns: table => new
                {
                    MaHuongDan = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    HoTenHocVien = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Lop = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    He = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    NamHoc = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    TenDeTai = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    SoCBHD = table.Column<int>(type: "int", nullable: false),
                    MaLoaiHinhHuongDan = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TaiHuongDan", x => x.MaHuongDan);
                    table.ForeignKey(
                        name: "FK_TaiHuongDan_LoaiHinhHuongDan_MaLoaiHinhHuongDan",
                        column: x => x.MaLoaiHinhHuongDan,
                        principalTable: "LoaiHinhHuongDan",
                        principalColumn: "MaLoaiHinhHuongDan",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TaiHoiDong",
                columns: table => new
                {
                    MaHoiDong = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    SoLuong = table.Column<int>(type: "int", nullable: false),
                    NamHoc = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    ThoiGianBatDau = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ThoiGianKetThuc = table.Column<DateTime>(type: "datetime2", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    MaLoaiHoiDong = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TaiHoiDong", x => x.MaHoiDong);
                    table.ForeignKey(
                        name: "FK_TaiHoiDong_LoaiHoiDong_MaLoaiHoiDong",
                        column: x => x.MaLoaiHoiDong,
                        principalTable: "LoaiHoiDong",
                        principalColumn: "MaLoaiHoiDong",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LoaiNCKH",
                columns: table => new
                {
                    MaLoaiNCKH = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MoTa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    TenLoaiNCKH = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaQuyDoi = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LoaiNCKH", x => x.MaLoaiNCKH);
                    table.ForeignKey(
                        name: "FK_LoaiNCKH_QuyDoiGioChuanNCKH_MaQuyDoi",
                        column: x => x.MaQuyDoi,
                        principalTable: "QuyDoiGioChuanNCKH",
                        principalColumn: "MaQuyDoi",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LichSuChucVu",
                columns: table => new
                {
                    MaLichSuChucVu = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    NgayNhan = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NgayKetThuc = table.Column<DateTime>(type: "datetime2", nullable: true),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaChucVu = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LichSuChucVu", x => x.MaLichSuChucVu);
                    table.ForeignKey(
                        name: "FK_LichSuChucVu_ChucVu_MaChucVu",
                        column: x => x.MaChucVu,
                        principalTable: "ChucVu",
                        principalColumn: "MaChucVu",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_LichSuChucVu_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ChiTietTaiKhaoThi",
                columns: table => new
                {
                    MaChiTietTaiKhaoThi = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    SoBai = table.Column<int>(type: "int", nullable: false),
                    SoGioQuyChuan = table.Column<double>(type: "float", nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaTaiKhaoThi = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChiTietTaiKhaoThi", x => x.MaChiTietTaiKhaoThi);
                    table.ForeignKey(
                        name: "FK_ChiTietTaiKhaoThi_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ChiTietTaiKhaoThi_TaiKhaoThi_MaTaiKhaoThi",
                        column: x => x.MaTaiKhaoThi,
                        principalTable: "TaiKhaoThi",
                        principalColumn: "MaTaiKhaoThi",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ThamGiaHuongDan",
                columns: table => new
                {
                    MaThamGiaHuongDan = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaHuongDan = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    SoGio = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ThamGiaHuongDan", x => x.MaThamGiaHuongDan);
                    table.ForeignKey(
                        name: "FK_ThamGiaHuongDan_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ThamGiaHuongDan_TaiHuongDan_MaHuongDan",
                        column: x => x.MaHuongDan,
                        principalTable: "TaiHuongDan",
                        principalColumn: "MaHuongDan",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ThamGia",
                columns: table => new
                {
                    MaThamGia = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaHoiDong = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    SoGio = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ThamGia", x => x.MaThamGia);
                    table.ForeignKey(
                        name: "FK_ThamGia_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ThamGia_TaiHoiDong_MaHoiDong",
                        column: x => x.MaHoiDong,
                        principalTable: "TaiHoiDong",
                        principalColumn: "MaHoiDong",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TaiNCKH",
                columns: table => new
                {
                    MaTaiNCKH = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenCongTrinhKhoaHoc = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    NamHoc = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    SoTacGia = table.Column<int>(type: "int", nullable: false),
                    MaLoaiNCKH = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TaiNCKH", x => x.MaTaiNCKH);
                    table.ForeignKey(
                        name: "FK_TaiNCKH_LoaiNCKH_MaLoaiNCKH",
                        column: x => x.MaLoaiNCKH,
                        principalTable: "LoaiNCKH",
                        principalColumn: "MaLoaiNCKH",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ChiTietNCKH",
                columns: table => new
                {
                    MaChiTietNCKH = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    VaiTro = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaTaiNCKH = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    SoGio = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChiTietNCKH", x => x.MaChiTietNCKH);
                    table.ForeignKey(
                        name: "FK_ChiTietNCKH_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ChiTietNCKH_TaiNCKH_MaTaiNCKH",
                        column: x => x.MaTaiNCKH,
                        principalTable: "TaiNCKH",
                        principalColumn: "MaTaiNCKH",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TaiGiangDay_MaDoiTuong",
                table: "TaiGiangDay",
                column: "MaDoiTuong");

            migrationBuilder.CreateIndex(
                name: "IX_TaiGiangDay_MaNgonNgu",
                table: "TaiGiangDay",
                column: "MaNgonNgu");

            migrationBuilder.CreateIndex(
                name: "IX_TaiGiangDay_MaThoiGian",
                table: "TaiGiangDay",
                column: "MaThoiGian");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietCongTacKhac_MaCongTacKhac",
                table: "ChiTietCongTacKhac",
                column: "MaCongTacKhac");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietCongTacKhac_MaGV",
                table: "ChiTietCongTacKhac",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietNCKH_MaGV",
                table: "ChiTietNCKH",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietNCKH_MaTaiNCKH",
                table: "ChiTietNCKH",
                column: "MaTaiNCKH");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietTaiKhaoThi_MaGV",
                table: "ChiTietTaiKhaoThi",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietTaiKhaoThi_MaTaiKhaoThi",
                table: "ChiTietTaiKhaoThi",
                column: "MaTaiKhaoThi");

            migrationBuilder.CreateIndex(
                name: "IX_ChucVu_MaDinhMucMienGiam",
                table: "ChucVu",
                column: "MaDinhMucMienGiam");

            migrationBuilder.CreateIndex(
                name: "IX_LichSuChucVu_MaChucVu",
                table: "LichSuChucVu",
                column: "MaChucVu");

            migrationBuilder.CreateIndex(
                name: "IX_LichSuChucVu_MaGV",
                table: "LichSuChucVu",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_LichSuDangNhap_MaNguoiDung",
                table: "LichSuDangNhap",
                column: "MaNguoiDung");

            migrationBuilder.CreateIndex(
                name: "IX_LoaiNCKH_MaQuyDoi",
                table: "LoaiNCKH",
                column: "MaQuyDoi");

            migrationBuilder.CreateIndex(
                name: "IX_LyLichKhoaHoc_MaGV",
                table: "LyLichKhoaHoc",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_NhatKyThayDoi_MaLichSu",
                table: "NhatKyThayDoi",
                column: "MaLichSu");

            migrationBuilder.CreateIndex(
                name: "IX_QuanHam_MaGV",
                table: "QuanHam",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_TaiHoiDong_MaLoaiHoiDong",
                table: "TaiHoiDong",
                column: "MaLoaiHoiDong");

            migrationBuilder.CreateIndex(
                name: "IX_TaiHuongDan_MaLoaiHinhHuongDan",
                table: "TaiHuongDan",
                column: "MaLoaiHinhHuongDan");

            migrationBuilder.CreateIndex(
                name: "IX_TaiKhaoThi_MaLoaiCongTacKhaoThi",
                table: "TaiKhaoThi",
                column: "MaLoaiCongTacKhaoThi");

            migrationBuilder.CreateIndex(
                name: "IX_TaiNCKH_MaLoaiNCKH",
                table: "TaiNCKH",
                column: "MaLoaiNCKH");

            migrationBuilder.CreateIndex(
                name: "IX_ThamGia_MaGV",
                table: "ThamGia",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_ThamGia_MaHoiDong",
                table: "ThamGia",
                column: "MaHoiDong");

            migrationBuilder.CreateIndex(
                name: "IX_ThamGiaHuongDan_MaGV",
                table: "ThamGiaHuongDan",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_ThamGiaHuongDan_MaHuongDan",
                table: "ThamGiaHuongDan",
                column: "MaHuongDan");

            migrationBuilder.AddForeignKey(
                name: "FK_TaiGiangDay_DoiTuongGiangDay_MaDoiTuong",
                table: "TaiGiangDay",
                column: "MaDoiTuong",
                principalTable: "DoiTuongGiangDay",
                principalColumn: "MaDoiTuong",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_TaiGiangDay_NgonNguGiangDay_MaNgonNgu",
                table: "TaiGiangDay",
                column: "MaNgonNgu",
                principalTable: "NgonNguGiangDay",
                principalColumn: "MaNgonNgu",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_TaiGiangDay_ThoiGianGiangDay_MaThoiGian",
                table: "TaiGiangDay",
                column: "MaThoiGian",
                principalTable: "ThoiGianGiangDay",
                principalColumn: "MaThoiGian",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TaiGiangDay_DoiTuongGiangDay_MaDoiTuong",
                table: "TaiGiangDay");

            migrationBuilder.DropForeignKey(
                name: "FK_TaiGiangDay_NgonNguGiangDay_MaNgonNgu",
                table: "TaiGiangDay");

            migrationBuilder.DropForeignKey(
                name: "FK_TaiGiangDay_ThoiGianGiangDay_MaThoiGian",
                table: "TaiGiangDay");

            migrationBuilder.DropTable(
                name: "ChiTietCongTacKhac");

            migrationBuilder.DropTable(
                name: "ChiTietNCKH");

            migrationBuilder.DropTable(
                name: "ChiTietTaiKhaoThi");

            migrationBuilder.DropTable(
                name: "DoiTuongGiangDay");

            migrationBuilder.DropTable(
                name: "LichSuChucVu");

            migrationBuilder.DropTable(
                name: "LyLichKhoaHoc");

            migrationBuilder.DropTable(
                name: "NgonNguGiangDay");

            migrationBuilder.DropTable(
                name: "NhatKyThayDoi");

            migrationBuilder.DropTable(
                name: "QuanHam");

            migrationBuilder.DropTable(
                name: "SequenceGenerator");

            migrationBuilder.DropTable(
                name: "ThamGia");

            migrationBuilder.DropTable(
                name: "ThamGiaHuongDan");

            migrationBuilder.DropTable(
                name: "ThoiGianGiangDay");

            migrationBuilder.DropTable(
                name: "CongTacKhac");

            migrationBuilder.DropTable(
                name: "TaiNCKH");

            migrationBuilder.DropTable(
                name: "TaiKhaoThi");

            migrationBuilder.DropTable(
                name: "ChucVu");

            migrationBuilder.DropTable(
                name: "LichSuDangNhap");

            migrationBuilder.DropTable(
                name: "TaiHoiDong");

            migrationBuilder.DropTable(
                name: "TaiHuongDan");

            migrationBuilder.DropTable(
                name: "LoaiNCKH");

            migrationBuilder.DropTable(
                name: "LoaiCongTacKhaoThi");

            migrationBuilder.DropTable(
                name: "DinhMucMienGiam");

            migrationBuilder.DropTable(
                name: "LoaiHoiDong");

            migrationBuilder.DropTable(
                name: "LoaiHinhHuongDan");

            migrationBuilder.DropTable(
                name: "QuyDoiGioChuanNCKH");

            migrationBuilder.DropIndex(
                name: "IX_TaiGiangDay_MaDoiTuong",
                table: "TaiGiangDay");

            migrationBuilder.DropIndex(
                name: "IX_TaiGiangDay_MaNgonNgu",
                table: "TaiGiangDay");

            migrationBuilder.DropIndex(
                name: "IX_TaiGiangDay_MaThoiGian",
                table: "TaiGiangDay");

            migrationBuilder.DropColumn(
                name: "NoiDungGiangDay",
                table: "ChiTietGiangDay");

            migrationBuilder.AlterColumn<float>(
                name: "SoTietQuyDoi",
                table: "ChiTietGiangDay",
                type: "real",
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AddColumn<string>(
                name: "MaNoiDungGiangDay",
                table: "ChiTietGiangDay",
                type: "nvarchar(15)",
                maxLength: 15,
                nullable: false,
                defaultValue: "");
        }
    }
}
