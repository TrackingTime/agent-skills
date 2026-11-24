# Connector notes (tested 2026-11-05)

What the TrackingTime MCP connector does and doesn't do today for account work.

## Customers and projects

- `list_customers` (`filter: ACTIVE`) returns name, id and contact; hour and rate fields come back empty. `get_customer` adds nothing.
- `list_projects` (`filter: ACTIVE`) pages with `page_size` and `page`; 49 active projects came back in one page at `page_size: 200`. Each project carries `customer`, `estimated_time` (seconds, 0 = none), `accumulated_time`, `billing` (`hourly_rate`, `fixed_rate`, `is_billable`), `accumulated_rate` (billable value to date), `accumulated_rate_billed`, `accumulated_cost`, `is_retainer`, `retainer_settings`, `current_retainer_cycle`.
- `get_project` returns the full retainer block: `retainer_settings` (frequency, closing day, billing type, rate source) and `current_retainer_cycle` (period, budget, used hours as decimal hours, progress and over-budget percentages, overage policy, status, recompute status). This is the retainer data; no separate tool is needed.
- `list_project_times` ignores `project_ids`, `from` and `to`: it returns all-time totals for every project. Use `list_filtered_events` for a period.

## Entries, billable and billed

- `list_filtered_events` filters work with **names**, not ids: `{"by": "customer", "operator": "is", "value": ["Marketing"]}`, `{"by": "project", ..., "value": ["Product releases"]}`, `{"by": "user", ..., "value": ["Eric Tulle"]}`, `{"by": "is_billed", "operator": "is", "value": [true]}`. A bare string or an id is rejected or returns nothing.
- `parameters` decide which fields come back: `customer` → `c`/`cid`, `project` → `p`/`pid`, `task` → `t`/`tid`, `user` → `u`/`uid`, `is_billed` → `bd`, `is_billable` → `b`, `notes` → `n`. Duration is `d` in seconds. No pagination; query a month at a time on busy accounts.
- `list_events` (`filter: CUSTOMER` or `PROJECT`, `id`) also works and always includes `b`, `bd`, notes and task names, but pages at 50.
- Rates and amounts aren't on entries: `uhr`/`uhc` are null in `list_events`, and asking `list_filtered_events` for `loc_hourly_rate` or `loc_rounded_amount` returns nothing extra. Take them from the project (`billing.hourly_rate`) or the person (`list_users` with `include_billing: true`).
- `update_events_batch` (mark entries as billed) was not exercised; it is a destructive batch write. Use the web app.

## Invoices

- `list_invoices` (`from`, `to`, `status`, `customer_id`) returns full invoices with `lines`; the response can be large. Statuses seen: `DRAFT`, `OPEN`, `OVERDUE`, `PAID`.
- `create_invoice` accepts only `customer_name`, `customer_address`, `terms`, `payment_details` (no lines). Don't use it to invoice hours.
- `send_invoice` (`invoice_id`, `email`, `message`, `confirm`) and `mark_invoice_paid` (`invoice_id`, `confirm`) exist and were not exercised. Verify with `get_invoice`.
- `export_invoice` returns `{}`.
- Account invoicing defaults are in `get_me` → `apps[key = "invoicing"].settings` (`default_tax_rate`, `default_payment_details`, `default_invoice_terms`).

## Reports

- The connector has no tools for TrackingTime's shared reports. A live link for a client is created in the web app (Reports → Share).

## Expenses

- `list_expenses` and `list_expense_categories` respond but were empty on the test account; row shape unverified. `create_expense` needs `confirm: true` and was not exercised.

## Summaries

- `get_events_stats` fails. Add up `d` yourself.
