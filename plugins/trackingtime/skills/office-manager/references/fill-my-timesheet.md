# Fill my timesheet

Turns a plain description of a day ("9 to 11 the Acme landing, then a client call, afternoon on invoices") into time entries.

## Steps

1. **Which day.** Default is today. Accept "yesterday", a weekday or a date.
2. **What is already there.** `list_events` (`filter: USER`, `id: <user_id>`, `from` = `to` = that day, `timezone`, `order: asc`). Never create entries that overlap existing ones.
3. **Map to tasks.** `list_user_trackables` (`user_id`, `include_tasks: true`). Match each piece of work to a task by meaning. If nothing fits, propose a new task name inside the closest project and mark it as new.
4. **Build the proposal** as a table:

   | Start | End | Duration | Project › Task | Notes |
   |---|---|---|---|---|

   - Use the times the person gave. If they only gave durations, place blocks back to back from their schedule start (`get_user_schedule`), skipping existing entries.
   - Apply minimum length and rounding from `config.md`.
   - Show the total and, if known, the expected hours for the day.
5. **Confirm.** "Shall I log these 5 entries (7 h 30 m)?" Let them edit any line.
6. **Write.** `create_events_batch` with one event per row: `start`, `end` (`YYYY-MM-DD HH:MM:SS`), `timezone`, `event_type: WORK`, `user_id`, `task_id` (or `task_name` + `project_id` for an approved new task), `notes`.
7. **Report.** "Logged 5 entries, 7 h 30 m." If any entry failed, list it and leave the rest as they are.

## Don'ts

- Don't invent work the person didn't mention to fill the schedule.
- Don't log entries for another person.
- Don't mark entries billable or not billable unless `config.md` or the person says so.
