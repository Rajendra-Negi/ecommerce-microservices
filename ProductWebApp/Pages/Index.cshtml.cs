using Microsoft.AspNetCore.Mvc.RazorPages;
using ProductWebApp.Models;
using ProductWebApp.Services;

namespace ProductWebApp.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ProductApiClient _client;
        public List<Product> Products { get; set; } = new();

        public IndexModel(ProductApiClient client) => _client = client;

        public async Task OnGetAsync()
        {
            Products = await _client.GetProductsAsync();
        }
    }
}
