using eventLib.Dal;
using eventLib.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using WebApp.ViewModels;

namespace WebApp.Controllers
{
    public class PerformerManagementController : Controller
    {
        // GET: PerformerController
        public ActionResult Index(string? search = null)
        {
            PerformerVM performerVM = new PerformerVM();
            performerVM.Performers = RepoFactory.GetRepo().PerformersGet(search);
            return View(performerVM);
        }


        // GET: PerformerController/Create
        public ActionResult Create()
        {

            return View();
        }

        // POST: PerformerController/Create
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

        // GET: PerformerController/Edit/5
        public ActionResult Edit(int idPerformer)
        {
            PerformerVM performerVM = new PerformerVM();
            performerVM.Performer = RepoFactory.GetRepo().PerformerGet(idPerformer);
            return View(performerVM);
        }

        // POST: PerformerController/Edit/5
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

        public ActionResult Delete(int? idPerformer)

        {
            Performer value = RepoFactory.GetRepo().PerformerGet(idPerformer);
            return View(value);
        }

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
