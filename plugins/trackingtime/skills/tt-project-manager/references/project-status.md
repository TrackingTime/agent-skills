# Project status

Where one project stands: hours against the estimate, delivery date, open and overdue tasks, who is on it, and what moved in the period.

## Steps

1. **Project.** Match the name against `list_projects` (`filter: ACTIVE`, `page_size: 200`); if several match, ask. Keep `estimated_time` (hours), `accumulated_time` (seconds), `delivery_date`, `customer`, `billing.is_billable`, `is_retainer`.
2. **Tasks.** Two ways, pick by size:
   - **Small project** (`active_tasks + archived_tasks` from `list_projects` under about 40): `get_project` with `include_tasks: true` and `include_task_lists: true`. Loose tasks are in `tasks`; tasks inside lists are in `task_lists[].tasks`. For each task: `name`, `is_archived`, `due_date`, `estimated_time`, `accumulated_time`, `users` (owner `status` `ACTIVE`/`INACTIVE`, `accumulated_time` per owner), `list_name`. Drop `is_archived: true` tasks yourself; the call returns them too.
   - **Anything bigger**: that call returns every task ever, archived included, at about 2 KB each (a project with 171 tasks came back as 400,000 characters), which breaks the conversation. Use `get_project` **without** tasks for the header and `coworkers`, then one `list_user_trackables` per member with `user_id`, `project_id` and `include_tasks: true`: it returns only active tasks assigned to that person, about 150 bytes each (`id`, `name`, `estimated_time`, `accumulated_time`, `due_date`). Merge by task `id`. Say that tasks assigned to nobody aren't in this view and that `accumulated_time` there is the member's own time; the project total comes from the header.
   - Count open tasks from the list you built. The project's `active_tasks` field can differ from it (15 vs 13 in a test); use the count.
3. **Period activity** (default: this week, or the range asked): `list_filtered_events` with `date_range`, `parameters: ["project", "task", "user"]`, `filters: [{"by": "project", "operator": "is", "value": ["<project name>"]}]`. Sum `d` per task and per person. Rows whose `tid` isn't in the task list you built (tasks of type `GHOST`, created by a timer with only a name, or tasks assigned to nobody) are added up into one line, **time on tasks not in the project list**, with their names from `t`; don't drop them and don't invent a task for them.
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
- Don't ask for a big project's tasks through `get_project`; see step 2.
