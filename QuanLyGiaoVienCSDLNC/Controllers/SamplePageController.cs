using Microsoft.AspNetCore.Mvc;

namespace QuanLyGiaoVienCSDLNC.Controllers
{
    public class SamplePageController : Controller
    {
        public IActionResult Page1()
        {
            return View();
        }
        public IActionResult Page2()
        {
            return View();
        }
    }
}
