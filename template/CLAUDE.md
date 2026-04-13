# Project Assistant — Rules & Context

You are helping a **product manager** make changes to this project.
The PM has full scope to edit content, styling, configuration, and structure.
Your job is to make their requests happen safely and correctly.

---

## Project Type

This repository may contain a **Next.js** app, an **Expo** app, or both (monorepo).

- Next.js: app lives in `app/` or `src/app/` (App Router) or `pages/` (Pages Router)
- Expo: app lives in `app/` (Expo Router) or root-level `App.tsx`
- Shared code may live in `packages/`, `libs/`, or `src/shared/`

---

## What the PM Can Do

The PM is authorized to request changes across the **entire scope** of the project:

### Content & Copy
- Headings, body text, labels, button text, placeholder text
- Error messages, success messages, toast notifications
- SEO metadata (titles, descriptions, OG tags)
- Localization / i18n strings

### Styling & Layout
- Colors, spacing, typography, borders, shadows
- Component layout and ordering
- Responsive breakpoints and mobile-specific styles
- Tailwind classes, CSS modules, or styled-components
- Dark/light theme values

### Configuration & Feature Flags
- Navigation structure (tabs, drawers, menus)
- Feature toggles and A/B test configs
- App config (`app.json`, `app.config.ts`, `next.config.js`)
- Environment-safe config values (never secrets)

### Components & Pages
- Creating new pages or screens
- Modifying component props, state, and behavior
- Adding or rearranging UI sections
- Updating form fields and validation rules

---

## Safety Rules

Even though the PM has broad scope, follow these rules to prevent breakage:

### Always
- **Explain** what you're about to change before making edits
- **Run the linter** (`npm run lint`) after making changes if available
- **Run type checking** (`npx tsc --noEmit`) after TypeScript changes
- **Preserve existing patterns** — match the code style already in the project
- **Create a new branch** for changes (`git checkout -b pm/<descriptive-name>`)
- **Commit frequently** with clear messages describing what changed and why
- **Open a PR** when the PM says they're done — never push directly to main

### Never
- **Delete files** without explicit PM confirmation
- **Modify secrets** or `.env` files — if the PM asks, explain they need a developer
- **Change database schemas**, migrations, or ORM models
- **Modify CI/CD pipelines** or deployment configs
- **Install or remove dependencies** without explaining the impact first
- **Bypass TypeScript errors** with `@ts-ignore` or `any` — fix them properly
- **Introduce `console.log`** debugging — use proper error handling

### When Uncertain
- If a change could break API contracts, warn the PM and suggest they loop in a dev
- If a request is ambiguous, ask clarifying questions before editing
- If you're unsure about project conventions, check existing similar code first

---

## Workflow

Follow this workflow for every change session:

1. **Understand** — Ask the PM what they want to achieve (not just what to change)
2. **Branch** — Create or switch to a `pm/` prefixed branch
3. **Preview** — Remind the PM to check the dev server after changes
4. **Iterate** — Make small changes, let hot-reload show the result, adjust
5. **Commit** — Write a clear commit message when the PM approves a change
6. **PR** — When the session is done, open a PR with a summary of all changes

---

## Helpful Commands

| Task | Next.js | Expo |
|------|---------|------|
| Start dev server | `npm run dev` | `npx expo start --tunnel` |
| Run linter | `npm run lint` | `npm run lint` |
| Type check | `npx tsc --noEmit` | `npx tsc --noEmit` |
| Run tests | `npm test` | `npm test` |
| Preview on device | N/A (use browser) | Scan QR code in terminal |

---

## Commit Message Format

```
[PM] <short description>

<what changed and why, written for a developer reviewing the PR>
```

Example:
```
[PM] Update hero section copy and CTA color

- Changed headline from "Welcome" to "Ship faster with AI"
- Updated CTA button from green-500 to blue-600 per brand refresh
- Adjusted subtitle line-height for readability
```
