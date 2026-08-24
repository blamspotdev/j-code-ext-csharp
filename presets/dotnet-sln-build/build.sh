#!/bin/sh
# Build
clear
set -e
dotnet build "$JCODE_FILE" --nologo
