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

## Pick where your PSP lives (do this once)

Your plan, your tracking, and your weekly form answers live together in **one
folder**. Claude (or ChatGPT) will ask where it is the first time. How the
files get updated depends on how you use your assistant:

| How you use it | What happens | What you do |
|---|---|---|
| **An assistant that can open a folder** (Claude Code, Claude desktop with a folder connected, Codex) | It reads and updates your files itself. | Tell it the folder path once. |
| **A Project** (Claude Project or ChatGPT Project) | Files you upload stay with the project across chats, but the assistant can't change them in place. | At the end of each session, download the updated file it gives you and re-upload it to the project, replacing the old one. |
| **A single chat** (no project) | Everything lives in that one conversation. | **Stay in that same chat for all 100 days.** To start a new chat, download your latest files first and attach them to the new one. |

If you're not sure, use a Project: it's the easiest way to keep your plan
from getting lost between chats.

The folder looks like this:

```
my-psp/
├── plan.md                  your PSP, in the program's wording
├── tracker.yaml             the plan as numbers (base, stretch, milestones)
├── log/week-01.yaml         what you did, by date, one file per program week
├── weekly-form/week-01.md   that Sunday's form answers, as you submitted them
└── private/people.yaml      loved ones, enrolling conversations, your team list
```

Keep this folder private. If you publish your dashboard anywhere, leave
`private/` out: it holds other people's names.

## Every Sunday: the weekly form

ChoiceCenter's weekly PSP roadmap form is due **Sunday afternoon**. Tracking
during the week is what makes Sunday quick. On Sunday, say *"Let's do my weekly
form"* and your assistant will:

1. Catch up any days you haven't logged, asking about each one (never guessing).
2. Score the week against each goal's base and stretch, and log this
   week's reading for each outcome.
3. Draft every answer it can from your log: week number, your top 3 results,
   on/off track, this week's declarations, which daily practices you kept,
   books finished, loved ones enrolled to date.
4. Ask you for what only you know: breakthroughs, by-when times, the people
   you'll talk with, and whether a practice was done "in excellence."
5. Save your final answers and next week's declarations, so next Sunday's
   "Top 3 results" can be drafted from them.

You paste the answers into the form yourself; nothing is submitted for you.
During the week, ask *"Where am I this week?"* any time to see what's left
before Sunday.

## The philosophy

Outcomes (weight, income, a finished album) are **lagging indicators**: you
can want them, but you can't do them. Process goals (fasting days, Zone 2
minutes, calls made) are the **leading indicators** that drive them. The
toolkit scores the process every week, reads the outcome weekly as a
trend, and scores it only at Day 30, 60, and 90 against paced milestones
(the program form's own checkpoints).

- Bring an **outcome**, and Claude finds the process goals behind it and
  **paces** them with realistic rates, setting where you should be at Day
  30, 60, and 90.
- Bring a **process goal**, and Claude **projects** a reasonable outcome if
  you keep it, and splits it across the same checkpoints.
- Either way, habits are **layered, not stacked**: start small, add one at
  a time. Ambition goes in the outcome, not in Week 1.

Full method: [`references/goal-pacing.md`](references/goal-pacing.md).

## Tracking and dashboards

Progress lives in plain files in your PSP folder that any assistant (or a
text editor) can update: `tracker.yaml`, the plan as numbers, and one log
file per program week. They roll up from days to weeks to the Day 30/60/90 checkpoints,
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
│   └── goal-block-scored.md    the scored goal block (base, stretch, rules)
├── scripts/
│   ├── build-psp.sh            markdown → pasteable HTML + .docx
│   ├── build-psp.py            inline-styles pandoc HTML for Google Docs
│   └── package-skill.sh        builds the uploadable skill zip
├── references/
│   ├── goal-pacing.md          the philosophy: leading indicators paced to an outcome
│   ├── dashboard-guidelines.md tracking: tracker.yaml + weekly logs → week → Day 30/60/90
│   ├── Weekly-Cadence.md       the Sunday-to-Saturday clock and the Sunday session
│   ├── Weekly-Form.md          every question on the weekly form, and where its answer comes from
│   ├── PSP-Folder-and-Modes.md one folder per member; folder, Project, or single chat
│   ├── Outcome-Progress.md     how far each outcome has come and where it's heading
│   ├── template-anatomy.md     program sections vs. member extensions
│   ├── example-plan.md         one finished plan, identity details stripped
│   └── rendering/              Astro pattern for the plan page and the dashboard
├── context-v/
│   ├── agent-skills/personal-strategic-plan/SKILL.md
│   └── specs/                  what's being designed next (dashboard, weekly form)
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
