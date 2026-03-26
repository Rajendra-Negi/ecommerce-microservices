using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using System.Text.Json.Serialization;

[ApiController]
[Route("orders")]
public class OrderController : ControllerBase
{
    // Store enriched order details instead of raw orders
    private static readonly List<OrderDetails> Orders = new();
    private readonly HttpClient _httpClient;
    private readonly JsonSerializerOptions _jsonOptions;

    public OrderController(IHttpClientFactory httpClientFactory)
    {
        _httpClient = httpClientFactory.CreateClient();
        _jsonOptions = new JsonSerializerOptions
        {
            PropertyNameCaseInsensitive = true
        };
    }

    [HttpPost]
    public async Task<IActionResult> PlaceOrder([FromBody] Order order)
    {
        // Call Product Service
        var productResponse = await _httpClient.GetAsync($"http://dev.ecommerce.local/products/{order.ProductId}");
        if (!productResponse.IsSuccessStatusCode)
            return BadRequest("Product not found");
        var productJson = await productResponse.Content.ReadAsStringAsync();
        var product = JsonSerializer.Deserialize<Product>(productJson, _jsonOptions);

        // Call Customer Service
        var customerResponse = await _httpClient.GetAsync($"http://dev.ecommerce.local/customers/{order.CustomerId}");
        if (!customerResponse.IsSuccessStatusCode)
            return BadRequest("Customer not found");
        var customerJson = await customerResponse.Content.ReadAsStringAsync();
        var customer = JsonSerializer.Deserialize<Customer>(customerJson, _jsonOptions);

        // Build enriched order details
        var orderDetails = new OrderDetails(order, product, customer, "Placed");

        // Save enriched order details
        Orders.Add(orderDetails);

        return Ok(orderDetails);
    }

    [HttpGet]
    public IActionResult GetAllOrders() => Ok(Orders);
}

// Records
public record Order(string OrderId, string ProductId, string CustomerId, int Quantity);

public record Product(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("price")] decimal Price
);

public record Customer(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("status")] string Status
);

// New record to hold enriched details
public record OrderDetails(Order Order, Product Product, Customer Customer, string Status);
