using JustLearn1.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using JustLearn1.Models;

[Authorize(Roles = "Instructor")]
public class StudentsController : Controller
{
    private readonly JustDbContext _context;
    private readonly UserManager<IdentityUser> _userManager;

    public StudentsController(JustDbContext context, UserManager<IdentityUser> userManager)
    {
        _context = context;
        _userManager = userManager;
    }

    public async Task<IActionResult> Index(int productId)
    {
        // Önce ürünün bu eğitmene ait olup olmadığını kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        // İlgili ürünü veritabanından çekelim
        var product = await _context.Products.FindAsync(productId);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        var totalAssignments = await _context.Assignments
            .Where(a => a.ProductID == productId).CountAsync();

        var usersWhoBoughtProduct = await _context.OrderDetails
            .Where(od => od.ProductId == productId)
            .Include(od => od.User)
            .Select(od => new StudentViewModel
            {
                UserName = od.User.UserName,
                UserId = od.UserId,
                UserAssignments = _context.UserAssignments
                                    .Where(ua => ua.UserId == od.UserId && ua.Assignment.ProductID == productId)
                                    .ToList(),
                // Bölme hatasını kontrol etme işlemi eklendi
                Process = totalAssignments == 0
                          ? 0
                          : (_context.UserAssignments
                              .Where(ua => ua.UserId == od.UserId
                                          && ua.Assignment.ProductID == productId && ua.IsSubmitted)
                              .Count() / (decimal)totalAssignments) * 100
            })
            .ToListAsync();

        usersWhoBoughtProduct = usersWhoBoughtProduct
            .GroupBy(u => u.UserId)
            .Select(g => g.First())
            .ToList();

        ViewBag.CourseName = product.Name;
        return View(usersWhoBoughtProduct);
    }

    [HttpGet]
    public async Task<IActionResult> GradeAssignment(int assignmentId)
    {
        // Not: Buradaki 'assignmentId' UserAssignment tablosunun ID değeri
        var userAssignment = await _context.UserAssignments
            .Include(ua => ua.Assignment)
                .ThenInclude(a => a.Product)
            .FirstOrDefaultAsync(ua => ua.Id == assignmentId);
        
        // Eğer ID bulunamazsa, belki de assignmentId parametresi Assignment ID olarak geçilmiş olabilir
        if (userAssignment == null)
        {
            // Alternatif sorgu dene - verilen ID'nin Assignment.AssignmentID olduğunu varsay
            var alternatives = await _context.UserAssignments
                .Where(ua => ua.AssignmentId == assignmentId)
                .ToListAsync();
                
            if (alternatives.Any())
            {
                userAssignment = alternatives.First();
            }
            else
            {
                TempData["error"] = "Assignment submission not found";
                return RedirectToAction("Index", "Home");
            }
        }

        // Ödev bilgileri yüklü değilse yükle
        if (userAssignment.Assignment == null)
        {
            userAssignment.Assignment = await _context.Assignments
                .Include(a => a.Product)
                .FirstOrDefaultAsync(a => a.AssignmentID == userAssignment.AssignmentId);
        }

        // Ödev değerlendirmesinin, ödevin ait olduğu kursa öğretmenin sahip olup olmadığını kontrol et
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        // Kursun ait olduğu ürünü bul
        var product = userAssignment.Assignment?.Product;
        if (product == null)
        {
            var assignment = await _context.Assignments.FindAsync(userAssignment.AssignmentId);
            if (assignment == null)
            {
                return NotFound("Assignment details not found");
            }
            
            product = await _context.Products.FindAsync(assignment.ProductID);
            if (product == null)
            {
                return NotFound("Course not found");
            }
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }
        
        // Kullanıcı bilgilerini manuel olarak yükle
        var userInfo = await _userManager.FindByIdAsync(userAssignment.UserId);
        if (userInfo != null)
        {
            userAssignment.User = new ApplicationUser
            {
                Id = userInfo.Id,
                UserName = userInfo.UserName,
                Email = userInfo.Email,
                PhoneNumber = userInfo.PhoneNumber
            };
        }

        return View(userAssignment);
    }

    [HttpPost]
    public async Task<IActionResult> GradeAssignment(UserAssignment updatedUserAssignment)
    {
        // Gelen verilerle UserAssignment kaydını bul
        var originalAssignment = await _context.UserAssignments
            .FirstOrDefaultAsync(ua => ua.Id == updatedUserAssignment.Id);
        
        if (originalAssignment == null)
        {
            // ID ile bulamadıysak, AssignmentId ve UserId kombinasyonu ile deneyelim
            originalAssignment = await _context.UserAssignments
                .FirstOrDefaultAsync(ua => ua.AssignmentId == updatedUserAssignment.AssignmentId 
                                          && ua.UserId == updatedUserAssignment.UserId);
        }
        
        if (originalAssignment == null)
        {
            TempData["error"] = "Assignment submission not found";
            return RedirectToAction("Index", "Home");
        }

        // Ödev değerlendirmesinin, ödevin ait olduğu kursa öğretmenin sahip olup olmadığını kontrol et
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        // Ödev ve ürün bilgilerini yükle
        var assignment = await _context.Assignments
            .Include(a => a.Product)
            .FirstOrDefaultAsync(a => a.AssignmentID == originalAssignment.AssignmentId);
        
        if (assignment == null)
        {
            return NotFound("Assignment details not found");
        }
        
        var product = assignment.Product;
        if (product == null)
        {
            product = await _context.Products.FindAsync(assignment.ProductID);
            if (product == null)
            {
                return NotFound("Course not found");
            }
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        // Değişiklikleri kaydet
        originalAssignment.Score = updatedUserAssignment.Score;
        originalAssignment.Feedback = updatedUserAssignment.Feedback;
        originalAssignment.IsGraded = true; 

        try
        {
            await _context.SaveChangesAsync();
            TempData["success"] = "Assignment graded successfully";
        }
        catch (Exception ex)
        {
            TempData["error"] = "Error saving grade";
            ModelState.AddModelError("", "Error saving changes to database");
            
            // Form yeniden gösterilecekse, gerekli verileri doldur
            var userInfo = await _userManager.FindByIdAsync(originalAssignment.UserId);
            updatedUserAssignment.Assignment = assignment;
            if (userInfo != null)
            {
                updatedUserAssignment.User = new ApplicationUser
                {
                    Id = userInfo.Id,
                    UserName = userInfo.UserName,
                    Email = userInfo.Email
                };
            }
            return View(updatedUserAssignment);
        }

        return RedirectToAction("Index", new { productId = product.Id });
    }

    // Öğrencinin kursla ilgili tüm ödevlerini görüntülemek için yeni bir action
    public async Task<IActionResult> StudentAssignments(string userId, int productId)
    {
        // Önce ürünün bu eğitmene ait olup olmadığını kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        // İlgili ürünü veritabanından çekelim
        var product = await _context.Products.FindAsync(productId);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        var student = await _userManager.FindByIdAsync(userId);
        if (student == null)
        {
            return NotFound("Student not found");
        }

        var assignments = await _context.Assignments
            .Where(a => a.ProductID == productId)
            .ToListAsync();

        var userAssignments = await _context.UserAssignments
            .Where(ua => ua.UserId == userId && ua.Assignment.ProductID == productId)
            .Include(ua => ua.Assignment)
            .ToListAsync();

        // Eksik ödevleri de ekleyelim
        var missingAssignments = assignments
            .Where(a => !userAssignments.Any(ua => ua.AssignmentId == a.AssignmentID))
            .Select(a => new UserAssignment
            {
                Assignment = a,
                AssignmentId = a.AssignmentID,
                IsSubmitted = false,
                Score = 0
            })
            .ToList();

        var allAssignments = userAssignments.Union(missingAssignments).ToList();

        ViewBag.StudentName = student.UserName;
        ViewBag.CourseName = product.Name;
        return View(allAssignments);
    }
}
