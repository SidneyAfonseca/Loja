
using System;
using System.ComponentModel.DataAnnotations;

namespace Loja.Models
{
    public partial class Vendas 
    {
        public int ID { get; set; }

        [Display(Name = "Código")]
        public int CodCli { get; set; }

        [Display(Name = "Nome Cliente")]
        public string Cliente { get; set; }

        [Display(Name = "Data")]
        public DateTime? Data { get; set; }

        [Display(Name = "Total")]
        public decimal? Total { get; set; }
    }
}