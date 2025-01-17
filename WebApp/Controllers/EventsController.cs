using eventLib.Dal;
using eventLib.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Security.Claims;
using WebApp.ViewModels;

namespace WebApp.Controllers
{
    public class EventsController : Controller
    {
        // GET: EventsController
        public ActionResult Index(string? search=null)
        {
            EventVM eventVM = new EventVM();


            eventVM.Events = RepoFactory.GetRepo().MyEventsGet(search);



            return View(eventVM);
        }

        // GET: EventsController/Details/5
        public ActionResult Details(int? idEvent)
        {
            EventVM eventVM = new EventVM();

            eventVM.Event = RepoFactory.GetRepo().EventGet(idEvent);
            eventVM.EventPerformers = RepoFactory.GetRepo().EventPerformersGet(idEvent);
            eventVM.EventTypes = RepoFactory.GetRepo().EventTypesGet();

            return View(eventVM);
        }

        public ActionResult MyEventsDetails(int? idEvent)
        {
            EventVM eventVM = new EventVM();

            eventVM.Event = RepoFactory.GetRepo().EventGet(idEvent);
            eventVM.EventPerformers = RepoFactory.GetRepo().EventPerformersGet(idEvent);
            eventVM.EventTypes = RepoFactory.GetRepo().EventTypesGet();

            return View(eventVM);
        }

        public ActionResult Add(int? idEvent)
        {
            EventVM eventVM = new EventVM();

            eventVM.Event = RepoFactory.GetRepo().EventGet(idEvent);
            eventVM.EventPerformers = RepoFactory.GetRepo().EventPerformersGet(idEvent);
            eventVM.EventTypes = RepoFactory.GetRepo().EventTypesGet();

            return View(eventVM);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RegistrationConfirm(int? eventID)
        {
            try
            {
                //HttpContext.Request.Cookies.TryGetValue("Name", out var username);


                string? username = HttpContext.User.FindFirst(ClaimTypes.Name)?.Value;

                User user = RepoFactory.GetRepo().UserGet(null, username);

                RepoFactory.GetRepo().EventRegistrationAdd(eventID, user.IDUser);


                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }




        public ActionResult MyEvents(string? search = null)
        {
            EventVM eventVM = new EventVM();

            string? username = HttpContext.User.FindFirst(ClaimTypes.Name)?.Value;
            User user = RepoFactory.GetRepo().UserGet(null, username);

            eventVM.EventRegistrations = RepoFactory.GetRepo().EventRegistrationsGet(user.IDUser,search);



            return View(eventVM);
        }


        public ActionResult Remove(int? idEvent)
        {
            EventVM eventVM = new EventVM();

            eventVM.Event = RepoFactory.GetRepo().EventGet(idEvent);
            eventVM.EventPerformers = RepoFactory.GetRepo().EventPerformersGet(idEvent);
            eventVM.EventTypes = RepoFactory.GetRepo().EventTypesGet();

            return View(eventVM);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RegistrationRemoveConfirm(int? eventID)
        {
            try
            {
                //HttpContext.Request.Cookies.TryGetValue("Name", out var username);


                string? username = HttpContext.User.FindFirst(ClaimTypes.Name)?.Value;

                User user = RepoFactory.GetRepo().UserGet(null, username);

                RepoFactory.GetRepo().EventRegistrationDelete(eventID, user.IDUser);


                return RedirectToAction(nameof(MyEvents));
            }
            catch
            {
                return View();
            }
        }

    }
}
