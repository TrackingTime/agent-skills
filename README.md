# TrackingTime Agents

**Your back office, with the roles you need.**

Official AI agents for [TrackingTime](https://trackingtime.co). Each agent covers one back-office role and works through the TrackingTime MCP connector, inside the assistant your team already uses: Claude, ChatGPT, Gemini, Perplexity, Copilot, Codex or Cursor.

**No surveillance.** Attendance is self-reported. No screenshots, no activity monitoring.

## Agents

| Agent | Role | Status |
|---|---|---|
| **Office Manager** | Clock in and out, breaks, who's in today, fill your timesheet, end-of-day report | Available |
| **HR Manager** | Timesheet reminders, compliance, time off requests and approvals, holidays | Coming soon |
| **Payroll Assistant** | Time card and overtime calculators, timesheet approvals, payroll close | Coming soon |
| **Account Manager** | Retainer burn alerts, client reports, unbilled hours, invoices, expenses | Coming soon |
| **Project Manager** | Projects from a brief, profitability, team workload | Coming soon |

One install includes every agent. Turn on only the roles you need.

## What you need

- A TrackingTime account. Timesheets work on the Free Plan; attendance and Time Cards need the Pro Plan.
- The TrackingTime connector: `https://mcp.trackingtime.co/mcp` (OAuth: you sign in with your TrackingTime account).

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

### Claude (web and desktop)

1. Settings → Capabilities → turn on **Code execution and file creation**.
2. Settings → Connectors → **Add custom connector**. Name: TrackingTime. URL: `https://mcp.trackingtime.co/mcp`. Connect and sign in.
3. Customize → Skills → **+** → **Create skill** → **Upload a skill**. Upload the ZIP of each agent you want (download it from the latest GitHub Release, e.g. `office-manager.zip`).
4. Turn the skill on.

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

Or copy the agent folders into `.agents/skills/`, and add the connector in your tool's MCP settings.

## Customize

Each agent has a `config.md` next to its `SKILL.md`: default task, language, warnings, what managers can see. Edit it before uploading. Nothing else needs to change.

## Repository layout

```
agent-skills/
├── .claude-plugin/marketplace.json     Claude Code marketplace
├── plugins/trackingtime/
│   ├── .claude-plugin/plugin.json      The plugin
│   ├── .mcp.json                       TrackingTime connector
│   ├── commands/                       Slash commands
│   └── skills/
│       └── office-manager/             One folder per agent
│           ├── SKILL.md
│           ├── config.md
│           └── references/             One file per workflow
├── perplexity/                         Agent instructions for Perplexity Spaces
├── scripts/package.sh                  Builds dist/<agent>.zip for chat apps
└── dist/                               Built ZIPs (git-ignored; attached to each GitHub Release)
```

## More

- Agents: https://trackingtime.co/ai-agents
- Help Center: https://support.trackingtime.co
- Privacy: https://trackingtime.co/privacy-policy
- License: MIT
