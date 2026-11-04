#!/usr/bin/env bash
# Builds one ZIP per skill in dist/, ready to upload to Claude, ChatGPT or Gemini.
# Each ZIP has the skill folder at its root, which is what those apps expect.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/*.zip
for dir in plugins/trackingtime/skills/*/; do
  name="$(basename "$dir")"
  (cd plugins/trackingtime/skills && zip -qr "../../../dist/${name}.zip" "$name")
  echo "dist/${name}.zip"
done
