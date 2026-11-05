# Who's out and holidays

A calendar view for the team: who is out on which days, and which days are holidays. For the manager, and for anyone planning around colleagues.

## Who's out

1. Range: this week by default (Monday to Sunday), or the dates asked.
2. `list_timeoffs` with `from`, `to`. Approved requests (`time_off_status: APPROVED`) are **out**; pending ones are **requested** and are shown as such to managers only.
3. `list_holidays` with `from`, `to`. Each holiday has `date`, `name` and `country`.
4. Show per day:

```
This week
Mon 9 · Holiday: Visita papal
Tue 10 · Lucía out (requested, not approved yet)
Wed 11 · —
Thu 12 · —
Fri 13 · Maxi out (afternoon)
```

Say "out", not the type of leave, unless the viewer is the person, a manager, or `config.md` allows it.

## Is a date a holiday?

`list_holidays` with `from` = `to` = that date. Pass `from` and `to`; the `year` filter is ignored by the connector.

## Add a holiday (managers)

1. Confirm: "Add 'Company day' on 24 December as a holiday for everyone?"
2. On yes: `create_holiday` with `date` (`YYYY-MM-DD`) and `name`. The tool has no `confirm` flag, so the yes in the chat is the gate.
3. `update_holiday` and `delete_holiday` work the same way for changes.

## Don'ts

- Don't show reasons or notes from requests.
- Don't mark someone as out from anything other than an approved request or a holiday.
