# Connector notes (tested 2026-11-05)

What the TrackingTime MCP connector does and doesn't do today for project work.

## Projects and tasks

- `list_projects` (`filter: ACTIVE`, `page_size: 200`, paging) returns `estimated_time` in **hours** (`loc_estimated_time` `249:00`), `accumulated_time` in seconds, `delivery_date`, `customer`, `billing`, `accumulated_rate`, `accumulated_rate_billed`, `accumulated_cost`, `sum_estimates`, `is_template`, `is_retainer`.
- `get_project` with `include_tasks: true` and `include_task_lists: true` returns a project's tasks: loose tasks in `tasks`, grouped tasks in `task_lists[].tasks`, each with `due_date`, `estimated_time`, `accumulated_time`, `users` (with per-owner `accumulated_time` and `status`), `is_archived`, `list_id`. `coworkers` lists members.
- **Size problem**: that call includes archived tasks and weighs about 2 KB per task. Measured: 400,000 characters for a project with 171 tasks, 163,000 for one with 68. That exceeds what Claude and ChatGPT keep in a conversation. Use it only for small projects.
- **Lighter path**: `list_user_trackables` with `user_id`, `project_id` and `include_tasks: true` returns the active tasks of that project assigned to that person, about 150 bytes each. One call per member (`coworkers` from `get_project` without tasks), merged by task id. It misses tasks assigned to nobody.
- **Request to the connector team**: `get_project` should exclude archived tasks by default (or take `include_archived`) and accept a `fields` list, so a project's task list fits in one small call.
- `active_tasks` on the project can disagree with the tasks returned (15 reported, 13 non-archived tasks came back). Count the tasks; don't trust the field.
- `list_tasks` ignores `project_id`: it returns tasks from the whole account (100 per page). Don't use it for one project.
- `list_user_tasks` (`user_id`, `sort_by: "due_date"`) returns a person's tasks grouped by project, including tasks where the person is `INACTIVE` and `EVERYONE` tasks nobody picked up. Keep only tasks where the `user_id` is in `users[]` with `status: "ACTIVE"`. Without `filter`; `TRACKING` fails.
- `advanced_search` (`keyword`, 3+ characters) finds tasks and projects by text, with list name and description. It matches text, not the project name, and brings full HTML descriptions, so it's not a way to list a project's tasks. The `users` list repeats each owner many times; dedupe by id.
- `list_subtasks` (`task_id`) works. `list_user_groups` → "The action you requested doesn't exist"; teams come from `user_group_name` in `list_users`.
- Task-level `estimated_time` was 0 on every task in the test account, so its unit is unverified; after `update_task` read `loc_estimated_time` to check.

## Writes

- `create_project` (`name`, `customer_id` or `customer_name`, `estimated_time`, `is_public`), `create_task` (`name`, `project_id`, `users`, `description`, `is_billable`, `type`), `create_subtask`, `update_task` (`confirm`, `due_date`, `estimated_time`, `users`, `project_id`), `update_project` (`confirm`), `assign_user_projects`, `duplicate_project`, `archive_task` exist and were not exercised in testing. In an earlier test the assistant's own permission layer blocked `create_task`; that is the assistant, not the API.
- There is no tool to create a task list. Tasks can be moved into an existing list with `update_task` → `list_id`.
- `batch_update_tasks` is a destructive batch write; not exercised. One `update_task` per task is safer.
- `track_task` with `task_name` creates a nameless GHOST task; create tasks with `create_task`. Entries on GHOST tasks still show in `list_filtered_events` with a `tid` that isn't in the project's task list; report them as time on tasks not in the project list.

## Hours and money

- `list_filtered_events` filters take names in an array (`project`, `customer`, `user`, `is_billed`), not ids. `parameters` choose the fields (`project`, `task`, `user`, `is_billable`, `is_billed`, `notes`). No pagination; one month at a time on busy accounts.
- `list_project_times` ignores `project_ids`, `from` and `to`.
- Rates and costs are on projects (`billing`) and people (`list_users` with `include_billing: true`), not on entries.
- `get_events_summary` is empty and `get_events_stats` fails. Add up `d` yourself.

## Capacity

- `list_users` has each person's `schedule` and `user_group_name`. `list_holidays` ignores `year`; pass `from` and `to`. `list_timeoffs` with `status: APPROVED` returns `hours` per request.
