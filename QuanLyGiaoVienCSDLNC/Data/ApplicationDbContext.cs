// Data/ApplicationDbContext.cs
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Models;
using System;
using System.Collections.Generic;
using System.Reflection.Emit;

namespace QuanLyGiaoVienCSDLNC.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
            Console.WriteLine($"Connection string used: {this.Database.GetConnectionString()}");
        }

        public DbSet<GiaoVien> GiaoViens { get; set; }
        public DbSet<BoMon> BoMons { get; set; }
        public DbSet<Khoa> Khoas { get; set; }
        public DbSet<HocVi> HocVis { get; set; }
        public DbSet<HocHam> HocHams { get; set; }
        public DbSet<LichSuHocHam> LichSuHocHams { get; set; }
        public DbSet<DinhMucGiangDay> DinhMucGiangDays { get; set; }
        public DbSet<DinhMucNghienCuu> DinhMucNghienCuus { get; set; }
        public DbSet<TaiGiangDay> TaiGiangDays { get; set; }
        public DbSet<ChiTietGiangDay> ChiTietGiangDays { get; set; }
        public DbSet<NguoiDung> NguoiDungs { get; set; }
        public DbSet<NhomNguoiDung> NhomNguoiDungs { get; set; }
        public DbSet<NguoiDung_Nhom> NguoiDung_Nhoms { get; set; }
        public DbSet<Quyen> Quyens { get; set; }
        public DbSet<Nhom_Quyen> Nhom_Quyens { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configure composite keys
            modelBuilder.Entity<NguoiDung_Nhom>()
                .HasKey(n => new { n.MaNguoiDung, n.MaNhom });

            modelBuilder.Entity<Nhom_Quyen>()
                .HasKey(n => new { n.MaNhom, n.MaQuyen });

            // Configure table names to match the database
            modelBuilder.Entity<GiaoVien>().ToTable("GiaoVien");
            modelBuilder.Entity<BoMon>().ToTable("BoMon");
            modelBuilder.Entity<Khoa>().ToTable("Khoa");
            modelBuilder.Entity<HocVi>().ToTable("HocVi");
            modelBuilder.Entity<HocHam>().ToTable("HocHam");
            modelBuilder.Entity<LichSuHocHam>().ToTable("LichSuHocHam");
            modelBuilder.Entity<DinhMucGiangDay>().ToTable("DinhMucGiangDay");
            modelBuilder.Entity<DinhMucNghienCuu>().ToTable("DinhMucNghienCuu");
            modelBuilder.Entity<TaiGiangDay>().ToTable("TaiGiangDay");
            modelBuilder.Entity<ChiTietGiangDay>().ToTable("ChiTietGiangDay");
            modelBuilder.Entity<NguoiDung>().ToTable("NguoiDung");
            modelBuilder.Entity<NhomNguoiDung>().ToTable("NhomNguoiDung");
            modelBuilder.Entity<NguoiDung_Nhom>().ToTable("NguoiDung_Nhom");
            modelBuilder.Entity<Quyen>().ToTable("Quyen");
            modelBuilder.Entity<Nhom_Quyen>().ToTable("Nhom_Quyen");
        }
    }
}