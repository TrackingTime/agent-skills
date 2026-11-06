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

## Who's in and out

- Who may ask who's in today and who's out: [anyone with an Admin or Project Manager role in TrackingTime]
- Show what each person is working on (task and project): [no, status and hours only]
- Check who is tracking right now, one call per person, when the team has at most this many people: [15]
- Show the type of leave (vacation, sick leave…) to managers: [no, say "on leave" or "out" only]

## Hours checks

- A day counts as logged when it has at least this many minutes of worked time: [1]
- Count today as missing only after this local time: [17:00]
- Escalate to a manager after this many consecutive missed working days: [3]
- Look back this many working days when computing streaks: [10]
- Hours expected per day for people with no schedule: [8, Monday to Friday]

## Reminders

- How to send reminders: [Slack or Teams connector if this assistant has one; otherwise draft the message and let the person send it]
- Send reminders as direct messages only, never in a public channel: [yes]
- Sign messages as: [HR Manager]
- Mention the tool by name in reminders ("in TrackingTime"): [yes]
- Days when reminders are not sent (weekends are always skipped):

## Time off approvals

- Who may approve time off: [anyone with an Admin or Project Manager role in TrackingTime]

## Reports

- Compliance window in days: [30]
- Working week for team percentages: [Monday to Friday]
- Where to post reports (only if a Slack or Teams connector is available): [don't post, show in the chat]
