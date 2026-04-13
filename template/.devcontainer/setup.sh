#!/usr/bin/env bash
set -uo pipefail

# Portable setup.sh — works for any repo using this template.
# Detects the project root, package manager, and handles first-boot PM setup.

WORKSPACE_DIR="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$WORKSPACE_DIR"

echo "📁 Workspace: $WORKSPACE_DIR"

# -----------------------------------------------------------------------------
# Auto-checkout a PM branch so the PM never edits main by accident
# -----------------------------------------------------------------------------
if [ -n "${CODESPACE_NAME:-}" ]; then
  USER_SLUG="${GITHUB_USER:-pm}"
  CS_SLUG="${CODESPACE_NAME##*-}"
  BRANCH="pm/${USER_SLUG}-${CS_SLUG}"
  echo "🌿 Creating PM branch: $BRANCH"
  if git checkout -b "$BRANCH" 2>/dev/null; then
    echo "✓ Created branch $BRANCH"
  elif git checkout "$BRANCH" 2>/dev/null; then
    echo "✓ Switched to existing branch $BRANCH"
  else
    echo "⚠️ Could not create or switch to $BRANCH — staying on current branch"
  fi
fi

# -----------------------------------------------------------------------------
# Detect and run the right package manager
# -----------------------------------------------------------------------------
PM=""
if   [ -f bun.lock ] || [ -f bun.lockb ]; then PM="bun"
elif [ -f pnpm-lock.yaml ];                 then PM="pnpm"
elif [ -f yarn.lock ];                       then PM="yarn"
elif [ -f package-lock.json ];               then PM="npm"
elif [ -f package.json ];                    then PM="npm"
fi

if [ -n "$PM" ]; then
  echo "🔧 Installing project dependencies with $PM..."
  case "$PM" in
    bun)  command -v bun  >/dev/null 2>&1 || npm install -g bun
          bun install ;;
    pnpm) command -v pnpm >/dev/null 2>&1 || npm install -g pnpm
          pnpm install ;;
    yarn) command -v yarn >/dev/null 2>&1 || npm install -g yarn
          yarn install ;;
    npm)  npm install ;;
  esac
else
  echo "ℹ️  No package.json found — skipping dependency install."
fi

# -----------------------------------------------------------------------------
# Install Claude Code CLI
# -----------------------------------------------------------------------------
echo "🤖 Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code

echo "🔗 Adding cc alias..."
grep -qxF "alias cc='claude --dangerously-skip-permissions'" ~/.bashrc || \
  echo "alias cc='claude --dangerously-skip-permissions'" >> ~/.bashrc

# -----------------------------------------------------------------------------
# Optional: Expo CLI if this looks like an Expo project
# -----------------------------------------------------------------------------
if [ -f "app.json" ] || [ -f "app.config.js" ] || [ -f "app.config.ts" ]; then
  echo "📱 Expo project detected — installing Expo CLI..."
  npm install -g expo-cli @expo/ngrok || true
fi

# -----------------------------------------------------------------------------
# Derive a codespace-friendly NEXT_PUBLIC_APP_URL into .env.local if present
# -----------------------------------------------------------------------------
if [ -n "${CODESPACE_NAME:-}" ]; then
  APP_URL="https://${CODESPACE_NAME}-3000.app.github.dev"
  echo "🌐 Setting NEXT_PUBLIC_APP_URL=$APP_URL in .env.local"
  touch .env.local
  if grep -q '^NEXT_PUBLIC_APP_URL=' .env.local 2>/dev/null; then
    grep -v '^NEXT_PUBLIC_APP_URL=' .env.local > .env.local.tmp && mv .env.local.tmp .env.local
  fi
  echo "NEXT_PUBLIC_APP_URL=$APP_URL" >> .env.local
fi

# -----------------------------------------------------------------------------
# Install the PM Launcher VS Code extension
# -----------------------------------------------------------------------------
echo "📦 Installing PM Launcher extension..."
VSIX_PATH="$WORKSPACE_DIR/.devcontainer/zen-startup.vsix"
if [ -f "$VSIX_PATH" ]; then
  if command -v code >/dev/null 2>&1 && code --install-extension "$VSIX_PATH" --force; then
    echo "✓ Extension installed via code CLI"
  else
    echo "⚠️ code --install-extension failed — falling back to direct copy"
    EXT_DIR="$HOME/.vscode-remote/extensions/local.zen-startup-0.0.5"
    mkdir -p "$EXT_DIR"
    cp -r "$WORKSPACE_DIR/.devcontainer/zen-startup/"* "$EXT_DIR/" 2>/dev/null || true
    echo "✓ Extension copied to $EXT_DIR"
  fi
else
  echo "⚠️ VSIX not found at $VSIX_PATH — PM Launcher UI polish will be skipped"
fi

echo ""
echo "✅ PM Codespace environment ready!"
