# Absences

Work days in the period with no worked time and no approved leave, plus short days when `config.md` asks for them. The list goes to payroll and to HR; it is not a message to the person.

## Steps

1. Run the period summary (`period-summary.md`) if it isn't in this conversation; keep the per-day numbers.
2. **Unexplained absences**: days with `is_workable` true, `day_type` `WORK_DAY`, worked = 0 and `timeoff_seconds` = 0. Holidays and days off are already excluded by `day_type`.
3. **Requested but not approved**: `list_timeoffs` with `from`, `to`, `status: PENDING`. Any pending request that covers an unexplained day moves that day to "requested, pending approval". Say who can approve it (the HR Manager agent handles approvals).
4. **Partial leave**: `TIMEOFF` days with `timeoff_seconds` smaller than the schedule hours. Expected hours are the remainder; if worked is 0, that remainder is an unexplained absence of that size.
5. **Short days** (only when `config.md` sets a threshold): `WORK_DAY` days where expected − worked is above the threshold. Report the gap, not a percentage.
6. **Running timers**: an entry still running on the last day of the period isn't in the time card yet. For small teams (the threshold in the Office Manager's `config.md`, default 15 people) check `list_user_tasks` per person and mention anyone still tracking.

## Output

```
Absences · October 2026
Carla · 2 unexplained days: Mon 6 Oct, Tue 7 Oct
Diego · 1 day requested, pending approval: Fri 24 Oct (Vacation, requested 20 Oct)
Eva · 1 partial: Wed 15 Oct, 4h leave approved, 4h expected, 0h worked
Short days (threshold 60 min): Bruno · Thu 9 Oct, 05:10 worked of 08:00
Everyone else: complete.
```

Then offer: "Want the HR Manager to ask about the unexplained days?" If the HR Manager skill isn't installed, offer to draft the message for the person to send.

## Don'ts

- Don't mark a day as an absence because the hours are low; that's a short day, and only if `config.md` asks for it.
- Don't deduce leave from task names or notes. Only approved time off counts.
- Don't send anything to the person from here. Payroll reports; HR asks.
