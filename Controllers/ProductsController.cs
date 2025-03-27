﻿using JustLearn1.Repository.IRepository;
using JustLearn1.Data;
using JustLearn1.Models;
using JustLearn1.ViewModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using JustLearn1.Models.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authorization;

namespace JustLearn1Web.Areas.Admin.Controllers
{

    public class ProductsController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly UserManager<IdentityUser> _userManager;
        public ProductsController(IUnitOfWork unitOfWork, IWebHostEnvironment webHostEnvironment, UserManager<IdentityUser> userManager)
        {
            _unitOfWork = unitOfWork;
            _webHostEnvironment = webHostEnvironment;
            _userManager = userManager;
        }
        public IActionResult Admin()
        {
            return View();
        }
        [Authorize]
        public async Task<IActionResult> Shop()
        {
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return Challenge();
            }

            List<Product> objProductsList = _unitOfWork.Product.GetAll(includeProperties: "Category").ToList();

            return View(objProductsList);
        }

        public IActionResult Upsert(int? id)
        {
            ProductsVM ProductsVM = new()
            {
                CategoryList = _unitOfWork.Category.GetAll().Select(u => new SelectListItem
                {
                    Text = u.Name,
                    Value = u.Id.ToString()
                }),
                Product = new Product()
            };
            if (id == null || id == 0)
            {
                //create
                ProductsVM.IsTrending = false;
                return View(ProductsVM);
            }
            else
            {
                //update
                ProductsVM.Product = _unitOfWork.Product.Get(u => u.Id == id);
                if (ProductsVM.Product == null)
                {
                    return NotFound();
                }
                ProductsVM.IsTrending = ProductsVM.Product.IsTrendingProduct;
                return View(ProductsVM);
            }

        }
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> Upsert(ProductsVM ProductsVM, IFormFile? file)
        {
            if (ModelState.IsValid)
            {
                var currentUser = await _userManager.GetUserAsync(User);  // Asenkron kullanıcı bilgisi alınır

                // Eğer kullanıcı null değilse, ürünün UserId'sini ayarla.
                if (currentUser != null)
                {
                    ProductsVM.Product.UserId = currentUser.Id;
                }
                else
                {
                    // Oturum açmamış kullanıcı için bir işlem veya hata mesajı göster
                    ModelState.AddModelError(string.Empty, "User is not logged in");
                    return View(ProductsVM);  // veya başka bir işlem
                }

                string wwwRootPath = _webHostEnvironment.WebRootPath;
                if (file != null)
                {
                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                    string ProductsPath = Path.Combine(wwwRootPath, @"images\Products");

                    if (!Directory.Exists(ProductsPath))
                    {
                        Directory.CreateDirectory(ProductsPath);
                    }

                    if (!string.IsNullOrEmpty(ProductsVM.Product.ImageUrl))
                    {
                        //delete the old image
                        var oldImagePath =
                            Path.Combine(wwwRootPath, ProductsVM.Product.ImageUrl.TrimStart('\\'));

                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }

                    using (var fileStream = new FileStream(Path.Combine(ProductsPath, fileName), FileMode.Create))
                    {
                        file.CopyTo(fileStream);
                    }

                    ProductsVM.Product.ImageUrl = @"\images\Products\" + fileName;
                }

                if (ProductsVM.Product.Id == 0)
                {
                    _unitOfWork.Product.Add(ProductsVM.Product);
                    TempData["success"] = "Course created successfully";
                }
                else
                {
                    _unitOfWork.Product.Update(ProductsVM.Product);
                    TempData["success"] = "Course updated successfully";
                }

                _unitOfWork.Save();
                
                return RedirectToAction("MyProducts");
            }
            else
            {
                ProductsVM.CategoryList = _unitOfWork.Category.GetAll().Select(u => new SelectListItem
                {
                    Text = u.Name,
                    Value = u.Id.ToString()
                });
                return View(ProductsVM);
            }
        }


        public IActionResult Detail(int id)
        {
            var product = _unitOfWork.GetProductDetail(id);
            if (product == null)
            {
                return NotFound();
            }
            return View(product);
        }
        [Authorize(Roles = "Instructor")]
        public async Task<IActionResult> MyProducts()
        {
            var currentUser = await _userManager.GetUserAsync(User);

            if (currentUser == null)
            {
                return NotFound("User not found");
            }

            List<Product> objProductsList = _unitOfWork.Product.GetAll(
                filter: p => p.UserId == currentUser.Id,
                includeProperties: "Category").ToList();

            return View(objProductsList);
        }


        #region API CALLS

        [HttpGet]
        public IActionResult GetAll()
        {
            List<Product> objProductsList = _unitOfWork.Product.GetAll(includeProperties: "Category").ToList();
            return Json(new { data = objProductsList });
        }


        [HttpPost]
        [Authorize(Roles = "Instructor,Admin")]
        public async Task<IActionResult> Delete(int? id)
        {
            var productToBeDeleted = _unitOfWork.Product.Get(u => u.Id == id);
            if (productToBeDeleted == null)
            {
                return RedirectToAction("MyProducts");
            }

            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return NotFound("User not found");
            }

            if (!await _userManager.IsInRoleAsync(currentUser, "Admin") && 
                productToBeDeleted.UserId != currentUser.Id)
            {
                return Forbid();
            }

            if (!string.IsNullOrEmpty(productToBeDeleted.ImageUrl))
            {
                var oldImagePath =
                    Path.Combine(_webHostEnvironment.WebRootPath, productToBeDeleted.ImageUrl.TrimStart('\\'));

                if (System.IO.File.Exists(oldImagePath))
                {
                    System.IO.File.Delete(oldImagePath);
                }
            }

            _unitOfWork.Product.Remove(productToBeDeleted);
            _unitOfWork.Save();

            TempData["success"] = "Course deleted successfully";
            return RedirectToAction("MyProducts");
        }

        [HttpDelete]
        [Authorize(Roles = "Instructor,Admin")]
        public async Task<IActionResult> Delete(int id)
        {
            var productToBeDeleted = _unitOfWork.Product.Get(u => u.Id == id);
            if (productToBeDeleted == null)
            {
                return Json(new { success = false, message = "Error while deleting" });
            }

            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null)
            {
                return Json(new { success = false, message = "User not found" });
            }

            if (!await _userManager.IsInRoleAsync(currentUser, "Admin") && 
                productToBeDeleted.UserId != currentUser.Id)
            {
                return Json(new { success = false, message = "Not authorized to delete this product" });
            }

            _unitOfWork.Product.Remove(productToBeDeleted);
            _unitOfWork.Save();
            return Json(new { success = true, message = "Delete Successful" });
        }

        #endregion
    }
}