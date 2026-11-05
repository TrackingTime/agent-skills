# Time off request and balance

For the person asking about **their own** time off. Managers can run it for someone else only when they name the person and `config.md` allows approvals for them.

## Balance

1. `list_timeoff_balances` with `user_id`. It returns one row per policy and cycle. Keep the rows whose cycle covers today (`cycle_start` ≤ today ≤ `cycle_end`).
2. For each policy show: name, unit (`WORKING_DAYS` or `HOURS`), `balance_overview.balance` (available), `taken`, `allowance` and `allowance_carry_forward` if not zero. `is_unlimited: true` means no cap.
3. Don't use `get_timeoff_balance`: it returns only a sync status.

> Vacation: 9 working days left (15 allowed, 6 taken). Personal time: unlimited, 4 h taken.

## Request

1. **What and when.** Policy (from the balance list; ask if more than one fits), first day, last day, full or half days. Half day → the times in `config.md`.
2. **Dates to times.** TrackingTime takes a start and an end with time. Full days: the person's schedule start and end for that weekday (`get_user_schedule`), or the default in `config.md`. Example: `2026-11-10 09:00:00` to `2026-11-12 18:00:00`.
3. **Amount and conflicts.** `calculate_timeoff_amount` with `user_id`, `policy_id`, `from`, `to` (both with time). It returns `amount[].requested_amount` and unit, `overlap` (existing requests on those days), `balance.available_balance` and `balance_alerts` (for example `NEGATIVE_BALANCE_CURRENT_CYCLE`).
4. **Holidays inside the range.** `list_holidays` with `from`, `to`. Mention them; the calculation already skips them.
5. **Confirm.** "Request 3 working days of Vacation, 10 to 12 November? You'd have 6 left. It needs approval from your manager." Mention if the balance would go negative; don't block, the policy decides.
6. **Write.** `create_timeoff` with `user_id`, `policy_id`, `from`, `to`, `notes` (the reason only if the person gave one), `confirm: true`.
7. **Reply** with the status: `PENDING` when the policy needs approval, otherwise `APPROVED`. Say who approves, if `config.md` names them.

## Cancel or change

`update_timeoff` with `timeoff_id` and the new `from`, `to` or `notes` after confirming; `delete_timeoff` to cancel. Both need `confirm: true` after a yes. Approved requests may be locked by the account's policy; if the call fails, say so and point to the app.

## Don'ts

- Don't ask for the reason. Record it only if offered.
- Don't tell the person how much time a colleague has left.
