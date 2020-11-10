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
    public class VendasItensController : Controller
    {
        private LojaContext db = new LojaContext();

        // GET: VendasItens
        public ActionResult Index()
        {
            return View(db.VendasItens.ToList());
        }

        // GET: VendasItens/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            VendasItens vendasItens = db.VendasItens.Find(id);
            if (vendasItens == null)
            {
                return HttpNotFound();
            }
            return View(vendasItens);
        }

        // GET: VendasItens/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: VendasItens/Create
        // Para proteger-se contra ataques de excesso de postagem, ative as propriedades específicas às quais deseja se associar. 
        // Para obter mais detalhes, confira https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Pedido,Produto,QuantProd,ValUnit")] VendasItens vendasItens)
        {
            if (ModelState.IsValid)
            {
                db.VendasItens.Add(vendasItens);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(vendasItens);
        }

        // GET: VendasItens/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            VendasItens vendasItens = db.VendasItens.Find(id);
            if (vendasItens == null)
            {
                return HttpNotFound();
            }
            return View(vendasItens);
        }

        // POST: VendasItens/Edit/5
        // Para proteger-se contra ataques de excesso de postagem, ative as propriedades específicas às quais deseja se associar. 
        // Para obter mais detalhes, confira https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Pedido,Produto,QuantProd,ValUnit")] VendasItens vendasItens)
        {
            if (ModelState.IsValid)
            {
                db.Entry(vendasItens).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(vendasItens);
        }

        // GET: VendasItens/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            VendasItens vendasItens = db.VendasItens.Find(id);
            if (vendasItens == null)
            {
                return HttpNotFound();
            }
            return View(vendasItens);
        }

        // POST: VendasItens/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            VendasItens vendasItens = db.VendasItens.Find(id);
            db.VendasItens.Remove(vendasItens);
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
