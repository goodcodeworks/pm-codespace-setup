# Welcome, Product Manager 👋

This project lets you make changes to the app using **Claude Code** — no developer tools, no local setup. Everything runs in your browser.

---

## Step 1 — Open the Codespace

On GitHub, click the green **Code** button → **Codespaces** tab → **Create codespace on main**. Wait about 60 seconds for the environment to set up.

---

## Step 2 — Claude is already running

When the codespace finishes loading, you'll land in a full-screen terminal with Claude Code ready. No clicks needed.

If Claude isn't running, type `cc` and press Enter to launch it.

---

## Step 3 — Log in to Claude (first time only)

Claude will ask how you'd like to authenticate. Pick:

> **✅ Claude Max plan**

A browser tab will open for Claude sign-in. Use the same credentials you use on claude.ai. Close the sign-in tab when done.

---

## Step 4 — Tell Claude what you want

Type what you want in plain English. Examples:

- *"Change the homepage headline to 'Build Better Products'"*
- *"Make the signup button larger and change it to our brand blue (#1E40AF)"*
- *"Add a new FAQ item about pricing"*

---

## Step 5 — Preview the app

Ask Claude:

> *"Start the dev server"*

Claude runs the app and a new browser tab automatically opens with your live preview. Watch it update as Claude makes more changes.

---

## Step 6 — Save your work

When you're happy, tell Claude:

> *"Commit everything and open a PR"*

Claude creates a pull request for a developer to review and merge.

---

## Step 7 — Shut down when done

Back on GitHub, go to your Codespaces list → **⋯** menu → **Stop codespace**. This prevents idle billing.

---

## Keyboard shortcuts

| What | Shortcut |
|---|---|
| Restart Claude | Type `cc` and hit Enter |
| Show/hide file sidebar | `⌘B` (Mac) / `Ctrl+B` (Win) |
| Maximize/unmaximize terminal | `⌘⇧\`` (Mac) / `Ctrl+Shift+\`` (Win) |
| Command palette | `⌘⇧P` / `Ctrl+Shift+P` |

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Terminal is showing bash, not Claude | Type `cc` and press Enter |
| "Usage limit reached" | Wait an hour or upgrade your Max plan |
| Preview tab didn't open | Ask Claude *"What's the dev server URL?"* |
| Claude seems stuck | `Ctrl+C` to cancel, then `cc` to restart |
| Want to undo everything | Tell Claude: *"Undo all my changes"* |

---

## Pro tips

- **Be specific.** "Make the button bigger" works, but "increase the CTA button padding to 16px and font size to 18px" works better.
- **Point at things you can see.** *"The section that says 'Trusted by 1000+ teams' — change 1000+ to 5000+"*.
- **One change at a time.** Claude is more reliable with focused requests.
- **Ask questions.** *"What files control the navigation?"* — Claude will explore for you.

---

## Need more detail?

See [PM-ONBOARDING.md](./PM-ONBOARDING.md) for the full reference, including the GitHub Issues workflow for async requests.
