---
site_uuid: 571f4ffa-3226-4971-a064-d858591fb48d
hex_code: fb45bf
title: "Shared PSP Workspace with Circles and a Native Connector"
lede: "Each member's PSP lives in their own versioned repo; they choose what their dyad, power group and team can see; and the whole cohort talks to it from the Claude or ChatGPT app they already use."
summary: "Stub spec for moving hope-ai from download-and-run to a hosted, multiplayer PSP workspace. Borrows event-hog's storage pattern (Cloudflare Artifacts repos as the human-readable, git-history record, D1 for structure, a Worker serving a remote MCP connector) and adds what event-hog doesn't have: identity, nested groups (dyad, power group, team), per-circle sharing with permissions enforced in code, and discussion on shared progress. mpstaton-site's /psp dashboard becomes the first reader of the new data. Not yet scheduled for build."
publish: false
date_created: 2026-11-11
date_modified: 2026-11-11
date_authored_initial_draft: 2026-11-11
date_authored_current_draft: 2026-11-11
date_authored_final_draft:
authors:
  - Michael Staton
augmented_with:
  - Claude Code on Claude Opus 5.5
at_semantic_version: 0.0.0.1
tags:
  - Spec
  - Personal-Strategic-Plan
  - Cloudflare-Artifacts
  - MCP
  - Permissions
  - Group-Coaching
status: Draft
type: Specs
related:
  - "[[Progress-Dashboard-for-Flexible-PSP-Dataviz]]"
  - "[[2026-10-25_Three-Layers-and-an-Agnostic-CRM-for-Event-Hog]]"
  - "[[cloudflare-artifacts-interface]]"
  - "[[personal-strategic-plan]]"
---

# Shared PSP Workspace with Circles and a Native Connector

> **Stub.** This was written so the idea isn't lost. The shapes below are a
> first proposal to argue with, not decisions. Open questions are at the end.

## Why Care?

A 100-day plan held alone is easy to avoid. The program already knows this,
which is why it pairs every member with a coach, puts them in a small power
group, and runs the whole cohort as a team. The tools don't reflect that
yet:

- **The download bundle** in [[Progress-Dashboard-for-Flexible-PSP-Dataviz]]
  is single player. Your plan and logs live in your chat or your downloads,
  and nobody sees them unless you paste them somewhere.
- **mpstaton-site's `/psp/dashboard`** (the one working dashboard) reads YAML
  files committed into a public site repo. Logging a day means a commit and a
  deploy. That's too much friction for a daily habit, and the friction makes
  a plan that already feels heavy easy to stop opening. This happened: the
  log stops at Week 2, Day 7.

What would help: log a day by saying it to the assistant you already use,
let the right people see it without anyone forwarding anything, and let them
respond.

## What exists to build on

| Piece | Where | What we take from it |
|---|---|---|
| **event-hog** | `ai-labs/mcps/event-hog-mcp` ([GitHub](https://github.com/lossless-group/event-hog-mcp)) | The whole storage and connector pattern: a Cloudflare Worker serving a remote MCP server; one **Cloudflare Artifacts** repo per workspace where every write is a commit authored as the caller; **D1** for structured, queryable data; **R2** for images; skills bundled into the Worker (`kit/`) and served to the model. Its decision record (`context-v/decisions/2026-10-25_Three-Layers-and-an-Agnostic-CRM-for-Event-Hog.md`) explains the layering. |
| **event-hog's gap** | its README: *"There's no org management yet: everyone on a deployment shares one workspace and one database."* | The thing this spec adds. event-hog's teams are one flat circle where everyone sees everything. A coaching cohort needs nested circles and privacy. |
| **mpstaton-site PSP** | `astro-knots/sites/mpstaton-site` ([GitHub](https://github.com/lossless-group/mpstaton-site)): `src/content/psp/`, `src/pages/psp/`, `src/components/psp/` | The data shape (`tracker.yaml`, `log/week-NN.yaml`), the 7-day cycles rolled up to Day 30/60/90, the outcome tiles, and the rule that an unlogged day shows as "not logged", never as a miss. The dashboard components become the first reader of the new store. |
| **hope-ai skill** | `context-v/agent-skills/personal-strategic-plan/` | How to draft, score, check in, and fill in the Sunday weekly form. It becomes the instructions the connector serves. |

## The shape

### 1. Circles: dyad, power group, team

Everyone is a **member**. Members belong to **circles**. A circle has a kind,
and the kinds nest:

| Circle kind | Who's in it | Example | Default can see |
|---|---|---|---|
| **self** | Just the member | (implicit) | Everything |
| **dyad** | A member + their coach | Michael + coach | Everything the member hasn't marked private |
| **power group** | A coach + a handful of members | `power-group` | Weekly scores, the weekly form, posts |
| **team** | The whole cohort (~22) | `lv236` (TBD) | Week-level score and posts the member chose to share |

- A coach is a member who has a **coach** role in several dyads and usually
  one power group. Coaches can see their members' dyad-level data in one view
  (a "coach brief" across dyads).
- Circles are data, not hardcoded kinds, so a cohort that runs differently
  (triads, accountability pairs between members, a second coach) can add a
  kind without a schema change. Dyad, power group and team are the defaults.
- A program admin role (Michael for now) creates circles and sends invites.

### 2. Storage: three layers, like event-hog

| Layer | What | Job |
|---|---|---|
| **Artifacts: one repo per member** (`hope-ai/psp-<handle>`) | `plan.md`, `tracker.yaml`, `log/week-NN.yaml`, `forms/week-NN.md` (Sunday form) | The member's own record, human-readable, with history and undo. The member can export or take it with them at any time: it's just a git repo |
| **Artifacts: one repo per circle** (`hope-ai/circle-<slug>`) | `posts/<date>-<member>-<slug>.md`, each with its replies appended below | The discussion. Append-only, authored per commit, so who said what, when, is never in doubt |
| **D1 `hope-ai`** | members, circles, memberships, roles, share grants, a weekly-rollup cache, a post index | Who's who and who can see what. Fast queries for feeds and dashboards. Rebuildable from the repos except membership and grants |

The member's repo is never written to by anyone else. Sharing **copies a
rendered snapshot** into the circle (a post) or answers a read through the
Worker after a permission check. Nobody gets direct access to another
member's repo.

### 3. Sharing: grants enforced in code, not asked of the model

event-hog's README separates what's **enforced in code** from what's **asked
of the model**. Here, privacy has to be in the first list. A model can be
talked into reading something it shouldn't, but a Worker that checks a grant
before every read can't.

- Every piece of a member's data has a **visibility level**: `private`,
  `dyad`, `power-group`, `team`. Data defaults to `dyad`. The member sets
  overrides per goal: a weight goal can be `private` while the sales goal is
  `team`.
- Reading another member's data goes through one function,
  `canSee(viewer, owner, item)`, that checks circle membership and the item's
  level. Tools never read across members any other way.
- **Posting is explicit.** Nothing reaches a circle until the member says to
  share it ("share my week with the power group"). The assistant drafts the
  post, the member approves it, and the server writes it.
- Raw daily notes stay out of posts by default. Posts carry scores, outcome
  tiles and what the member chose to write.

### 4. Discussion

- A **post** is a share: a weekly score card, a breakthrough, an ask
  ("I keep skipping my morning practice; what works for you?"), or the
  Sunday form.
- **Replies** append to the post file. **Reactions** (a short fixed set)
  live in D1, so they don't create a commit per tap.
- **Feeds:** "what's new in my power group", "what has my coach said this
  week", "who in the team posted a breakthrough". These are D1 queries
  filtered through `canSee`.
- **Coaches reply in the same place.** The dyad circle is effectively a
  private thread between member and coach.

### 5. The connector: one link, any native app

The point is that a member opens Claude or ChatGPT on their phone, says
"log today: hydration yes, keto no, two chunks done", and it works.

- **One remote MCP server** (the Worker), added as a custom connector in
  Claude (desktop, mobile, web) and in ChatGPT where its connector support
  allows. Confirm what each app supports at build time.
- **Auth: OAuth, not keys in URLs.** event-hog puts the credential in the
  connector URL, which is fine for a conference team but not for health and
  personal goals shared across 22 people. Use OAuth (e.g. Cloudflare's
  `workers-oauth-provider`) with an invite-based sign-in (email magic link),
  so a forwarded URL alone grants nothing and access can be revoked per
  person.
- **Server instructions + bundled skill:** the Worker serves the
  `personal-strategic-plan` skill (as event-hog serves its kit), so any
  assistant knows the program's language (base and stretch, chunks, the
  Sunday form) without the member installing anything.
- **Sketch of tools:**
  - *Me:* `whoami`, `my_plan`, `edit_plan`, `log_day`, `my_week`,
    `my_progress` (Day 30/60/90 rollup), `weekly_form`, `restart` (new Day 0
    without erasing history), `export_my_repo`
  - *Sharing:* `set_visibility`, `share` (draft → approve → post), `my_circles`
  - *Discussion:* `feed`, `read_post`, `reply`, `react`
  - *Coach:* `coach_brief` (all dyads, who's logged, who's gone quiet),
    `nudge` (a reply in the dyad, never a message outside it)
  - *Admin:* `create_circle`, `invite`, `remove_member`
- **Dashboard:** a page served by the Worker (or the hope-ai site) that reads
  the same API behind the same sign-in, reusing mpstaton-site's dashboard
  components. mpstaton-site's `/psp/dashboard` switches from committed YAML
  to this API, or stays a build-time snapshot for the public view.

### 6. Starting again is a feature

Members will stop logging, as Michael did. The design should make coming
back cheap and blame-free:

- `restart` sets a new Day 0, keeps the old cycles as history, and never
  shows unlogged days as failures.
- `coach_brief` surfaces who's gone quiet so the coach can reach out in the
  dyad. It doesn't announce it to the team.
- Gone-quiet status is never visible above the dyad by default.

## Phasing (when there's time)

1. **Single player on the new store.** Michael's PSP moves from
   mpstaton-site YAML into his Artifacts repo; `log_day`, `my_week`,
   `my_progress` work from the Claude app; the dashboard reads from it.
2. **Identity and circles.** OAuth sign-in, D1 membership tables, `canSee`,
   one dyad (Michael + coach) and visibility levels.
3. **Discussion.** Posts, replies, reactions, feeds; one power group.
4. **The team.** Invites for all 22, coach brief, admin tools, ChatGPT check.

## Open questions

- **Consent and the program.** Does ChoiceCenter have norms about what's
  shared outside sessions, and should coaches see more than members choose to
  show? Who besides Michael administers it?
- **Where it runs.** Lossless's Cloudflare account, a dedicated hope-ai
  account, or an account the program owns? (event-hog runs in the client's
  own account.)
- **Names.** What's the team's actual name (cohort ID?), and is there one
  power group or several?
- **Is a circle repo the right home for discussion,** or is D1 alone simpler
  and the git history not worth it for chat-like content?
- **ChatGPT parity.** How much of this works through ChatGPT connectors today,
  and what's the fallback for members who use neither app's connectors?
- **Data retention.** What happens to a member's repo and posts when the 100
  days end or they leave the cohort?
- **The shared Google Doc.** The program's canonical PSP is a Google Doc.
  Is the repo the source and the Doc an export, or the other way round?
