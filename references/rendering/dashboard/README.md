# Dashboard reference implementation (Astro)

Copied from mpstaton.com (`astro-knots/sites/mpstaton-site`), where it runs at
`/psp/dashboard` (Michael's) and `/psp/dashboard/sample` (fictional data).
Copy and adapt; this isn't a package. The spec it implements is
`../../dashboard-guidelines.md`.

| File | Role |
|---|---|
| `tracker.ts` | All rollup logic: program weeks, the ramp, day → week → checkpoint, status rules. Plain TypeScript with no framework imports, so it ports to any renderer (an assistant-built artifact, a script, another site). |
| `load.ts` | Astro/Vite loader: bundles `tracker.yaml` + `log/week-NN.yaml` with `import.meta.glob` so pages can render per request. |
| `components/DashboardPage.astro` | Page chrome, sample banner. |
| `components/SummaryView.astro` | Goals × weeks grid, Day 30/60/90 cards, this week so far. |
| `components/WeekView.astro` | The 7-day detail grid per goal. |
| `components/OutcomesPanel.astro` | Top of the week view: a stat tile per outcome (latest reading, a start-to-goal meter, and where the current rate lands by the goal's day). |
| `components/StatusLegend.astro` | The always-on legend. |
| `psp-dashboard.css` | Styles, built on the host site's semantic color tokens. |
| `example/` | The fictional sample dataset (four goals, six weeks of logs, including unlogged days, a rough week, and a weekly-totals logger). |

Routes on the host site are four thin pages: summary and `week/[week]`, for
each dataset. Render them per request (not prerendered) so "today", and so
the current week, is always right.
