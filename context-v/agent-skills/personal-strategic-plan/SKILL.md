---
name: personal-strategic-plan
description: Draft, score, revise, and render a ChoiceCenter Personal Strategic Plan (PSP), the 100-day goal document used in the Leadership Legacy (LV) coaching program. Use whenever the user mentions "PSP", "Personal Strategic Plan", "ChoiceCenter", "LV" cohort goals, the 100-day plan, their weekly action plan, floors and targets, the weekly scorecard, or morning/evening check-ins against their goals; whenever a goal needs rewriting into measurable weekly inputs; or whenever a plan needs exporting to the program's shared Google Doc or rendering on a site. Stub: the workflow sections below are still being filled in.
---

# Personal Strategic Plan

**Status:** stub (2026-10-02). Templates, the build script, and one worked
example exist. The coaching workflows are not written yet.

Everything this skill points at lives in the `psp-ai` repo, at
`ai-labs/psp-ai/` in the lossless-monorepo tree. Paths below are relative to
that repo root.

## What a PSP is

A 100-day plan, written on ChoiceCenter's form, worked as a group. Each goal
carries a statement, three commitment boxes (why it matters, the prices I'll
pay, the ways of being I'll access), a 12-week action plan, and 30/60/90-day
milestones. The plan ends with a community-service goal, a transformation
(enrollment) goal, and a list of 25–40 relationships to elevate.

## Files

| Path | Use |
|---|---|
| `templates/psp-blank.md` | The program form, blank. Start every new plan here. |
| `templates/goal-block-scored.md` | The scored goal block and the How-I-Keep-Score section. |
| `references/template-anatomy.md` | Which sections are the program's and which are extensions. Read before restructuring a plan. |
| `references/example-plan.md` | A finished plan (identity details stripped). The model for tone and specificity. |
| `scripts/build-psp.sh` | Markdown → Google-Docs-pasteable HTML + .docx. |
| `references/rendering/` | Astro page + CSS that render a plan on a site. |

## Rules

- **Keep the program's wording.** Box labels, goal headers, and the closing
  sections are read by coaches and pasted into a shared doc. Extend around
  them; don't rephrase them.
- **Score inputs, not outcomes.** Rewrite a goal until each week is checkable
  by what the member did, with a floor (bad-week minimum) and a target.
- **The member's plan is private.** Never commit a member's filled-in plan to
  this repo; work on it wherever they keep it. Strip the identity table before
  anything is published.

## Workflows (to be written)

- [ ] Draft a new plan from the blank template through conversation
- [ ] Convert a goal into the scored shape (what counts / score / rules / floor-target)
- [ ] Daily check-in: morning intent, evening tally against the scorecard
- [ ] Weekly retro and rewrite of the remaining weeks
- [ ] 30/60/90 readings
- [ ] Export for the shared Google Doc (`scripts/build-psp.sh`)
