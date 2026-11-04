# End-of-day report

A short summary of the person's own day, built from their entries.

## Steps

1. `list_events` (`filter: USER`, `id: <user_id>`, `from` = `to` = today, `timezone`, `order: asc`).
2. If `config.md` says to compare with the schedule: `get_user_schedule` (`user_id`) → expected hours for today's weekday.
3. Build the report:
   - **Total** worked today, and expected hours if available.
   - **By project**: hours per project, largest first.
   - **Highlights**: one line per main task, using their own notes. Don't add accomplishments they didn't write.
   - **Gaps**: a timer still running, or missing hours against the schedule. Offer to fix them (clock out, or *Fill my timesheet*).
4. Keep it under ten lines.

## Example

> **Wednesday · 7 h 45 m of 8 h**
> - Acme · 4 h 10 m — landing page, client call
> - Internal · 2 h 05 m — invoices
> - Beta Corp · 1 h 30 m — proposal draft
>
> Timer still running on *Proposal draft*. Clock out?

## Posting it

Only if `config.md` names a channel **and** a Slack or Teams connector is available in this assistant: show the text first, ask for confirmation, then post it with that connector. Otherwise just show it in the chat.
