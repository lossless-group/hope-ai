# The PSP folder, and the three ways to work with it

Each member keeps their whole PSP in **one folder**. Whatever assistant they use
(Claude, ChatGPT, another one, or none) reads and updates the same files.

## The folder

```
my-psp/
├── plan.md                  the PSP itself, in the program's wording
├── tracker.yaml             the plan as numbers: habits, base, stretch, milestones
├── log/week-01.yaml         what happened, by date, one file per program week
├── weekly-form/week-01.md   that Sunday's form answers, as submitted
└── private/people.yaml      loved ones, enrolling conversations, team list, buddy
```

- Start `tracker.yaml` from `templates/tracker.yaml` and each week's log from
  `templates/log-week.yaml`.
- **`private/` holds other people's names.** If the member publishes a dashboard
  (a site, a shared page), `private/` stays out of it.
- **First run:** ask where the folder is, or help them pick one. Don't scatter
  files anywhere else afterward.

## Three ways to work

Find out which situation you're in (can you write files? is there a project with
uploaded files?) and tell the member in plain words. Don't make them know these
terms.

| Mode | What you can do | What you tell the member |
|---|---|---|
| **Folder** (Claude Code, Claude desktop with a folder connected, Codex, …) | Read and write the files directly. | Nothing to do: name the folder once. |
| **Project** (a Claude Project or ChatGPT Project with the files uploaded) | Read the files; you can't change them in place. | At the end of each session, hand back every changed file (usually just this week's log) and ask them to re-upload it to the project, replacing the old copy. |
| **Single chat** (no project, no files) | Keep everything in this conversation. | Plainly, on the first run and again each Sunday: **stay in this chat for all 100 days**, or download the latest files and attach them to a new chat. Suggest a Project if they'd rather not worry about it. |

If you can't write files at all, give the exact YAML to paste, one file at a
time, saying which file it goes in.

## Privacy

- Never commit or publish a member's filled-in plan, logs, or form answers to a
  public place on their behalf.
- Other people's names (family, enrolling conversations, buddy, team) go in
  `private/` only. A member may choose to show their own numbers publicly; that's
  their call, and it doesn't extend to anyone else's name.
