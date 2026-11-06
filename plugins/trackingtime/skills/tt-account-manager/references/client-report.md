# Client report

What was done for one client in a period: hours by project and task, people if allowed, billable hours and amount. Written so it can go to the client as is.

## Steps

1. **Client and period.** Match the client's name against `list_customers` (`filter: ACTIVE`). Say both back.
2. **Entries.** `list_filtered_events` with `date_range: {period: "custom_range", start, end}`, `parameters: ["customer", "project", "task", "user", "is_billable", "is_billed"]` (add `"notes"` only when `config.md` allows notes) and `filters: [{"by": "customer", "operator": "is", "value": ["<client name>"]}]`. Each row has `d` (seconds), `p`/`pid`, `t`/`tid`, `u`/`uid`, `b` (billable), `bd` (billed). No pagination: for a long period or a busy client, query one month at a time and add up.
3. **Rates** (when amounts are shown): `list_projects` for the client's projects → `billing.hourly_rate`, `billing.fixed_rate`, `billing.is_billable`. A project rate of `null` or `0` falls back to each person's rate from `list_users` (`include_billing: true`). Fixed-rate projects show hours only. Apply the rounding in `config.md` per entry before multiplying.
4. **Group** as `config.md` says (default project, then task). Within a group, hours, billable hours, amount. Non-billable time is listed but not priced.
5. **Expenses** billable to the client in the period (`list_expenses` with `customer_id`, `spent_date_from`, `spent_date_to`, `is_billable: true`), as a separate block.
6. Write the report: title, period, one table per project, totals, expenses, sign-off from `config.md`. If the assistant can create files, offer it as a document; otherwise the chat is the report.

## Output

```
Acme · October 2026

Website redesign · 42:15 (billable 40:00 · USD 4,000)
  Homepage and navigation        18:30   Ana, Bruno
  Design system                  15:45   Ana
  QA and fixes                    8:00   Carla (2:15 not billable)
Support retainer · 12:00 (billable 12:00 · USD 1,200)
  Content updates                 9:00   Bruno
  Bug reports                     3:00   Carla

Total: 54:15 · billable 52:00 · USD 5,200
Expenses: stock photos USD 120 (billable)
```

## Shareable link

TrackingTime's shared reports (docs) have a public link. `list_reports` shows existing ones (`doc_type`, `public_token`, `live`); creating one through `create_report` is not reliable yet (see `connector-notes.md`). To give the client a live link, the person creates the report in the web app (Reports → Share) and can refresh its token here with `refresh_report_share_token` after a yes if the link leaked.

## Don'ts

- Don't include cost, margin or people's hourly rates in a client report, whatever `config.md` says about managers.
- Don't include notes unless `config.md` allows it; notes are written for the team, not the client.
- Don't rank people or comment on their pace. The report is about the work.
- Don't mix two clients in one report.
