# Close period

Check that a pay period is ready, then lock it so entries up to the lock date can't be edited by the people who logged them. Locking is the one real write in this skill. It needs an Admin and an explicit yes.

## Readiness check

Run all of it and show one list before asking anything:

1. **Period summary** (`period-summary.md`) for the period, if not already in this conversation.
2. **Submission status**: `get_timecards_count` with `from` and `to` gives `submitted` and `pending_submission`. `list_timecards` with `from`, `to` and `users: [{"id": N}, …]` gives each person's `status` and `total_working_days`. Note: the per-period seconds in that call stay at 0 unless days were saved; use the summary for hours.
3. **Already locked**: `list_users` → each person's `lock_date`. People already locked on or after the period end are done.
4. **Unexplained absences** and **pending time off** from `absences.md`.
5. **Running timers** on the period's last day (see `absences.md`, step 6).
6. **Approval setting**: `get_me` → `apps[key = "timecards"].settings.needs_approval`. When true and `config.md` requires it, every time card must be submitted and approved before locking; otherwise warn and continue.

```
Close check · October 2026
Time cards: 12 submitted, 4 pending (Carla, Diego, Fede, Gabi)
Locked already: Ana (lock date 31 Oct)
Unexplained absences: Carla 2 days · pending time off: Diego 1 day
Running timers: none
Ready to lock: 15 people on 31 Oct. Carla has open items; lock her too?
```

## Lock

1. Build the list: one `{ "user_id": N, "lock_date": "YYYY-MM-DD" }` per person, `lock_date` = the period's last day (or the date in `config.md`). Leave out anyone the person excludes and anyone already locked on a later date.
2. Show the list in full: names and the date. Ask once: "Lock these 15 people through 31 October?"
3. On yes, call `lock_user_events` with `data` = the list and `confirm: true`. Not before.
4. Verify: `list_users` again and read `lock_date` for each person in the list. Report who is locked and who isn't.
5. Offer the export (`export.md`).

Unlocking is done in the TrackingTime web app (Settings → Users). Say so if asked; don't try to lock with an earlier date.

## Saving time card days

`save_timecard_day` writes a day's time card (in and out times) for a person. Use it only when the person explicitly asks to fix a specific day and has given the times, show the day before writing, and prefer pointing them to the Time Cards page in the web app, where the change is visible at once.

## Don'ts

- Don't lock because the summary "looks fine". Locking needs the person's yes on the list shown.
- Don't lock a period that is still running (end date in the future).
- Don't describe open items as faults. "4 time cards pending" is the whole sentence.
