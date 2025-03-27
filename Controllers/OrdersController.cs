using JustLearn1.Models;
using JustLearn1.Models.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using JustLearn1.Data;
using Microsoft.EntityFrameworkCore;

namespace JustLearn1.Controllers
{
    [Authorize]
    public class OrdersController : Controller
    {
        private IOrderRepository _orderRepository;
        private IShoppingCartRepository _shoppingCartRepository;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly JustDbContext _context;// Veritabanını kullanmak için.

        public OrdersController(UserManager<IdentityUser> userManager, IOrderRepository orderRepository, IShoppingCartRepository shoppingCartRepository, JustDbContext context)
        {
            _userManager = userManager;
            _orderRepository = orderRepository;
            _shoppingCartRepository = shoppingCartRepository;
            _context = context;
        }

        public async Task<IActionResult> CheckOut()
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return Challenge();
            }
            
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> CheckOut(Order order)
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return Challenge();
            }
            
            if (ModelState.IsValid)
            {
                order.UserId = currentUser.Id;
                order.Email = currentUser.Email;

                _orderRepository.PlaceOrder(order);
                _shoppingCartRepository.ClearCart();
                HttpContext.Session.SetInt32("CartCount", 0);
                
                TempData["success"] = "Your order has been placed successfully!";
                return RedirectToAction("CheckoutComplete");
            }
            else
            {
                // Eğer ModelState geçerli değilse sipariş sayfasına geri dönülür.
                return View(order);
            }
        }

        public IActionResult CheckoutComplete()
        {
            return View();
        }
        
        [Authorize(Roles = "Instructor,Admin")]
        public async Task<IActionResult> ViewOrders(int productId)
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return NotFound("User not found");
            }

            // Ürünün bu eğitmene ait olup olmadığını kontrol et
            var product = await _context.Products
                                       .FirstOrDefaultAsync(p => p.Id == productId);

            if (product == null)
            {
                return NotFound("Course not found");
            }

            // Admin değilse ve ürün bu kullanıcıya ait değilse, erişimi reddet
            if (!await _userManager.IsInRoleAsync(currentUser, "Admin") && 
                product.UserId != currentUser.Id)
            {
                return Forbid();
            }

            var orderDetails = await _context.OrderDetails
                                             .Where(od => od.ProductId == productId)
                                             .Include(od => od.User) // User bilgilerini de getir.
                                             .ToListAsync();

            ViewBag.ProductName = product.Name;
            ViewBag.ProductId = productId;

            return View(orderDetails);
        }
    }
}
