#!/bin/sh
# Run
clear
set -e
OUT="$HOME/.jcode-run/dotnet-run"
rm -rf "$OUT"
dotnet build "$JCODE_FILE" -c Debug -o "$OUT" --nologo
cd "$OUT"
ASPNETCORE_URLS='http://0.0.0.0:5080' dotnet "$(basename "$JCODE_FILE" .csproj).dll"
