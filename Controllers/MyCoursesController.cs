using JustLearn1.Data;
using JustLearn1.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using System.Linq;
using System.Threading.Tasks;

namespace JustLearn1.Controllers
{
    [Authorize] // Kullanıcı girişi gerektiren controller
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
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return NotFound("User not found");
            }

            // Kullanıcının satın aldığı ürünleri getirme
            var purchasedProducts = await _context.OrderDetails
                .Include(od => od.Product)
                .ThenInclude(p => p.Category)
                .Where(od => od.UserId == currentUser.Id)
                .Select(od => od.Product)
                .Distinct() // Aynı ürün birden fazla kez gösterilmesin diye
                .ToListAsync();

            // Eğer instructor ise ve hiç kurs satın almamışsa, kendi oluşturduğu kursları göster
            if (await _userManager.IsInRoleAsync(currentUser, "Instructor") && !purchasedProducts.Any())
            {
                purchasedProducts = await _context.Products
                    .Include(p => p.Category)
                    .Where(p => p.UserId == currentUser.Id)
                    .ToListAsync();
            }

            return View(purchasedProducts);
        }

        // Kurs detay sayfası için bir metod
        public async Task<IActionResult> Detail(int id)
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return NotFound("User not found");
            }

            // Kontrol: Kullanıcı bu ürünü satın aldı mı?
            bool hasPurchased = await _context.OrderDetails
                .AnyAsync(od => od.UserId == currentUser.Id && od.ProductId == id);

            if (!hasPurchased)
            {
                TempData["error"] = "You have not purchased this course";
                return RedirectToAction("Shop", "Products"); // Kurs mağazasına yönlendir
            }

            // Ürün bilgilerini getirme
            var product = await _context.Products
                .Include(p => p.Category)
                .Include(p => p.Assignment) // Assignment bilgilerini dahil etme
                .FirstOrDefaultAsync(p => p.Id == id);

            if (product == null)
            {
                return NotFound("Course not found");
            }

            // Kullanıcının bu kurstaki ödevlerini getir
            var userAssignments = await _context.UserAssignments
                .Where(ua => ua.UserId == currentUser.Id && ua.Assignment.ProductID == id)
                .Include(ua => ua.Assignment)
                .ToListAsync();

            // Tamamlanan ödevlerin sayısını ve yüzdesini hesapla
            var totalAssignments = product.Assignment != null ? product.Assignment.Count : 0;
            var completedAssignments = userAssignments.Count(ua => ua.IsSubmitted);
            
            ViewBag.CompletedAssignments = completedAssignments;
            ViewBag.TotalAssignments = totalAssignments;
            ViewBag.CompletionPercentage = totalAssignments > 0 
                ? (completedAssignments * 100) / totalAssignments 
                : 0;
            ViewBag.UserAssignments = userAssignments;

            return View(product);
        }

        public async Task<IActionResult> StartAssignment(int assignmentId)
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return NotFound("User not found");
            }

            // Daha detaylı bir sorgu ile ödevi ve ürün bilgilerini çek
            var assignment = await _context.Assignments
                                       .Include(a => a.Product)  // İlgili ürün bilgilerini çekiyoruz.
                                       .FirstOrDefaultAsync(a => a.AssignmentID == assignmentId);

            if (assignment == null)
            {
                TempData["error"] = "Assignment not found";
                return RedirectToAction("Index");
            }

            // Kontrol: Kullanıcı bu ürünü satın aldı mı?
            bool hasPurchased = await _context.OrderDetails
                .AnyAsync(od => od.UserId == currentUser.Id && od.ProductId == assignment.ProductID);

            if (!hasPurchased)
            {
                TempData["error"] = "You have not purchased this course";
                return RedirectToAction("Shop", "Products"); // Kurs mağazasına yönlendir
            }

            // Kullanıcının bu ödeve daha önce bir yanıt verip vermediğini kontrol et
            var userAssignment = await _context.UserAssignments
                .FirstOrDefaultAsync(ua => ua.UserId == currentUser.Id && ua.AssignmentId == assignmentId);

            // Eğer bu ödeve hiç yanıt verilmemişse otomatik olarak kullanıcı assignment'ını oluştur
            if (userAssignment == null)
            {
                userAssignment = new UserAssignment
                {
                    UserId = currentUser.Id,
                    AssignmentId = assignmentId,
                    IsSubmitted = false,
                    UserAnswer = string.Empty
                };
                
                _context.UserAssignments.Add(userAssignment);
                await _context.SaveChangesAsync();
            }

            ViewBag.ExistingAnswer = userAssignment?.UserAnswer;
            ViewBag.IsSubmitted = userAssignment?.IsSubmitted ?? false;
            ViewBag.SubmissionDate = userAssignment?.SubmissionDate;
            ViewBag.Score = userAssignment?.Score;
            ViewBag.Feedback = userAssignment?.Feedback;
            ViewBag.IsGraded = userAssignment?.IsGraded ?? false;

            return View(assignment);  
        }

        [HttpPost]
        public async Task<IActionResult> SubmitAssignment(int AssignmentId, string UserAnswer)
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return NotFound("User not found");
            }

            var assignment = await _context.Assignments.FindAsync(AssignmentId);
            if (assignment == null)
            {
                return NotFound("Assignment not found");
            }

            // Kontrol: Kullanıcı bu ürünü satın aldı mı?
            bool hasPurchased = await _context.OrderDetails
                .AnyAsync(od => od.UserId == currentUser.Id && od.ProductId == assignment.ProductID);

            if (!hasPurchased)
            {
                TempData["error"] = "You have not purchased this course";
                return RedirectToAction("Shop", "Products");
            }

            // Kullanıcının bu assignment'ı daha önce submit edip etmediğini kontrol et
            var userAssignment = await _context.UserAssignments
                .FirstOrDefaultAsync(ua => ua.UserId == currentUser.Id && ua.AssignmentId == AssignmentId);

            if (string.IsNullOrWhiteSpace(UserAnswer))
            {
                TempData["error"] = "Answer cannot be empty";
                return RedirectToAction("StartAssignment", new { assignmentId = AssignmentId });
            }

            if (userAssignment == null)
            {
                // Eğer userAssignment null ise, yeni bir kayıt oluştur
                userAssignment = new UserAssignment
                {
                    UserId = currentUser.Id,
                    AssignmentId = AssignmentId,
                    IsSubmitted = true,
                    SubmissionDate = DateTime.Now,
                    UserAnswer = UserAnswer // Comment'i UserAnswer olarak kaydet
                };
                _context.UserAssignments.Add(userAssignment);
            }
            else
            {
                // Eğer önceden bir kayıt var ise, mevcut kaydı güncelle
                userAssignment.IsSubmitted = true;
                userAssignment.SubmissionDate = DateTime.Now;
                userAssignment.UserAnswer = UserAnswer; // Comment'i UserAnswer olarak güncelle
                userAssignment.IsGraded = false; // Yeniden gönderildiği için notlandırılmadı olarak işaretle
            }

            await _context.SaveChangesAsync();

            // Başarı mesajı ve ilgili kursa yönlendirme
            TempData["success"] = "Assignment submitted successfully";
            return RedirectToAction("Detail", new { id = assignment.ProductID });
        }

        // Kullanıcının tüm ödevlerini ve notlarını görüntüleyebileceği bir dashboard
        public async Task<IActionResult> Assignments()
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return NotFound("User not found");
            }

            // Kullanıcının tüm ödevleri
            var userAssignments = await _context.UserAssignments
                .Where(ua => ua.UserId == currentUser.Id)
                .Include(ua => ua.Assignment)
                .ThenInclude(a => a.Product)
                .OrderByDescending(ua => ua.SubmissionDate)
                .ToListAsync();

            return View(userAssignments);
        }
    }
}

