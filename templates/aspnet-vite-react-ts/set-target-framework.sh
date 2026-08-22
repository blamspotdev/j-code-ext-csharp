#!/bin/sh
# Set target framework
set -e

for cs in "$JCODE_PROJECT_DIR/Server"/*.csproj; do
  sed -i "s#<TargetFramework>[^<]*</TargetFramework>#<TargetFramework>$JCODE_INPUT_DOTNETTFM</TargetFramework>#" "$cs"
done
