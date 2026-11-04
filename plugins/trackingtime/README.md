# TrackingTime

Official TrackingTime agents for Claude: your back office, with the roles you need. This plugin installs the TrackingTime connector (OAuth, you sign in with your TrackingTime account) and the agents as skills. Available now: **Office Manager**, which clocks you in and out, handles breaks, shows managers who's in today, fills your timesheet from a plain description of your day and writes an end-of-day report. HR Manager, Payroll Assistant, Account Manager and Project Manager are coming next.

Install in Claude Code: `/plugin install trackingtime --marketplace trackingtime/agent-skills`

Commands: `/trackingtime:clock-in`, `/trackingtime:clock-out`, `/trackingtime:whos-in`, `/trackingtime:log-my-day`.

Customize each agent in its `config.md`. Attendance is self-reported: no screenshots, no activity monitoring.

Requires a TrackingTime account. Timesheets work on the Free Plan; attendance and Time Cards need the Pro Plan.

Privacy: https://trackingtime.co/privacy-policy · Docs: https://github.com/trackingtime/agent-skills
