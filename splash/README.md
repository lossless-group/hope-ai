# hope-ai splash

The GitHub Pages face of `hope-ai`: https://lossless-group.github.io/hope-ai/

Built for ChoiceCenter cohort members using the Claude desktop app. The
primary action is copying a message (with the repo link) into Claude; the
secondary is downloading the skill zip and installing it in Claude.

## Local dev

```bash
pnpm install    # splash/ is its own pnpm workspace (pnpm-workspace.yaml)
pnpm dev        # http://localhost:4321/hope-ai/
pnpm build      # astro build + packages dist/personal-strategic-plan.zip
pnpm preview    # exercise search and the zip download locally
```

`pnpm build` runs `../scripts/package-skill.sh dist` after Astro, so the
skill zip linked from the page is always built from the current skill,
templates, and references.

pnpm 12 refuses to run dependency build scripts until they're approved.
Approvals live in `pnpm-workspace.yaml` (`allowBuilds:`); add one with
`pnpm approve-builds <pkg>`. Don't install with `--ignore-workspace`: it
skips those approvals and the install fails.

## Deploy

`.github/workflows/pages.yml` at the repo root builds `splash/` and deploys
to GitHub Pages on every push to `main`.

**Vercel** (optional second host): import `lossless-group/hope-ai` and set
**Root Directory** to `splash`. `vercel.json` supplies the install, build,
and output settings. Leave "Include files outside the root directory" on
(the default): the build packages the skill zip from `../templates`,
`../references`, and `../scripts`.

`astro.config.mjs` serves from `/` when `VERCEL=1` (set by Vercel) and from
`/hope-ai/` on Pages. Set `SITE_URL` in Vercel once a custom domain is
attached, so canonical and OG URLs use it.

## Where content lives

| Surface | Source |
|---|---|
| Landing page | `src/pages/index.astro` |
| Copy, SEO, repo URL | `src/lib/seo.ts` |
| `/changelog/` | `../changelog/` |
| `/context-v/` | `../context-v/` |
| Skill zip | `../context-v/agent-skills/personal-strategic-plan/` + `../templates`, `../references`, `../scripts` |
| Brand marks | `public/brand/`, `public/favicon.svg` |
| Design contract | `DESIGN.md` (runtime truth: `src/styles/theme.css`) |

## Brand assets

- `public/brand/hope-ai-mark.svg`: the mark (also the favicon)
- `public/brand/hope-ai-app-icon.svg` → `-128.png`, `-512.png`; `public/app-icon-180.png` (Apple touch)
- `public/brand/hope-ai-logotype.svg` / `.png`
- `public/ogimage__Hope-Ai--Banner.jpg`: 1200×630 share image

PNGs are rendered from the SVGs with headless Chrome, so the web fonts in
the logotype and share image render correctly.
