# Expenses

Billable and internal expenses for a client, a project or a period, and logging a new one.

## Reading

`list_expenses` with `spent_date_from`, `spent_date_to`, and optionally `customer_id`, `project_id`, `category_id`, `is_billable`. `list_expense_categories` for the category names. The test account had no expenses, so the row shape is unverified: read the first row, then summarize. Billable expenses for a client go into the client report and the unbilled list as separate lines.

## Logging a new expense

1. Collect: amount, date (`spent_date`, `YYYY-MM-DD`), category (match against `list_expense_categories`), customer and project (match names against `list_customers` and `list_projects`), billable or not (`config.md` default), a one-line note. The receipt is attached in the web or mobile app.
2. Show the expense in one block and ask for a yes.
3. `create_expense` with those fields and `confirm: true`.
4. `list_expenses` for that date and confirm in one line.

```
Expense to log
Acme · Website redesign · Stock photos · USD 120 · 3 Nov 2026 · billable · "Hero images, licence #4411"
Log it?
```

## Don'ts

- Don't log an expense without an amount and a date. Ask.
- Don't guess billable. Ask or use the default in `config.md`, and say which you did.
- Don't put a receipt's contents in notes beyond what the person said.
