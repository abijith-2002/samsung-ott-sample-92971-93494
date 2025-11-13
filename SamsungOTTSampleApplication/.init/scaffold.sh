#!/usr/bin/env bash
set -euo pipefail
WORKDIR="/home/kavia/workspace/code-generation/samsung-ott-sample-92971-93494/SamsungOTTSampleApplication"
cd "$WORKDIR"
LOG=/tmp/scaffold.log
# Idempotency: check package.json with react dependency
if [ -f package.json ]; then
  if node -e "const p=require('./package.json'); if(p.dependencies&&p.dependencies.react||p.devDependencies&&p.devDependencies.react){process.exit(0)} else {process.exit(2)}" 2>/dev/null; then exit 0; fi
fi
# Choose CRA binary: prefer preinstalled but fall back to npx to avoid global permission issues
if command -v create-react-app >/dev/null; then
  # try to run create-react-app but fall back to npx if permission issues occur
  CRA_CMD=(create-react-app . --use-npm --template cra-template-pwa)
  if ("${CRA_CMD[@]}" > "$LOG" 2>&1); then
    true
  else
    # capture failure and switch to npx
    sed -n '1,200p' "$LOG" >&2 || true
    CRA_CMD=(npx --yes create-react-app@latest . --use-npm --template cra-template-pwa)
    ("${CRA_CMD[@]}" > "$LOG" 2>&1) || (sed -n '1,200p' "$LOG" >&2; exit 20)
  fi
else
  CRA_CMD=(npx --yes create-react-app@latest . --use-npm --template cra-template-pwa)
  ("${CRA_CMD[@]}" > "$LOG" 2>&1) || (sed -n '1,200p' "$LOG" >&2; exit 20)
fi
# ensure git is initialized
[ -d .git ] || git init -q || true
# quick verification: package.json now must declare react
if ! node -e "const p=require('./package.json'); if(!(p.dependencies&&p.dependencies.react)) process.exit(1)" 2>/dev/null; then
  echo "ERR: scaffold failed - react not present" >&2
  sed -n '1,200p' "$LOG" || true
  exit 21
fi
