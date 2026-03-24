using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("products")]
public class ProductController : ControllerBase
{
    private static readonly List<Product> Products = new()
    {
        new Product("P101", "Laptop", 75000),
        new Product("P102", "Smartphone", 25000),
        new Product("P103", "Headphones", 3000),
        new Product("P104", "Monitor", 12000),
        new Product("P105", "Keyboard", 1500)
    };

    [HttpGet]
    public IActionResult GetAllProducts() => Ok(Products);

    [HttpGet("{id}")]
    public IActionResult GetProduct(string id)
    {
        var product = Products.FirstOrDefault(p => p.Id == id);
        return product is null ? NotFound() : Ok(product);
    }

    [HttpPost]
    public IActionResult AddProduct([FromBody] Product product)
    {
        Products.Add(product);
        return Created($"/products/{product.Id}", product);
    }
}

public record Product(string Id, string Name, decimal Price);