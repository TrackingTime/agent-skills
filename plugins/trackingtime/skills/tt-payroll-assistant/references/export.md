# Export

A CSV of the period summary for the payroll system. The connector has no export tool, so the file is built from the summary.

## Steps

1. Run the period summary (`period-summary.md`) if it isn't in this conversation.
2. Columns, in this order. Hours appear twice when `config.md` says "both": `HH:MM` and decimal with two places.

```
person,email,period_start,period_end,days_expected,days_worked,regular_hhmm,regular_hours,overtime_hhmm,overtime_hours,break_hhmm,break_hours,leave_paid_hhmm,leave_paid_hours,leave_unpaid_hhmm,leave_unpaid_hours,holiday_hhmm,holiday_hours,absences_unexplained,locked_through
```

   Add `cost_estimate` and `currency` at the end only when `config.md` allows cost.
3. Separator from `config.md` (default: `csv_separator` in `get_me` → `settings`). Decimal point always `.` in the decimal columns, whatever `number_format` says, unless `config.md` overrides it.
4. One row per person, ordered by name. A last row `TEAM` with the sums, no averages.
5. If this assistant can create files, write `payroll-<period>.csv` and hand it over. Otherwise print the CSV in a code block and say how many rows it has.
6. Per-day detail on request: one row per person per day with `date`, `day_type`, `expected_hhmm`, `worked_hhmm`, `regular_hhmm`, `overtime_hhmm`, `break_hhmm`, `leave_hhmm`, `holiday_hhmm`, `status`. Same rules.

## Rounding

Entry-level rounding (each entry to the nearest N minutes) is available from `list_filtered_events` with `rounding: { "by": 15, "method": "round" }`, but that call returns entries, not time card days, so it won't match the time card's break and overtime split. Use it only when `config.md` asks for entry rounding and say that totals come from rounded entries, not from the time card.

## Don'ts

- Don't include task, project, customer or notes columns. If someone asks for them, that's a report for the Project Manager or Account Manager agent, not a payroll export.
- Don't include hourly rates or costs unless `config.md` allows cost.
- Don't change column names between exports; payroll imports break on that.
