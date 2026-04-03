using ProductWebApp.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddRazorPages();
builder.Services.AddHttpClient<ProductApiClient>(client =>
{
    var baseUrl = Environment.GetEnvironmentVariable("PRODUCT_API_URL")
                  ?? "http://localhost:5000"; // fallback for local dev
    client.BaseAddress = new Uri(baseUrl);
});

var app = builder.Build();
app.UseStaticFiles();
app.MapRazorPages();
app.Run();
