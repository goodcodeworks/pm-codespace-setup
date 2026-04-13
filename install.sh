#!/usr/bin/env bash
set -euo pipefail

# pm-codespace-setup installer
# Usage: curl -sL https://raw.githubusercontent.com/goodcodeworks/pm-codespace-setup/main/install.sh | bash

REPO="goodcodeworks/pm-codespace-setup"
BRANCH="${PM_SETUP_BRANCH:-main}"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/template"

# Colors (ANSI-C quoted so the bytes are real ESC, not literal \033)
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
RED=$'\033[0;31m'
CYAN=$'\033[0;36m'
NC=$'\033[0m'

say() { printf "${CYAN}▶${NC} %s\n" "$*"; }
ok()  { printf "${GREEN}✓${NC} %s\n" "$*"; }
warn(){ printf "${YELLOW}⚠${NC} %s\n" "$*"; }
die() { printf "${RED}✗${NC} %s\n" "$*" >&2; exit 1; }

# Must run in a git repo root
if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
  die "Not inside a git repository. cd into a repo root and re-run."
fi

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

say "Installing PM Codespace setup into $(basename "$REPO_ROOT")"

# Files to fetch: <source>:<dest>[:<mode>]
FILES=(
  ".devcontainer/devcontainer.json:.devcontainer/devcontainer.json"
  ".devcontainer/setup.sh:.devcontainer/setup.sh:755"
  ".devcontainer/zen-startup.vsix:.devcontainer/zen-startup.vsix"
  ".devcontainer/zen-startup/extension.js:.devcontainer/zen-startup/extension.js"
  ".devcontainer/zen-startup/package.json:.devcontainer/zen-startup/package.json"
  "CLAUDE.md:CLAUDE.md"
  "README-PM.md:README-PM.md"
)

overwrites=()
for entry in "${FILES[@]}"; do
  IFS=':' read -r src dest mode <<< "$entry"
  if [ -f "$dest" ]; then overwrites+=("$dest"); fi
done

if [ ${#overwrites[@]} -gt 0 ]; then
  warn "These files already exist and will be overwritten:"
  printf "  - %s\n" "${overwrites[@]}"
  printf "Continue? [y/N] "
  read -r confirm </dev/tty || confirm="n"
  case "$confirm" in
    y|Y|yes|YES) ;;
    *) die "Aborted." ;;
  esac
fi

for entry in "${FILES[@]}"; do
  IFS=':' read -r src dest mode <<< "$entry"
  mkdir -p "$(dirname "$dest")"
  say "Fetching $src"
  if ! curl -fsSL "$BASE_URL/$src" -o "$dest"; then
    die "Failed to fetch $BASE_URL/$src"
  fi
  if [ -n "${mode:-}" ]; then
    chmod "$mode" "$dest"
  fi
done

ok "Files installed."

# If README.md doesn't exist, copy README-PM.md to it
if [ ! -f "README.md" ]; then
  cp README-PM.md README.md
  ok "README.md created from PM template (delete README-PM.md if you like)"
else
  warn "README.md already exists — left untouched. PM content saved as README-PM.md for reference."
fi

# Summary / next steps
cat <<EOF

${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
  ${GREEN}✓ PM Codespace setup installed${NC}
${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}

Next steps:

  1. Review the changes:
     ${CYAN}git status${NC}

  2. Commit and push:
     ${CYAN}git add .devcontainer CLAUDE.md README*.md${NC}
     ${CYAN}git commit -m "Add PM Codespace setup"${NC}
     ${CYAN}git push${NC}

  3. Add any required Codespaces secrets (if your app needs env vars):
     Org:  https://github.com/organizations/<ORG>/settings/codespaces
     Repo: https://github.com/<ORG>/<REPO>/settings/secrets/codespaces

  4. If this is in an org, enable Codespaces access for org members:
     https://github.com/organizations/<ORG>/settings/codespaces

  5. Open a Codespace to try it:
     Green Code button → Codespaces tab → Create codespace on main

${YELLOW}Heads up:${NC} The first boot takes ~90s while dependencies install.
After that, you land in a full-screen terminal with Claude Code ready to go.

EOF
