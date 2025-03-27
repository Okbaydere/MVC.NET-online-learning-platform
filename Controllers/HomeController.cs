using JustLearn1.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using JustLearn1.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace JustLearn1.Controllers
{
    public class HomeController : Controller
    {
        private IProductRepository productRepository;
        private readonly JustDbContext _context;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public HomeController(
            IProductRepository productRepository, 
            JustDbContext context, 
            UserManager<IdentityUser> userManager, 
            RoleManager<IdentityRole> roleManager)
        {
            this.productRepository = productRepository;
            _context = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }

        public async Task<IActionResult> Index()
        {
            // Öğrenci sayısı (User rolüne sahip kullanıcılar)
            var userRole = await _roleManager.FindByNameAsync("User");
            int studentCount = 0;
            if (userRole != null)
            {
                var userIds = await _context.UserRoles
                    .Where(ur => ur.RoleId == userRole.Id)
                    .Select(ur => ur.UserId)
                    .ToListAsync();
                studentCount = userIds.Count;
            }

            // Kurs sayısı
            int courseCount = await _context.Products.CountAsync();

            // Eğitmen sayısı (Instructor rolüne sahip kullanıcılar)
            var instructorRole = await _roleManager.FindByNameAsync("Instructor");
            int trainerCount = 0;
            if (instructorRole != null)
            {
                var instructorIds = await _context.UserRoles
                    .Where(ur => ur.RoleId == instructorRole.Id)
                    .Select(ur => ur.UserId)
                    .ToListAsync();
                trainerCount = instructorIds.Count;
            }

            // ViewBag ile verileri view'a gönderme
            ViewBag.StudentCount = studentCount;
            ViewBag.CourseCount = courseCount;
            ViewBag.TrainerCount = trainerCount;

            return View(productRepository.GetTrendingProducts());       
        }
    }
}
