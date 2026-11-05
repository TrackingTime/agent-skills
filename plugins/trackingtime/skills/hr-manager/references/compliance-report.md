# Compliance report

For a manager. Shows, per person, which working days have entries over a window. Status only; no hours per task, no notes.

## Types

- **Daily** — one day (default yesterday). Same as the hours check, formatted as a report.
- **Weekly** — Monday to the last closed day of the current week, or a past week on request.
- **Monthly** — the window in `config.md` (default 30 days) up to yesterday.

## Steps

1. People, working days, holidays and approved leave as in `hours-check.md` steps 1 and 2, for the whole range.
2. Entries: `list_filtered_events` with `parameters: ["user"]`, **one call per week** (a month in one call is too large on bigger teams). Build a set of (person, date) with entries above the minimum.
3. Per person: logged working days ÷ scheduled working days (holidays and leave excluded). Current streak (logged or missed).
4. Team: average of the personal rates, and the share of people at 100%.

## Weekly layout

```
Weekly compliance · 2–6 November

| Name  | Mon | Tue | Wed | Thu | Fri | Week |
|-------|-----|-----|-----|-----|-----|------|
| Ana   |  ●  |  ●  |  ●  |  ●  |  ●  | 100% |
| Bruno |  ●  |  –  |  –  |  ●  |  ●  |  60% |
| Carla |  ●  |  ●  |  L  |  L  |  ●  | 100% |

● logged · – missing · L on leave · H holiday · · not scheduled
Team: 87% · 7 of 9 people complete
```

## Monthly layout

```
Compliance · last 30 days

Complete (≥ 95%): Ana, Carla, …
Mostly complete (75–94%): Bruno 88%
Needs a hand (< 75%): Diego 62%, 4-day streak

Team: 84%
```

## Rules

- The report goes to the person who asked and, if `config.md` allows it, to the channel there. Never to the people in it.
- Don't rank people from best to worst. Group them as above, alphabetically inside each group.
- "Needs a hand", not "worst performers". The point is to offer help, and the manager decides what to do.
