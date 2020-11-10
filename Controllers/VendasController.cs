using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Loja.Data;
using Loja.Models;

namespace Loja.Controllers
{
    public class VendasController : Controller
    {
        private LojaContext db = new LojaContext();

        // GET: Vendas
        public ActionResult Index()
        {
            return View(db.Vendas.ToList());
        }

        // GET: Vendas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Vendas vendas = db.Vendas.Find(id);
            if (vendas == null)
            {
                return HttpNotFound();
            }
            return View(vendas);
        }

        // GET: Vendas/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Vendas/Create
        // Para proteger-se contra ataques de excesso de postagem, ative as propriedades específicas às quais deseja se associar. 
        // Para obter mais detalhes, confira https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,CodCli,Cliente,Data,Total")] Vendas vendas)
        {
            if (ModelState.IsValid)
            {
                db.Vendas.Add(vendas);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(vendas);
        }

        // GET: Vendas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Vendas vendas = db.Vendas.Find(id);
            if (vendas == null)
            {
                return HttpNotFound();
            }
            return View(vendas);
        }

        // POST: Vendas/Edit/5
        // Para proteger-se contra ataques de excesso de postagem, ative as propriedades específicas às quais deseja se associar. 
        // Para obter mais detalhes, confira https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,CodCli,Cliente,Data,Total")] Vendas vendas)
        {
            if (ModelState.IsValid)
            {
                db.Entry(vendas).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(vendas);
        }

        // GET: Vendas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Vendas vendas = db.Vendas.Find(id);
            if (vendas == null)
            {
                return HttpNotFound();
            }
            return View(vendas);
        }

        // POST: Vendas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Vendas vendas = db.Vendas.Find(id);
            db.Vendas.Remove(vendas);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
