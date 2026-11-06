# Connecting TrackingTime

Read this when the TrackingTime tools (`get_me`, `list_users`, `track_task`…) aren't available in the conversation, or when the first call fails with an authentication error. Tell the person which case it is, then give only the steps for their app. Never pretend to have checked anything in TrackingTime.

## The connector

- URL: `https://mcp.trackingtime.co/mcp`
- Name it **TrackingTime**. Authentication is OAuth: the person signs in with their TrackingTime account and the connector sees what that account sees.
- It needs a TrackingTime account. Timesheets work on the Free Plan; attendance, Time Cards, time off, retainers and invoices need the Pro Plan.

## Two different situations

1. **Connector not added yet**: no TrackingTime tools exist in this assistant. Follow the steps for the app below.
2. **Connector added but not on in this chat**: the person added it before, but this conversation doesn't have it enabled. In Claude, open the tools or connectors menu in the message box and turn TrackingTime on; in ChatGPT, open the "+" or connectors menu and pick TrackingTime. No sign-in needed again.

## Steps by app

**Claude (web and desktop)**
1. Settings → Connectors → **Add custom connector**.
2. Name: TrackingTime. URL: `https://mcp.trackingtime.co/mcp`. Add, then **Connect** and sign in.
3. Back in the chat, turn TrackingTime on in the connectors menu, then ask again.

**Claude Code**
- With the plugin: `/plugin install trackingtime@trackingtime` brings the connector; restart Claude Code and sign in when prompted.
- Without it: `claude mcp add --transport http trackingtime https://mcp.trackingtime.co/mcp`, then `/mcp` to sign in.

**ChatGPT**
1. Settings → Apps & Connectors → Advanced → turn on **Developer mode** (Plus, Pro, Business, Enterprise or Edu plan).
2. Settings → Apps & Connectors → **Create**. Name: TrackingTime. URL: `https://mcp.trackingtime.co/mcp`. Authentication: OAuth. Sign in.
3. In the chat, enable TrackingTime from the connectors menu.

**Gemini**
- Gemini app: Settings → Connectors, add a custom connector with the same URL if the account allows it; otherwise use Gemini CLI.
- Gemini CLI: `gemini mcp add trackingtime https://mcp.trackingtime.co/mcp --transport http`, then sign in when prompted.

**Perplexity**
- Settings → Connectors → **+ Custom connector** → Remote. Name: TrackingTime. URL: `https://mcp.trackingtime.co/mcp`. Paid plans only. Turn it on in the Space.

**Codex, Cursor, Copilot and other coding agents**
- Add an HTTP MCP server named `trackingtime` with URL `https://mcp.trackingtime.co/mcp` in the tool's MCP settings, then sign in.

## After connecting

Call `get_me`. If it returns the person's `account_id` and `role`, continue with the workflow they asked for. If it fails, say so plainly and point them to the help center: https://support.trackingtime.co
