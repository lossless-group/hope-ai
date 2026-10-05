---
site_uuid: b6cd7df3-23ad-4df9-88b3-29f4a8dc91de
hex_code: n2521c
title: "Progress Dashboard for Flexible PSP Dataviz"
lede: "A PSP dashboard you download, not deploy: hand Claude or ChatGPT your plan and a week of notes, get back a chart and your weekly form."
summary: "Spec for the hope-ai progress dashboard and weekly-questionnaire helper. Delivered as a downloadable bundle (skill + instructions + data templates) that an assistant renders on demand, not a hosted app. Builds on references/dashboard-guidelines.md and the tracker.yaml / log/week-NN.yaml data shape; may fork the questionnaire into its own spec."
publish: false
date_created: 2026-10-04
date_modified: 2026-10-04
date_authored_initial_draft: 2026-10-04
date_authored_current_draft: 2026-10-04
date_authored_final_draft:
authors:
  - Michael Staton
augmented_with:
  - Claude Code on Claude Opus 5.5
at_semantic_version: 0.0.0.3
tags:
  - Spec
  - Personal-Strategic-Plan
  - Dashboard
  - Data-Visualization
  - Weekly-Questionnaire
status: In-Discussion
---

# Progress Dashboard for Flexible PSP Dataviz

## Why Care?

A 100-day plan only works if you can see it working. The people in a
ChoiceCenter Leadership Legacy cohort each have four or so goals that look
nothing alike: one is pacing weight loss, another is counting sales calls,
another is writing minutes. And every week the program asks each of them to
fill out the same form: top three results, breakthroughs, who they enrolled.

Nobody in the cohort wants to install, host, or troubleshoot an app. Most of
them already talk to Claude (some to ChatGPT). So the dashboard ships as a
**download plus instructions**: the person gives their assistant the bundle,
their plan, and whatever they did this week, and the assistant draws the
dashboard and drafts the weekly form answers. No server, no accounts, no
live support.

## Summary

Two jobs, one data source:

1. **Progress dashboard.** Render a person's PSP progress (detailed week for
   them, summary for coach and buddy) from `tracker.yaml` + `log/week-NN.yaml`,
   flexible enough that very different goals all chart sensibly.
2. **Weekly questionnaire helper.** Draft the program's weekly form answers
   from the same log, so filling it out is review-and-paste, not a blank page.

Whether (2) becomes its own spec is an open question; see *Open questions*.

## What already exists (don't rebuild)

- `references/dashboard-guidelines.md`: the three-level rollup (day → week →
  Day 30/60/90 checkpoint), the status rules (unlogged ≠ missed, floors are
  wins, ceilings, ramps and deloads), and the two-file data shape.
- `templates/tracker.yaml`, `templates/log-week.yaml`: the data templates.
- `references/rendering/dashboard/`: the Astro reference implementation
  (copied from mpstaton-site), with `tracker.ts` holding the rollup logic and
  fictional example data.
- The `personal-strategic-plan` skill's *Logging*, *Build a dashboard*, and
  *Weekly review* sections, which already tell an assistant how to log and
  render.

So this spec is mostly about **delivery and flexibility**, not the rollup
model, which is settled.

## Goals

- A cohort member with Claude desktop (or ChatGPT) and no dev tooling can get
  a working dashboard in one conversation.
- The dashboard handles heterogeneous goals: checks, counts, minutes, money,
  ceilings, ramps, track-only outcomes, without per-person code.
- The summary view stands alone for a coach or buddy who has never seen the
  plan.
- Weekly form answers are drafted from logged data, in the program's wording,
  ready to paste into the form.
- Works for a person editing YAML by hand, with any assistant or none.

## Non-goals

- A hosted, multi-user app, login, or database.
- Submitting the Google Form on the person's behalf.
- Replacing the Google Form. It stays; the job is making it fast to fill in
  on Sunday afternoon (draft, review, paste).
- Storing anyone's data in this repo (public; see *Privacy*).
- Changing the scoring philosophy in `references/goal-pacing.md`.

## Constraints & Assumptions

- **Assistant-rendered.** The primary renderer is an assistant-generated
  artifact (Claude artifact / ChatGPT canvas): one self-contained HTML file.
  // TBD: ship a prebuilt `dashboard.html` that reads pasted YAML/JSON, vs.
  instruct the assistant to generate the page each time. Prebuilt is
  consistent; generated is flexible. Leaning: prebuilt template the assistant
  fills, with freedom to add a chart for an odd goal.
- **Data stays with the person.** Their files live in their Claude project,
  their Drive, or their desktop; the assistant reads them each session.
- **Packaging** reuses `scripts/package-skill.sh` and the splash download.
- **Program wording is fixed** for anything pasted back into ChoiceCenter
  surfaces (form questions, Google Doc headers).

## Design

### Weekly rhythm: the Sunday deadline drives everything

The questionnaire is due **every Sunday afternoon**. That's the one fixed beat
in the program, so tracking exists to make Sunday easy and to keep the week
on track before Sunday arrives:

- **During the week:** log whenever (daily, in batches, Friday catch-up).
  Mid-week, the assistant can say where each goal stands against this week's
  floor and target and what's left to hit before Sunday.
- **Sunday:** catch up any unlogged days (asked one by one, never assumed),
  score the week, draft every draftable form answer, ask the person for the
  rest (breakthroughs, by-when times, people, "in excellence"), and save the
  final answers plus next week's declarations into the working folder.
- **The loop:** Sunday's declarations become next Sunday's "Top 3 results"
  and on-track baseline.

**The cohort's clock is Sunday to Sunday** (confirmed by a member,
2026-10-04): Sunday's session closes the week just ended and opens the next,
and Sunday itself belongs to the new week. `tracker.yaml` gets
`week_starts: sunday`; Week 1 is the part-week from Day 1 to the first
Saturday (Mon–Sat for a Monday start), with base and stretch prorated.
// TBD: the form's Week # picker runs 1–12; confirm it counts the same way.

### The PSP working folder

Every member gets **one folder** that holds their whole PSP. The bundle asks
for (or helps them pick) its location on first run; everything after that
reads and writes there. Proposed layout, mirroring what already works in
mpstaton-site:

```
<psp-folder>/
  plan.md                    # the PSP itself (program wording)
  tracker.yaml               # the plan as numbers (+ the program block)
  log/week-NN.yaml           # what happened, by date
  weekly-form/week-NN.md     # that Sunday's answers, as submitted
  private/people.yaml        # loved ones, enrolling conversations, team list
```

- `private/` exists so a member who publishes their dashboard (as mpstaton-site
  does) can keep other people's names out of it with one gitignore line.
- // TBD: whether `weekly-form/` and the declarations live in the week log or
  in their own file.

### Where the person works: three modes

The folder is the same in every mode; what changes is who moves the files.

1. **Folder mode (assistant can read and write files).** Claude Code, Claude
   desktop with folder access, Codex, etc. The person names a path once; the
   assistant reads and updates the files directly. Best experience.
2. **Project mode (Claude Project / ChatGPT Project).** Files uploaded to the
   project persist across chats, but the assistant can't edit them in place.
   At the end of each session it hands back the changed files (usually just
   this week's log) to download and re-upload, replacing the old copy.
3. **Single-chat mode (plain chat, no project).** Everything lives in one
   conversation. **Stay in that chat all 100 days**, or, to start a fresh
   chat, download the latest files and attach them to the new one. The
   assistant should say this plainly on first run and remind at the end of
   each Sunday session.

The skill should detect which mode it's in (can it write a file?) and say
which one, rather than making the person know the terms. // TBD: verify
current Claude / ChatGPT capabilities per mode before writing user-facing
copy; they change often.

### Reference implementation: mpstaton-site

The first real dashboard is designed in
`astro-knots/sites/mpstaton-site` (public repo, `development` branch):

- Plan: `src/content/psp/personal-strategic-plan.md`
- Data: `src/content/psp/tracking/mpstaton/tracker.yaml` + `log/week-NN.yaml`
  (Day 1 = 2026-09-28, a Monday; Week 1 logged Mon–Fri so far)
- Fictional sample: `src/content/psp/tracking/sample/`
- Rendering: `src/lib/psp/{tracker,load}.ts`, `src/components/psp/*`,
  `src/pages/psp/dashboard/**`; already copied into this repo as
  `references/rendering/dashboard/`

Here the working folder is `src/content/psp/` (plan) plus
`src/content/psp/tracking/mpstaton/` (data), split across two levels;
// TBD whether the site adopts the folder layout above or the bundle allows a
split layout.

Things this instance already surfaces:

- **The program's goal structure is 3 + 1 + 1** (confirmed by a member
  2026-10-04): three flexible Personal goals, a fourth that must be Creative,
  and a fifth that is always a Relationships goal. Page 2 of the form carries
  goals 1–4; the Relationships goal is what page 3 (enrolling conversations)
  and page 1 (loved ones enrolled) are about. The program deliberately
  intermingles it with its word-of-mouth enrollment asks. So the mapping is a
  rule, not a per-member setting: `kind: Relationships` (goal 5) feeds pages 1
  and 3; `kind: Personal` and `kind: Creative` feed page 2.
- **The repo is public**, and the site renders from committed files. Page 3–4
  data (other people's names) must not land here: `private/` is gitignored,
  or that data lives outside the repo.
- Program habits (journaling, meditation, gratitude walk, books, buddy, team
  conversation) aren't in this tracker yet; the `program:` block would be
  added here first.

### Delivery bundle

// TBD. Candidate contents of the zip:

- the `personal-strategic-plan` skill (already packaged)
- a dashboard template (single HTML file) + its instructions
- a weekly-questionnaire template + instructions
- blank `tracker.yaml` and `log-week.yaml`
- a short "start here" for non-technical members (Claude Project setup,
  ChatGPT custom GPT / project setup)

### Flexible dataviz

// TBD with Michael. Starting point: the mark per measure type.

| Measure | Weekly cell | Over time |
|---|---|---|
| `check` (daily) | 7-day dot row, hatched if unlogged | days hit vs floor/target band |
| `count` / `minutes` / `amount` | bar vs floor & target | cumulative line vs paced plan |
| ceiling (`direction: down`) | bar vs limit | weeks under limit |
| outcome reading | not on weekly grid | sparkline vs Day 30/60/90 milestone bands |
| `track_only` | not scored | sparkline only |

#### Goals are process; outcomes are read weekly, scored at checkpoints

From a member's review of Week 1 (2026-10-04):

- **A goal is its process habits:** dailies, weeklies, and monthlies. Two
  shapes recur: **frequency checks** (did it happen, how many times:
  `measure: check`, or `count` of occurrences) and **quantities** (minutes,
  dollars, reps). `tracker.yaml` has `daily | weekly | biweekly` today;
  **add `cadence: monthly`** (e.g. an expense review, a monthly billing check).
  // TBD: how a monthly habit shows on the weekly grid (a marker in the week
  it's due, blank otherwise).
- **Outcomes get a reading every week**, filled in as part of the Sunday form
  session, so the dashboard shows progress toward each quantitative outcome
  as it happens rather than three dots at Day 30/60/90.
- **Proposed reconciliation with `goal-pacing.md`:** weekly readings render
  as a **trend line against the paced milestone band, with no status color**;
  the on-track/behind verdict on an outcome still happens only at Day 30, 60,
  and 90. That keeps "score the process weekly" intact while making the
  outcome visible. // TBD: confirm; if adopted, update `goal-pacing.md`,
  `dashboard-guidelines.md`, `tracker.ts`, and the site together.
- Outcomes still never appear as cells on the weekly *process* grid.
- **Reasons (built 2026-10-04).** A week log can carry `reasons:` keyed by
  habit or goal id: the person's context for a result ("contacts not
  imported yet"). The week view shows an ⓘ popover beside the status; the
  summary grid marks the cell with a dot and puts the text in its tooltip.
  The status itself never changes. A member asked for this so a miss can
  carry its why without being softened.
- **When the outcome is already met, the process still matters if it feeds
  a different outcome.** A member's take-home outcome was nearly met in
  Week 1 by consulting, but the same goal's outreach habits (solicitations,
  activations, asks) drive the fundraising outcomes. Pacing should tie each
  habit to the outcome it moves (// TBD: an optional `drives:` list on a
  habit), so "outcome met" on one doesn't read as license to drop the rest.
- **Outcomes panel (built 2026-10-04).** The week view opens with every
  outcome as a stat tile, grouped by goal: latest reading, a meter from the
  starting point to the far milestone ("77% of the way"), and, for outcomes
  that drift or accumulate, a linear projection to the goal's day with its
  variance ("at this rate: 186 lb by Day 90, 4 lb past the goal"). Levels
  like a monthly income run-rate set `projection: none` and show where they
  stand against the goal's range instead. Outcomes with no goal and no reading
  collapse into one "also tracked" line. The status chip names the direction
  in words; the meter stays neutral ink. // TBD: a linear projection from the
  first week or two overreacts (early weight loss is mostly water); consider
  a rolling window once there are 4+ readings.
- **Blocked habits.** Some habits can't start until something outside the
  person's control happens (a member's language practice waits on a payment
  to buy the app). Logged honestly, that's weeks of "below floor" with no
  information in it. Proposal: an optional `blocked: { reason, since }` on a
  habit, rendered as its own state (labelled, not red) and stated as such in
  the form's on-track answer. Unblocking is a weekly-review edit. It must not
  become a way to hide misses: the reason is shown, and the person decides.
  // TBD

### Weekly questionnaire (ChoiceCenter weekly PSP roadmap form)

The form is a multi-page Google Form, one submission per week, shared with the
member's accountability buddy. Page 1 (scraped 2026-10-04, confirmed
against a member's pasted copy the same day):

| # | Question (program wording) | Type | Required | Draftable from data? |
|---|---|---|---|---|
| 1 | Email | email | yes | no (identity; never stored here) |
| 2 | Name | text | yes | no (identity) |
| 3 | Your buddy's e-mail address (your PSP roadmap will be shared with them) | text | yes | no (identity) |
| 4 | Week # | choice 1–12 | yes | yes, from `day_one` |
| 5 | Celebrate your top 3 results from last week: #1 | text | yes | yes, from log + floors/targets hit |
| 6 | … #2 | text | yes | yes |
| 7 | … #3 | text | yes | yes |
| 8 | My breakthrough learnings last week | text | yes | partly; needs the person's reflection |
| 9 | Did you enroll a loved one last week? | YES / NO | yes | yes, if enrollments are logged |
| 10 | If YES, celebrate who they are to you and what you see possible for them | text | no | no, person writes; assistant can prompt |
| 11 | Total loved ones enrolled to date | number | yes | yes, cumulative |

Page 2, "PSP Goals" (pasted by a member 2026-10-04). Four sections, one per
goal; Goals #2, #3 and Creative repeat the Goal #1 block minus the on-track
question:

| # | Section | Question (program wording) | Type | Required | Draftable from data? |
|---|---|---|---|---|---|
| 12 | PSP Goal #1 | PSP 100-Day Goal #1 | text | yes | yes, goal title from `tracker.yaml` (same every week) |
| 13 | | Am I currently on track or off track for my 100 days? | Yes - On Track / No - Off Track | yes | yes, from pace vs. plan (asked once, on Goal #1 only) |
| 14 | | My declaration for this week (specific actions I am taking) | text | yes | yes, from this week's floor/target in the ramp |
| 15 | | By When (Day and Time) | text | yes | partly; person picks the deadline |
| 16 | | Is your weekly declaration 10-15% of your overall goal? | Yes / No | yes | yes, computable (see below) |
| 17–20 | PSP Goal #2 | Goal / Declaration for this Week / By When / 10-15%? | same | yes | same |
| 21–24 | PSP Goal #3 | same | same | yes | same |
| 25–28 | Creative Genius Goal | PSP 100-Day Creative Goal / Declaration / By When / 10-15%? | same | goal text **not** marked required; rest yes | same |

Observations from page 2:

- **The form's goal slots are fixed: three Personal + one Creative.** That
  matches `kind: Personal | Creative` in `tracker.yaml`. Members with more or
  fewer goals have to map to these four slots. // TBD: what if someone has 5?
- **On-track is asked once, for the whole plan,** even though it sits under
  Goal #1. The helper should answer it from all goals' process pace, not
  Goal #1 alone. // TBD: confirm with the coach's intent.
- **The weekly declaration is the week's process commitment.** It maps to the
  per-week floor/target in the ramp, phrased as specific actions. That's new
  data per week: the declaration text and its by-when deadline. Neither is in
  `log/week-NN.yaml` today.
- **The 10–15% rule is a pacing check, and it disagrees with our pacing
  model.** A straight-line 100-day plan is ~7% per week (1/14). 10–15% per
  week implies the goal finishes in 7–10 weeks, or that declarations are
  front-loaded. Our ramps start low and deload in weeks 8 and 12, so early
  weeks will often read "No" honestly. // TBD: how does the program mean
  "% of overall goal" for process goals (habits) vs. outcomes? Options:
  compute it from the week's target ÷ the plan's 100-day process total and
  show the number, or treat it as the coach's sanity check and let the
  person answer. Don't fudge it to "Yes".
- **This closes a loop.** Last week's declarations are what next week's "Top 3
  results" and on-track answer are judged against. The helper should store
  each declaration so next week's page 1 can be drafted from it.

Early observations:

- The form's week picker runs 1–12; the plan runs 100 days (≈14–15 program
  weeks). // TBD: how does the program number weeks?
- "Loved ones enrolled" is a program-level metric not in `tracker.yaml` today.
  Probably a standing, program-defined goal/counter every member's tracker
  gets. // TBD
- The answers want *celebration*, not scores: the helper should turn floor and
  target hits into human sentences, never "Below floor".

Page 3, "My Relationship / Enrolling Conversations This Week" (pasted by a
member 2026-10-04):

| # | Question (program wording) | Type | Required | Draftable from data? |
|---|---|---|---|---|
| 29 | 1. Name and Relationship to Me | text | yes | carry-forward only, from the person's private list |
| 30 | 1a. Activity and By When? | text | yes | partly; person picks |
| 31–32 | 2. / 2a. (same) | text | yes | same |
| 33–34 | 3. / 3a. (same) | text | yes | same |
| 35–36 | 4. / 4a. (same) | text | no | same |
| 37–38 | 5. / 5a. (same) | text | no | same |

Observations from page 3:

- **Three enrolling conversations a week are required, up to five.** With
  page 1's enrolled yes/no and running total, word-of-mouth enrollment is a
  standing program requirement, not one of the member's goals. Members find
  it the most tedious part of the form.
- **Keep the burden low.** The helper's job here is to cut retyping: keep a
  private, person-owned list of people and where each conversation stands,
  carry unfinished ones forward, and offer last week's list as this week's
  draft. It is not to push members to enroll more.
- **This is the most private data in the form:** real people's names and
  relationships. Never in the repo, never in examples (fictional only), never
  on the coach/buddy summary unless the person adds them.
- Not dashboard material beyond a count (conversations held, enrollments to
  date), and even that is opt-in. // TBD

Page 4, program practices (pasted by a member 2026-10-04, plus a screenshot
of the book dropdown). The page footer says a copy of responses is emailed
to the submitter, so this appears to be the last page:

| # | Question (program wording) | Type | Required | Draftable from data? |
|---|---|---|---|---|
| 39 | Which Daily Practices did you complete in excellence last week? | checkboxes: Daily Journaling / Daily Meditation / Gratitude Walk (40 minutes total for the week) | yes | yes, if logged as program habits |
| 40 | Did you complete a Book this week? | Yes / No | yes | yes, if logged |
| 41 | If yes, which Book did you complete? | dropdown (list below) | no | yes; must match the option text exactly |
| 42 | Buddy Accountability: Did you support your Buddy to be on Track last week? | Yes / No | yes | yes, if logged |
| 43 | Who will you make a difference with on your team this week, deepening your team relationship one conversation at a time? | choice of team members' names (cohort-specific) | no | carry-forward / rotate; names never stored in repo |

Book dropdown options, verbatim as the form shows them (2026-10-04):

1. The Power of Vulnerability by Brené Brown
2. The Power of Intention by Wayne Dyer
3. Dare to Lead by Brené Brown
4. The 4 Agreements by Don Miguel Ruiz
5. The Soul of Money by Lynne Twist
6. The Mastery of Love by Don Miguel Ruiz
7. The Last Word on Power by Tracy Goss
8. Finding Your Own North Star by Martha Beck
9. The Last Lecture Jeffrey Zaslow and Randy Pausch
10. The Outliers by Brené Brown
11. Daring Greatly by Brené Brown
12. Rising Strong by Brené Brown
13. Die With Zero by Bill Perkins

(Option 10 credits *Outliers* to Brené Brown; it's Malcolm Gladwell's. Keep
the form's text verbatim when drafting the answer, since the answer has to
match the dropdown. Possibly worth mentioning to the coach.)

Observations from page 4:

- **The program has its own standing habits, the same for every member:**
  daily journaling, daily meditation, a 40-minute-a-week gratitude walk,
  books from a fixed reading list, supporting your buddy, a team-relationship
  conversation, and the enrolling conversations from page 3. None of these
  are the member's own goals, and none are in `tracker.yaml` today.
- **This is the strongest dashboard case in the form.** These are
  ordinary process habits that fit the existing model: journaling and
  meditation are `cadence: daily, measure: check`; the walk is
  `cadence: weekly, measure: minutes, target: 40`; buddy support and the team
  conversation are weekly checks; books are a count against a reading list.
  Proposal: a program-defined `program:` block (or "Goal 0") that ships
  pre-filled in `templates/tracker.yaml`, rendered as its own row group,
  separate from the member's four goals. // TBD
- **"In excellence" is the member's call.** The helper offers the boxes that
  the log supports and lets the person decide; it never ticks one on a
  partial week without asking.
- **The team-member list is cohort data.** Names aren't ours to publish; the
  template carries a placeholder and the person fills their own list.

### Privacy

- Identity fields (email, name, buddy email) are never written to repo files,
  templates, or examples. The helper leaves them for the person to fill.
- Loved-one names are personal; same rule. Example data uses fictional names.

## Open questions

- [ ] One spec or two? Leaning: keep together until the form's remaining pages
      are captured, then fork the questionnaire into its own spec if it grows
      its own data (enrollments, reflections) and rendering.
- [ ] Prebuilt HTML template vs. assistant-generated page each time.
- [ ] Where do declarations + by-when deadlines live (a `declarations:` block
      in `log/week-NN.yaml`, keyed by goal id?).
- [ ] The 10–15% rule vs. ramps and deloads (see page 2 observations).
- [x] Goal-count mismatch: resolved, the fifth goal is Relationships (pages 1 and 3).
- [ ] Where does the weekly reflection text live (`log/week-NN.yaml` field? a
      separate `reflections/` file?).
- [ ] Week numbering: form's 1–12 vs. program weeks from Day 1.
- [ ] ChatGPT parity: what's the equivalent of a skill zip there?

## Related

- [[dashboard-guidelines]] (`references/dashboard-guidelines.md`)
- [[goal-pacing]] (`references/goal-pacing.md`)
- `references/rendering/dashboard/README.md`
- `context-v/agent-skills/personal-strategic-plan/SKILL.md`
