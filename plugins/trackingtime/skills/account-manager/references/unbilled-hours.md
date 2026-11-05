# Unbilled hours

Billable time that hasn't been invoiced, per client and project, with the amount at the billing rate. The list that becomes the next invoice.

## Steps

1. **Range.** Default: everything up to today that isn't billed, starting from the date in the request or the last 90 days. Say it back.
2. **Entries.** `list_filtered_events` with `date_range` for the range, `parameters: ["customer", "project", "task", "user", "is_billable", "is_billed"]`, and `filters: [{"by": "is_billed", "operator": "is", "value": [false]}]`. Keep rows with `b: true` (billable) and a customer (`cid`). For one client, add a `customer` filter by name. Query month by month if the range is long.
3. **Projects.** `list_projects` for the projects seen: drop projects with `billing.is_billable: false`; note `billing.hourly_rate`, `billing.fixed_rate`; treat projects with no customer as internal unless `config.md` says otherwise.
4. **Amount.** Hours × rate, rate order from `config.md` (project rate, then the person's rate from `list_users` with `include_billing: true`). Fixed-rate projects: hours only, amount "per contract". Apply the rounding and the minimum entry from `config.md`.
5. **Retainers.** For a retainer project, say which cycle the hours fall in and whether the cycle is within budget (`get_project` → `current_retainer_cycle`); hours inside a prepaid retainer are usually not billed again. Say so; don't drop them silently.
6. Group by client, then project. Totals per client and overall.

## Output

```
Unbilled · up to 5 Nov 2026
Acme
  Website redesign     40:00  USD 100/h   USD 4,000   (1 Oct to 31 Oct)
  Support retainer     12:00  retainer    cycle Nov, within budget
Globex
  Brand guidelines     18:30  fixed rate  per contract
Total billable at hourly rates: USD 4,000 · hours on fixed or retainer projects: 30:30
```

Then offer: an invoice draft (`invoices.md`) for one client, or the client report for the same range.

## Marking as billed

Once an invoice is out, the entries should be marked as billed so they drop off this list. The connector's `update_events_batch` is a destructive batch write that was not exercised in testing; don't use it. The web app marks entries as billed from the report or the invoice (one click), and `config.md` says whether to remind the person.

## Don'ts

- Don't price non-billable time. List it in a separate line if the person wants to see it.
- Don't bill hours twice: retainer hours and fixed-rate hours are flagged, not summed with hourly amounts.
- Don't invent a rate. "No rate set" is a valid cell, and a reason to fix the project.
