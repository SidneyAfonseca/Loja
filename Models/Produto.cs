
using System.ComponentModel.DataAnnotations;

namespace Loja.Models
{
    
    public partial class Produtos
    {
        public int ID { get; set; }
        public string Descricao { get; set; }
        public decimal? Quantidade { get; set; }
        public decimal? Valor { get; set; }
    }
}