using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace QuanLyGiaoVienCSDLNC.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "DinhMucGiangDay",
                columns: table => new
                {
                    MaDinhMucGiangDay = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    ChucDanhGiangDay = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    dinhMucGiangDay = table.Column<int>(type: "int", nullable: false),
                    MucGiaoDuKienChatLuong_GiaoDuKienPhong = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DinhMucGiangDay", x => x.MaDinhMucGiangDay);
                });

            migrationBuilder.CreateTable(
                name: "DinhMucNghienCuu",
                columns: table => new
                {
                    MaDinhMucNghienCuu = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    ChucDanhGiangDay = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    DinhMucThoiGianHoatDongNghienCuuKhoaHoc = table.Column<int>(type: "int", nullable: false),
                    DinhMucGioChuanHoatDongNghienCuuKhoaHoc = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DinhMucNghienCuu", x => x.MaDinhMucNghienCuu);
                });

            migrationBuilder.CreateTable(
                name: "HocHam",
                columns: table => new
                {
                    MaHocHam = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenHocHam = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaDinhMucNghienCuu = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaDinhMucGiangDay = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HocHam", x => x.MaHocHam);
                });

            migrationBuilder.CreateTable(
                name: "Khoa",
                columns: table => new
                {
                    MaKhoa = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenKhoa = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    DiaChi = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaChuNhiemKhoa = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Khoa", x => x.MaKhoa);
                });

            migrationBuilder.CreateTable(
                name: "NhomNguoiDung",
                columns: table => new
                {
                    MaNhom = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    TenNhom = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NhomNguoiDung", x => x.MaNhom);
                });

            migrationBuilder.CreateTable(
                name: "Quyen",
                columns: table => new
                {
                    MaQuyen = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    TenQuyen = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Quyen", x => x.MaQuyen);
                });

            migrationBuilder.CreateTable(
                name: "TaiGiangDay",
                columns: table => new
                {
                    MaTaiGiangDay = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenHocPhan = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    SiSo = table.Column<int>(type: "int", nullable: false),
                    He = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Lop = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    SoTinChi = table.Column<int>(type: "int", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    NamHoc = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    MaDoiTuong = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaThoiGian = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaNgonNgu = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TaiGiangDay", x => x.MaTaiGiangDay);
                });

            migrationBuilder.CreateTable(
                name: "BoMon",
                columns: table => new
                {
                    MaBM = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenBM = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    DiaChi = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaKhoa = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaChuNhiemBM = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BoMon", x => x.MaBM);
                    table.ForeignKey(
                        name: "FK_BoMon_Khoa_MaKhoa",
                        column: x => x.MaKhoa,
                        principalTable: "Khoa",
                        principalColumn: "MaKhoa",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Nhom_Quyen",
                columns: table => new
                {
                    MaNhom = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    MaQuyen = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nhom_Quyen", x => new { x.MaNhom, x.MaQuyen });
                    table.ForeignKey(
                        name: "FK_Nhom_Quyen_NhomNguoiDung_MaNhom",
                        column: x => x.MaNhom,
                        principalTable: "NhomNguoiDung",
                        principalColumn: "MaNhom",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Nhom_Quyen_Quyen_MaQuyen",
                        column: x => x.MaQuyen,
                        principalTable: "Quyen",
                        principalColumn: "MaQuyen",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "GiaoVien",
                columns: table => new
                {
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    HoTen = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NgaySinh = table.Column<DateTime>(type: "datetime2", nullable: false),
                    GioiTinh = table.Column<bool>(type: "bit", nullable: false),
                    QueQuan = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    DiaChi = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    SDT = table.Column<int>(type: "int", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaBM = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GiaoVien", x => x.MaGV);
                    table.ForeignKey(
                        name: "FK_GiaoVien_BoMon_MaBM",
                        column: x => x.MaBM,
                        principalTable: "BoMon",
                        principalColumn: "MaBM",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ChiTietGiangDay",
                columns: table => new
                {
                    MaChiTietGiangDay = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    SoTiet = table.Column<int>(type: "int", nullable: false),
                    SoTietQuyDoi = table.Column<float>(type: "real", nullable: false),
                    GhiChu = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaTaiGiangDay = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaNoiDungGiangDay = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChiTietGiangDay", x => x.MaChiTietGiangDay);
                    table.ForeignKey(
                        name: "FK_ChiTietGiangDay_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ChiTietGiangDay_TaiGiangDay_MaTaiGiangDay",
                        column: x => x.MaTaiGiangDay,
                        principalTable: "TaiGiangDay",
                        principalColumn: "MaTaiGiangDay",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "HocVi",
                columns: table => new
                {
                    MaHocVi = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenHocVi = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NgayNhan = table.Column<DateTime>(type: "datetime2", nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_HocVi", x => x.MaHocVi);
                    table.ForeignKey(
                        name: "FK_HocVi_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LichSuHocHam",
                columns: table => new
                {
                    MaLSHocHam = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    TenHocHam = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    NgayNhan = table.Column<DateTime>(type: "datetime2", nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false),
                    MaHocHam = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LichSuHocHam", x => x.MaLSHocHam);
                    table.ForeignKey(
                        name: "FK_LichSuHocHam_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_LichSuHocHam_HocHam_MaHocHam",
                        column: x => x.MaHocHam,
                        principalTable: "HocHam",
                        principalColumn: "MaHocHam",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "NguoiDung",
                columns: table => new
                {
                    MaNguoiDung = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    TenDangNhap = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MatKhau = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    MaGV = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NguoiDung", x => x.MaNguoiDung);
                    table.ForeignKey(
                        name: "FK_NguoiDung_GiaoVien_MaGV",
                        column: x => x.MaGV,
                        principalTable: "GiaoVien",
                        principalColumn: "MaGV",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "NguoiDung_Nhom",
                columns: table => new
                {
                    MaNguoiDung = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    MaNhom = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NguoiDung_Nhom", x => new { x.MaNguoiDung, x.MaNhom });
                    table.ForeignKey(
                        name: "FK_NguoiDung_Nhom_NguoiDung_MaNguoiDung",
                        column: x => x.MaNguoiDung,
                        principalTable: "NguoiDung",
                        principalColumn: "MaNguoiDung",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_NguoiDung_Nhom_NhomNguoiDung_MaNhom",
                        column: x => x.MaNhom,
                        principalTable: "NhomNguoiDung",
                        principalColumn: "MaNhom",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_BoMon_MaKhoa",
                table: "BoMon",
                column: "MaKhoa");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietGiangDay_MaGV",
                table: "ChiTietGiangDay",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietGiangDay_MaTaiGiangDay",
                table: "ChiTietGiangDay",
                column: "MaTaiGiangDay");

            migrationBuilder.CreateIndex(
                name: "IX_GiaoVien_MaBM",
                table: "GiaoVien",
                column: "MaBM");

            migrationBuilder.CreateIndex(
                name: "IX_HocVi_MaGV",
                table: "HocVi",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_LichSuHocHam_MaGV",
                table: "LichSuHocHam",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_LichSuHocHam_MaHocHam",
                table: "LichSuHocHam",
                column: "MaHocHam");

            migrationBuilder.CreateIndex(
                name: "IX_NguoiDung_MaGV",
                table: "NguoiDung",
                column: "MaGV");

            migrationBuilder.CreateIndex(
                name: "IX_NguoiDung_Nhom_MaNhom",
                table: "NguoiDung_Nhom",
                column: "MaNhom");

            migrationBuilder.CreateIndex(
                name: "IX_Nhom_Quyen_MaQuyen",
                table: "Nhom_Quyen",
                column: "MaQuyen");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ChiTietGiangDay");

            migrationBuilder.DropTable(
                name: "DinhMucGiangDay");

            migrationBuilder.DropTable(
                name: "DinhMucNghienCuu");

            migrationBuilder.DropTable(
                name: "HocVi");

            migrationBuilder.DropTable(
                name: "LichSuHocHam");

            migrationBuilder.DropTable(
                name: "NguoiDung_Nhom");

            migrationBuilder.DropTable(
                name: "Nhom_Quyen");

            migrationBuilder.DropTable(
                name: "TaiGiangDay");

            migrationBuilder.DropTable(
                name: "HocHam");

            migrationBuilder.DropTable(
                name: "NguoiDung");

            migrationBuilder.DropTable(
                name: "NhomNguoiDung");

            migrationBuilder.DropTable(
                name: "Quyen");

            migrationBuilder.DropTable(
                name: "GiaoVien");

            migrationBuilder.DropTable(
                name: "BoMon");

            migrationBuilder.DropTable(
                name: "Khoa");
        }
    }
}
