# Connector notes (tested 2026-11-05)

What the TrackingTime MCP connector does and doesn't do today for payroll work.

## Time cards

- `get_timecard` (`user_id`, `from`, `to`) computes the time card live from the entries and works for past ranges and, for Admins, for other people. One object per calendar day with `day_type` (`WORK_DAY`, `DAY_OFF`, `HOLIDAY`, `TIMEOFF`), `is_workable`, `regular_seconds`, `extra_seconds`, `break_seconds`, `timeoff_seconds`, `holiday_seconds`, `status`, `locked`.
- `total_seconds` / `total_hours` is the span from first clock-in to last clock-out, breaks included. Worked time is `regular + extra`.
- `entries` inside each day carry `type` (`null` = work, `BREAK_HOURS`, `EXTRA_HOURS`, `TIMEOFF_HOURS`, `HOLIDAY_HOURS`), `in`, `out` and no task or notes. Work entries show `duration: 0`; use the day fields.
- Extra time is what falls outside the schedule window (`mon_from`/`mon_to`…) and anything worked on a day off or holiday. On a `DAY_OFF` or `HOLIDAY` day the worked time is all in `extra_seconds`.
- A month for one person is a large response (31 days with entries). Call one person at a time and keep only the day fields.
- `generate_timecard` returns the same computed days; `save_days: true` would store them (not exercised). Leave `save_days` out.
- `list_timecards` needs `users: [{"id": N}, …]` (a bare list of numbers fails). It returns `status`, `total_working_days`, `total_pending_days` and so on, but `regular_seconds` and friends stay at 0 and `timecard_days` is empty unless days were saved or submitted. Use it for status, not for hours.
- `get_timecards_count` (`from`, `to`) works: `{"submitted": N, "pending_submission": N}`.
- `export_timecards` is unusable: the connector rejects any `data` value, and without it the API says `data` is missing. Build the CSV from `get_timecard`.
- `list_timecard_logs` → "The action you requested doesn't exist".
- `lock_user_events` (`data: [{user_id, lock_date}]`, `confirm: true`) and `save_timecard_day` were not exercised in testing. Verify a lock with `list_users` → `lock_date`.

## Schedules and people

- `list_users` returns each person's `schedule` (hours per weekday and from/to times), `lock_date`, `role`, and with `include_billing: true` the `billing.hourly_rate` and `billing.hourly_cost`.
- Some schedules have hours empty but from/to times set (summer schedules); expected hours are `to − from`. Some people have no schedule at all.
- The Time Cards settings are in `get_me` → `apps[key = "timecards"].settings`: `timecard_range`, `monthly_close_date`, `allow_breaks` (minutes), `allow_extras`, `allow_timeoffs`, `needs_approval`, `auto_submit_timecards`.
- The tracking policy is in `get_me` → `apps[key = "policies"].settings`: `avoid_tracking_overtime`, `allow_nonwork_day_tracking`, `max_hours`.
- `get_account` is very large (every app and setting); `get_me` already has what this skill needs.

## Leave and holidays

- `list_timeoffs` with `from`, `to` and `status` (`APPROVED` or `PENDING`) works; rows carry `time_off_type.name`, `time_off_type.unit` (`WORKING_DAYS` or `HOURS`), `hours`, `working_day_amount`, `is_all_day`, `time_off_status` (`APPROVED`, `AUTO_APPROVED`, `PENDING`…).
- `list_holidays` ignores `year`; pass `from` and `to`. Account holidays can apply to a subset of people (`users` empty = everyone).
- `list_timeoff_balances` returns every cycle for every policy; pick the cycle that covers the period.
- `list_filtered_events` with `include_timeoffs: true` adds `TIME_OFF_DEFAULT` rows (`toi` = request id, `pdf` = deductible amount) and `HOLIDAY_DEFAULT` rows with a `users` list. Useful for a quick overview of a week; the time card is still the source for payroll numbers.
- `list_filtered_events` accepts `rounding: {"by": 15, "method": "round"}`. Its `filters` by `user` don't work (a string is rejected, an array returns nothing).

## Expenses

- `list_expenses` (`spent_date_from`, `spent_date_to`) and `list_expense_categories` respond but were empty on the test account, so the row shape is unverified. Reimbursements are the Account Manager's area anyway.

## Summaries

- `get_events_summary` returns an empty result and `get_events_stats` fails. Sum the day fields yourself.
