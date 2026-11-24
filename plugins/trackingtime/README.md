# TrackingTime

Official TrackingTime agents for Claude: your back office, with the roles you need. This plugin installs the TrackingTime connector (OAuth, you sign in with your TrackingTime account) and the agents as skills.

The five agents:

- **Timesheet Assistant** — for your own time: clocks you in and out, handles breaks, fills your timesheet from a plain description of your day, writes an end-of-day report, shows your hours, overtime and missing days for a period, and requests time off and shows your balance.
- **HR Manager** — for managers: who's in today and who's out this week, who hasn't logged hours, reminders by Slack or Teams with a tone that firms up after repeated misses, escalation to a manager after three missed days, compliance reports, time off approvals and holidays.
- **Payroll Assistant** — turns time cards into payroll hours per person for a pay period (regular, overtime, breaks, paid leave, holidays), checks overtime and unexplained absences, runs a readiness check and locks the period on request, and builds the CSV for the payroll system. Hours, not pay.
- **Account Manager** — watches retainer burn and alerts before a budget runs out, reports hours and amounts per client, lists unbilled billable hours, shows invoice status and sends or marks invoices paid after confirmation, and logs billable expenses.
- **Project Manager** — sets up a project with tasks, owners, due dates and an estimate from a plain brief, reports where a project stands against its estimate and delivery date, shows profitability per project or client, and shows team workload for the week.

Install in Claude Code:

```
/plugin marketplace add trackingtime/agent-skills
/plugin install trackingtime@trackingtime
```

Restart Claude Code and sign in with your TrackingTime account when prompted.

Commands: `/trackingtime:clock-in`, `/trackingtime:clock-out`, `/trackingtime:whos-in`, `/trackingtime:log-my-day`, `/trackingtime:my-hours`, `/trackingtime:hours-check`, `/trackingtime:remind-team`, `/trackingtime:compliance-report`, `/trackingtime:time-off`, `/trackingtime:whos-out`, `/trackingtime:payroll-summary`, `/trackingtime:overtime-check`, `/trackingtime:absences`, `/trackingtime:close-period`, `/trackingtime:retainer-burn`, `/trackingtime:client-report`, `/trackingtime:unbilled-hours`, `/trackingtime:invoices`, `/trackingtime:new-project`, `/trackingtime:project-status`, `/trackingtime:profitability`, `/trackingtime:team-workload`.

Customize each agent in its `config.md`. Attendance and hours are self-reported: no screenshots, no activity monitoring.

Requires a TrackingTime account. Timesheets work on the Free Plan; attendance, Time Cards, time off, retainers and invoices need the Pro Plan.

Privacy: https://trackingtime.co/privacy-policy · Docs: https://github.com/trackingtime/agent-skills
