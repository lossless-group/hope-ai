# Agent instructions for `hope-ai`

> `CLAUDE.md` is a symlink to this file. Edit `AGENTS.md`; never replace the
> symlink with a copy.

`hope-ai` is a child of `ai-labs` (itself a child of `lossless-monorepo`). It is
the toolkit for the **ChoiceCenter Personal Strategic Plan (PSP)**, the 100-day
goal document a Leadership Legacy (LV) cohort works through together.

**Not an app.** It is an agent skill plus the templates, scripts, and
reference patterns that skill points at. Don't scaffold a web app, package
manager, or build system here unless asked.

## Layout

| Path | Role |
|---|---|
| `context-v/agent-skills/personal-strategic-plan/SKILL.md` | the skill; linked into `~/.claude/skills/` by the anchor's `sync-skills-symlinks.sh` |
| `templates/` | `psp-blank.md` (the program form) and `goal-block-scored.md` (the scored extension) |
| `scripts/build-psp.sh` | plan markdown → Google-Docs-pasteable HTML + .docx (needs `pandoc`, `python3`) |
| `references/` | template anatomy, one finished example plan, the Astro rendering pattern |
| `changelog/` | ship log, per `changelog-conventions` |

## Rules

- **Program wording is fixed.** Box labels, goal headers, and the closing
  sections are ChoiceCenter's and get pasted into a shared Google Doc. See
  `references/template-anatomy.md` before restructuring a template.
- **This repo is public.** Never commit a member's filled-in plan, and never
  commit identity details (phone, email, address, handles). The one example
  plan is already published on mpstaton-site and has its identity table stripped.
- **After editing the skill, re-run the skills sync** so the link stays current:
  `bash /Users/mpstaton/code/lossless-monorepo/context-v/agent-skills/sync-skills-symlinks.sh`
- **Python: `uv`**, not plain `pip`, if a script ever grows dependencies.

## Branch tier model

`development` → `main` → `master`, as everywhere in the tree. The parent
`ai-labs` tracks this submodule on `main`.
