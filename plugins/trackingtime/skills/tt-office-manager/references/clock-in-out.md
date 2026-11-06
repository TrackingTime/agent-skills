# Clock in / clock out

## Clock in

1. Check whether a timer is already running (see "Finding the running timer" below).
   - If one is running, tell the person ("You're already on *Task* since 9:12") and ask whether to keep it or switch. Do not start a second one.
2. Decide the task:
   - If the person said what they'll work on, find it with `list_user_trackables` (`user_id`, `include_tasks: true`). Match by meaning, not only by exact words. If two tasks fit, ask which one.
   - Otherwise use the default task and project from `config.md`. If there is none, ask: "What are you starting with?"
   - If the task doesn't exist yet and the person approves a new one: `create_task` with `name` and `project_id` first, then track its `task_id`. Never start a new task through `track_task` with `task_name`: it creates a task without a name.
3. Optional schedule check: `get_user_schedule` (`user_id`). If they clock in much earlier than their start time (threshold in `config.md`), mention it once, then proceed. Never block a clock in.
4. Confirm and start: `track_task` with `task_id`, `timezone`, and `stop_running_task: true`.
5. Reply: "You're in at 9:04 on *Task* (Project)."

## Clock out

1. Find the running timer (see below). If nothing is running, say so and ask whether they forgot to clock in; offer to log the day with the *Fill my timesheet* workflow.
2. If the timer has run longer than the threshold in `config.md` (for example since yesterday), ask what time they actually stopped before closing it.
3. Ask for confirmation: "Clock you out of *Task* at 18:02?"
4. On yes: `stop_task` with `task_id`, `date` = now as `YYYY-MM-DD HH:MM:SS`, `timezone`, `confirm: true`.
5. Reply with the day's total: `list_events` (`filter: USER`, `id: <user_id>`, `from` = `to` = today, `timezone`) and add up `d` (seconds). The entry you just stopped is included. Example: "Done. 7 h 48 m today. See you tomorrow."

## Switching task during the day

"Now I'm on the Acme proposal" = clock in on the new task with `stop_running_task: true`. Confirm in one line which task stopped and which started.

## Edge cases

- Time off today (`list_timeoffs` with `user_id`, `from` = `to` = today): mention it and ask if they really want to clock in.
- Clocking in or out for a past time ("I started at 8:30"): `track_task` starts now, so for past times create the entry with `create_event` (`start`, `end`, `timezone`, `event_type: WORK`, `task_id`) after confirming, or tell them to fix it in the app.

## Finding the running timer

1. `list_user_tasks` with `user_id` and no `filter`. The task with `tracking: true` is the one running; `users[].event.id` is its entry and `start_date` is when it began.
2. If you already know the task, `get_task` shows the same `tracking` flag.
3. Don't use `filter: TRACKING` (it fails today) and don't rely on `list_events`: the running entry isn't listed until it stops. See `connector-notes.md`.
