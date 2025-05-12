using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using System.Data;

namespace QuanLyGiaoVienCSDLNC.Repositories
{
    public class ThongKeRepository : IThongKeRepository
    {
        private readonly ApplicationDbContext _context;

        public ThongKeRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<dynamic> ThongKeSoGioGiangDayAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_ThongKeSoGioGiangDay @MaGV, @MaBM, @MaKhoa, @NamHoc";
                    command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaBM", maBM ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaKhoa", maKhoa ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        var result = new DataTable();
                        result.Load(reader);
                        return result;
                    }
                }
            }
        }

        public async Task<dynamic> ThongKeSoGioNCKHAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_ThongKeSoGioNCKH @MaGV, @MaBM, @MaKhoa, @NamHoc";
                    command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaBM", maBM ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaKhoa", maKhoa ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        var result = new DataTable();
                        result.Load(reader);
                        return result;
                    }
                }
            }
        }

        public async Task<dynamic> ThongKeSoGioKhaoThiAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_ThongKeSoGioKhaoThi @MaGV, @MaBM, @MaKhoa, @NamHoc";
                    command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaBM", maBM ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaKhoa", maKhoa ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        var result = new DataTable();
                        result.Load(reader);
                        return result;
                    }
                }
            }
        }

        public async Task<dynamic> TongHopKhoiLuongCongTacAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_TongHopKhoiLuongCongTac @MaGV, @MaBM, @MaKhoa, @NamHoc";
                    command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaBM", maBM ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaKhoa", maKhoa ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        var result = new DataTable();
                        result.Load(reader);
                        return result;
                    }
                }
            }
        }

        public async Task<dynamic> KiemTraHoanThanhDinhMucAsync(string maGV = null, string maBM = null, string maKhoa = null, string namHoc = null)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                Console.WriteLine(">>> Connection string: " + connection.ConnectionString); // <-- THÊM DÒNG NÀY

               
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_KiemTraHoanThanhDinhMuc @MaGV, @MaBM, @MaKhoa, @NamHoc";
                    command.Parameters.Add(new SqlParameter("@MaGV", maGV ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaBM", maBM ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@MaKhoa", maKhoa ?? (object)DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        var result = new DataTable();
                        result.Load(reader);
                        return result;
                    }
                }
            }
        }

        public async Task<dynamic> BaoCaoGiangDayTheoKhoaBoMonAsync(string namHoc = null)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_BaoCaoGiangDayTheoKhoaBoMon @NamHoc";
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        // Đọc kết quả đầu tiên (theo khoa)
                        var resultByKhoa = new DataTable();
                        resultByKhoa.Load(reader);

                        // Kiểm tra xem còn kết quả tiếp theo không (theo bộ môn)
                        var resultByBoMon = new DataTable();
                        if (reader.NextResult())
                        {
                            resultByBoMon.Load(reader);
                        }

                        return new
                        {
                            TheoKhoa = resultByKhoa,
                            TheoBoMon = resultByBoMon
                        };
                    }
                }
            }
        }

        public async Task<dynamic> BaoCaoNCKHTheoKhoaBoMonAsync(string namHoc = null)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_BaoCaoNCKHTheoKhoaBoMon @NamHoc";
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                    using (var reader = await command.ExecuteReaderAsync())
                    {                await connection.OpenAsync();

                        // Đọc kết quả đầu tiên (theo khoa)
                        var resultByKhoa = new DataTable();
                        resultByKhoa.Load(reader);

                        // Kiểm tra xem còn kết quả tiếp theo không (theo bộ môn)
                        var resultByBoMon = new DataTable();
                        if (reader.NextResult())
                        {
                            resultByBoMon.Load(reader);
                        }

                        return new
                        {
                            TheoKhoa = resultByKhoa,
                            TheoBoMon = resultByBoMon
                        };
                    }
                }
            }
        }

        public async Task<dynamic> BaoCaoHoanThanhDinhMucTheoKhoaBoMonAsync(string namHoc = null)
        {
            using (var connection = _context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_BaoCaoHoanThanhDinhMucTheoKhoaBoMon @NamHoc";
                    command.Parameters.Add(new SqlParameter("@NamHoc", namHoc ?? (object)DBNull.Value));

                    using (var reader = await command.ExecuteReaderAsync())
                    {
                        // Đọc kết quả đầu tiên (theo khoa)
                        var resultByKhoa = new DataTable();
                        resultByKhoa.Load(reader);

                        // Kiểm tra xem còn kết quả tiếp theo không (theo bộ môn)
                        var resultByBoMon = new DataTable();
                        if (reader.NextResult())
                        {
                            resultByBoMon.Load(reader);
                        }

                        return new
                        {
                            TheoKhoa = resultByKhoa,
                            TheoBoMon = resultByBoMon
                        };
                    }
                }
            }
        }
    }

}
