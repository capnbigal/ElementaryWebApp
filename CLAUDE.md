# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- Build: `dotnet build`
- Run (HTTPS dev profile): `dotnet run --launch-profile https`
- Run (HTTP dev profile): `dotnet run --launch-profile http`
- Restore: `dotnet restore`
- Clean: `dotnet clean`

There is no test project in this repo.

Dev URLs are bound to a custom hostname (`elementarybridgeapp.dev.localhost`) on ports 7221 (https) / 5210 (http) — see `Properties/launchSettings.json`. Reaching the app in a browser requires that hostname to resolve to localhost.

## Architecture

ASP.NET Core **Blazor Web App** targeting **net10.0** with `Nullable` and `ImplicitUsings` enabled.

- `Program.cs` is the composition root. It registers Razor components with `AddInteractiveServerComponents()` and maps them via `MapRazorComponents<App>().AddInteractiveServerRenderMode()`. Static assets are served through `MapStaticAssets()` (the .NET 9+ optimized static asset pipeline) — referenced from `App.razor` via the `@Assets[...]` helper, not raw paths.
- Render mode: the entire app runs under **InteractiveServer**. `App.razor` applies `@rendermode="InteractiveServer"` to both `<HeadOutlet>` and `<Routes>`, so every page is interactive-server by default. Switching a page to a different render mode (Static, WebAssembly, Auto) requires opting in per-component.
- `BlazorDisableThrowNavigationException` is set in the csproj — code must not rely on `NavigationManager.NavigateTo` throwing `NavigationException` to short-circuit execution.
- Routing: `Components/Routes.razor` wires the `Router` with `MainLayout` as the default and `Pages/NotFound.razor` as the not-found page. Status code re-execution is handled by `UseStatusCodePagesWithReExecute("/not-found", ...)` in `Program.cs`.
- Component layout follows the standard Blazor Web App template:
  - `Components/App.razor` — root HTML document
  - `Components/Layout/` — `MainLayout`, `NavMenu`, `ReconnectModal` (with co-located `.razor.css` and `.razor.js`)
  - `Components/Pages/` — routable pages (`Home`, `Counter`, `Weather`, `Error`, `NotFound`)
  - `Components/_Imports.razor` — global `@using` directives for all components
- Bootstrap is vendored under `wwwroot/lib/bootstrap/` and loaded via `@Assets["lib/bootstrap/dist/css/bootstrap.min.css"]`.
