using JustLearn1.Models.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authorization;

namespace JustLearn1.Controllers
{
    [Authorize]
    public class ShoppingCartController : Controller
    {
        private IShoppingCartRepository shoppingCartRepository;
        private IProductRepository productRepository;
        private UserManager<IdentityUser> _userManager;
        
        public ShoppingCartController(
            IShoppingCartRepository shoppingCartRepository, 
            IProductRepository productRepository,
            UserManager<IdentityUser> userManager)
        {
            this.shoppingCartRepository = shoppingCartRepository;
            this.productRepository = productRepository;
            this._userManager = userManager;
        }
        
        public IActionResult Index()
        {
            var items = shoppingCartRepository.GetShoppingCartItems();
            shoppingCartRepository.ShoppingCartItems = items;
            ViewBag.CartTotal = shoppingCartRepository.GetShoppingCartTotal();
            return View(items);
        }
        
        public async Task<IActionResult> AddToShoppingCart(int pId)
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return Challenge();
            }
            
            var product = productRepository.GetAllProducts().FirstOrDefault(p => p.Id == pId);
            if (product != null)
            {
                shoppingCartRepository.AddToCart(product);
                int cartCount = shoppingCartRepository.GetShoppingCartItems().Count;
                HttpContext.Session.SetInt32("CartCount", cartCount);
                TempData["success"] = "Course added to cart";
            }
            return RedirectToAction("Index");
        }
        
        public RedirectToActionResult RemoveFromShoppingCart(int pId)
        {
            var product = productRepository.GetAllProducts().FirstOrDefault(p => p.Id == pId);
            if (product != null)
            {
                shoppingCartRepository.RemoveFromCart(product);
                int cartCount = shoppingCartRepository.GetShoppingCartItems().Count;
                HttpContext.Session.SetInt32("CartCount", cartCount);
                TempData["success"] = "Course removed from cart";
            }
            return RedirectToAction("Index");
        }
    }
}
