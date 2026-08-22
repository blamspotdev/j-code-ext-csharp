#!/bin/sh
# Serve the built client from the server
set -e

cat > "$JCODE_PROJECT_DIR/Server/Program.cs" <<'EOF'
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Serve the Vite-built React client published into wwwroot.
app.UseDefaultFiles();
app.UseStaticFiles();

// Example API endpoint the client can call.
app.MapGet("/api/hello", () => "Hello from ASP.NET Core");

// SPA fallback: any non-file route returns index.html so client routing works.
app.MapFallbackToFile("index.html");

app.Run();
EOF
