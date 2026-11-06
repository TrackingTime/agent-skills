#!/usr/bin/env bash
# Builds one ZIP per skill in dist/, ready to upload to Claude, ChatGPT or Gemini,
# plus dist/trackingtime-agents.zip with every agent folder for coding agents
# (.agents/skills/) and dist/trackingtime-plugin.zip, the whole plugin for
# Claude Team and Enterprise organization uploads.
# Each per-agent ZIP has the skill folder at its root, which is what those apps expect.
set -euo pipefail
cd "$(dirname "$0")/.."
bash scripts/check-shared-refs.sh
mkdir -p dist
rm -f dist/*.zip
for dir in plugins/trackingtime/skills/*/; do
  name="$(basename "$dir")"
  (cd plugins/trackingtime/skills && zip -qr "../../../dist/${name}.zip" "$name")
  echo "dist/${name}.zip"
done
bundle_dir="$(mktemp -d)/trackingtime-agents"
mkdir -p "$bundle_dir"
cp -R plugins/trackingtime/skills/. "$bundle_dir/"
cp plugins/trackingtime/README.md "$bundle_dir/README.md"
(cd "$(dirname "$bundle_dir")" && zip -qr "$OLDPWD/dist/trackingtime-agents.zip" "trackingtime-agents" -x '*.DS_Store')
rm -rf "$(dirname "$bundle_dir")"
echo "dist/trackingtime-agents.zip"
# Plugin ZIP for Claude Team and Enterprise (Organization settings > Plugins & skills > Upload a plugin):
# the plugin folder at the root, with .claude-plugin/plugin.json, .mcp.json, commands/ and skills/.
plugin_dir="$(mktemp -d)/trackingtime"
mkdir -p "$plugin_dir"
cp -R plugins/trackingtime/. "$plugin_dir/"
(cd "$(dirname "$plugin_dir")" && zip -qr "$OLDPWD/dist/trackingtime-plugin.zip" "trackingtime" -x '*.DS_Store')
rm -rf "$(dirname "$plugin_dir")"
echo "dist/trackingtime-plugin.zip"
