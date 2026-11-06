# Missing day · shared definition

One definition of "a working day with nothing logged", used by the Timesheet Assistant (*My period*), the HR Manager (*Hours check*, *Compliance report*) and the Payroll Assistant (*Absences*). The three copies of this file are identical and `scripts/check-shared-refs.sh` in the repo fails when they drift; change all three together. The minimum below has the same key name in the three `config.md` files.

## 1. Working days

For each person and each calendar day in the range:

- **Schedule.** `schedule` from `list_users` (or `get_user_schedule` for one person) gives hours per weekday (`mon`… `sun`). Hours above 0 for that weekday → working day, expected = those hours. A schedule with only `mon_from`/`mon_to` times → expected = `to` − `from`. No schedule → the default in `config.md` (hours per day and weekdays).
- **Holidays.** `list_holidays` with `from` and `to` (the `year` filter is ignored). A holiday with an empty `users` list applies to everyone; otherwise only to the people listed. A holiday removes the day.
- **Approved time off.** `list_timeoffs` with `from`, `to`, `status: APPROVED`; keep rows whose `time_off_status` is `APPROVED` or `AUTO_APPROVED`. A full day (`is_all_day: true`, or `hours` at or above the expected hours) removes the day. A partial request keeps the day with expected = expected − `hours`.
- Days after today never count. Today counts only when the workflow's `config.md` sets a cut-off time and it has passed; before that, report today as **still open**.

## 2. Worked time per day

Pick the source once per conversation from `get_me` → `apps[key = "timecards"].status`:

- **Time Cards on**: `get_timecard` with `user_id`, `from`, `to`. Worked = `regular_seconds + extra_seconds`. Never `total_seconds` (clock-in to clock-out span). `day_type` already marks `HOLIDAY`, `TIMEOFF` and `DAY_OFF` days; still apply step 1 for partial leave and for people without a schedule.
- **Time Cards off**: `list_filtered_events` with `date_range: {period: "custom_range", start, end}` and `parameters: ["user"]`; group rows by `uid` and by the date part of `s`, sum `d` (seconds). For one person, `list_events` with `filter: USER`, `id`, `from`, `to` is cheaper. Say that this count has no break or overtime split.

**Running timers** are in neither source until they stop. When a workflow needs them, `list_user_tasks` (`user_id`, no filter) → a task with `tracking: true`. Report them as "timer running since HH:MM", never as hours, and never turn a day with only a running timer into a logged day.

## 3. Missing

A working day (step 1) is **missing** when its worked time (step 2) is below the minimum in `config.md`:

> A day counts as logged when it has at least this many minutes of worked time: [1]

Before deciding, check `list_timeoffs` with `status: PENDING` for the range: a pending request that covers the day makes it **requested, pending approval**, not missing. A partial pending request doesn't change the day.

## 4. Words to use

`missing` · `requested, pending approval` · `on leave` · `holiday` · `not scheduled` · `still open` (today, before the cut-off) · `timer running`. Streaks, percentages and groupings are each workflow's business; the per-day verdict comes only from here.
