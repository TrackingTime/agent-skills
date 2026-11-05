# Project Manager · company settings

Edit the values after each colon. Leave a value empty to use the default in brackets.
This file is the only thing you need to change to adapt the agent to your company.

## Basics

- Company name:
- Language for replies: [same as the person writing]
- Use emojis: [no]
- Currency: [the account currency from get_me]

## New projects

- Default visibility: [public to the team]
- A customer is required: [as the account's tracking policy says; ask when missing]
- Default billable for new tasks: [as the project]
- Task type for new tasks: [EVERYONE when no owner is named, PERSONAL when owners are named]
- Naming convention for projects (empty = as written in the brief):
- Create tasks from a template project when the brief names one: [yes, with duplicate_project]
- Maximum tasks to create from one brief without a second confirmation: [25]
- Estimate unit when the brief gives none: [hours]

## Project status

- Warn when used hours reach this share of the estimate: [80%]
- Warn when the delivery date is within this many days: [7]
- Overdue means: [due date before today and task still active]
- Count a task as "unowned" when it has no active assignee: [yes]

## Profitability

- Who may see cost and margin: [anyone with an Admin role in TrackingTime]
- Rate order for an hour: [project hourly rate, then the person's hourly rate]
- Cost source: [the person's hourly cost in TrackingTime]
- Fixed-rate projects: [revenue = fixed rate; show hours and cost against it]
- Show margin per person: [no]

## Team workload

- Week starts on: [Monday]
- Capacity for people with no schedule: [8 hours, Monday to Friday]
- "Over capacity" when logged or planned hours exceed capacity by: [10%]
- "Has room" when logged hours are below this share of capacity by Thursday: [50%]
- Include open task counts per person when the team has at most this many people: [15]
- Teams come from: [user_group_name in list_users]
- People to skip (bots, test users):
