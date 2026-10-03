<p align="center">
  <img src="splash/public/brand/hope-ai-logotype.png" alt="hope.ai" width="360">
</p>

# hope-ai

An open toolkit for the **ChoiceCenter Personal Strategic Plan (PSP)**, the
100-day goal document a Leadership Legacy (LV) cohort works through together.
Give Claude this repo, and it helps you write goals you can keep, score each
week on what you did, and start again the next morning.

**Website:** https://lossless-group.github.io/hope-ai/

## Start here (Claude app on Mac or Windows)

**Fastest:** start a new chat in Claude and paste this:

```
I'm in a ChoiceCenter 100-day program and I'm writing my Personal Strategic Plan (PSP). Please read this toolkit first: https://github.com/lossless-group/hope-ai

Start with the skill at https://raw.githubusercontent.com/lossless-group/hope-ai/main/context-v/agent-skills/personal-strategic-plan/SKILL.md and follow it. Then interview me one goal at a time and help me write a plan I can score every week.
```

If Claude says it can't open the link, make sure web search is on for the chat.

**For every chat:** install the skill.

1. Download [`personal-strategic-plan.zip`](https://lossless-group.github.io/hope-ai/personal-strategic-plan.zip).
2. In Claude, **Settings → Capabilities**: turn on **Code execution and file creation**.
3. **Customize → Skills → + → Create skill → Upload a skill**, and choose the zip (don't unzip it).
4. Start a new chat: *"Let's work on my PSP."*

Steps per [Anthropic's help center](https://support.claude.com/en/articles/12512180-use-skills-in-claude).

## The philosophy

Outcomes (weight, income, a finished album) are **lagging indicators**: you
can want them, but you can't do them. Process goals (fasting days, Zone 2
minutes, calls made) are the **leading indicators** that drive them. The
toolkit scores the process every week, and scores the outcome at Day 30,
60, and 90 against paced milestones (the program form's own checkpoints).

- Bring an **outcome**, and Claude finds the process goals behind it and
  **paces** them with realistic rates, setting where you should be at Day
  30, 60, and 90.
- Bring a **process goal**, and Claude **projects** a reasonable outcome if
  you keep it, and splits it across the same checkpoints.
- Either way, habits are **layered, not stacked**: start small, add one at
  a time. Ambition goes in the outcome, not in Week 1.

Full method: [`references/goal-pacing.md`](references/goal-pacing.md).

## Tracking and dashboards

Progress lives in two plain files any assistant (or a text editor) can
update: `tracker.yaml`, the plan as numbers, and one log file per program
week. They roll up from days to weeks to the Day 30/60/90 checkpoints,
rendered as a detailed week view for you and a one-glance summary for your
coach and cohort. Log daily, weekly, or in catch-up batches: days not yet
logged never count as misses.

Guidelines: [`references/dashboard-guidelines.md`](references/dashboard-guidelines.md).
Live example: [mpstaton.com/psp/dashboard](https://mpstaton.com/psp/dashboard)
(and [a sample with data](https://mpstaton.com/psp/dashboard/sample)).

## Layout

```
hope-ai/
├── templates/
│   ├── psp-blank.md            the program form, blank
│   ├── tracker.yaml            the plan as numbers, for a dashboard
│   ├── log-week.yaml           one program week's log
│   └── goal-block-scored.md    the scored goal block (floors, targets, rules)
├── scripts/
│   ├── build-psp.sh            markdown → pasteable HTML + .docx
│   ├── build-psp.py            inline-styles pandoc HTML for Google Docs
│   └── package-skill.sh        builds the uploadable skill zip
├── references/
│   ├── goal-pacing.md          the philosophy: leading indicators paced to an outcome
│   ├── dashboard-guidelines.md tracking: tracker.yaml + weekly logs → week → Day 30/60/90
│   ├── template-anatomy.md     program sections vs. member extensions
│   ├── example-plan.md         one finished plan, identity details stripped
│   └── rendering/              Astro pattern for the plan page and the dashboard
├── context-v/
│   └── agent-skills/personal-strategic-plan/SKILL.md
├── splash/                     the GitHub Pages site (Astro)
└── changelog/
```

## Using it directly

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
