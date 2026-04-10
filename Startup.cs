using ElementaryBridgeApp.Components;
using ElementaryBridgeApp.Data;
using Microsoft.EntityFrameworkCore;
using MudBlazor.Services;

namespace ElementaryBridgeApp
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddRazorComponents()
                .AddInteractiveServerComponents();

            services.AddMudServices();

            services.AddDbContextFactory<ElementaryDbContext>(options =>
                options.UseSqlServer(Configuration.GetConnectionString("ElementaryDB")));

            // Add my services here
            services.AddScoped<ToolSlotConfigurationService>();
            services.AddScoped<ToolSlotConfigurationAuditService>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(WebApplication app, IWebHostEnvironment env)
        {
            if (!env.IsDevelopment())
            {
                app.UseExceptionHandler("/Error", createScopeForErrors: true);
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseStatusCodePagesWithReExecute("/not-found", createScopeForStatusCodePages: true);
            app.UseHttpsRedirection();

            app.UseAntiforgery();

            app.MapStaticAssets();
            app.MapRazorComponents<App>()
                .AddInteractiveServerRenderMode();
        }
    }
}
