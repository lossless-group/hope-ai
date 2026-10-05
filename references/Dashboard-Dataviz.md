# Dashboard dataviz: making progress visible, their way

A PSP dashboard has one job: let a member, and the coach and buddy they share it
with, see two things at a glance.

1. **The process:** are they doing the habits they committed to, week by week?
2. **The outcomes:** are the results those habits are meant to move actually
   moving toward the goal?

Everything in this toolkit (the files, the statuses, the reference renderer) is
**a set of guidelines for answering those two questions, not a format to impose.**
It matters much less that a dashboard is done our way than that it works for the
person using it.

## Start with the member, not the format

Before building anything, ask:

- **How do you already keep track?** A notes app, a spreadsheet, a paper
  calendar, a fitness app, a habit tracker, nothing at all. If something already
  works, build on it rather than replacing it.
- **How often will you actually log?** Daily, a few times a week, or once on
  Sunday. Design for the real rhythm, not the ideal one.
- **Who sees it, and where?** Just them, their buddy, their coach, the cohort.
  On a phone, in a doc, on a site, in this chat.
- **What would you want to see first when you open it?**

Then adapt. Reasonable shapes, all valid:

- A Claude or ChatGPT artifact rebuilt from their files each Sunday
- A Google Sheet with one tab per week and a summary tab
- A page on their own site (see `references/rendering/dashboard/`)
- A printed one-page grid they tick by hand and photograph on Sunday
- No dashboard at all: just the Sunday conversation, if that's what keeps them going

Whatever the shape, keep the few principles that protect people: unlogged is
never missed, base is a win, the process is scored weekly and outcomes at the
checkpoints, a reason sits beside a result without changing it, and other
people's names stay private.

## If they don't have an opinion: recommend our way, firmly

Most people won't have one, and an open-ended "how would you like to track it?"
just stalls them. In that case, say so directly: *"Here's what I'd recommend;
it's what this toolkit is built around,"* and set up the following.

### The process: habits as inputs

Every process habit is something the member **does**, with a rhythm and two bars:

| Rhythm | Use it for | Example |
|---|---|---|
| **Daily** | Things that happen most days | Morning move, keto until dinner, 20 minutes of language |
| **Weekly** | Things that happen a few times a week | 3 resistance sessions, 5 calls, 1 date night |
| **Biweekly** | Things that happen every couple of weeks | 2 coffee chats per two weeks |
| **Monthly** | Things that happen once a month or so | A portfolio refresh, a budget review |

- **Base and stretch.** Base is the bad-week minimum and counts as a win; stretch
  is a great week. Both can ramp up week by week, with lighter deload weeks.
- **Counts or checks.** A check is "did it happen" (a day ticks or doesn't); a
  count is "how many" or "how much" (calls, minutes, hours).
- **Limits.** For a "no more than" habit (carb meals, drinks, hours worked), the
  limit is the stretch, and staying under is the win.
- **Longest stretch.** For something continuous, like a fast, the week's longest
  counts (`aggregate: max`), not the sum.
- **Bonus.** A habit with no base that week can't be missed; doing it shows as a
  win.

### The outcomes: results as readings

Every outcome is something the habits **move**, read on Sunday:

- A **starting point** (baseline), a **goal** (usually Day 90), and optional
  Day 30 and 60 milestones.
- Each week: the **latest reading**, the **share of the way** from start to goal,
  and **where the current rate is heading**. That's information, not a grade (see
  [[references/Outcome-Progress.md]]).
- **Levels** (a monthly income run-rate) show where they stand against the goal's
  range; **trends** (weight, words written) also show a projection.
- **Ratings** (how close a relationship feels, 0–10) are tracked, never scored.

### The views

- **This week (for them):** each goal as a 7-day grid of its habits, with a
  running total against base and stretch, and the outcomes panel on top.
- **The summary (for coach and buddy):** goals × weeks, one cell per week, the
  Day 30/60/90 checkpoints, and a legend that's always visible, so someone who
  has never seen the plan can read it.

The data format (`tracker.yaml` plus one log per week) and every rule are in
`references/dashboard-guidelines.md`; the templates are in `templates/`.

## Visual rules worth keeping in any shape

- **Words carry status, color supports it.** Every status has a label ("Stretch
  hit", "Base met", "Below base", "Bonus", "In progress"); color is never the only
  signal.
- **Not logged looks different from missed.** Use hatching or blank, never red,
  for a day nobody has written down yet.
- **Outcomes stay neutral week to week.** Show progress and direction in words; save
  the on-track / behind verdict for Day 30, 60, and 90.
- **Lead with wins.** A week with two misses and five hits is a good week with two
  things to look at.
- **Keep it glanceable.** If the member has to study it, simplify it: fewer
  habits per goal (two to five), fewer outcomes, larger numbers.
