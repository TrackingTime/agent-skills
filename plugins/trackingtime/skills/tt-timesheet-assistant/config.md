# Timesheet Assistant · company settings

Edit the values after each colon. Leave a value empty to use the default in brackets.
This file is the only thing you need to change to adapt the agent to your company.

## Basics

- Company name:
- Language for replies: [same as the person writing]
- Use emojis: [no]
- Timezone if people don't have one set: [the person's own]

## Clock in / clock out

- Default task when someone clocks in without saying what they'll work on (exact task name in TrackingTime): [ask the person]
- Default project for that task: [ask the person]
- Ask what they'll work on at clock in: [yes]
- Warn if someone clocks in more than this many minutes before their schedule starts: [60]
- Warn if a timer has been running longer than this many hours: [10]

## Breaks

- Name breaks in the entry notes (for example "Lunch"): [yes]
- Remind after a break of this many minutes, if the person comes back to the chat: [60]

## Fill my timesheet

- Minimum entry length in minutes: [15]
- Round entries to: [15 minutes]
- Mark entries as billable by default: [use the project's default]

## End-of-day report

- Compare against the person's work schedule: [yes]
- Where to post it (only if a Slack or Teams connector is available in this assistant): [don't post, show it in the chat]

## My period

- A day counts as logged when it has at least this many minutes of worked time: [1]
- Hours expected per day for people with no schedule: [8, Monday to Friday]
- Default period when none is named: [this month, up to today]

## Time off

- Default start and end times for a full day when the person has no schedule: [09:00 to 18:00]
- Half day means: [morning 09:00 to 13:00, afternoon 14:00 to 18:00]
- Who approves requests (name or role, shown to the person after a request): [the account's approvers]
