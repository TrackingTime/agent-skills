# Payroll Assistant · company settings

Edit the values after each colon. Leave a value empty to use the default in brackets.
This file is the only thing you need to change to adapt the agent to your company.

## Basics

- Company name:
- Language for replies: [same as the person writing]
- Use emojis: [no]
- Currency for cost estimates: [the account currency from get_me]

## Pay period

- Period length: [as set in TrackingTime Time Cards: `timecard_range` from get_me; monthly if unset]
- Monthly periods close on day: [`monthly_close_date` from get_me; last day of the month if unset]
- For weekly or biweekly periods, weeks start on: [Monday]
- Default period when none is named: [the last closed period]

## Hours

- Hours expected per day for people with no schedule: [8, Monday to Friday]
- Count work before or after the schedule window as overtime: [yes, as TrackingTime's `extra_seconds`]
- Also count hours over the daily schedule total as overtime: [no]
- Weekly overtime threshold in hours (empty = none): [none]
- Work on days off and holidays counts as: [overtime]
- Round day totals to the nearest: [no rounding] (for example: 15 minutes)
- A day counts as worked when it has at least this many minutes: [1]
- A day counts as short when worked hours are below the expected hours by more than: [60 minutes]

## Breaks

- Breaks are: [unpaid, excluded from worked hours]
- Minimum gap TrackingTime treats as a break: [`allow_breaks` from get_me, in minutes]

## Leave and holidays

- Paid leave types (names as in TrackingTime; empty = every type is paid):
- Unpaid leave types (names as in TrackingTime):
- Holidays are paid: [yes]
- Count pending (not yet approved) time off as leave: [no, list it separately]

## Money

- Show a labor cost estimate: [no]
- Hourly cost comes from: [TrackingTime, `billing.hourly_cost` per person via list_users]
- Overtime multiplier for the estimate: [1.0, hours only]

## Closing

- Who may lock a period: [anyone with an Admin role in TrackingTime]
- Lock automatically after the summary is approved in chat: [no, ask]
- Lock date to use: [the last day of the period]
- Require every time card to be submitted before locking: [no, warn only]

## People

- People to skip (bots, test users, contractors paid elsewhere):
- Project Managers may see summaries for their own project members: [no]

## Output

- Default format: [table in the chat; CSV on request]
- CSV separator: [`csv_separator` from get_me settings]
- Hours in the CSV as: [both HH:MM and decimal]
