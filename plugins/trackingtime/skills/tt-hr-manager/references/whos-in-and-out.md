# Who's in and out

Two views for managers: **today** (who is working now, done, not started, on leave, not scheduled) and **the week** (who is out on which days, and holidays). It is not monitoring: status and hours, nothing about how people work. Holidays can be checked and added here too.

## Who may ask

Only people allowed by `config.md` (default: Admin or Project Manager). If `list_users` or company-wide event listing is denied for this person, explain that this view needs a manager role in TrackingTime and stop.

## Today

1. `list_users` (`filter: ACTIVE`) → everyone, with each person's `schedule`. Drop the people in *skip* in `config.md`.
2. **Today's hours:** `list_filtered_events` with `date_range: {period: "custom_range", start: today, end: today}` and `parameters: ["user"]`; one compact row per entry with `uid` and `d` (seconds); group by person. It has no pagination; on a big team, if the response is cut, ask again per group of people with a `user` filter (display names).
3. **Working now:** the running entry isn't in those lists. If the team has at most the number of people in `config.md`, call `list_user_tasks` (`user_id`, no filter) per person and mark those with a task where `tracking: true`. For bigger teams, skip it and say that "working now" is available on request per person. Don't use `filter: TRACKING`: it fails today.
4. `list_timeoffs` with `from` = `to` = today; keep `time_off_status` `APPROVED` or `AUTO_APPROVED`.
5. `list_holidays` with `from` = `to` = today. If today is a holiday for everyone, say so and stop grouping.
6. Put each person in one group:
   - **Working now** — tracking right now (step 3). Show since when.
   - **Done for today** — has entries, none running. Show hours.
   - **Not started** — no entries yet and today is a working day for them (schedule hours for today's weekday above 0, no leave, no holiday).
   - **On leave** — approved time off today. Say "on leave" only, never the type or reason, unless `config.md` allows it.
   - **Not scheduled today** — no entries and not a working day.

A short list per group with names and times, then one line with counts ("8 in, 2 done, 1 not started, 1 on leave"). No tasks, projects or notes unless `config.md` allows it **and** the manager asks.

## The week

1. Range: this week by default (Monday to Sunday), or the dates asked.
2. `list_timeoffs` with `from`, `to`. Approved requests are **out**; pending ones are **requested** and are shown as such to managers only.
3. `list_holidays` with `from`, `to`. Each holiday has `date`, `name`, `country` and `users` (empty = everyone).
4. Show per day:

```
This week
Mon 9 · Holiday: Visita papal
Tue 10 · Lucía out (requested, not approved yet)
Wed 11 · —
Thu 12 · —
Fri 13 · Maxi out (afternoon)
```

Say "out", not the type of leave, unless `config.md` allows it.

## Is a date a holiday?

`list_holidays` with `from` = `to` = that date. Pass `from` and `to`; the `year` filter is ignored by the connector.

## Add a holiday

1. Confirm: "Add 'Company day' on 24 December as a holiday for everyone?"
2. On yes: `create_holiday` with `date` (`YYYY-MM-DD`) and `name`. The tool has no `confirm` flag, so the yes in the chat is the gate.
3. `update_holiday` and `delete_holiday` work the same way for changes.

## Don'ts

- Don't show reasons or notes from requests.
- Don't mark someone as out from anything other than an approved request or a holiday.
- Never suggest reprimands or rank people. To remind those who haven't started, use *Reminders and escalation* after an hours check; don't improvise a message from this view.
