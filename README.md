# TrackingTime Agents

**Your back office, with the roles you need.**

Official AI agents for [TrackingTime](https://trackingtime.co). Each agent covers one back-office role and works through the TrackingTime MCP connector, inside the assistant your team already uses: Claude, ChatGPT, Gemini, Perplexity, Copilot, Codex or Cursor.

**No surveillance.** Attendance is self-reported. No screenshots, no activity monitoring.

## Agents

| Agent | Role | Status |
|---|---|---|
| **Office Manager** | Clock in and out, breaks, who's in today, fill your timesheet, end-of-day report | Available |
| **HR Manager** | Hour-logging reminders and escalation, compliance reports, time off requests, balances and approvals, holidays, who's out | Available |
| **Payroll Assistant** | Pay period hours per person, overtime, absences, period close and lock, CSV for payroll | Available |
| **Account Manager** | Retainer burn alerts, client reports, unbilled hours, invoices, expenses | Available |
| **Project Manager** | Projects from a brief, project status, profitability, team workload | Available |

One install includes all five agents. Turn on only the roles you need.

## What you need

- A TrackingTime account. Timesheets work on the Free Plan; attendance, Time Cards, time off, retainers and invoices (Payroll Assistant and Account Manager) need the Pro Plan.
- The TrackingTime connector: `https://mcp.trackingtime.co/mcp` (OAuth: you sign in with your TrackingTime account).
- For HR Manager reminders: a Slack or Microsoft Teams connector in the same assistant. Without one, the agent drafts the messages and you send them.

## Install

### Claude Code

```
/plugin marketplace add trackingtime/agent-skills
/plugin install trackingtime@trackingtime
```

Brings every agent, the connector and the slash commands. Restart Claude Code after installing.

| Command | Does |
|---|---|
| `/trackingtime:clock-in [task]` | Start your workday |
| `/trackingtime:clock-out [time]` | Stop and see today's total |
| `/trackingtime:whos-in` | Who's in today (managers) |
| `/trackingtime:log-my-day [description]` | Fill your timesheet |
| `/trackingtime:hours-check [day or week]` | Who hasn't logged hours, with streaks (managers) |
| `/trackingtime:remind-team` | Draft and send reminders by Slack or Teams, escalate after 3 days (managers) |
| `/trackingtime:compliance-report [daily, weekly, monthly]` | Timesheet compliance report (managers) |
| `/trackingtime:time-off [dates or "balance"]` | Request time off or check your balance |
| `/trackingtime:whos-out [range]` | Who's out this week and upcoming holidays |
| `/trackingtime:payroll-summary [period] [csv]` | Payroll hours per person for a pay period (admins) |
| `/trackingtime:overtime-check [period]` | Who has overtime, how much, which days (admins) |
| `/trackingtime:absences [period]` | Unexplained absences, pending leave, short days (admins) |
| `/trackingtime:close-period [period]` | Readiness check, then lock the period after confirmation (admins) |
| `/trackingtime:retainer-burn [client]` | Retainer usage, pace and alerts (managers) |
| `/trackingtime:client-report <client> [period]` | Client-ready report of hours and amounts (managers) |
| `/trackingtime:unbilled-hours [client]` | Billable hours not yet invoiced, with amounts (managers) |
| `/trackingtime:invoices [overdue, send N, paid N]` | Invoice status; send or mark paid after confirmation (admins) |
| `/trackingtime:new-project <brief>` | Project with tasks, owners and dates from a brief, after confirmation (managers) |
| `/trackingtime:project-status <project>` | Hours vs estimate, delivery, open and overdue tasks (managers) |
| `/trackingtime:profitability [project or client]` | Billable value, cost and margin (admins) |
| `/trackingtime:team-workload [team]` | Capacity, hours logged, open tasks this week (managers) |

### Claude (web and desktop)

1. Settings → Capabilities → turn on **Code execution and file creation**.
2. Settings → Connectors → **Add custom connector**. Name: TrackingTime. URL: `https://mcp.trackingtime.co/mcp`. Connect and sign in.
3. Customize → Skills → **+** → **Create skill** → **Upload a skill**. Upload the ZIP of each agent you want (download it from the latest GitHub Release, e.g. `tt-office-manager.zip`, `tt-hr-manager.zip`, `tt-payroll-assistant.zip`, `tt-account-manager.zip` or `tt-project-manager.zip`).
4. Turn the skill on.

### Claude Team and Enterprise (everyone at once)

An Owner uploads the whole plugin once and every member gets all five agents, the commands and the connector:

1. Organization settings → Plugins & skills → **Add** → **Upload a plugin**.
2. Choose `trackingtime-plugin.zip` from the latest GitHub Release (under 200 MB; the plugin folder is the ZIP root).
3. Set the distribution to "Installed by default" or "Available to install". Members find it under Customize → Plugins.

Members who sign in to Claude Code with the same account get it there too.

### ChatGPT

1. Settings → Apps & Connectors → Advanced → turn on **Developer mode** (Plus, Pro, Business, Enterprise, Edu).
2. Settings → Apps & Connectors → **Create**. Name: TrackingTime. URL: `https://mcp.trackingtime.co/mcp`. Authentication: OAuth.
3. Plugins → **Skills** → **Create** → **Upload from your computer**. Upload the ZIP of each agent you want.

### Gemini

- Settings → Skills → **Upload**, then the agent's ZIP.
- Gemini CLI: add the connector with `gemini mcp add`, and copy the agent folder into `~/.gemini/skills/`.

### Perplexity

Perplexity doesn't load skills. Add TrackingTime as a custom remote connector (Settings → Connectors → + Custom connector → Remote), create a Space, and paste the agent's instructions from `perplexity/` into it.

### Codex, Copilot, Cursor and other coding agents

```
npx skills add trackingtime/agent-skills
```

Or download `trackingtime-agents.zip` from the latest GitHub Release, unzip it into `.agents/skills/`, and add the connector in your tool's MCP settings. The bundle has one folder per agent; Claude, ChatGPT and Gemini take one agent per upload, so use the per-agent ZIPs there.

## Customize

Each agent has a `config.md` next to its `SKILL.md`: default task, language, who the managers are, when to escalate, what managers can see, pay period and overtime rules, retainer alert thresholds, what client reports may show. Edit it before uploading. Nothing else needs to change.

Each agent also ships `references/connector-notes.md`: what the TrackingTime connector can't do yet and the workaround the agent uses. We update it as the connector improves.

And `references/connect.md`: the connector URL and the steps to add it in each app, so the agent can tell the person what to do when the TrackingTime tools aren't in the conversation.

## Repository layout

```
agent-skills/
├── .claude-plugin/marketplace.json     Claude Code marketplace
├── plugins/trackingtime/
│   ├── .claude-plugin/plugin.json      The plugin
│   ├── .mcp.json                       TrackingTime connector
│   ├── commands/                       Slash commands
│   └── skills/
│       ├── tt-office-manager/             One folder per agent
│       │   ├── SKILL.md
│       │   ├── config.md
│       │   └── references/             One file per workflow, plus connector notes
│       ├── tt-hr-manager/
│       ├── tt-payroll-assistant/
│       ├── tt-account-manager/
│       └── tt-project-manager/
├── perplexity/                         Agent instructions for Perplexity Spaces
├── scripts/package.sh                  Builds dist/<agent>.zip, dist/trackingtime-agents.zip and dist/trackingtime-plugin.zip
└── dist/                               Built ZIPs (git-ignored; attached to each GitHub Release)
```

## More

- Agents: https://trackingtime.co/ai-agents
- Help Center: https://support.trackingtime.co
- Privacy: https://trackingtime.co/privacy-policy
- License: MIT

No surveillance. No pricing puzzles.
