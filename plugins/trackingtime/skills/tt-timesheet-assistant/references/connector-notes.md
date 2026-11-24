# Connector notes (tested 2026-11-04)

What the TrackingTime MCP connector does and doesn't do today. Read this before improvising a different call.

## Finding the running timer

- `list_user_tasks` with `user_id` and **no filter** returns the person's active tasks. The one being tracked has `tracking: true`, and `users[].event.id` is the running entry. This is the reliable way.
- `get_task` with a known `task_id` shows the same `tracking` flag.
- `filter: TRACKING` fails: `list_user_tasks` returns a 500 and `list_tasks` doesn't accept the value. Don't use it until the connector is fixed.
- `list_events` and `list_filtered_events` **don't return the running entry**. It appears only after it is stopped. So "no entry without an end" does not mean "no timer running".

## Day totals

- `get_events_stats` fails. Sum the `d` field (seconds) of `list_events` instead.
- `get_timecard` and `generate_timecard` for the current day lag behind entries created or edited later in the day. Use them for past days, never for "today".
- `list_events` ignores the time part of `from` and `to`: it returns the whole day. Filter by time yourself.

## Writing entries

- `create_events_batch` fails ("the action you requested doesn't exist"). Create entries one by one with `create_event`.
- `track_task` with `task_name` creates a task **without a name**. For a new task, call `create_task` (`name`, `project_id`) first, then `track_task` with the new `task_id`. `update_task` can't rename a task.
- `add_task_comment` fails ("You need to enter some text first"). Don't offer to comment on tasks.

## Very short timers

- Two test timers stopped after 16 seconds and about 1.5 minutes did not persist as entries; manual entries of 15 and 20 minutes did. If someone clocks in and out within a couple of minutes, check `list_events` before confirming that anything was recorded.

## Breaks

- The Time Cards setting `allow_breaks` (minutes) decides which gaps count as breaks. Read it from `get_me` → `apps` → the item with `key: "timecards"` → `settings.allow_breaks`. A gap shorter than that is merged into the work block.

## Other

- `list_holidays` ignores `year`; pass `from` and `to`.
- `list_timecards` needs `users: [{"id": <user_id>}]`.

## Time off (for the request workflow)

- `list_timeoff_policies` fails (the connector doesn't send the `status` the API wants). Get the person's policies from `list_timeoff_balances` instead.
- `get_timeoff_balance` returns only `{"status": "SYNCED"}`. Use `list_timeoff_balances` and pick the cycle that covers today.
- `calculate_timeoff_amount` needs `from` and `to` with a time (`YYYY-MM-DD HH:MM:SS`); a bare date is rejected.
- `list_holidays` ignores `year`; pass `from` and `to`.

## Time cards (for My period)

- `get_timecard` computes the days live: `regular_seconds`, `extra_seconds`, `break_seconds`, `timeoff_seconds`, `holiday_seconds`, `day_type`. Worked = regular + extra; `total_seconds` is the clock-in to clock-out span. Today's time card can lag behind entries made in the last minutes.
- Whether Time Cards are on: `get_me` → `apps[key = "timecards"].status`.
