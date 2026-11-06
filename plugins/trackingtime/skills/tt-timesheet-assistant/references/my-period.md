# My period

The person's own hours for a period: worked, expected, overtime, and the working days with nothing logged. Only for the `user_id` from `get_me`.

## Period

Default from `config.md` (this month up to today), or the one asked ("this week", "October", "last two weeks"). Say it back with its dates. Days after today are never counted.

## Source

`get_me` → `apps[key = "timecards"].status`:

- **`on`**: `get_timecard` with the person's `user_id`, `from`, `to`. One object per day: `day_type`, `is_workable`, `regular_seconds`, `extra_seconds`, `break_seconds`, `timeoff_seconds`, `holiday_seconds`. Worked = `regular + extra`. Overtime = `extra_seconds` (time outside the schedule window, and anything on a day off or holiday). Ignore `total_seconds`: it is the clock-in to clock-out span.
- **Otherwise** (Time Cards are a Pro Plan feature): `list_events` with `filter: USER`, `id: <user_id>`, `from`, `to`; group by the date in `s` and sum `d`. Say in the reply that this count has no break or overtime split, because that needs Time Cards.

A running timer is in neither source until it stops (`list_user_tasks`, no filter, `tracking: true`). Mention it as "still running since HH:MM", not as hours.

## Expected hours and missing days

Follow `missing-day.md`: working days from the schedule, minus holidays and approved time off; expected hours per working day; a day is missing when worked is under the minimum in `config.md`. Pending time off on a day shows as "requested, pending approval".

## Output

```
November so far (1 to 5) · 3 working days
Worked 22:10 · expected 24:00 · overtime 01:30 (Tue 3, after 18:00)
Missing: Wed 4 (nothing logged)
Timer running since 14:05 on "Landing page"
```

Then offer what fits: *Fill my timesheet* for a missing day, clock out for a running timer, or the time off request if a missing day was actually a day off.

## Don'ts

- Don't show or compare anyone else's hours, even if asked "am I below the team?". That view belongs to the HR Manager.
- Don't present overtime as good or bad. It's a number from the time card.
- Don't show cost or rates.
