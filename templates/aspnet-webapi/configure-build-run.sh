#!/bin/sh
# Configure Build & Run
set -e

mkdir -p "$JCODE_PROJECT_DIR/.jcode"
cat > "$JCODE_PROJECT_DIR/.jcode/run.yaml" <<YAML
version: 1
name: ASP.NET Core Web API (dev)
readyPort: 5080
terminals:
  - label: API
    command: |
      clear
      set -e
      PROJ="$JCODE_PROJECT_DIR"
      SRV="\$HOME/.jcode-run/$JCODE_PROJECT_NAME-api"
      CSPROJ=\$(ls "\$PROJ"/*.csproj | head -1)
      echo '== J Code: ASP.NET Core Web API =='
      rm -rf "\$SRV"
      dotnet build "\$CSPROJ" -c Debug -o "\$SRV" --nologo
      cd "\$SRV"
      ASPNETCORE_ENVIRONMENT=Development ASPNETCORE_URLS='http://0.0.0.0:5080' dotnet "\$(basename "\$CSPROJ" .csproj).dll"
YAML
