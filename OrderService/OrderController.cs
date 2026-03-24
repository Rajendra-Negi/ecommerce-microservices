using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

[ApiController]
[Route("orders")]
public class OrderController : ControllerBase
{
    private static readonly List<Order> Orders = new();
    private readonly HttpClient _httpClient;

    public OrderController(IHttpClientFactory httpClientFactory)
    {
        _httpClient = httpClientFactory.CreateClient();
    }

    [HttpPost]
    public async Task<IActionResult> PlaceOrder([FromBody] Order order)
    {
        // Call Product Service
        var productResponse = await _httpClient.GetAsync($"http://product-service:8080/products/{order.ProductId}");
        if (!productResponse.IsSuccessStatusCode)
            return BadRequest("Product not found");
        var productJson = await productResponse.Content.ReadAsStringAsync();
        var product = JsonSerializer.Deserialize<Product>(productJson);

        // Call Customer Service
        var customerResponse = await _httpClient.GetAsync($"http://customer-service:8080/customers/{order.CustomerId}");
        if (!customerResponse.IsSuccessStatusCode)
            return BadRequest("Customer not found");
        var customerJson = await customerResponse.Content.ReadAsStringAsync();
        var customer = JsonSerializer.Deserialize<Customer>(customerJson);

        // Save order
        Orders.Add(order);

        // Return combined details
        var orderDetails = new
        {
            Order = order,
            Product = product,
            Customer = customer,
            Status = "Placed"
        };

        return Ok(orderDetails);
    }

    [HttpGet]
    public IActionResult GetAllOrders() => Ok(Orders);
}

public record Order(string OrderId, string ProductId, string CustomerId, int Quantity);
public record Product(string Id, string Name, decimal Price);
public record Customer(string Id, string Name, string Status);