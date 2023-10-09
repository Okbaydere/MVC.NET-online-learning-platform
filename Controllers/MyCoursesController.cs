using JustLearn1.Data;
using JustLearn1.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace JustLearn1.Controllers
{
    public class MyCoursesController : Controller
    {
        private readonly JustDbContext _context;
        private readonly UserManager<IdentityUser> _userManager;

        public MyCoursesController(JustDbContext context, UserManager<IdentityUser> userManager)
        {
            _context = context;
            _userManager = userManager;
        }

        public async Task<IActionResult> Index()
        {
            var products = await _context.Products.Include(p => p.Assignment).ToListAsync();
            var userId = _userManager.GetUserId(User);

            // Kullanıcının satın aldığı ürünleri getirme
            var purchasedProducts = await _context.OrderDetails
                .Include(od => od.Product)
                .Where(od => od.UserId == userId)
                .Select(od => od.Product)
                .Distinct() // Aynı ürün birden fazla kez gösterilmesin diye
                .ToListAsync();

            return View(purchasedProducts);
        }

        // Kurs detay sayfası için bir metod
        public async Task<IActionResult> Detail(int id)
        {
            // Kontrol: Kullanıcı bu ürünü satın aldı mı?
            var userId = _userManager.GetUserId(User);
            bool hasPurchased = await _context.OrderDetails
                .AnyAsync(od => od.UserId == userId && od.ProductId == id);

            if (!hasPurchased)
            {
                return Forbid(); // ya da başka bir hata sayfasına yönlendirme
            }

            // Ürün bilgilerini getirme
            var product = await _context.Products
                .Include(p => p.Assignment) // Assignment bilgilerini dahil etme
                .FirstOrDefaultAsync(p => p.Id == id);

            return View(product);
        }

            public async Task<IActionResult> StartAssignment(int assignmentId)
            {
                var assignment = await _context.Assignments
                                               .Include(a => a.Product)  // İlgili ürün bilgilerini çekiyoruz.
                                               .FirstOrDefaultAsync(a => a.AssignmentID == assignmentId);

                if (assignment == null)
                {
                    return NotFound(); 
                }

                return View(assignment);  
            }
        [HttpPost]
        public async Task<IActionResult> SubmitAssignment(int AssignmentId, string UserComment)
        {
            var userId = _userManager.GetUserId(User);

            // Kullanıcının bu assignment'ı daha önce submit edip etmediğini kontrol et
            var userAssignment = await _context.UserAssignments.FirstOrDefaultAsync(ua => ua.UserId == userId && ua.AssignmentId == AssignmentId);

            if (userAssignment == null)
            {
                // Eğer userAssignment null ise, yeni bir kayıt oluştur
                userAssignment = new UserAssignment
                {
                    UserId = userId,
                    AssignmentId = AssignmentId,
                    IsSubmitted = true,
                    SubmissionDate = DateTime.Now,
                    UserAnswer = UserComment // Comment'i UserAnswer olarak kaydet
                };
                _context.UserAssignments.Add(userAssignment);
            }
            else
            {
                // Eğer önceden bir kayıt var ise, mevcut kaydı güncelle
                userAssignment.IsSubmitted = true;
                userAssignment.SubmissionDate = DateTime.Now;
                userAssignment.UserAnswer = UserComment; // Comment'i UserAnswer olarak güncelle
            }

            await _context.SaveChangesAsync();

            // Burada kullanıcıyı uygun bir sayfaya yönlendirin
            return RedirectToAction(nameof(Index));
        }




    }
}

