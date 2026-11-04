# Breaks and lunch

TrackingTime counts the gap between two entries as a break in the Time Card. A break is therefore just "stop now, start again later" on the same task.

## Start a break

1. Find the running timer as described in `clock-in-out.md` › *Finding the running timer*. If none is running, say "You're not clocked in" and stop.
2. Confirm: "Pause *Task* for lunch?"
3. On yes: `stop_task` with `task_id`, `date` = now, `timezone`, `confirm: true`.
4. If `config.md` says to name breaks, keep the reason ("Lunch") in mind for the reply; do not create an extra entry for the break itself.
5. Reply: "Paused at 13:02. Tell me when you're back."

## Back from a break

1. Use the task that was paused (the last stopped entry today) unless the person names another.
2. `track_task` with that `task_id`, `timezone`, `stop_running_task: true`.
3. Reply with the length of the break: "Back on *Task* at 13:41 — 39 min break."
4. If the break was longer than the threshold in `config.md`, just state the length. Never scold.

## When the BREAK event type is available

TrackingTime is adding a dedicated BREAK event type. When the MCP exposes it, record breaks with it instead of the stop/start pair. Until then, the stop/start pair is correct and Time Cards will show the gap as a break.
