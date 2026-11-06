# Hours check

Who has entries and who doesn't, for one day or for the week so far. This is the base for reminders and reports. It answers one question per person per day: *is there at least one entry?* It never looks at what the entries say.

## Which day

- Default: **yesterday** (the last working day). If the person asks for "today", only count today as missing after the cut-off time in `config.md`; before that, say the day is still open and show who has started.
- "This week": every working day from Monday to the last closed day.

## Steps

1. **People.** `list_users` (`filter: ACTIVE`). Keep each person's `id`, `name`, `email`, `role` and `schedule` (hours per weekday: `mon`, `tue`…). Drop the people listed under *skip* in `config.md`.
2. **Working days.** For each person and day: it's a working day when their schedule has hours for that weekday. No schedule → the default in `config.md`. Then remove:
   - holidays: `list_holidays` with `from` and `to` covering the range;
   - approved time off: `list_timeoffs` with `from`, `to` and `status: APPROVED` (keep `time_off_status: APPROVED` only). A full-day request removes the day; a partial one keeps it.
3. **Entries for the day.** `list_filtered_events` with `date_range: {period: "custom_range", start: <day>, end: <day>}` and `parameters: ["user"]`. Each row has `uid` and `d` (seconds). A person has logged the day when their rows add up to at least the minimum in `config.md`. Running timers aren't in this list; a day with only a running timer counts as not logged yet.
   - For one person only, `list_events` with `filter: USER`, `id: <user_id>`, `from`, `to` is cheaper.
4. **Missed streak** for each person missing that day: walk backwards over their working days (skipping holidays and approved leave) and count consecutive days without entries, up to the look-back limit in `config.md`. Use one `list_events` call per person for the whole look-back range and group by date (`s`). Stop at the first day with entries.
5. **Level** from the streak:

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
On leave: Gabi
Holiday / not scheduled: —
```

Then offer the next step: "Send the reminders?" (→ `reminders.md`). Never list hours per person here; that is not the point of this check.

## Don'ts

- Don't infer presence from anything but entries. No "last seen" data.
- Don't add up hours to judge effort. A day with 15 minutes logged is a logged day.
- Don't keep a private tally between conversations. Everything is recomputed from TrackingTime each time, so the record is the only source of truth.
