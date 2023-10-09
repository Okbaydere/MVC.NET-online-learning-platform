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

        public IActionResult CheckOut()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> CheckOut(Order order)
        {
                var user = await _userManager.GetUserAsync(User);
                if (user != null)
                {

                    _orderRepository.PlaceOrder(order);
                    _shoppingCartRepository.ClearCart();
                    HttpContext.Session.SetInt32("CartCount", 0);

                    return RedirectToAction("CheckoutComplete");
                }
                else
                {
                    // Eğer kullanıcı null dönerse, bu bir hata durumudur ve uygun bir hata mesajı gösterilebilir.
                    ModelState.AddModelError(string.Empty, "An error occurred while getting user information.");
                }

            // Eğer ModelState geçerli değilse veya kullanıcı bilgisi alınamazsa, sipariş sayfasına geri dönülür.
            return View(order);
        }

        public IActionResult CheckoutComplete()
        {
            return View();
        }
        public async Task<IActionResult> ViewOrders(int productId)
        {
            var orderDetails = await _context.OrderDetails
                                             .Where(od => od.ProductId == productId)
                                             .Include(od => od.User) // User bilgilerini de getir.
                                             .ToListAsync();

            var product = await _context.Products
                                        .FirstOrDefaultAsync(p => p.Id == productId);

            if (product == null)
            {
                return NotFound();
            }

            ViewBag.ProductName = product.Name;

            return View(orderDetails);
        }



    }
}
