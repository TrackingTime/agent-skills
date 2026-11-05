# Profitability

Billable value, cost and margin for a project, a client or a period. Admins only, or the people `config.md` names.

## Two views

- **All-time, per project**: `list_projects` returns `accumulated_rate` (billable value at the rates in force), `accumulated_rate_billed` (value already invoiced), `accumulated_cost` (hours × each person's hourly cost) and `accumulated_time`. They are `null` when rates or costs aren't set. Margin = `accumulated_rate` − `accumulated_cost`.
- **Period, per project or client**: `list_filtered_events` for the range with `parameters: ["project", "user", "is_billable"]` and a `project` or `customer` filter by name. Hours per person per project × rate = revenue; hours × the person's `hourly_cost` = cost. Rates and costs from `list_projects` (`billing.hourly_rate`, `billing.fixed_rate`) and `list_users` (`include_billing: true`).

Retainer projects have the cycle's `accumulated_cost_amount`, `accumulated_billable_amount` and `profit_amount` in `get_project` → `current_retainer_cycle`; use those for the current cycle.

## Rules

- Rate order from `config.md` (project rate, then the person's rate). Non-billable entries (`b: false`) count as cost with zero revenue.
- Fixed-rate projects: revenue = `fixed_rate` once, not per hour. Show hours and cost against it, and say the share of the fixed amount already consumed by cost.
- No rate or no cost for someone → the row shows "no rate" or "no cost" and the totals say "partial".
- Rounding: none unless `config.md` sets it.

## Output

```
Profitability · October 2026
Project            Hours   Billable value   Cost      Margin    Margin %
Website redesign   93:30   USD 9,350        USD 4,210 USD 5,140  55%
Support retainer   12:00   USD 1,200        USD 540   USD 660    55%   (cycle Nov)
Brand guidelines   18:30   USD 3,000 fixed  USD 830   USD 2,170  72%   (cost so far)
Internal           40:15   —                USD 1,810 —          —
Total              164:15  USD 13,550       USD 7,390 USD 6,160  45%  (partial: 1 person without cost)
```

Per-person margin only when `config.md` allows it, and then as a cost line, never as a ranking.

## Don'ts

- Don't show cost or margin to anyone who isn't allowed by `config.md`, even inside a project status.
- Don't treat `accumulated_rate_billed` as revenue received; it is the invoiced amount. Payments are the Account Manager's area.
- Don't recompute a retainer cycle from entries when the cycle figures exist.
