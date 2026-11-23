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

Claude will ask how you'd like to sign in. Pick the **Claude account with subscription** option (not the Console / API one).

1. A browser tab opens for Claude sign-in. Use the same account you use on claude.ai. If no tab opens, press `c` in the terminal to copy the sign-in link and paste it into a new tab.
2. After you sign in, the page shows a **code**. Copy it, go back to the codespace tab, and paste it into the terminal where it says *Paste code here*.
3. When the terminal says **Login successful**, press Enter.

Your Claude account needs a paid plan (Pro, Max, or a Team/Enterprise seat) — the free plan doesn't include Claude Code. If you don't have one, ask your admin.

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
| "Usage limit reached" | Wait for the reset time Claude shows, or ask your admin about a bigger plan |
| Claude asks you to sign in again | Type `/login` and repeat Step 3 |
| Preview tab didn't open | Ask Claude *"What's the dev server URL?"* |
| Claude seems stuck | `Ctrl+C` to cancel, then `cc` to restart |
| Want to undo everything | Tell Claude: *"Undo all my changes"* |

---

## Pro tips

- **Be specific.** "Make the button bigger" works, but "increase the CTA button padding to 16px and font size to 18px" works better.
- **Point at things you can see.** *"The section that says 'Trusted by 1000+ teams' — change 1000+ to 5000+"*.
- **One change at a time.** Claude is more reliable with focused requests.
- **Ask questions.** *"What files control the navigation?"* — Claude will explore for you.
