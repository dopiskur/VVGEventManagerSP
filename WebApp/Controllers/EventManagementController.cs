﻿using eventLib.Dal;
using eventLib.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;
using WebApp.ViewModels;

namespace WebApp.Controllers
{
    public class EventManagementController : Controller
    {


        [Authorize]
        public ActionResult Index(string? search=null)
        {
            EventVM eventVM = new EventVM();


            eventVM.Events = RepoFactory.GetRepo().EventsGet(search);

            

            return View(eventVM);
        }

        [Authorize]
        public ActionResult Details(int idEvent)
        {
            EventVM eventVM = new EventVM();

            eventVM.Event = RepoFactory.GetRepo().EventGet(idEvent);
            eventVM.EventPerformers = RepoFactory.GetRepo().EventPerformersGet(idEvent);
            eventVM.EventTypes = RepoFactory.GetRepo().EventTypesGet();

            return View(eventVM);
        }

        [Authorize]
        public ActionResult Create()
        {

            try
            {
                var errMsg = TempData["ErrorMessage"] as string;
                ViewBag.ErrorMessage = errMsg;
                EventVM eventVM = new EventVM();
                eventVM.EventTypes = RepoFactory.GetRepo().EventTypesGet();

                return View(eventVM);
            }
            catch (Exception e)
            {

                return StatusCode(500, e.Message);
            }
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(EventVM eventVM, IFormFile imageFile)
        {
            try
            {
                //if (imageFile != null)
                //{}

                var memoryStream = new MemoryStream();
                imageFile.CopyToAsync(memoryStream);
                var imageData = memoryStream.ToArray();

                eventVM.Event.ImageName = imageFile.FileName;
                eventVM.Event.ImageData = imageData;

                RepoFactory.GetRepo().EventAdd(eventVM.Event);
                return RedirectToAction(nameof(Index));
            }
            catch (Exception e)
            {
                //TempData["ErrorMessage"] = "Name already exists";
                //return RedirectToAction("Create");

                //ModelState.AddModelError() //RIJESI OVO
                return View();
            }
        }

        [Authorize]
        public ActionResult Edit(int idEvent)
        {
            EventVM eventVM = new EventVM();

            eventVM.Event = RepoFactory.GetRepo().EventGet(idEvent);
            eventVM.EventPerformers = RepoFactory.GetRepo().EventPerformersGet(idEvent);
            eventVM.EventTypes = RepoFactory.GetRepo().EventTypesGet();

            

            return View(eventVM);
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(EventVM eventVM, IFormFile imageFile)
        {
            try
            {

                if (imageFile != null)
                {
                    var memoryStream = new MemoryStream();
                    imageFile.CopyToAsync(memoryStream);
                    var imageData = memoryStream.ToArray();

                    eventVM.Event.ImageName = imageFile.FileName;
                    eventVM.Event.ImageData = imageData;
                }

                RepoFactory.GetRepo().EventUpdate(eventVM.Event);


                return RedirectToAction("Edit", new { idEvent = eventVM.Event.IDEvent });
                //return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        [Authorize]
        public ActionResult Delete(int? idEvent)

        {
            Event value = RepoFactory.GetRepo().EventGet(idEvent);
            return View(value);
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirm(int idEvent)
        {
            try
            {
                RepoFactory.GetRepo().EventDelete(idEvent);
                return RedirectToAction(nameof(Index));
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
        }


        [Authorize]
        public ActionResult EventPerformerDelete(int? eventID, int? performerID)
        {
            RepoFactory.GetRepo().EventPerformerDelete(eventID, performerID);

            return RedirectToAction("Edit", new { idEvent = eventID });
        }

        [Authorize]
        public ActionResult EventPerformerAdd(int? eventID, string? search = null)
        {
            EventVM eventVM = new EventVM();
            eventVM.Event.IDEvent = eventID;
            eventVM.Performers = RepoFactory.GetRepo().PerformersGet(search);

            // eventVM.Event.IDEvent = eventID;
            eventVM.Performers = RepoFactory.GetRepo().PerformersGet(search);

            // 

            return View(eventVM);
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EventPerformerAdd(EventVM value)
        {


            try
            {
                RepoFactory.GetRepo().EventPerformerAdd(value.Event.IDEvent, value.EventPerformer.PerformerID);
                return RedirectToAction("Edit", new { idEvent = value.Event.IDEvent });
            }
            catch
            {
                return View();
            }
        }


    }
}
