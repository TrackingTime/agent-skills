# TrackingTime Agents

**Your back office, with the roles you need.**

Official AI agents for [TrackingTime](https://trackingtime.co). Each agent covers one back-office role and works through the TrackingTime MCP connector, inside the assistant your team already uses: Claude, ChatGPT, Gemini, Perplexity, Copilot, Codex or Cursor.

**No surveillance.** Attendance is self-reported. No screenshots, no activity monitoring.

## Agents

| Agent | Role | Status |
|---|---|---|
| **Timesheet Assistant** | Your own time: clock in and out, breaks, fill your timesheet, end-of-day report, your hours and overtime for the period, time off requests and balance | Available |
| **HR Manager** | For managers: who's in today and who's out, hour-logging reminders and escalation, compliance reports, time off approvals, holidays | Available |
| **Payroll Assistant** | Pay period hours per person, overtime, absences, period close and lock, CSV for payroll | Available |
| **Account Manager** | Retainer burn alerts, client reports, unbilled hours, invoices, expenses | Available |
| **Project Manager** | Projects from a brief, project status, profitability, team workload | Available |

One install includes all five agents. Turn on only the roles you need. They are split by who uses them: the Timesheet Assistant is for each person about their own time; the HR Manager and the Project Manager are for managers about the team; the Payroll Assistant and the Account Manager are for admins at period close and billing time.

## What you need

- A TrackingTime account. Timesheets work on the Free Plan; attendance, Time Cards, time off, retainers and invoices (Payroll Assistant and Account Manager) need the Pro Plan.
- The TrackingTime connector, which also brings the agents. You sign in with your TrackingTime account (OAuth); see [Install](#install).
- For HR Manager reminders: a Slack or Microsoft Teams connector in the same assistant. Without one, the agent drafts the messages and you send them.

## Install

### Recommended: add the TrackingTime connector

The connector serves the five agents together with the tools. One install brings everything, and the agents stay up to date on their own.

| Assistant | How |
|---|---|
| Claude (web and desktop) | Open the [TrackingTime connector in the Claude directory](https://claude.ai/directory/mcp-trackingtime-co) and add it. |
| ChatGPT | Open the [TrackingTime plugin in the ChatGPT store](https://chatgpt.com/plugins/plugin_asdk_app_6aff2529d18c81919e861a125b50a317) and choose **Install plugin**. Developer mode is not needed. |
| Any other assistant | Add a remote MCP server with the URL `https://mcp.trackingtime.co/mcp`. |

Sign in with your TrackingTime account when asked, then ask for something an agent does, for example "who's in today?" or "log my day".

Not every assistant loads agents from a connector yet. If yours doesn't show the TrackingTime agents among its skills, keep the connector and [install the agents one by one](#install-the-agents-one-by-one).

### Claude Code

The plugin adds slash commands on top of the agents and the connector:

```
/plugin marketplace add trackingtime/agent-skills
/plugin install trackingtime@trackingtime
```

Restart Claude Code after installing.

| Command | Does |
|---|---|
| `/trackingtime:clock-in [task]` | Start your workday |
| `/trackingtime:clock-out [time]` | Stop and see today's total |
| `/trackingtime:whos-in` | Who's in today (managers) |
| `/trackingtime:log-my-day [description]` | Fill your timesheet |
| `/trackingtime:my-hours [period]` | Your hours, overtime and missing days |
| `/trackingtime:hours-check [day or week]` | Who hasn't logged hours, with streaks (managers) |
| `/trackingtime:remind-team` | Draft and send reminders by Slack or Teams, escalate after 3 days (managers) |
| `/trackingtime:compliance-report [daily, weekly, monthly]` | Timesheet compliance report (managers) |
| `/trackingtime:time-off [dates or "balance"]` | Request time off or check your balance |
| `/trackingtime:whos-out [range]` | Who's out this week and upcoming holidays (managers) |
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

### Install the agents one by one

Use this when your assistant doesn't load the agents from the connector, or when you want only some of them. Claude, ChatGPT and Gemini take one agent per upload. Download the ZIPs first, then follow the steps for your app.

#### Step 1: Download the ZIP of each agent you want

The ZIPs are attached to the [latest GitHub Release](https://github.com/TrackingTime/agent-skills/releases/latest). Download only the agents you need and don't unzip them.

| Agent | ZIP |
|---|---|
| Timesheet Assistant | [`tt-timesheet-assistant.zip`](https://github.com/TrackingTime/agent-skills/releases/latest/download/tt-timesheet-assistant.zip) |
| HR Manager | [`tt-hr-manager.zip`](https://github.com/TrackingTime/agent-skills/releases/latest/download/tt-hr-manager.zip) |
| Payroll Assistant | [`tt-payroll-assistant.zip`](https://github.com/TrackingTime/agent-skills/releases/latest/download/tt-payroll-assistant.zip) |
| Account Manager | [`tt-account-manager.zip`](https://github.com/TrackingTime/agent-skills/releases/latest/download/tt-account-manager.zip) |
| Project Manager | [`tt-project-manager.zip`](https://github.com/TrackingTime/agent-skills/releases/latest/download/tt-project-manager.zip) |

#### Step 2: Install in your app

**Claude (web and desktop)**

1. Settings → Capabilities → turn on **Code execution and file creation**.
2. Add the connector, if you haven't yet: https://claude.ai/directory/mcp-trackingtime-co. Sign in with your TrackingTime account.
3. Customize → Skills → **+** → **Create skill** → **Upload a skill**. Choose a ZIP from step 1. Repeat for each agent.
4. Turn each skill on.

**ChatGPT**

Skills in ChatGPT need a Business, Enterprise, Healthcare or Edu plan. On Enterprise and Edu, a workspace admin has to allow skill uploading.

1. Install the TrackingTime plugin, if you haven't yet: https://chatgpt.com/plugins/plugin_asdk_app_6aff2529d18c81919e861a125b50a317. Sign in with your TrackingTime account.
2. In the sidebar, select **Plugins**, then open the **Skills** tab.
3. Select **Add** → **Upload from your computer** and choose a ZIP from step 1. Repeat for each agent.
4. Wait for ChatGPT to scan each skill. Most are available right after the scan; if one is marked **Needs Review**, open it and confirm.

**Gemini**

- Settings → Skills → **Upload**, then the agent's ZIP.
- Gemini CLI: add the connector with `gemini mcp add`, and copy the agent folder into `~/.gemini/skills/`.

### Claude Team and Enterprise (everyone at once)

An Owner uploads the whole plugin once and every member gets all five agents, the commands and the connector:

1. Organization settings → Plugins & skills → **Add** → **Upload a plugin**.
2. Choose `trackingtime-plugin.zip` from the latest GitHub Release (under 200 MB; `.claude-plugin/plugin.json` is at the ZIP root).
3. Set the distribution to "Installed by default" or "Available to install". Members find it under Customize → Plugins.

Members who sign in to Claude Code with the same account get it there too.

### Perplexity

Perplexity doesn't load skills. Add TrackingTime as a custom remote connector (Settings → Connectors → + Custom connector → Remote), create a Space, and paste the agent's instructions from `perplexity/` into it.

### Codex, Copilot, Cursor and other coding agents

```
npx skills add trackingtime/agent-skills
```

Or download `trackingtime-agents.zip` from the latest GitHub Release, unzip it into `.agents/skills/`, and add the connector in your tool's MCP settings. The bundle has one folder per agent; Claude, ChatGPT and Gemini take one agent per upload, so use the per-agent ZIPs there.

## Customize

Each agent has a `config.md` next to its `SKILL.md`: default task, language, who the managers are, when to escalate, what managers can see, pay period and overtime rules, retainer alert thresholds, what client reports may show. Edit it before uploading. Nothing else needs to change.

The Timesheet Assistant, the HR Manager and the Payroll Assistant share one definition of a working day without hours, `references/missing-day.md`, copied into each of them; `scripts/check-shared-refs.sh` fails when the copies drift.

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
│       ├── tt-timesheet-assistant/        One folder per agent
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
