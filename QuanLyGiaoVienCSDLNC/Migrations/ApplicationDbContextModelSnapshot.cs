﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using QuanLyGiaoVienCSDLNC.Data;

#nullable disable

namespace QuanLyGiaoVienCSDLNC.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    partial class ApplicationDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.20")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.BoMon", b =>
                {
                    b.Property<string>("MaBM")
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("DiaChi")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("MaChuNhiemBM")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaKhoa")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("TenBM")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaBM");

                    b.HasIndex("MaKhoa");

                    b.ToTable("BoMon", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.ChiTietGiangDay", b =>
                {
                    b.Property<string>("MaChiTietGiangDay")
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("GhiChu")
                        .IsRequired()
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.Property<string>("MaGV")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaNoiDungGiangDay")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaTaiGiangDay")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<int>("SoTiet")
                        .HasColumnType("int");

                    b.Property<float>("SoTietQuyDoi")
                        .HasColumnType("real");

                    b.HasKey("MaChiTietGiangDay");

                    b.HasIndex("MaGV");

                    b.HasIndex("MaTaiGiangDay");

                    b.ToTable("ChiTietGiangDay", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.DinhMucGiangDay", b =>
                {
                    b.Property<string>("MaDinhMucGiangDay")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("ChucDanhGiangDay")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("GhiChu")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.Property<string>("MucGiaoDuKienChatLuong_GiaoDuKienPhong")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<int>("dinhMucGiangDay")
                        .HasColumnType("int");

                    b.HasKey("MaDinhMucGiangDay");

                    b.ToTable("DinhMucGiangDay", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.DinhMucNghienCuu", b =>
                {
                    b.Property<string>("MaDinhMucNghienCuu")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("ChucDanhGiangDay")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<int>("DinhMucGioChuanHoatDongNghienCuuKhoaHoc")
                        .HasColumnType("int");

                    b.Property<int>("DinhMucThoiGianHoatDongNghienCuuKhoaHoc")
                        .HasColumnType("int");

                    b.HasKey("MaDinhMucNghienCuu");

                    b.ToTable("DinhMucNghienCuu", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.GiaoVien", b =>
                {
                    b.Property<string>("MaGV")
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("DiaChi")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<bool>("GioiTinh")
                        .HasColumnType("bit");

                    b.Property<string>("HoTen")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("MaBM")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<DateTime>("NgaySinh")
                        .HasColumnType("datetime2");

                    b.Property<string>("QueQuan")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<int>("SDT")
                        .HasColumnType("int");

                    b.HasKey("MaGV");

                    b.HasIndex("MaBM");

                    b.ToTable("GiaoVien", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.HocHam", b =>
                {
                    b.Property<string>("MaHocHam")
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaDinhMucGiangDay")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaDinhMucNghienCuu")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("TenHocHam")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaHocHam");

                    b.ToTable("HocHam", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.HocVi", b =>
                {
                    b.Property<string>("MaHocVi")
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaGV")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<DateTime>("NgayNhan")
                        .HasColumnType("datetime2");

                    b.Property<string>("TenHocVi")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaHocVi");

                    b.HasIndex("MaGV");

                    b.ToTable("HocVi", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.Khoa", b =>
                {
                    b.Property<string>("MaKhoa")
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("DiaChi")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("MaChuNhiemKhoa")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("TenKhoa")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaKhoa");

                    b.ToTable("Khoa", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.LichSuHocHam", b =>
                {
                    b.Property<string>("MaLSHocHam")
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaGV")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaHocHam")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<DateTime>("NgayNhan")
                        .HasColumnType("datetime2");

                    b.Property<string>("TenHocHam")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaLSHocHam");

                    b.HasIndex("MaGV");

                    b.HasIndex("MaHocHam");

                    b.ToTable("LichSuHocHam", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.NguoiDung", b =>
                {
                    b.Property<string>("MaNguoiDung")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("MaGV")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MatKhau")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("TenDangNhap")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaNguoiDung");

                    b.HasIndex("MaGV");

                    b.ToTable("NguoiDung", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.NguoiDung_Nhom", b =>
                {
                    b.Property<string>("MaNguoiDung")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)")
                        .HasColumnOrder(0);

                    b.Property<string>("MaNhom")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)")
                        .HasColumnOrder(1);

                    b.HasKey("MaNguoiDung", "MaNhom");

                    b.HasIndex("MaNhom");

                    b.ToTable("NguoiDung_Nhom", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.NhomNguoiDung", b =>
                {
                    b.Property<string>("MaNhom")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("TenNhom")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaNhom");

                    b.ToTable("NhomNguoiDung", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.Nhom_Quyen", b =>
                {
                    b.Property<string>("MaNhom")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)")
                        .HasColumnOrder(0);

                    b.Property<string>("MaQuyen")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)")
                        .HasColumnOrder(1);

                    b.HasKey("MaNhom", "MaQuyen");

                    b.HasIndex("MaQuyen");

                    b.ToTable("Nhom_Quyen", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.Quyen", b =>
                {
                    b.Property<string>("MaQuyen")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("TenQuyen")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaQuyen");

                    b.ToTable("Quyen", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.TaiGiangDay", b =>
                {
                    b.Property<string>("MaTaiGiangDay")
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("GhiChu")
                        .IsRequired()
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.Property<string>("He")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("nvarchar(20)");

                    b.Property<string>("Lop")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("nvarchar(20)");

                    b.Property<string>("MaDoiTuong")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaNgonNgu")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("MaThoiGian")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("nvarchar(15)");

                    b.Property<string>("NamHoc")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("nvarchar(20)");

                    b.Property<int>("SiSo")
                        .HasColumnType("int");

                    b.Property<int>("SoTinChi")
                        .HasColumnType("int");

                    b.Property<string>("TenHocPhan")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("MaTaiGiangDay");

                    b.ToTable("TaiGiangDay", (string)null);
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.BoMon", b =>
                {
                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.Khoa", "Khoa")
                        .WithMany()
                        .HasForeignKey("MaKhoa")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Khoa");
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.ChiTietGiangDay", b =>
                {
                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.GiaoVien", "GiaoVien")
                        .WithMany()
                        .HasForeignKey("MaGV")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.TaiGiangDay", "TaiGiangDay")
                        .WithMany()
                        .HasForeignKey("MaTaiGiangDay")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("GiaoVien");

                    b.Navigation("TaiGiangDay");
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.GiaoVien", b =>
                {
                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.BoMon", "BoMon")
                        .WithMany()
                        .HasForeignKey("MaBM")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("BoMon");
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.HocVi", b =>
                {
                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.GiaoVien", "GiaoVien")
                        .WithMany()
                        .HasForeignKey("MaGV")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("GiaoVien");
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.LichSuHocHam", b =>
                {
                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.GiaoVien", "GiaoVien")
                        .WithMany()
                        .HasForeignKey("MaGV")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.HocHam", "HocHam")
                        .WithMany()
                        .HasForeignKey("MaHocHam")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("GiaoVien");

                    b.Navigation("HocHam");
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.NguoiDung", b =>
                {
                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.GiaoVien", "GiaoVien")
                        .WithMany()
                        .HasForeignKey("MaGV")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("GiaoVien");
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.NguoiDung_Nhom", b =>
                {
                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.NguoiDung", "NguoiDung")
                        .WithMany()
                        .HasForeignKey("MaNguoiDung")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.NhomNguoiDung", "NhomNguoiDung")
                        .WithMany()
                        .HasForeignKey("MaNhom")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("NguoiDung");

                    b.Navigation("NhomNguoiDung");
                });

            modelBuilder.Entity("QuanLyGiaoVienCSDLNC.Models.Nhom_Quyen", b =>
                {
                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.NhomNguoiDung", "NhomNguoiDung")
                        .WithMany()
                        .HasForeignKey("MaNhom")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("QuanLyGiaoVienCSDLNC.Models.Quyen", "Quyen")
                        .WithMany()
                        .HasForeignKey("MaQuyen")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("NhomNguoiDung");

                    b.Navigation("Quyen");
                });
#pragma warning restore 612, 618
        }
    }
}
