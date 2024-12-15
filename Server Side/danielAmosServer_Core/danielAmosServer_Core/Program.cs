using danielAmosServer_Core;
using danielAmosServer_Core.BL;
using danielAmosServer_Core.BLInterfaces;
using danielAmosServer_Core.DAL;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.DB;
using danielAmosServer_Core.Helpers.Middleware;
using danielAmosServer_Core.Helpers.Service;
using danielAmosServer_Core.Orchestration;
using danielAmosServer_Core.OrchestrationInterfaces;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Serilog;
using Serilog.AspNetCore;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.


// Configure Dependency injection

builder.Services.AddSingleton<DataHelper>();
builder.Services.AddSingleton<AppService>();

// DAL Layer
builder.Services.AddSingleton<EmployeeDAL>();
builder.Services.AddSingleton<ManagerDAL>();

// BL Layer
builder.Services.AddSingleton<EmployeeBL>();
builder.Services.AddSingleton<ManagerBL>();

// Orc Layer
builder.Services.AddSingleton<EmployeeOrcWrite>();
builder.Services.AddSingleton<EmployeeOrcRead>();
builder.Services.AddSingleton<ManagerOrcWrite>();
builder.Services.AddSingleton<ManagerOrcRead>();

// Configure CORS (Cross-Origin)

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowClientSide",
        builder =>
        {
            builder
                .WithOrigins("http://localhost:3000")
                .AllowAnyMethod()
                .AllowAnyHeader()
                .AllowCredentials();
        });
});


builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


// Configure Authentication

var jwtSettings = new JwtSettings();
builder.Configuration.GetSection("jwtSettings").Bind(jwtSettings);
builder.Services.AddSingleton(jwtSettings);

builder.Services.AddAuthentication(option =>
{
    option.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    option.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;

})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtSettings.Issuer,
        ValidAudience = jwtSettings.Audience,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SecretKey))
    };
});

builder.Services.AddAuthentication();



// Configure Log Tool

builder.Host.UseSerilog((context, configuration) =>
configuration.ReadFrom.Configuration(context.Configuration));

var app = builder.Build();

// Middleware
app.UseMiddleware<LogRequest>();
app.UseMiddleware<ExceptionRequest>();
app.UseCors("AllowClientSide");

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();


app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
