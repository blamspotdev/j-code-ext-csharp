#!/bin/sh
# Configure Build & Run
set -e

mkdir -p "$JCODE_PROJECT_DIR/.jcode"
cat > "$JCODE_PROJECT_DIR/.jcode/run.yaml" <<YAML
version: 1
name: ASP.NET Core + Vite React (dev)
readyPort: 5173
terminals:
  - label: Run
    command: |
      clear
      set -e
      PROJ="$JCODE_PROJECT_DIR"
      SRV="\$HOME/.jcode-run/$JCODE_PROJECT_NAME-server"
      STAGE="\$HOME/.jcode-run/$JCODE_PROJECT_NAME-client"
      export npm_config_fund=false npm_config_audit=false
      CSPROJ=\$(ls "\$PROJ/Server"/*.csproj | head -1)
      echo '== J Code: ASP.NET Core + Vite React (dev) =='
      echo '[1/3] Building server (dotnet build, Debug)...'
      rm -rf "\$SRV"
      dotnet build "\$CSPROJ" -c Debug -o "\$SRV" --nologo
      echo '[2/3] Staging client + installing deps (npm install)...'
      rm -rf "\$STAGE" && mkdir -p "\$STAGE" && cp -a "\$PROJ/client/." "\$STAGE/"
      ( cd "\$STAGE" && npm install )
      echo '[3/3] Starting server (:5080, background) + Vite client (:5173)...'
      ( cd "\$SRV" && ASPNETCORE_ENVIRONMENT=Development ASPNETCORE_URLS='http://0.0.0.0:5080' exec dotnet "\$(basename "\$CSPROJ" .csproj).dll" ) &
      SRV_PID=\$!
      trap 'kill "\$SRV_PID" 2>/dev/null' INT TERM EXIT
      cd "\$STAGE"
      npm run dev -- --host 0.0.0.0 --port 5173
YAML
