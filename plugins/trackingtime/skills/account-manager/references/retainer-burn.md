# Retainer burn

How much of each retainer cycle is used, how fast it is going, and which ones need a word with the client before the budget runs out.

## Where the data is

Retainers live on projects. `list_projects` (`filter: ACTIVE`, `page_size: 200`, then `page: 1`, `2`… until empty) returns every active project with `is_retainer`, `customer`, `estimated_time` (seconds), `accumulated_time` and `billing`. For each project with `is_retainer: true`, `get_project` returns:

- `retainer_settings`: `frequency` (`MONTHLY`…), `closing_day`, `billing_type` (`BY_THE_HOUR`…), `estimated_time_hours`, `hourly_rate`, `rate_source`, `active`.
- `current_retainer_cycle`: `period_key`, `start_date`, `end_date`, `budget_type` (`TIME` or money), `effective_time_budget_hours`, `effective_money_budget_amount`, `accumulated_time` (hours, decimal), `accumulated_billable_amount`, `accumulated_billed_amount`, `carry_over_time_hours`, `overage_policy` (`ALLOW_AND_FLAG`…), `progress_pct`, `over_budget_pct`, `status` (`OPEN`, closed…), `recompute_status`, `recomputed_at`. With cost allowed in `config.md`: `accumulated_cost_amount`, `profit_amount`.

## Steps

1. Projects: `list_projects` as above. Keep retainers; when `config.md` says so, also keep projects with `estimated_time > 0` and no retainer (a plain budget).
2. For each retainer, `get_project` and read `current_retainer_cycle`. If `recompute_status` isn't `PROCESSED`, say the figure may be a few minutes old (`recomputed_at`).
3. Numbers per retainer:
   - Used = `accumulated_time` (hours) or `accumulated_billable_amount` for money budgets.
   - Budget = `effective_time_budget_hours` or `effective_money_budget_amount` (carry-over already included). Budget 0 means no budget was set: report hours and skip the percentage.
   - Progress = `progress_pct`; over = `over_budget_pct`.
   - Pace, when `config.md` asks for it: used ÷ days elapsed in the cycle × days in the cycle. Say "at this pace" and nothing stronger.
   - Days left = `end_date` − today.
4. For plain-budget projects: used = `accumulated_time`, budget = `estimated_time`, both in seconds; no cycle, so no pace.
5. Level from the thresholds in `config.md` (default 75, 90, 100):

   | Progress | Level | What to say |
   |---|---|---|
   | below first threshold | fine | nothing unless asked |
   | first threshold | watch | days left and pace |
   | second threshold | talk to the client | suggest the message |
   | 100 or more | over budget | what `overage_policy` does, hours over |

## Output

```
Retainers · 5 Nov 2026
Acme · Support retainer · cycle 1 to 30 Nov · 38:00 of 40:00 (95%) · 25 days left · at this pace: 61:00 → talk to the client
Globex · Design · cycle 31 Oct to 29 Nov · 12:30 of 60:00 (21%) · fine
Initech · Dev (no budget set) · 34:14 this cycle · hours only
Over budget: none. Source: TrackingTime retainer cycles, recomputed 4 Nov 12:50.
```

Then offer: a short note to the client for anything at "talk to the client" or over (draft it, the person sends it), or posting the table to the channel in `config.md` through the Slack or Teams connector after a yes.

## Don'ts

- Don't recompute a retainer from entries when the cycle figures are there; two numbers for one thing cause arguments.
- Don't say "will run out on the 18th". Say "at this pace, 61 hours by the 30th".
- Don't name who used the hours in an alert. That is a client-report question, if at all.
