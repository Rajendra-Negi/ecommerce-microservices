using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("customers")]
public class CustomerController : ControllerBase
{
    private static readonly List<Customer> Customers = new()
    {
        new Customer("C101", "Rajesh Kumar", "Active"),
        new Customer("C102", "Anita Sharma", "Inactive"),
        new Customer("C103", "Vikram Singh", "Active"),
        new Customer("C104", "Priya Nair", "Active"),
        new Customer("C105", "Sunil Mehta", "Suspended")
    };

    [HttpGet]
    public IActionResult GetAllCustomers() => Ok(Customers);

    [HttpGet("{id}")]
    public IActionResult GetCustomer(string id)
    {
        var customer = Customers.FirstOrDefault(c => c.Id == id);
        return customer is null ? NotFound() : Ok(customer);
    }

    [HttpPost]
    public IActionResult AddCustomer([FromBody] Customer customer)
    {
        Customers.Add(customer);
        return Created($"/customers/{customer.Id}", customer);
    }
}

public record Customer(string Id, string Name, string Status);