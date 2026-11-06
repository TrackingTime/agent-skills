# Project status

Where one project stands: hours against the estimate, delivery date, open and overdue tasks, who is on it, and what moved in the period.

## Steps

1. **Project.** Match the name against `list_projects` (`filter: ACTIVE`, `page_size: 200`); if several match, ask. Keep `estimated_time` (hours), `accumulated_time` (seconds), `delivery_date`, `customer`, `billing.is_billable`, `is_retainer`.
2. **Tasks.** `get_project` with `include_tasks: true` and `include_task_lists: true`. Loose tasks are in `tasks`; tasks inside lists are in `task_lists[].tasks`. For each task: `name`, `is_archived`, `due_date`, `estimated_time`, `accumulated_time`, `users` (owner `status` `ACTIVE`/`INACTIVE`, `accumulated_time` per owner), `list_name`.
3. **Period activity** (default: this week, or the range asked): `list_filtered_events` with `date_range`, `parameters: ["project", "task", "user"]`, `filters: [{"by": "project", "operator": "is", "value": ["<project name>"]}]`. Sum `d` per task and per person.
4. **Numbers.**
   - Used = `accumulated_time` ÷ 3600. Used % = used ÷ estimate when the estimate is above 0; otherwise "no estimate".
   - Remaining = estimate − used (can be negative: "over by N h").
   - Days to delivery = `delivery_date` − today; none → "no delivery date".
   - Open tasks = active tasks; overdue = open with `due_date` before today; due this week; unowned = no owner with status `ACTIVE`.
   - Retainer projects: show the current cycle from `get_project` → `current_retainer_cycle` instead of the all-time estimate (see the Account Manager agent for cycles).
5. Warnings from `config.md`: used % at or above the threshold; delivery within N days with open tasks; overdue tasks; unowned tasks.

## Output

```
Website redesign · Acme · delivery 19 Dec (44 days)
Estimate 120 h · used 93:30 (78%) · remaining 26:30
Tasks: 14 open · 3 overdue · 2 unowned · 9 archived
This week: 18:15 logged (Ana 10:00, Bruno 8:15) on 4 tasks
Overdue: Wireframes (Ana, due 21 Nov) · Copy v1 (Bruno, due 28 Nov) · Legal review (unowned, due 1 Nov)
Warnings: used hours near the estimate (78% of 120 h, threshold 80%)
```

Then offer: reassign or reschedule the overdue ones (`project-from-brief.md`, "Changes"), or the profitability view.

## Don'ts

- Don't call a project "at risk" or "healthy". Give the numbers and the warnings `config.md` defines.
- Don't attribute overrun to a person. "Wireframes: 22 h of 16 h estimated" is the sentence.
- Don't use `list_tasks` for a project's tasks; it ignores the project filter.
