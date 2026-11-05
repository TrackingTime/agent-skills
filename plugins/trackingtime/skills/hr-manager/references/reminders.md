# Reminders and escalation

Takes the result of an hours check and sends one message per missing person, plus one note to the manager for anyone at the escalation level. Always show every message first and send only after a yes.

## How messages go out

Check, in this order, what this assistant can do:

1. **Slack connector available** (tools like `slack_send_message`, `slack_search_users`): find each person by their TrackingTime email, send a **direct message**. Never post names in a channel.
2. **Microsoft Teams connector available**: same, as a chat message to the person.
3. **No chat connector**: write the messages out, one block per person with their name on top, and tell the user to send them. Offer the escalation note the same way.

TrackingTime's own Slack and Teams integrations will be reachable from the connector later (`send_reminder`). When that tool exists, prefer it.

## Steps

1. Run the hours check (`hours-check.md`) if it hasn't been run in this conversation.
2. Build one message per missing person at their level (templates below). Vary the wording between people and days; two identical messages on the same day look automated.
3. Show the full list: name, channel, message. Ask once: "Send these 3 reminders?" One yes covers the batch shown, nothing else.
4. Send. Report what went out and what failed. A failure is reported in one line with the message text, so the user can send it by hand.
5. For each person at level 3, build the manager note (below), show it, ask separately, send it to the manager named in `config.md`.

## Templates

Keep them short. Replace `{name}`, `{day}`, `{days}`. Adapt to the language in `config.md`. No emojis unless `config.md` allows them. Sign with the name in `config.md`.

**Level 1 · first reminder** (one missed day)

> Hi {name}, your hours for {day} aren't in TrackingTime yet. When you get a moment, add them in. Thanks.

> {name}, quick one: {day} has no time entries yet. A rough split is fine; you can tidy it later.

**Level 2 · second reminder** (two missed days)

> Hi {name}, {days} are still missing in TrackingTime. If something makes logging hard this week, tell me and we'll sort it out. Otherwise, could you add them today?

> {name}, two days without entries now ({days}). No rush on the detail, but please get them in today so the week stays complete.

**Level 3 · direct reminder** (three or more missed days)

> Hi {name}, your hours have been missing for {n} days ({days}). I'll let {manager} know today so nobody is surprised later. If there's a reason, tell me and I'll pass it on. Please add the entries when you can.

**Manager note** (one per escalation, factual, no adjectives)

> Hours check · {date}
> {name}: {n} working days without entries ({days}). Last day with entries: {last_logged}. Reminders sent: {count} (first on {first_reminder_date}).
> No action needed unless you want to follow up personally.

## Tone rules

- Warmer and more direct with each level, never sharper. Level 3 states the next step; it doesn't threaten.
- Never: "as per my previous message", "for the Nth time", "this is unacceptable", deadlines in capitals.
- Mondays: light. Fridays: ask for the whole week. After a holiday: mention the break, ask them to catch up.
- Skip people who were on approved leave or whose working day it wasn't. Skip people the manager marked as excused in this conversation.
- If the person replies in the chat with a reason, don't argue and don't log it anywhere. Pass it on to the manager only if they asked you to.
