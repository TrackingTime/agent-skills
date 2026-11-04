# Who's in today (managers)

Gives a manager a simple attendance view. It is not monitoring: it shows status and hours, nothing about how people work.

## Who may ask

Only people allowed by `config.md` (default: Admin or Manager role). If `list_users` or company-wide `list_events` is denied for this person, explain that this view needs a manager role in TrackingTime and stop.

## Steps

1. `list_users` (`filter: ACTIVE`) → everyone in the team.
2. **Working now:** `list_tasks` with `filter: TRACKING` when the connector offers it — one call returns every task being tracked across the company, each with its user. If it doesn't, use `list_user_tasks` (`filter: TRACKING`) per person.
3. **Today's hours:** `list_events` with `filter: COMPANY`, `from` = `to` = today, `timezone`, `order: asc` (paginate with `page` until a page comes back with fewer items than `page_size`).
4. `list_timeoffs` with `from` = `to` = today (approved ones only, if `status` allows filtering).
5. Optionally `get_user_schedule` for people with no entries, to know whether today is a working day for them.
6. Put each person in one group:
   - **Working now** — tracking right now (step 2). Show since when.
   - **Done for today** — has entries, none running. Show hours.
   - **Not started** — no entries yet and today is a working day for them.
   - **On leave** — has approved time off today. Show "on leave" only, never the type or reason unless `config.md` allows it.
   - **Not scheduled today** — no entries and not a working day.

## Output

A short list per group with names and times, then one line with counts ("8 in, 2 done, 1 not started, 1 on leave"). Do not show tasks, projects or notes unless `config.md` allows it **and** the manager asks.

Never suggest reprimands or rank people. If the manager asks to remind those who haven't started, say that reminders are the job of the **HR Manager** agent and, if a Slack or Teams connector is available here, offer to draft a friendly message for them to send.
