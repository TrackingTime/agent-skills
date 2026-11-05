# Invoices

Status of what's out, what's overdue, and the next invoice. Sending and marking paid are writes and need a yes.

## Status and overdue

1. `list_invoices` with `from`, `to` (invoice `date`), optional `customer_id` and `status` (`DRAFT`, `OPEN`, `OVERDUE`, `PAID`). Each invoice has `id`, `number`, `date`, `due_date`, `customer_name`, `customer_id`, `project_id`, `net_total`, `tax`, `discount`, `total`, `currency`, `paid`, `payments`, `lines` (`description`, `quantity`, `unit_amount`, `amount`, `quantity_hours`, `billed_time`), `hosted_invoice_url`, `invoice_pdf`.
2. The response is large (every line of every invoice). Ask for a range of three months at a time and keep only the header fields.
3. Overdue: `status: OVERDUE`, or `OPEN` with `due_date` before today. Bucket by days overdue as in `config.md`.
4. `get_invoice` for one invoice when the person asks for its lines.

```
Invoices · 5 Nov 2026
Overdue (1): #110 Globex · USD 56.90 · due 3 Oct · 33 days (31 to 60)
Open (2): #106 USD 1,516.50 · #107 USD 2,022.00 (no due date)
Draft (3): #108, #109 DEV USD 191.67, #111 (empty)
Paid this quarter: #105 USD 1,011.00
```

## Drafting a new invoice

The connector's `create_invoice` takes only header fields (customer name, address, terms, payment details), not line items, so an invoice built here would be empty. Instead:

1. Build the lines from `unbilled-hours.md` for the client and range: one line per project (or per task if `config.md` groups by task), `quantity_hours`, rate, amount; expenses as their own lines.
2. `get_next_invoice_number` for the number it will get.
3. Show the draft: number, client, date, due date (terms from `config.md` or the account's `default_invoice_terms`), lines, subtotal, tax rate from the account (`get_me` → `apps[key = "invoicing"].settings.default_tax_rate`), total.
4. Tell the person to create it in the web app (Invoices → New invoice, or from the report with "create invoice") and paste the number back if they want it sent from here.

## Sending

`send_invoice` with `invoice_id`, `email`, `message`, `confirm: true`. Before calling: show the invoice number, total, recipient email and the message text; wait for the yes. After: `get_invoice` and confirm the status changed from `DRAFT` to `OPEN`. Only Admins or the people in `config.md`.

## Marking paid

`mark_invoice_paid` with `invoice_id`, `confirm: true`, after showing number, client and total and getting a yes. After: `get_invoice` → `status: PAID`. Partial payments are recorded in the web app.

## PDF and link

`hosted_invoice_url` and `invoice_pdf` are in the invoice object when the invoice has been sent or exported from the web app. `export_invoice` returns an empty object through the connector; point to the web app for a fresh PDF.

## Don'ts

- Don't send an invoice to an address the person didn't state in this conversation.
- Don't mark paid on a hunch ("the client said they paid"). The person confirms, then you write.
- Don't change amounts in a draft to "make it round". Show the computed figure and let them decide.
