# Overtime check

Who has overtime in the period, how much, and on which days. Hours only; whether and how overtime is paid is for `config.md` and the payroll system.

## What counts

TrackingTime's time card marks as **extra** (`extra_seconds`, entry type `EXTRA_HOURS`) the time outside the person's schedule window (before `mon_from`, after `mon_to`, and so on) and every minute worked on a `DAY_OFF` or `HOLIDAY`. That is the default definition here.

`config.md` can add two more rules:

- **Daily total**: hours over the schedule's hours for that weekday count as overtime even if inside the window.
- **Weekly threshold**: hours over N in a week (weeks as in `config.md`) count as overtime.

When more than one rule applies, report each line separately; don't add them up into one number.

## Steps

1. Run the period summary (`period-summary.md`) if it isn't in this conversation; keep the per-day numbers.
2. For each person with overtime, list the days: date, overtime that day, why (`outside window`, `day off`, `holiday`, `over daily hours`, `over weekly threshold`).
3. Check the tracking policy in `get_me` → `apps[key = "policies"].settings`: `avoid_tracking_overtime` and `allow_nonwork_day_tracking`. If the policy blocks overtime but the time card shows some, say so: the entries were probably added by hand after the fact, which is allowed, but payroll may want to know.
4. Pending approvals: TrackingTime has no overtime approval flow yet. If `config.md` names someone who approves overtime, list the days for them and stop there.

## Output

```
Overtime · October 2026
Ana · 03:30 total
  Tue 14 Oct  01:30  outside window (18:00 to 19:30)
  Sat 25 Oct  02:00  day off
Carla · 01:15 total
  Thu 30 Oct  01:15  outside window
No overtime: 14 people.
Policy: overtime tracking is blocked by the account policy; these entries were added manually.
```

## Don'ts

- Don't call overtime "excessive" or "unusual". State hours and dates.
- Don't guess why someone worked late. If the person is in the chat, they can say.
- Don't apply a pay multiplier unless `config.md` sets one, and then only inside a cost estimate.
