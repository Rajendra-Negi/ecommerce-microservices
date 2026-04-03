using ProductWebApp.Models;

namespace ProductWebApp.Services
{
    public class ProductApiClient
    {
        private readonly HttpClient _httpClient;
        public ProductApiClient(HttpClient httpClient) => _httpClient = httpClient;

        public async Task<List<Product>> GetProductsAsync()
        {
            var response = await _httpClient.GetAsync("products");
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadFromJsonAsync<List<Product>>() ?? new List<Product>();
        }
    }
}
