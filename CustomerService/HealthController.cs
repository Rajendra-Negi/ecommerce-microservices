using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("healthz")]
public class HealthController : ControllerBase
{
    [HttpGet]
    public IActionResult Get()
    {
        // Optionally add deeper checks (DB, cache, etc.)
        return Ok("Healthy");
    }
}
