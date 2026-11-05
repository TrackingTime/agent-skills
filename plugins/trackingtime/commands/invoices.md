---
description: Invoice status and overdue list; draft, send or mark an invoice paid after confirmation (admins)
argument-hint: "[overdue | open | draft <client> | send <number> | paid <number>]"
---

Use the account-manager skill, workflow "Invoices" (references/invoices.md).

Request: $ARGUMENTS
If empty, show open and overdue invoices. Sending or marking paid happens only after an explicit yes on the invoice shown.
