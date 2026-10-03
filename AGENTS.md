# Agent instructions for `hope-ai`

> `CLAUDE.md` is a symlink to this file. Edit `AGENTS.md`; never replace the
> symlink with a copy.

`hope-ai` is a child of `ai-labs` (itself a child of `lossless-monorepo`). It is
the toolkit for the **ChoiceCenter Personal Strategic Plan (PSP)**, the 100-day
goal document a Leadership Legacy (LV) cohort works through together.

**Not an app.** It is an agent skill plus the templates, scripts, and
reference patterns that skill points at, and a `splash/` page whose job is to
get cohort members (mostly Claude desktop users, not developers) to hand
Claude the repo link or install the skill zip. Don't scaffold an app here
unless asked.

## Layout

| Path | Role |
|---|---|
| `context-v/agent-skills/personal-strategic-plan/SKILL.md` | the skill; linked into `~/.claude/skills/` by the anchor's `sync-skills-symlinks.sh` |
| `templates/` | `psp-blank.md` (the program form) and `goal-block-scored.md` (the scored extension) |
| `scripts/build-psp.sh` | plan markdown → Google-Docs-pasteable HTML + .docx (needs `pandoc`, `python3`) |
| `references/` | goal pacing (the philosophy), dashboard guidelines, template anatomy, one finished example plan, the Astro rendering patterns |
| `scripts/package-skill.sh` | builds `personal-strategic-plan.zip` for Claude's Customize → Skills upload; the splash build runs it |
| `splash/` | GitHub Pages site (Astro), deployed on push to `main`; see `splash/README.md` and `splash/DESIGN.md` |
| `changelog/` | ship log, per `changelog-conventions` |

## Rules

- **Program wording is fixed.** Box labels, goal headers, and the closing
  sections are ChoiceCenter's and get pasted into a shared Google Doc. See
  `references/template-anatomy.md` before restructuring a template.
- **The scoring philosophy is the product.** Process goals (leading
  indicators) are scored weekly; outcomes (lagging) are paced to Day 30/60/90
  milestones and scored only there;
  habits are layered, never stacked. `references/goal-pacing.md` is the
  source of truth; the skill, templates, README, and splash copy restate it
  and must not drift from it.
- **Agent-agnostic.** Cohort members use Claude, other assistants, or none.
  Data formats and instructions must work for any agent or a person editing
  files by hand; never assume a daily check-in or a specific assistant.
- **The dashboard reference is copied from mpstaton-site.** When changing
  the rollup rules, change `references/dashboard-guidelines.md` and
  `references/rendering/dashboard/tracker.ts` together, and port the change
  back to the site (or note that it's pending).
- **This repo is public.** Never commit a member's filled-in plan, and never
  commit identity details (phone, email, address, handles). The one example
  plan is already published on mpstaton-site and has its identity table stripped.
- **The skill has to work inside the Claude app.** Its readers are usually
  non-technical cohort members. Paths in `SKILL.md` must resolve both from the
  repo root and from the zip's skill folder (`package-skill.sh` mirrors the
  layout), with raw GitHub URLs as the fallback.
- **After editing the skill, re-run the skills sync** so the link stays current:
  `bash /Users/mpstaton/code/lossless-monorepo/context-v/agent-skills/sync-skills-symlinks.sh`
- **Python: `uv`**, not plain `pip`, if a script ever grows dependencies.

## Branch tier model

`development` → `main` → `master`, as everywhere in the tree. The parent
`ai-labs` tracks this submodule on `main`.
