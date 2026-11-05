# Period summary

One row per person for a pay period: days expected, days worked, regular hours, overtime, breaks, paid leave, holidays, unexplained absences. This is the base for the overtime check, the absences list, the close and the export.

## Steps

1. **Period.** From the request or `config.md`. Say it back with its dates.
2. **People.** `list_users` (`filter: ACTIVE`, `include_billing: true` only when cost is allowed). Keep `id`, `name`, `email`, `role`, `schedule` (hours per weekday: `mon`… `sun`; `mon_from`/`mon_to`… when the hours are empty), `lock_date`, and `billing.hourly_cost` if allowed. Drop people listed under *skip* in `config.md`.
3. **Time card per person.** `get_timecard` with `user_id`, `from`, `to`. One call per person, one person at a time. Keep only the day-level fields and discard `entries`; they add nothing payroll needs and make the context heavy. For each day keep:
   - `day`, `day_type` (`WORK_DAY`, `DAY_OFF`, `HOLIDAY`, `TIMEOFF`), `is_workable`
   - `regular_seconds`, `extra_seconds`, `break_seconds`, `timeoff_seconds`, `holiday_seconds`, `status`, `locked`
4. **Per-day numbers.**
   - Worked = `regular_seconds + extra_seconds`. Never `total_seconds` (it is the clock-in to clock-out span).
   - Expected = schedule hours for that weekday when `day_type` is `WORK_DAY`; 0 on `DAY_OFF` and `HOLIDAY`; on `TIMEOFF` days, schedule hours minus `timeoff_seconds` (0 for a full day off). No schedule → the default in `config.md`. Schedule with times but no hours → `to` minus `from`.
   - Overtime = `extra_seconds`, plus, when `config.md` turns it on, `max(0, worked − expected)` on work days.
   - Leave = `timeoff_seconds`. Paid or unpaid according to the type names in `config.md`; the type is in `list_timeoffs` (`time_off_type.name`) for the same range if you need to split it.
   - Holiday = `holiday_seconds`.
   - Day worked = worked ≥ the minimum in `config.md`.
   - Unexplained absence = `is_workable` true, `day_type` `WORK_DAY`, worked = 0, leave = 0.
5. **Period totals per person.** Sum the days. Apply rounding from `config.md` to the period totals only. Days expected = count of `WORK_DAY` days plus partial `TIMEOFF` days.
6. **Cost estimate** (only when `config.md` allows): worked hours × `hourly_cost`, overtime hours × `hourly_cost` × multiplier. Label it "estimate" every time.

For teams above ten people, say how many you will process, do them in order, and summarize each batch of five before the next; the final table comes last.

## Output

```
Payroll summary · October 2026 (1 to 31) · 16 people
Person   Days exp.  Days worked  Regular  Overtime  Breaks  Leave (paid)  Holidays  Absences
Ana      21         21           160:00   03:30     18:20   00:00         08:00     0
Bruno    21         17           128:15   00:00     12:05   32:00 (vac.)  08:00     0
Carla    21         19           150:40   01:15     14:00   00:00         08:00     2  ← see absences
Team     —          —            …
Source: TrackingTime time cards, read on 5 Nov 2026 10:12. Breaks excluded from worked hours. Overtime = work outside the schedule window.
```

Then offer the next step: the absences list if anything is unexplained, the overtime check if there is overtime, the close if the period is over, the CSV.

## Don'ts

- Don't show task names, projects or notes. Payroll needs hours, not what they were spent on.
- Don't compare people ("lowest hours", "most overtime"). The table is ordered by name.
- Don't quote `total_hours` or `total_seconds` from the time card as worked time.
- Don't present a number you couldn't compute. Write "n/a (no schedule)" or "n/a (call failed)" in the cell.
