# Outcome progress: how far, and where it's heading

Outcomes (weight, income, a first song in an hour) are **read every week and
scored only at Day 30, 60, and 90.** Between checkpoints, the member still
wants to know two things: *how far have I come* and *where is this heading.*
This file says how to answer both, in a dashboard or in conversation.

## The numbers

For each outcome, from its `baseline`, its readings, and its milestones:

- **Goal:** the far milestone (usually Day 90). For a range, the stretch end:
  the high end for an "up" outcome, the low end for a "down" one.
- **Share of the way:** (latest − baseline) ÷ (goal − baseline), shown as a
  percent. 213 → 208 lb against a 190 lb goal is 5 ÷ 23 ≈ 22%.
- **Projection** (`projection: linear`, the default): the rate from baseline to
  the latest reading, carried forward to the goal's day. 5 lb in 6 days carried
  to Day 90 lands near 139 lb, about 51 lb past the goal. Report the variance in
  words: "at this rate, X by Day 90, Y past the goal" or "Y short of it."
- **Levels** (`projection: none`): something read as it stands, like a monthly
  income run-rate. Show the share and where it sits against the goal's range
  ("In range", "At goal", "Below range"), and don't project a rate.

## When there's no number

Say so in words, never as a zero that looks like failure:

- **No starting point yet:** the first reading sets the baseline (a first timed
  song, a first VO2max test).
- **No reading since the start:** progress is 0% only because nothing new was
  measured. Ask for a reading on Sunday.
- **No goal yet:** track it, show the latest reading, and help set milestones
  once there's a baseline.
- **`track_only`** outcomes (a 0–10 relationship rating) are shown, never scored
  and never projected.

## How to say it

- The weekly status is **direction, not a verdict**: "heading past goal",
  "heading into range", "heading short". The Day 30, 60, and 90 checkpoints are
  where an outcome is scored (see `references/goal-pacing.md`).
- **Early projections overreact.** A week or two of readings carries noise:
  early weight loss is mostly water, a big invoice spikes income. Say so when
  the projection rests on one or two readings, and prefer a rolling average of
  the last few readings once there are four or more.
- **Hitting one outcome doesn't retire the habits.** A goal often has habits
  that drive a *different* outcome than the one already met (consulting income
  reached, while outreach habits drive fundraising). Name which outcome each
  habit feeds before suggesting anyone ease off.

## In the dashboard

The reference renderer (`references/rendering/dashboard/`) puts an **Outcomes**
panel at the top of each week view: one tile per outcome, grouped by goal, with
the latest reading, a neutral meter from start to goal, the share, the
projection line, and a status chip in words. Outcomes with no goal and no
reading collapse into one "also tracked" line. The logic is `outcomeProgress()`
in `tracker.ts`.
