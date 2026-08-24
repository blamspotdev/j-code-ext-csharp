#!/bin/sh
# Run
clear
set -e
SRV="$HOME/.jcode-run/aspnet-server"
STAGE="$HOME/.jcode-run/aspnet-react-client"
export npm_config_fund=false npm_config_audit=false
echo '== J Code: ASP.NET Core + React (dev) =='
echo '[1/3] Building server (dotnet build, Debug)...'
rm -rf "$SRV"
dotnet build "$JCODE_FILE1" -c Debug -o "$SRV" --nologo
echo '[2/3] Staging client + installing deps (npm install)...'
rm -rf "$STAGE" && mkdir -p "$STAGE" && cp -a "$JCODE_DIR2/." "$STAGE/"
( cd "$STAGE" && npm install )
echo '[3/3] Starting server (:5080, background) + Vite client (:5173)...'
( cd "$SRV" && ASPNETCORE_ENVIRONMENT=Development ASPNETCORE_URLS='http://0.0.0.0:5080' exec dotnet "$(basename "$JCODE_FILE1" .csproj).dll" ) &
SRV_PID=$!
trap 'kill "$SRV_PID" 2>/dev/null' INT TERM EXIT
cd "$STAGE"
npm run dev -- --host 0.0.0.0 --port 5173
