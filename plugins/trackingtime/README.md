# TrackingTime

Official TrackingTime agents for Claude: your back office, with the roles you need. This plugin installs the TrackingTime connector (OAuth, you sign in with your TrackingTime account) and the agents as skills.

Available now:

- **Office Manager** — clocks you in and out, handles breaks, shows managers who's in today, fills your timesheet from a plain description of your day and writes an end-of-day report.
- **HR Manager** — checks who hasn't logged hours, sends reminders by Slack or Teams with a tone that firms up after repeated misses, escalates to a manager after three missed days, builds compliance reports, and handles time off requests, balances, approvals, holidays and who's out.
- **Payroll Assistant** — turns time cards into payroll hours per person for a pay period (regular, overtime, breaks, paid leave, holidays), checks overtime and unexplained absences, runs a readiness check and locks the period on request, and builds the CSV for the payroll system. Hours, not pay.

Account Manager and Project Manager are coming next.

Install in Claude Code: `/plugin install trackingtime --marketplace trackingtime/agent-skills`

Commands: `/trackingtime:clock-in`, `/trackingtime:clock-out`, `/trackingtime:whos-in`, `/trackingtime:log-my-day`, `/trackingtime:hours-check`, `/trackingtime:remind-team`, `/trackingtime:compliance-report`, `/trackingtime:time-off`, `/trackingtime:whos-out`, `/trackingtime:payroll-summary`, `/trackingtime:overtime-check`, `/trackingtime:absences`, `/trackingtime:close-period`.

Customize each agent in its `config.md`. Attendance and hours are self-reported: no screenshots, no activity monitoring.

Requires a TrackingTime account. Timesheets work on the Free Plan; attendance, Time Cards, time off and the Payroll Assistant need the Pro Plan.

Privacy: https://trackingtime.co/privacy-policy · Docs: https://github.com/trackingtime/agent-skills
