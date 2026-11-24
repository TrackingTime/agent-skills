# Time off approvals (managers)

Lists pending requests and approves or rejects them. Only for people allowed by `config.md` (default: Admin or Project Manager role).

## Pending requests

1. `list_timeoffs` with `from` = today, `to` = three months ahead (or the range asked), `status: PENDING`. Keep `time_off_status: PENDING`.
2. Show one line per request: person, dates and times, amount (`working_day_amount` or `hours`, with `deductible_unit`), policy name (`time_off_type.name`), notes if any, requested on (`created_at`).
3. Who else is out those days (approved requests and holidays in the same range) so the manager can see overlaps. Names only.

```
Pending (2)
1. Lucía · Mon 10 Nov · 1 working day · Personal · "exam, day 1 of 3" · requested 20 Oct
2. Maxi · Fri 6 Nov 14:00–18:00 · 4 h · Personal · requested 2 Nov
Also out that week: Romina (Fri)
```

## Approve or reject

1. Confirm one request at a time: "Approve Lucía's request for 10 November?"
2. On yes: `update_timeoff` with `timeoff_id`, `status: "APPROVED"` (or `"REJECTED"` with the reason in `notes`), `confirm: true`.
3. If `update_timeoff` can't change the status, say so, point the manager to the approval email TrackingTime sent them or to the request in the web app, and stop. There is no other approval tool in the connector.
4. Reply with the result and, for rejections, confirm the reason was recorded. TrackingTime notifies the person by itself.

## Rules

- A rejection always carries a reason. Ask for one if it wasn't given.
- Never approve for someone else's team unless the manager says so explicitly.
- Don't reveal the type of leave to people who aren't the requester or a manager.
