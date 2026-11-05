---
description: Check a pay period is ready and lock it in TrackingTime after confirmation (admins)
argument-hint: "[month or date range]"
---

Use the payroll-assistant skill, workflow "Close period" (references/close-period.md).

Period: $ARGUMENTS
If that is empty, use the last closed period. Run the readiness check first, show the list of people and the lock date, and lock only after an explicit yes.
