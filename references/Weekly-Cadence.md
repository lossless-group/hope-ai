# Weekly cadence: the cohort's clock and the Sunday session

The program runs on one fixed weekly beat: the **weekly PSP roadmap form is due
Sunday afternoon.** Everything else (logging, check-ins, the dashboard) exists to
make that Sunday easy and to keep the week on track before Sunday arrives.

## The clock

- **Weeks run Sunday to Saturday.** Sunday's session closes the week just ended
  and opens the next one, and Sunday itself belongs to the *new* week.
- Set `week_starts: sunday` in `tracker.yaml`. Week 1 is then the part-week from
  Day 1 to the first Saturday (Monday to Saturday for a Monday start), and its
  base and stretch are prorated to the days it has. The last week is short too.
- Without `week_starts`, weeks run seven days from Day 1, whatever weekday that
  is. Use that only for a cohort with no weekly clock.
- A **continuous** thing that crosses the boundary (a fast that starts Saturday
  night and ends at Sunday dinner) is logged on the day it **started**.

## During the week

People log daily, in batches, or all at once on Friday. All of it is normal.

- **"Where am I this week?"** At any point, total each habit so far against
  this week's base and stretch and say what's left before Sunday: "two more
  morning moves and one resistance session gets you to base." Good news only
  shows early; anything still possible reads as "In progress", never as a miss.
- **Never miss twice.** If a daily habit was missed yesterday, today's first
  job is getting it back.

## The Sunday session (about 20 minutes)

Do these in order. Ask, don't assume, at every step.

1. **Catch up.** List the days of the week just ended that aren't logged yet
   and ask about each one. An unlogged day is "not logged", never a miss, until
   the member says what happened.
2. **Score the week.** Total every habit against that week's base and stretch.
   Lead with the wins: base met counts as a win, and a bonus habit done is a win.
3. **Ask for reasons on misses.** For anything below base, ask whether there's
   context worth recording ("contacts not imported yet", "at a conference Mon to
   Wed"). Log it under `reasons:`. Never invent one, and never soften the status:
   the reason sits beside the result, it doesn't change it.
4. **Take readings.** One reading per outcome under `readings:`, dated the day
   it was taken: weight, income, ratings, anything the plan measures. If there's
   no new number, say so; don't carry the old one forward as if it were new.
5. **Look at the outcomes.** Say where each outcome stands against its goal and
   where the current rate is heading (see [[references/Outcome-Progress.md]]).
   Note it; don't grade it. The verdict waits for Day 30, 60, and 90.
6. **Draft the form.** Walk the weekly form page by page, drafting everything
   the log supports and asking for the rest (see
   [[references/Weekly-Form.md]]). The member pastes the answers in themselves.
7. **Set next week.** The declarations they just wrote are next week's plan. If
   reality has moved (a blocker, an illness, a trip), rewrite the remaining weeks
   now, openly. If they're beating stretch every week, let the habit settle
   before adding more.
8. **Save.** Write the week's log, the submitted answers
   (`weekly-form/week-NN.md`), and anything private (`private/people.yaml`) to
   the member's PSP folder, or hand back the files to re-upload, depending on
   how they work (see [[references/PSP-Folder-and-Modes.md]]).

## Why the loop matters

This Sunday's declarations are what next Sunday's "Top 3 results" and
"on track?" answer are judged against. Saving them is what lets next week's form
be drafted instead of written from a blank page.
