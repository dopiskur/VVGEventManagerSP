using eventLib.Dal;
using eventLib.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using WebApp.ViewModels;

namespace WebApp.Controllers
{
    public class PerformerManagementController : Controller
    {
        [Authorize]
        public ActionResult Index(string? search = null)
        {
            PerformerVM performerVM = new PerformerVM();
            performerVM.Performers = RepoFactory.GetRepo().PerformersGet(search);
            return View(performerVM);
        }


        [Authorize]
        public ActionResult Create()
        {

            return View();
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(PerformerVM performerVM)
        {
            try
            {
                RepoFactory.GetRepo().PerformerAdd(performerVM.Performer);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        [Authorize]
        public ActionResult Edit(int idPerformer)
        {
            PerformerVM performerVM = new PerformerVM();
            performerVM.Performer = RepoFactory.GetRepo().PerformerGet(idPerformer);
            return View(performerVM);
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(PerformerVM value)
        {
            try
            {
                RepoFactory.GetRepo().PerformerUpdate(value.Performer);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        [Authorize]
        public ActionResult Delete(int? idPerformer)

        {
            Performer value = RepoFactory.GetRepo().PerformerGet(idPerformer);
            return View(value);
        }
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirm(int idPerformer)
        {
            try
            {
                RepoFactory.GetRepo().PerformerDelete(idPerformer);
                return RedirectToAction(nameof(Index));
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }
    }
}
