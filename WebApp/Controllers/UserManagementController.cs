﻿using eventLib.Dal;
using eventLib.Models;
using eventLib.Security;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using WebApp.ViewModels;
using Microsoft.AspNetCore.Authorization;

namespace WebApp.Controllers
{
    public class UserManagementController : Controller
    {
        // GET: PerformerController
        public ActionResult Index()
        {
            UserVM userVM = new UserVM();
            userVM.Users = RepoFactory.GetRepo().UsersGet();
            return View(userVM);
        }


   
        public ActionResult Create()
        {

            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(UserVM userVM)
        {
            try
            {
                // RepoFactory.GetRepo().UserAdd(userVM.UserEdit);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        [Authorize]
        public ActionResult Edit(int? idUser)
        {
            User user = RepoFactory.GetRepo().UserGet(idUser, null); 
            UserVM userVM = new UserVM();

 
            userVM.UserEdit.IDUser = user.IDUser;
            userVM.UserEdit.Username = user.Username;
            userVM.UserEdit.FirstName = user.FirstName;
            userVM.UserEdit.LastName = user.LastName;
            userVM.UserEdit.Email = user.Email;
            userVM.UserEdit.Phone = user.Phone;
            userVM.UserEdit.RoleName = user.RoleName;

            userVM.UserRoles = RepoFactory.GetRepo().UserRolesGet();
            return View(userVM);
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(UserVM value)
        {
            try
            {
                User user = RepoFactory.GetRepo().UserGet(value.UserEdit.IDUser,null);

                user.IDUser = value.UserEdit.IDUser;
                user.Username = value.UserEdit.Username;
                user.FirstName = value.UserEdit.FirstName;
                user.LastName = value.UserEdit.LastName;
                user.Email = value.UserEdit.Email;
                user.Phone = value.UserEdit.Phone;
                user.UserRoleId = value.UserEdit.UserRoleId;

                if(value.UserEdit.Password != null)
                {
                    var b64salt = AuthenticationProvider.GetSalt();
                    var b64hash = AuthenticationProvider.GetHash(value.UserEdit.Password, b64salt);
                    user.PwdSalt = b64salt;
                    user.PwdHash = b64hash;
                }

                RepoFactory.GetRepo().UserUpdate(user);


                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        [Authorize]
        public ActionResult Delete(int? idUser)

        {
            User value = RepoFactory.GetRepo().UserGet(idUser, null);
            return View(value);
        }
        [Authorize]

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirm(int? idUser)
        {
            try
            {
                RepoFactory.GetRepo().UserDelete(idUser);
                return RedirectToAction(nameof(Index));
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }

        [Authorize]
        public ActionResult EditProfile()
        {
            string? username = HttpContext.User.FindFirst(ClaimTypes.Name)?.Value;
            User user = RepoFactory.GetRepo().UserGet(null, username);
            UserVM userVM = new UserVM();

            if (user == null)
            {
                Task.Run(async () =>
                        await HttpContext.SignOutAsync(
                        CookieAuthenticationDefaults.AuthenticationScheme)
                        ).GetAwaiter().GetResult();

                return RedirectToAction("Login", "User");
            }


            userVM.UserEdit.IDUser = user.IDUser;
            userVM.UserEdit.Username = user.Username;
            userVM.UserEdit.FirstName = user.FirstName;
            userVM.UserEdit.LastName = user.LastName;
            userVM.UserEdit.Email = user.Email;
            userVM.UserEdit.Phone = user.Phone;
            userVM.UserEdit.RoleName = user.RoleName;

            userVM.UserRoles = RepoFactory.GetRepo().UserRolesGet();
            return View(userVM);
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProfile(UserVM value)
        {
            try
            {
                User user = RepoFactory.GetRepo().UserGet(value.UserEdit.IDUser, null);


                user.Username = value.UserEdit.Username;
                user.FirstName = value.UserEdit.FirstName;
                user.LastName = value.UserEdit.LastName;
                user.Email = value.UserEdit.Email;
                user.Phone = value.UserEdit.Phone;

                if (value.UserEdit.Password != null)
                {
                    var b64salt = AuthenticationProvider.GetSalt();
                    var b64hash = AuthenticationProvider.GetHash(value.UserEdit.Password, b64salt);
                    user.PwdSalt = b64salt;
                    user.PwdHash = b64hash;
                }

                RepoFactory.GetRepo().UserUpdate(user);


                return View();
            }
            catch
            {
                return View();
            }
        }


    }
}
