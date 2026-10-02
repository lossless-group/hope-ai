# Template anatomy

The ChoiceCenter Personal Strategic Plan (PSP) arrives as a Google Docs form.
No blank copy of that form was kept, so `templates/psp-blank.md` was
reconstructed from one finished plan (`example-plan.md`) by stripping the
answers and keeping the structure. Check it against your coach's current form
before relying on details like the number of goals.

## Program-owned (the form)

These come from ChoiceCenter and the shared Google Doc expects them. Keep the
wording.

| Section | Markdown shape | Notes |
|---|---|---|
| Title | `## **Personal Strategic Plan Outline**` | |
| Identity | 2-column table, first row `Name` | Name, phone/email, age, occupation, city, contract, coach, handles. Personal data: strip before publishing. |
| Purpose + three stands | four 1-column tables | purpose for being in `LV___`; vision for the world, myself/family, my team |
| `## **PERSONAL GOALS**` | H2 | |
| Goal header | `### **Personal Goal N: …**` (or `Creative Goal N`) | The build script turns this into the form's two-cell header band. |
| Commitment boxes | three 1-column tables | important because / prices I'm willing to pay / ways of being |
| Weekly action plan | `Week \| Action \| Results`, Weeks 1–12 | |
| Milestones | 2-column table, `By 30/60/90 Days` | |
| Community service goal | bold paragraph | fixed text |
| Transformation goal | declaration + 8-row enrollment table + three boxes | enrollment is into the next `LV` |
| Commitment line + signature | sentence, `Name: \| \| Date: \|` table | |
| 25–40 relationships | 5-column table | name, relationship, 0–10 rating, BE/DO |
| Message from HomeTeam | 1-column table | ChoiceCenter boilerplate |

## Member extensions (the scored layer)

Added in the example plan to make each goal checkable every week. The form
neither asks for nor forbids them; they paste into the Google Doc fine.

- **How I keep score**: an H2 of scoring principles, placed before PERSONAL GOALS.
- **Weekly scorecard**: `Goal | What I count | Floor | Target`, for the accountability partner.
- **Per goal**: `What counts:` list, `How I score it:` with floor and target, `Rules:`.
- **Floor / Target column** inserted into the weekly action plan, and the
  Action column reframed as "By end of week" (cumulative standards, not one-off tasks).
- **Deload weeks** at 8 and 12.
- **H4 protocols** under a goal (`#### **Hydration protocol**`, etc.) holding the standards the "What counts" list references.
- **Readings tables** (biomarkers, income scoreboard): columns for Day 0 / midpoint / end, or month 1–3.

Template: `templates/goal-block-scored.md`.

## Table shapes, and why they matter

Nearly every block is a table, doing one of three jobs. Anything that renders
or converts the plan has to tell them apart structurally, because the markdown
carries no class names:

| Shape | Job |
|---|---|
| 1 column | a labelled prose box |
| 2 columns, header-band row | goal header, or a label/value list (identity, milestones) |
| 3+ columns | a real data table (weekly plan, scorecard, readings) |

`rendering/psp.css` does this with `:has()`; `scripts/build-psp.py` does it for
the Google Docs paste.
