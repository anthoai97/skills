# Attack the premise

Apply when two or more fixes that share one assumption have failed the same
check.

Suspect the assumption, not the fixes.

**Why:** Each failed fix is evidence against the belief it assumed. A third fix
on the same assumption spends effort where the evidence already says the cause
is not.

## Steps

1. **Write the assumption down.** It is the one sentence every failed fix took
   for granted. For example, "this room is big enough for the requested set" or
   "the prompt is the reason the model picks the wrong item".
2. **Test the assumption before the next fix.** Find an observation that would
   come out differently if the assumption were false, and make it. Look at how
   the failures are spread, not only at how large they are. Make the check
   rerunnable (see [Build the lever](build-the-lever.md)).
3. **Follow the evidence.**
   - If it contradicts the assumption, the cause is elsewhere. Look for what the
     failures share that the assumption did not predict.
   - If it confirms the assumption, ask the next "why". The earlier fixes may
     have treated a consequence instead of the cause.
4. **Remove the condition instead of compensating for it.** If one part always
   ends up on the losing side, change what puts it there. A mechanism that cleans
   up afterward leaves the cause in place and adds work on every run.

Some checks cannot pass at all. If the requirement itself is impossible, such as
a layout that does not fit the space, no amount of solver or prompt tuning will
fix it. Report that the premise is false and what would have to change.

## Stop

Do not start the next fix until the assumption is written down and tested.

Prompt and LLM tuning falls into this loop easily, because each tweak looks
plausible and runs are noisy. Two failed prompt changes on the same check are the
signal to stop and test the assumption.
