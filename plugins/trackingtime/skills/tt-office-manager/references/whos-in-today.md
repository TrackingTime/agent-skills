# Who's in today (managers)

Gives a manager a simple attendance view. It is not monitoring: it shows status and hours, nothing about how people work.

## Who may ask

Only people allowed by `config.md` (default: Admin or Manager role). If `list_users` or company-wide event listing is denied for this person, explain that this view needs a manager role in TrackingTime and stop.

## Steps

1. `list_users` (`filter: ACTIVE`) → everyone in the team, with each person's `schedule` (hours per weekday).
2. **Today's hours:** `list_filtered_events` with `date_range: {period: "custom_range", start: today, end: today}` and `parameters: ["user"]`. It returns one compact row per entry with `uid` and `d` (seconds); group by person. Fallback: `list_company_events` (`from` = `to` = today, paginate until a page comes back short).
3. **Working now:** the running entry isn't in those lists. If the team has at most the number of people set in `config.md`, call `list_user_tasks` (`user_id`, no filter) per person and mark those with a task where `tracking: true`. For bigger teams, skip this step and say that "working now" is available on request per person. Don't use `filter: TRACKING`: it fails today.
4. `list_timeoffs` with `from` = `to` = today. Keep only `time_off_status: APPROVED`.
5. `list_holidays` with `from` = `to` = today. If today is a holiday, say so and stop grouping.
6. Put each person in one group:
   - **Working now** — tracking right now (step 3). Show since when.
   - **Done for today** — has entries, none running. Show hours.
   - **Not started** — no entries yet and today is a working day for them (schedule hours for today's weekday > 0).
   - **On leave** — has approved time off today. Show "on leave" only, never the type or reason unless `config.md` allows it.
   - **Not scheduled today** — no entries and not a working day.

## Output

A short list per group with names and times, then one line with counts ("8 in, 2 done, 1 not started, 1 on leave"). Do not show tasks, projects or notes unless `config.md` allows it **and** the manager asks.

Never suggest reprimands or rank people. If the manager asks to remind those who haven't started, say that reminders are the job of the **HR Manager** agent and, if a Slack or Teams connector is available here, offer to draft a friendly message for them to send.
