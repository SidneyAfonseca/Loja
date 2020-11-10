
using System.ComponentModel.DataAnnotations;

namespace Loja.Models
{
    
    public partial class VendasItens
    {
        public int Id { get; set; }
        public int Pedido { get; set; }        
        public int Produto { get; set; }
        public int? QuantProd { get; set; }
        public decimal? ValUnit { get; set; }      
    }
}