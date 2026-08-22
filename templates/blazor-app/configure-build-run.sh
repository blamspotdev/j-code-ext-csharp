#!/bin/sh
# Configure Build & Run
set -e

mkdir -p "$JCODE_PROJECT_DIR/.jcode"
cat > "$JCODE_PROJECT_DIR/.jcode/run.yaml" <<YAML
version: 1
name: Blazor Web App (dev)
readyPort: 5080
terminals:
  - label: Web
    command: |
      clear
      set -e
      PROJ="$JCODE_PROJECT_DIR"
      SRV="\$HOME/.jcode-run/$JCODE_PROJECT_NAME-web"
      CSPROJ=\$(ls "\$PROJ"/*.csproj | head -1)
      echo '== J Code: Blazor Web App =='
      rm -rf "\$SRV"
      dotnet build "\$CSPROJ" -c Debug -o "\$SRV" --nologo
      cd "\$SRV"
      ASPNETCORE_ENVIRONMENT=Development ASPNETCORE_URLS='http://0.0.0.0:5080' dotnet "\$(basename "\$CSPROJ" .csproj).dll"
YAML
