#!/usr/bin/env bash
# Fails when the shared reference files that every skill ships are not identical.
# Each skill installs on its own, so shared rules are copied, not linked.
set -euo pipefail
cd "$(dirname "$0")/.."
skills_dir="plugins/trackingtime/skills"
status=0
check() {
  file="$1"; shift
  first=""
  for skill in "$@"; do
    path="$skills_dir/$skill/references/$file"
    if [ ! -f "$path" ]; then echo "MISSING  $path"; status=1; continue; fi
    if [ -z "$first" ]; then first="$path"; continue; fi
    if ! cmp -s "$first" "$path"; then echo "DIFFERS  $path (vs $first)"; status=1; fi
  done
}
check missing-day.md tt-timesheet-assistant tt-hr-manager tt-payroll-assistant
check connect.md tt-timesheet-assistant tt-hr-manager tt-payroll-assistant tt-account-manager tt-project-manager
# The shared minimum must carry the same key in the three config files.
key='A day counts as logged when it has at least this many minutes of worked time:'
for skill in tt-timesheet-assistant tt-hr-manager tt-payroll-assistant; do
  if ! grep -qF "$key" "$skills_dir/$skill/config.md"; then echo "MISSING KEY  $skills_dir/$skill/config.md"; status=1; fi
done
if [ "$status" -eq 0 ]; then echo "shared references OK"; fi
exit "$status"
