# Absences

Work days in the period with no worked time and no approved leave, plus short days when `config.md` asks for them. The list goes to payroll and to HR; it is not a message to the person.

## Steps

1. Run the period summary (`period-summary.md`) if it isn't in this conversation; keep the per-day numbers.
2. **Unexplained absences**: the days `missing-day.md` marks as **missing** (a working day from the schedule, minus holidays and approved leave, with worked time under the minimum in `config.md`). With Time Cards on, worked = `regular_seconds + extra_seconds` from the time card already in the summary.
3. **Requested but not approved**: the days `missing-day.md` marks as **requested, pending approval** (a pending request covers the day). Say who can approve it (the HR Manager agent handles approvals).
4. **Partial leave**: `TIMEOFF` days with `timeoff_seconds` smaller than the schedule hours. Expected hours are the remainder; if worked is 0, that remainder is an unexplained absence of that size.
5. **Short days** (only when `config.md` sets a threshold): `WORK_DAY` days where expected − worked is above the threshold. Report the gap, not a percentage.
6. **Running timers**: an entry still running on the last day of the period isn't in the time card yet. When the team has at most the number of people in this skill's `config.md` (*Absences*), check `list_user_tasks` per person (no filter, `tracking: true`) and mention anyone still tracking; otherwise say the check was skipped.

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
- Don't redefine "missing" here. The rule lives in `missing-day.md` for every agent.
- Don't deduce leave from task names or notes. Only approved time off counts.
- Don't send anything to the person from here. Payroll reports; HR asks.
