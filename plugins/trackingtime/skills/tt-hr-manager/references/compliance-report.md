# Compliance report

For a manager. Shows, per person, which working days have entries over a window. Status only; no hours per task, no notes.

## Types

- **Daily** — one day (default yesterday). Same as the hours check, formatted as a report.
- **Weekly** — Monday to the last closed day of the current week, or a past week on request.
- **Monthly** — the window in `config.md` (default 30 days) up to yesterday.

## Steps

1. People: `list_users` (`filter: ACTIVE`), minus the people under *skip* in `config.md`.
2. Per-day verdict for every person and day in the range from `missing-day.md` (working days, source, minimum, pending requests). With Time Cards off, call `list_filtered_events` **one week at a time**; a month in one call is too large on bigger teams. With Time Cards on, one `get_timecard` per person for the range.
3. Per person: logged working days ÷ working days (holidays and leave excluded, days "requested, pending approval" excluded too). Current streak (logged or missing).
4. Team: average of the personal rates, and the share of people at 100%.

## Weekly layout

```
Weekly compliance · 2–6 November

| Name  | Mon | Tue | Wed | Thu | Fri | Week |
|-------|-----|-----|-----|-----|-----|------|
| Ana   |  ●  |  ●  |  ●  |  ●  |  ●  | 100% |
| Bruno |  ●  |  –  |  –  |  ●  |  ●  |  60% |
| Carla |  ●  |  ●  |  L  |  L  |  ●  | 100% |

● logged · – missing · P requested, pending approval · L on leave · H holiday · · not scheduled
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
