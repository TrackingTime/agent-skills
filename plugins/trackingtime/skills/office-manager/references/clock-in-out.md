# Clock in / clock out

## Clock in

1. Check whether a timer is already running (see "Finding the running timer" below).
   - If one is running, tell the person ("You're already on *Task* since 9:12") and ask whether to keep it or switch. Do not start a second one.
2. Decide the task:
   - If the person said what they'll work on, find it with `list_user_trackables` (`user_id`, `include_tasks: true`). Match by meaning, not only by exact words. If two tasks fit, ask which one.
   - Otherwise use the default task and project from `config.md`. If there is none, ask: "What are you starting with?"
3. Optional schedule check: `get_user_schedule` (`user_id`). If they clock in much earlier than their start time (threshold in `config.md`), mention it once, then proceed. Never block a clock in.
4. Confirm and start: `track_task` with `task_id` (or `task_name` + `project_id` for a new task the person approved), `timezone`, and `stop_running_task: true`.
5. Reply: "You're in at 9:04 on *Task* (Project)."

## Clock out

1. Find the running timer (see below). If nothing is running, say so and ask whether they forgot to clock in; offer to log the day with the *Fill my timesheet* workflow.
2. If the timer has run longer than the threshold in `config.md` (for example since yesterday), ask what time they actually stopped before closing it.
3. Ask for confirmation: "Clock you out of *Task* at 18:02?"
4. On yes: `stop_task` with `task_id`, `date` = now as `YYYY-MM-DD HH:MM:SS`, `timezone`, `confirm: true`.
5. Reply with the day's total: get it from `get_events_summary` (`from` = `to` = today, `filter: USER`, `id: <user_id>`) or by summing today's entries. Example: "Done. 7 h 48 m today. See you tomorrow."

## Switching task during the day

"Now I'm on the Acme proposal" = clock in on the new task with `stop_running_task: true`. Confirm in one line which task stopped and which started.

## Edge cases

- Time off today (`list_timeoffs` for the person, today): mention it and ask if they really want to clock in.
- Clocking in or out for a past time ("I started at 8:30"): `track_task` starts now, so for past times create the entry with `create_event` (`start`, `end`, `timezone`, `event_type: WORK`) after confirming, or tell them to fix it in the app.

## Finding the running timer

1. **Preferred:** `list_user_tasks` with `user_id` and `filter: TRACKING`. It returns the task(s) the person is tracking right now; a task with `tracking: true` carries its running entry in `tracking_event`.
2. **Fallback** (if that call fails or isn't available): `list_events` with `filter: USER`, `id: <user_id>`, `from` and `to` = today, `order: desc`, `page_size: 5`, `timezone`. An entry with no end (`e` empty) or an end in the future is running.
