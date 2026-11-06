# Team workload

Who has room this week and who is over: capacity from schedules, hours logged, open tasks and what's due. A planning view, not a scoreboard.

## Steps

1. **Week.** Default: the current week, Monday to Sunday as in `config.md`. Say the dates back.
2. **People.** `list_users` (`filter: ACTIVE`): `id`, `name`, `user_group_name` (team), `schedule` (hours per weekday). Drop the people in *skip*. Filter by team when asked.
3. **Capacity** per person = sum of schedule hours over the week's days, minus hours for holidays (`list_holidays` with `from`/`to`; a holiday with an empty `users` list applies to everyone) and approved time off (`list_timeoffs` with `from`, `to`, `status: APPROVED`; use `hours` on the request). No schedule → the default in `config.md`.
4. **Logged** per person = `list_filtered_events` for the week with `parameters: ["user", "project"]`, sum `d` by `uid`, and by project for the detail. Running timers aren't included.
5. **Open work** per person (only when the team is within the size in `config.md`): `list_user_tasks` with `user_id`, `sort_by: "due_date"`, `page_size: 50`. Count open tasks, those due this week, and those overdue (`due_date` before today). One call per person.
6. **Reading** (thresholds from `config.md`):
   - over capacity: logged > capacity × (1 + margin), or planned hours on due tasks exceed the remaining capacity;
   - has room: logged below the share of capacity by mid-week with few open tasks;
   - otherwise: on plan.
   Leave is capacity, not absence: a person on leave two days has a smaller capacity, not a "low" week.

## Output

```
Workload · 3 to 9 Nov 2026 · Product team (6)
Person   Capacity  Logged (Mon–Wed)  Open tasks  Due this week  Overdue  Reading
Ana      40:00     26:30             7           3              1        over capacity
Bruno    32:00     12:00             4           1              0        on plan (1 day leave)
Carla    40:00     6:15              2           0              0        has room
…
Due this week with no owner: 2 tasks in Website redesign
```

Then offer: move a task from someone over to someone with room (`project-from-brief.md`, "Changes"), after they say which.

## Don'ts

- Don't rank by hours, and don't label anyone "underperforming" or "most productive". The readings are about capacity.
- Don't read hours logged as hours worked when the week isn't over; say which days are in.
- Don't pull task names into the table for people outside the viewer's projects unless the viewer is an Admin.
