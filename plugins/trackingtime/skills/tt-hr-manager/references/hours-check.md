# Hours check

Who has hours and who doesn't, for one day or for the week so far. This is the base for reminders and reports. It answers one question per person per day: *is the day logged?* The answer comes from `missing-day.md`; this file only adds the streak and the level.

## Which day

- Default: **yesterday** (the last working day). "Today" counts as missing only after the cut-off time in `config.md`; before that, say the day is still open and show who has started.
- "This week": every working day from Monday to the last closed day.

## Steps

1. **People.** `list_users` (`filter: ACTIVE`). Keep `id`, `name`, `email`, `role` and `schedule`. Drop the people under *skip* in `config.md`.
2. **Per-day verdict.** Apply `missing-day.md` to each person and each day in the range: working days from the schedule minus holidays and approved leave; worked time from the time card when Time Cards are on, otherwise from `list_filtered_events` (`parameters: ["user"]`); missing when under the minimum in `config.md`; pending requests make a day "requested, pending approval".
3. **Missed streak** for each person missing the day: walk backwards over their working days, up to the look-back limit in `config.md`, and count consecutive missing days using the same verdict. Use one source call per person for the whole look-back range (`get_timecard`, or `list_events` with `filter: USER`) and stop at the first logged day.
4. **Level** from the streak:

   | Streak | Level | What happens |
   |---|---|---|
   | 1 | 1 · first reminder | light nudge |
   | 2 | 2 · second reminder | warmer, offers help |
   | ≥ escalation threshold (default 3) | 3 · direct reminder + escalation | manager gets a factual note |

## Output

```
Hours check · Tuesday 3 November
Logged (9): Ana, Bruno, Carla, …
Missing (3): Diego · 1 day, Eva · 2 days, Fede · 4 days (escalate)
Requested, pending approval: Gabi (Tue)
On leave: Hugo
Holiday / not scheduled: —
Timer running: Iván (since 09:12, not counted yet)
```

Then offer the next step: "Send the reminders?" (→ `reminders.md`). Never list hours per person here; that is not the point of this check.

## Don'ts

- Don't infer presence from anything but entries. No "last seen" data.
- Don't add up hours to judge effort. A day over the minimum is a logged day.
- Don't keep a private tally between conversations. Everything is recomputed from TrackingTime each time, so the record is the only source of truth.
- Don't redefine "missing" here. If the rule needs a change, it changes in `missing-day.md` for every agent.
