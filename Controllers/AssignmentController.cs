using JustLearn1.Data;
using JustLearn1.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using System;
using System.Linq;
using System.Threading.Tasks;

[Authorize(Roles = "Instructor")]
public class AssignmentController : Controller
{
    private readonly JustDbContext _context;
    private readonly UserManager<IdentityUser> _userManager;
    private readonly IWebHostEnvironment _webHostEnvironment;

    public AssignmentController(JustDbContext context, UserManager<IdentityUser> userManager, IWebHostEnvironment webHostEnvironment)
    {
        _context = context;
        _userManager = userManager;
        _webHostEnvironment = webHostEnvironment;
    }

    public async Task<IActionResult> Create(int productId)
    {
        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

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

        ViewBag.ProductName = product.Name;
        var assignment = new Assignment { ProductID = productId };
        return View(assignment);
    }

    public async Task<IActionResult> ListAssignmentsForProduct(int productId)
    {
        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

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

        // ProductId'ye göre tüm assignmentları getir.
        var assignments = await _context.Assignments
                                        .Where(a => a.ProductID == productId)
                                        .ToListAsync();

        // Verileri bir ViewModel'e aktarabilir veya doğrudan view'e iletebilirsiniz.
        ViewBag.ProductName = product.Name;
        ViewBag.ProductId = productId;
        return View(assignments);
    }

    [HttpPost]
    public async Task<IActionResult> Create(Assignment assignment)
    {
        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        var product = await _context.Products.FindAsync(assignment.ProductID);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        if (ModelState.IsValid)
        {
            _context.Add(assignment);
            await _context.SaveChangesAsync();
            TempData["success"] = "Assignment created successfully";
            return RedirectToAction("ListAssignmentsForProduct", new { productId = assignment.ProductID });
        }

        ViewBag.ProductName = product.Name;
        return View(assignment);
    }

    public async Task<IActionResult> Edit(int id)
    {
        var assignment = await _context.Assignments.FindAsync(id);
        if (assignment == null)
        {
            return NotFound("Assignment not found");
        }

        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        var product = await _context.Products.FindAsync(assignment.ProductID);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        ViewBag.ProductName = product.Name;
        return View(assignment);
    }

    [HttpPost]
    public async Task<IActionResult> Edit(int id, Assignment assignment)
    {
        if (id != assignment.AssignmentID)
        {
            return NotFound();
        }

        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        var product = await _context.Products.FindAsync(assignment.ProductID);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        if (ModelState.IsValid)
        {
            try
            {
                _context.Update(assignment);
                await _context.SaveChangesAsync();
                TempData["success"] = "Assignment updated successfully";
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Assignments.Any(a => a.AssignmentID == id))
                {
                    return NotFound("Assignment not found");
                }
                else
                {
                    throw;
                }
            }
            return RedirectToAction("ListAssignmentsForProduct", new { productId = assignment.ProductID });
        }

        ViewBag.ProductName = product.Name;
        return View(assignment);
    }

    [HttpPost]
    public async Task<IActionResult> UploadAssignmentFile(int assignmentId, IFormFile file)
    {
        var assignment = await _context.Assignments.FindAsync(assignmentId);
        if (assignment == null)
        {
            return NotFound("Assignment not found");
        }

        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        var product = await _context.Products.FindAsync(assignment.ProductID);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        if (file == null || file.Length == 0)
        {
            TempData["error"] = "No file selected";
            return RedirectToAction("Edit", new { id = assignmentId });
        }

        // Dosya uzantısı ve boyutu kontrolü
        var allowedExtensions = new[] { ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".txt" };
        var fileExtension = Path.GetExtension(file.FileName).ToLowerInvariant();
        if (!allowedExtensions.Contains(fileExtension))
        {
            TempData["error"] = "File type not allowed";
            return RedirectToAction("Edit", new { id = assignmentId });
        }

        // Maksimum dosya boyutu: 10MB
        if (file.Length > 10 * 1024 * 1024)
        {
            TempData["error"] = "File size exceeds maximum limit (10MB)";
            return RedirectToAction("Edit", new { id = assignmentId });
        }

        // Güvenli dosya adı oluştur
        var fileName = Guid.NewGuid().ToString() + fileExtension;
        var uploadPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "assignments");

        // Dizin yoksa oluştur
        if (!Directory.Exists(uploadPath))
        {
            Directory.CreateDirectory(uploadPath);
        }

        var filePath = Path.Combine(uploadPath, fileName);

        using (var stream = new FileStream(filePath, FileMode.Create))
        {
            await file.CopyToAsync(stream);
        }

        var assignmentFile = new AssignmentFile
        {
            FileName = file.FileName,
            FilePath = Path.Combine("uploads", "assignments", fileName),
            AssignmentId = assignmentId,
            UploadDate = DateTime.Now
        };

        _context.Add(assignmentFile);
        await _context.SaveChangesAsync();

        TempData["success"] = "File uploaded successfully";
        return RedirectToAction("Edit", new { id = assignmentId });
    }

    public async Task<IActionResult> ReviewAssignments(int assignmentId)
    {
        var assignment = await _context.Assignments.FindAsync(assignmentId);
        if (assignment == null)
        {
            TempData["error"] = "Assignment not found";
            return RedirectToAction("ListAssignmentsForProduct", new { productId = 1 });
        }

        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        var product = await _context.Products.FindAsync(assignment.ProductID);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        // Tüm UserAssignment kayıtlarını çek
        var userAssignments = await _context.UserAssignments
                                     .Where(ua => ua.AssignmentId == assignmentId)
                                     .ToListAsync();

        // Eğer hiç userAssignment yoksa, otomatik olarak kursu satın almış öğrenciler için oluştur
        if (!userAssignments.Any())
        {
            // Bu kursu satın alan öğrencileri bul
            var studentsWhoBoughtCourse = await _context.OrderDetails
                .Where(od => od.ProductId == product.Id)
                .Select(od => od.UserId)
                .Distinct()
                .ToListAsync();

            // Her öğrenci için boş bir UserAssignment oluştur
            foreach (var studentId in studentsWhoBoughtCourse)
            {
                var newUserAssignment = new UserAssignment
                {
                    UserId = studentId,
                    AssignmentId = assignmentId,
                    IsSubmitted = false,
                    UserAnswer = string.Empty
                };
                
                _context.UserAssignments.Add(newUserAssignment);
            }
            
            await _context.SaveChangesAsync();
            
            // Yeni oluşturulan kayıtları çek
            userAssignments = await _context.UserAssignments
                                     .Where(ua => ua.AssignmentId == assignmentId)
                                     .ToListAsync();
        }

        // Her bir UserAssignment için User bilgilerini manuel olarak doldur
        foreach (var ua in userAssignments)
        {
            // UserId kullanarak kullanıcı bilgilerini çek
            var userInfo = await _userManager.FindByIdAsync(ua.UserId);
            if (userInfo != null)
            {
                // ApplicationUser türünü oluştur ve bilgileri kopyala
                ua.User = new ApplicationUser
                {
                    Id = userInfo.Id,
                    UserName = userInfo.UserName,
                    Email = userInfo.Email,
                    PhoneNumber = userInfo.PhoneNumber
                };
            }
        }

        ViewBag.AssignmentName = assignment.Name;
        ViewBag.ProductId = assignment.ProductID;
        ViewBag.ProductName = product.Name;
        return View(userAssignments);
    }

    // Ödev silme işlemi
    [HttpPost]
    public async Task<IActionResult> Delete(int id)
    {
        var assignment = await _context.Assignments.FindAsync(id);
        if (assignment == null)
        {
            return NotFound("Assignment not found");
        }

        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        var product = await _context.Products.FindAsync(assignment.ProductID);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        // Önce bu ödeve ait dosyaları silmemiz gerekiyor
        var assignmentFiles = await _context.AssignmentFiles
                                       .Where(af => af.AssignmentId == id)
                                       .ToListAsync();

        foreach (var file in assignmentFiles)
        {
            // Fiziksel dosyayı sil
            var filePath = Path.Combine(_webHostEnvironment.WebRootPath, file.FilePath.TrimStart('\\'));
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
            }

            // Veritabanı kaydını sil
            _context.AssignmentFiles.Remove(file);
        }

        // Ödeve ait UserAssignment kayıtlarını sil
        var userAssignments = await _context.UserAssignments
                                         .Where(ua => ua.AssignmentId == id)
                                         .ToListAsync();

        foreach (var userAssignment in userAssignments)
        {
            _context.UserAssignments.Remove(userAssignment);
        }

        // Son olarak ödevi sil
        _context.Assignments.Remove(assignment);
        await _context.SaveChangesAsync();

        TempData["success"] = "Assignment deleted successfully";
        return RedirectToAction("ListAssignmentsForProduct", new { productId = assignment.ProductID });
    }

    // Ödev dosyasını indirme
    public async Task<IActionResult> DownloadFile(int id)
    {
        var assignmentFile = await _context.AssignmentFiles.FindAsync(id);
        if (assignmentFile == null)
        {
            return NotFound("File not found");
        }

        var assignment = await _context.Assignments.FindAsync(assignmentFile.AssignmentId);
        if (assignment == null)
        {
            return NotFound("Assignment not found");
        }

        // Bu ürün bu eğitmene ait mi kontrol edelim
        var currentUser = await _userManager.GetUserAsync(User);
        if (currentUser == null)
        {
            return NotFound("User not found");
        }

        var product = await _context.Products.FindAsync(assignment.ProductID);
        if (product == null)
        {
            return NotFound("Course not found");
        }

        // Ürün bu eğitmene ait değilse erişim reddet
        if (product.UserId != currentUser.Id)
        {
            return Forbid();
        }

        var filePath = Path.Combine(_webHostEnvironment.WebRootPath, assignmentFile.FilePath.TrimStart('\\'));
        if (!System.IO.File.Exists(filePath))
        {
            return NotFound("File not found on server");
        }

        var fileName = assignmentFile.FileName;
        var contentType = "application/octet-stream";

        return PhysicalFile(filePath, contentType, fileName);
    }
}
