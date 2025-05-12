// Controllers/LoginController.cs
using Microsoft.AspNetCore.Mvc;
using QuanLyGiaoVienCSDLNC.Models;
using QuanLyGiaoVienCSDLNC.Services.Interfaces;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class LoginController : Controller
    {
        private readonly IUserService _userService;

        public LoginController(IUserService userService)
        {
            _userService = userService;
        }

        public IActionResult Index()
        {
            // Kiểm tra nếu đã đăng nhập thì chuyển hướng đến trang chủ
            if (HttpContext.Session.GetString("UserId") != null)
            {
                return RedirectToAction("Index", "Home");
            }
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index(string username, string password)
        {
            var result = await _userService.LoginAsync(username, password);

            if (result.success)
            {
                // Lưu thông tin người dùng vào session
                HttpContext.Session.SetString("UserId", result.maLichSu);
                HttpContext.Session.SetString("Username", username);

                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.ErrorMessage = result.message;
                return View();
            }
        }

        public async Task<IActionResult> Logout()
        {
            var maLichSu = HttpContext.Session.GetString("UserId");
            if (!string.IsNullOrEmpty(maLichSu))
            {
                await _userService.LogoutAsync(maLichSu);
            }

            // Xóa session
            HttpContext.Session.Clear();

            return RedirectToAction("Index");
        }
    }
}