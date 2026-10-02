# hope-ai

Agent skill, templates, scripts, and reference patterns for the **ChoiceCenter
Personal Strategic Plan (PSP)**: the 100-day goal document a Leadership Legacy
(LV) cohort works through together.

Not an app. This repo is the toolkit an agent loads to help a member draft
their plan, turn each goal into something checkable week to week, run daily
check-ins and weekly retros against it, and export it back into the program's
shared Google Doc.

## Layout

```
hope-ai/
├── templates/
│   ├── psp-blank.md            the program form, blank
│   └── goal-block-scored.md    the scored goal block (floors, targets, rules)
├── scripts/
│   ├── build-psp.sh            markdown → pasteable HTML + .docx
│   └── build-psp.py            inline-styles pandoc HTML for Google Docs
├── references/
│   ├── template-anatomy.md     program sections vs. member extensions
│   ├── example-plan.md         one finished plan, identity details stripped
│   └── rendering/              Astro page + CSS for rendering a plan on a site
├── context-v/
│   └── agent-skills/personal-strategic-plan/SKILL.md
└── changelog/
```

## Using it

**Start a plan.** Copy `templates/psp-blank.md` somewhere private (not this
repo) and fill it in. To make a goal measurable, replace its block with
`templates/goal-block-scored.md`.

**Export for the shared Google Doc.** Needs `pandoc` and `python3`:

```bash
scripts/build-psp.sh ~/path/to/My_PSP.md
```

Open the `.html` in a browser, select all, and paste into the Google Doc. Docs
keeps inline styles and drops `<style>` blocks, which is why the script inlines
everything. The `.docx` is the fallback.

**Render it on a site.** `references/rendering/` is the page from
mpstaton-site (`/psp`): an LFM-rendered markdown file with a heading rail, and
a stylesheet that tells the plan's three table shapes apart with `:has()`.

## The skill

`context-v/agent-skills/personal-strategic-plan/` is picked up by the
monorepo's `sync-skills-symlinks.sh`, which links any
`context-v/agent-skills/<name>/` in the tree into `~/.claude/skills/`.

## Provenance

Pulled together on 2026-10-02 from Michael Staton's LV236 plan: the markdown
and build scripts in `astro-knots/context-v/extra/`, and the `/psp` page in
`astro-knots/sites/mpstaton-site`. No blank copy of the program's form
survived, so the blank template was reconstructed from the finished plan.
