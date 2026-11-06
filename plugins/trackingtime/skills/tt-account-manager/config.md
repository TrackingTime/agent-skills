# Account Manager · company settings

Edit the values after each colon. Leave a value empty to use the default in brackets.
This file is the only thing you need to change to adapt the agent to your company.

## Basics

- Company name:
- Language for replies: [same as the person writing]
- Language for client reports: [same as replies]
- Use emojis: [no]
- Currency: [the account currency from get_me]

## Clients

- Customers that are real clients (names as in TrackingTime; empty = every customer):
- Customers to skip (internal departments, test customers):
- Treat projects with no customer as: [internal, not billable]

## Retainers

- Alert when a retainer cycle reaches these percentages of its budget: [75, 90, 100]
- Project the end-of-cycle usage from the pace so far: [yes]
- Also watch projects with an estimated time but no retainer: [yes]
- Where alerts go: [the chat; Slack or Teams channel if this assistant has the connector and a channel is named here]
- Channel for alerts:

## Rates and money

- Rate order for an hour: [project hourly rate, then the person's hourly rate]
- Projects with a fixed rate: [report hours only, no amount]
- Show internal cost and margin to managers: [no]
- Round billable hours to the nearest: [no rounding] (for example: 15 minutes, up)
- Minimum billable entry in minutes: [0]

## Client reports

- Show people's names: [yes]
- Show task names: [yes]
- Show notes on entries: [no]
- Show amounts: [yes, at the billing rate]
- Group by: [project, then task]
- Sign-off line (empty = none):

## Invoices

- Overdue buckets in days: [1 to 30, 31 to 60, over 60]
- Who may send invoices and mark them paid: [anyone with an Admin role in TrackingTime]
- Default email message when sending an invoice: [none, ask each time]
- After invoicing, remind to mark the entries as billed in the web app: [yes]

## Expenses

- New expenses are billable by default: [ask each time]
- Receipts: [the web or mobile app; the agent only records amount, category, date and notes]
