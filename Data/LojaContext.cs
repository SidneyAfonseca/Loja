using Loja.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Loja.Data
{
    public class LojaContext : DbContext
    {
        public LojaContext() : base("Loja")
        {
        }

        public DbSet<Vendas> Vendas { get; set; }
        public DbSet<VendasItens> VendasItens { get; set; }
        public DbSet<Produtos> Produto { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();

            base.OnModelCreating(modelBuilder);
        }
    }
}