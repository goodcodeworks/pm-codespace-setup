# PM Codespace Setup

One-command installer to turn any GitHub repo into a **Claude-Code-in-Codespaces** workspace for non-technical product managers.

When a PM opens a codespace on a repo that has this setup installed, they land directly in a full-screen terminal running Claude Code, logged into a dedicated `pm/<user>-<slug>` branch, with no VS Code chrome to navigate.

---

## What it installs

| File | Purpose |
|---|---|
| `.devcontainer/devcontainer.json` | Node 20 devcontainer, settings to hide VS Code chrome, Claude Code terminal profile |
| `.devcontainer/setup.sh` | postCreateCommand: package-manager-aware install, Claude CLI, PM branch, `cc` alias, NEXT_PUBLIC_APP_URL, VS Code extension install |
| `.devcontainer/zen-startup.vsix` | Prebuilt VS Code extension that closes sidebars/editors and maximizes the terminal panel on startup |
| `.devcontainer/zen-startup/` | Extension source (for transparency / rebuild) |
| `CLAUDE.md` | Project-level rules Claude reads — PM workflow, safety rules, allowed scope |
| `README-PM.md` | Step-by-step PM-facing onboarding (auto-copied to `README.md` if none exists) |

---

## Install

From the **root of any git repo**:

```bash
curl -sL https://raw.githubusercontent.com/goodcodeworks/pm-codespace-setup/main/install.sh | bash
```

The installer:
1. Confirms you're in a git repo
2. Warns before overwriting existing files
3. Fetches the template files
4. Creates `README.md` from the PM template if none exists
5. Prints next steps (commit, push, secrets, open a codespace)

It does **not** commit or push for you — review the changes first.

---

## After install

1. **Commit the changes**
   ```bash
   git add .devcontainer CLAUDE.md README*.md
   git commit -m "Add PM Codespace setup"
   git push
   ```

2. **Set any required Codespaces secrets** (optional)
   If your app needs env vars (Supabase, Stripe, etc.):
   ```bash
   gh secret set MY_SECRET --app codespaces --repo OWNER/REPO
   ```

3. **Enable Codespaces access on the org** (orgs only, one-time)
   https://github.com/organizations/<ORG>/settings/codespaces → User permissions → Enable for members

4. **Open a Codespace**
   Code button → Codespaces → Create codespace on main → wait ~90s → land in full-screen Claude terminal

---

## What the PM experiences

1. Opens the codespace from GitHub
2. Sees a full-screen terminal (no file explorer, no Copilot Chat, no editor tabs)
3. Claude Code greets them and asks for Claude Max plan login
4. They tell Claude what they want changed in plain English
5. Claude makes edits on a pre-created `pm/<user>-<slug>` branch
6. When done, PM asks Claude to open a PR
7. PM closes the codespace; next visit picks up where they left off

---

## Portability notes

The template is designed to work on most Node/TypeScript monorepos:
- Auto-detects package manager (bun > pnpm > yarn > npm)
- Works for Next.js, Expo, or any Node app
- Forwards common ports (3000 for Next.js, 8081/19000/19006 for Expo)
- Uses `git rev-parse --show-toplevel` so no workspace paths are hardcoded

If your project uses Python / Go / Rust, swap the `image` field in `devcontainer.json` to the appropriate base image, and adjust `setup.sh` accordingly.

---

## Updating an existing install

Re-running the installer overwrites the template files (with a confirmation prompt). Your `CLAUDE.md` and `README.md` are flagged before being touched. Safe to re-run after upstream updates.

---

## License

Internal use within goodcodeworks. Ask before forking.
