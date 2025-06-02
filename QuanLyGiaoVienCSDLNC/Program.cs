// Program.cs
using Microsoft.EntityFrameworkCore;
using QuanLyGiaoVienCSDLNC.Data;
using QuanLyGiaoVienCSDLNC.Repositories.Interfaces;
using QuanLyGiaoVienCSDLNC.Repositories;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;
using QuanLyGiaoVienCSDLNC.Services;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllersWithViews()
    .AddRazorRuntimeCompilation();
builder.WebHost.ConfigureKestrel(serverOptions =>
{
    serverOptions.ListenAnyIP(5000); // Bạn có thể thay đổi cổng nếu muốn
});
builder.WebHost.UseUrls("http://0.0.0.0:5100");
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
Console.WriteLine($"Connection String: {connectionString}"); // Hoặc dùng logger
// Thêm kết nối database
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetSection("ConnectionStrings")["DB_Context"]));

// Đăng ký các repository
builder.Services.AddScoped<IGiaoVienRepository, GiaoVienRepository>();
builder.Services.AddScoped<IBoMonRepository, BoMonRepository>();
builder.Services.AddScoped<IKhoaRepository, KhoaRepository>();
builder.Services.AddScoped<ITaiGiangDayRepository, TaiGiangDayRepository>();
builder.Services.AddScoped<IThongKeRepository, ThongKeRepository>();
builder.Services.AddScoped<IUserRepository, UserRepository>();

// Đăng ký các repository mới cho NCKH
builder.Services.AddScoped<INCKHRepository, NCKHRepository>();
builder.Services.AddScoped<IChucVuRepository, ChucVuRepository>();
builder.Services.AddScoped<IHoiDongRepository, HoiDongRepository>();
builder.Services.AddScoped<IHuongDanRepository, HuongDanRepository>();
builder.Services.AddScoped<IKhaoThiRepository, KhaoThiRepository>();

// Đăng ký các service
builder.Services.AddScoped<IGiaoVienService, GiaoVienService>();
builder.Services.AddScoped<IBoMonService, BoMonService>();
builder.Services.AddScoped<IKhoaService, KhoaService>();
builder.Services.AddScoped<ITaiGiangDayService, TaiGiangDayService>();
builder.Services.AddScoped<IThongKeService, ThongKeService>();
builder.Services.AddScoped<IUserService, UserService>();

// Đăng ký các service mới cho NCKH
builder.Services.AddScoped<INCKHService, NCKHService>();
//builder.Services.AddScoped<IChucVuService, ChucVuService>();
//builder.Services.AddScoped<IHoiDongService, HoiDongService>();
//builder.Services.AddScoped<IHuongDanService, HuongDanService>();
//builder.Services.AddScoped<IKhaoThiService, KhaoThiService>();

// Thêm hỗ trợ session
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseSession();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Login}/{action=Index}/{id?}");

app.Run();