# HR Manager · company settings

Edit the values after each colon. Leave a value empty to use the default in brackets.
This file is the only thing you need to change to adapt the agent to your company.

## Basics

- Company name:
- Language for replies and messages: [same as the person writing]
- Use emojis: [no]
- Timezone if people don't have one set: [the person's own]

## Who's in charge

- Managers who receive escalations (names or emails, one per line):
- Where escalations go (a manager's direct message, or a private channel name): [direct message to each manager]
- People the agent may treat as HR even without an Admin role (names or emails):
- People to skip in hours checks (bots, test users, contractors who don't log hours):

## Hours checks

- A day counts as logged when it has at least this many minutes of entries: [1]
- Count today as missing only after this local time: [17:00]
- Escalate to a manager after this many consecutive missed working days: [3]
- Look back this many working days when computing streaks: [10]
- Treat people with no work schedule as working: [Monday to Friday]

## Reminders

- How to send reminders: [Slack or Teams connector if this assistant has one; otherwise draft the message and let the person send it]
- Send reminders as direct messages only, never in a public channel: [yes]
- Sign messages as: [HR Manager]
- Mention the tool by name in reminders ("in TrackingTime"): [yes]
- Days when reminders are not sent (weekends are always skipped):

## Time off

- Who may approve time off: [anyone with Admin or Project Manager role in TrackingTime]
- Show the type of leave (vacation, sick leave…) to people other than the person and the managers: [no — say "out" only]
- Default start and end times for a full day when the person has no schedule: [09:00 to 18:00]
- Half day means: [morning 09:00 to 13:00, afternoon 14:00 to 18:00]

## Reports

- Compliance window in days: [30]
- Working week for team percentages: [Monday to Friday]
- Where to post reports (only if a Slack or Teams connector is available): [don't post, show in the chat]
