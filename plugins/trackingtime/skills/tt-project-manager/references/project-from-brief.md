# Project from a brief

Turn a few sentences into a project with tasks, owners, due dates and an estimate. Show the plan, get one yes, create in order, read it back.

## Reading the brief

Pull out, and ask only for what is missing and required:

- **Project name**; apply the naming convention in `config.md`.
- **Customer**: match against `list_customers` (`filter: ACTIVE`) by name, case-insensitive. No match → offer to create it (`create_customer`) or to go without, unless the tracking policy requires a customer.
- **Estimate** in hours, if given. **Delivery date**, if given.
- **Tasks**: one line each, with owner(s), due date, estimate, billable, and the list (phase) they belong to when the brief has phases.
- **Owners**: match names against `list_users` (`filter: ACTIVE`). An unknown name stops the plan; ask.
- **Template**: a project named as the base ("like the Globex onboarding") → `duplicate_project` instead of creating tasks one by one.

## The plan

Show it in full before any call:

```
Project: Website redesign · customer Acme · public · estimate 120 h · delivery 19 Dec 2026
Members: Ana, Bruno, Carla
Tasks (8):
  Discovery
    1. Kick-off and goals            Ana         due 10 Nov   4 h
    2. Content inventory             Bruno       due 14 Nov   8 h
  Design
    3. Wireframes                    Ana         due 21 Nov  16 h
    …
Create it?
```

Task lists can't be created through the connector; phases are shown here and the tasks are named `Discovery · Kick-off and goals` when `config.md` wants phases in the name, or the person creates the lists in the web app afterwards and drags the tasks in.

## Creating, in order

1. `create_project`: `name`, `customer_id` (or `customer_name`), `estimated_time` (hours), `is_public`. Keep the returned `id`.
2. `assign_user_projects` for each owner who isn't a member yet (`user_id`, `project_ids: [id]`). Members from `get_project` → `coworkers`.
3. `create_task` per task: `name`, `project_id`, `users` (ids), `description`, `is_billable`, `type` (`PERSONAL` with owners, `EVERYONE` without). Keep each id.
4. `update_task` with `confirm: true` for `due_date` (`YYYY-MM-DD`) and `estimated_time` where given; the create call doesn't take them.
5. `create_subtask` (`task_id`, `name`) for sub-items.
6. From a template: `duplicate_project` (`project_id`, `name`), then `update_project` (`confirm: true`) for customer, estimate and delivery date, then `get_project` with tasks and adjust owners with `update_task`.
7. Read back: `get_project` with `include_tasks: true`, `include_task_lists: true`. Report name, id, task count, and anything that didn't land.

Stop at the first failure. Say what exists already (ids) and what is left, so a retry doesn't duplicate.

More tasks than the limit in `config.md`: create the first batch, read back, ask again for the rest.

## Changes to an existing project

- Reassign, reschedule, re-estimate: `update_task` with `confirm: true` and only the fields that change (`users`, `due_date`, `estimated_time`, `project_id` to move it). Show old → new first.
- Several tasks at once: one `update_task` per task. `batch_update_tasks` is a destructive batch write that wasn't exercised; avoid it.
- Done tasks: `archive_tasks_batch` with `task_ids` (a list, even for one task) and `confirm: true` after a yes on the tasks shown by name. Archiving keeps the time and can be undone with `restore_tasks_batch`; deleting doesn't keep it, so never delete.

## Don'ts

- Don't invent owners, dates or estimates the brief doesn't give. Leave the cell empty and say so.
- Don't create the project before the yes, even to "get an id".
- Don't put the whole brief into a task description. One line per task; the brief can go in the project notes if the person wants it.
