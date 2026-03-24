var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Services.AddHttpClient(); // enable REST calls

var app = builder.Build();
app.MapControllers();
app.Run();