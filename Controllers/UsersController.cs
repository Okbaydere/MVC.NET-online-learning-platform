using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using JustLearn1.Models;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Authorization;

namespace JustLearn1
{
    [Authorize(Roles = "Admin")]
    public class UsersController : Controller
    {
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public UsersController(UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _roleManager = roleManager;
        }
        public IActionResult Index()
        {
            return View();
        }
        public async Task<IActionResult> UsersWithRoles()
        {
            var users = await _userManager.Users.ToListAsync();
            var userRoleViewModel = new List<Users_in_Role>();
            foreach (var user in users)
            {
                var roles = await _userManager.GetRolesAsync(user);
                userRoleViewModel.Add(new Users_in_Role
                {
                    UserId = user.Id,
                    Username = user.UserName,
                    Email = user.Email,
                    Role = string.Join(",", roles)
                });
            }
            return View(userRoleViewModel);
        }

        public async Task<IActionResult> Edit(string userId)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return NotFound();
            }

            // Veritabanındaki rolleri alın.
            var roles = await _roleManager.Roles.ToListAsync();

            // Modeli oluştur
            var model = new Users_in_Role
            {
                Email = user.Email,
                UserId = user.Id,
                Username = user.UserName,
                // Ek olarak, varsa kullanıcının mevcut rolünü de model ile gönderebilirsiniz.
                Role = (await _userManager.GetRolesAsync(user)).FirstOrDefault()
            };

            // View'a rol listesini taşı
            ViewData["Roles"] = new SelectList(roles, "Name", "Name", model.Role); // model.Role varsayılan seçili değeri sağlar.

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(Users_in_Role model)
        {
            // Burada ViewData["Roles"] tanımlamasını aşağıdaki gibi güncelliyoruz
            // Çünkü hata mesajı gösterilirken bu ViewData kullanılabilir olmalı
            var rolesList = await _roleManager.Roles.ToListAsync();
            ViewData["Roles"] = new SelectList(rolesList, "Name", "Name");

            var user = await _userManager.FindByIdAsync(model.UserId);
            if (user == null)
            {
                return NotFound();
            }

            user.Email = model.Email;
            user.UserName = model.Username;

            // Edit User Roles
            var roles = await _userManager.GetRolesAsync(user);
            await _userManager.RemoveFromRolesAsync(user, roles.ToArray());
            var result = await _userManager.AddToRoleAsync(user, model.Role);

            // Handle Role update errors if result failed
            if (!result.Succeeded)
            {
                // Errors should be handled here. Maybe log the error or return a view with the error message
                ModelState.AddModelError(string.Empty, "Error updating role");
                return View(model);
            }

            await _userManager.UpdateAsync(user);

            return RedirectToAction("UsersWithRoles");
        }
        public async Task<IActionResult> Delete(string userId)
        {
            var user = await _userManager.FindByIdAsync(userId);

            if (user == null)
            {
                // Kullanıcı bulunamadı
                ModelState.AddModelError("", "Kullanıcı bulunamadı");
                return View("Error");
            }

            var result = await _userManager.DeleteAsync(user);

            if (!result.Succeeded)
            {
                // Hata var ise
                foreach (var error in result.Errors)
                {
                    ModelState.AddModelError("", error.Description);
                }

                return View("Error");
            }

            TempData["Message"] = "Kullanıcı başarı ile silindi";
            return RedirectToAction("UsersWithRoles");

        }

        // GET: Kullanıcı oluşturma formunu göster
        public async Task<IActionResult> CreateAsync()
        {
            var roles = await _roleManager.Roles.ToListAsync();
            ViewBag.Roles = new SelectList(roles, "Name", "Name");

            return View();
        }

       

        // POST: Create action

        [HttpPost]
        
        public async Task<IActionResult> Create(IdentityUser user, string password, string role)
        {
            var roles = await _roleManager.Roles.ToListAsync();
            ViewBag.Roles = new SelectList(roles, "Name", "Name");

            if (ModelState.IsValid)
            {
                // Create the user
                var result = await _userManager.CreateAsync(user, password);

                if (result.Succeeded)
                {
                    // Add the user to the role
                    var addedToRole = await _userManager.AddToRoleAsync(user, role);
                    return RedirectToAction("Index");
                }
                else
                {
                    // If there's an error, show it
                    foreach (var error in result.Errors)
                    {
                        ModelState.AddModelError("", error.Description);
                    }
                }
            }

            return View();
        }



    }
}
