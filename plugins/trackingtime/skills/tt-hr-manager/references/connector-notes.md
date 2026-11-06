# Connector notes (tested 2026-11-04)

What the TrackingTime MCP connector does and doesn't do today for HR work.

## Entries and presence

- `list_filtered_events` (`date_range` with `period: "custom_range"`, `parameters: ["user"]`) is the compact way to see who has entries in a range: one row per entry with `uid`, `s`, `e`, `d`. It has no pagination, so query one week at a time on larger teams.
- `list_filtered_events` `filters` work with display names, not ids: `{"by": "user", "operator": "is", "value": ["Ana García"]}`. An id returns nothing and a bare string is rejected.
- `list_events` with `filter: USER` is the cheap call for one person over a range. The time part of `from`/`to` is ignored; whole days come back.
- Running timers are not in either list until they stop. A person with only a running timer looks like "no entries yet".
- `get_events_summary` returns an empty result; `get_events_stats` fails. Add up `d` yourself.
- Time Cards (`get_timecard`, `list_timecards`) lag behind the day's entries. Don't use them to decide whether today is logged.

## Time off

- `list_timeoff_policies` fails (the connector doesn't send the `status` the API wants). Get the person's policies from `list_timeoff_balances` instead.
- `get_timeoff_balance` returns only `{"status": "SYNCED"}`. Use `list_timeoff_balances` and pick the current cycle.
- `calculate_timeoff_amount` needs `from` and `to` with a time (`YYYY-MM-DD HH:MM:SS`); a bare date is rejected.
- `list_timeoffs` accepts `status: PENDING` (or `APPROVED`) and `user_id`. Check `time_off_status` in each row anyway.
- `approve_timeoff` needs the `token` from the approval email. Try `update_timeoff` with `status` first.

## Holidays and schedules

- `list_holidays` ignores `year`; pass `from` and `to`.
- `list_users` already includes each person's `schedule`; `get_user_schedule` returns the same for one person. `list_schedules` returns every schedule with its members.

## Messaging

- There is no `send_reminder` tool yet. Use the assistant's Slack or Teams connector, or hand the text to the person.
- `add_task_comment` fails. Don't use task comments as a channel.
