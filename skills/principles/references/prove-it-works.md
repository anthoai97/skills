# Prove it works

Apply after finishing a task, before you call it done.

Check the real result directly. Do not infer it from a stand-in, a self-report,
or "it compiles".

**Why:** Unverified work has unknown correctness. An indirect check, such as a
file timestamp, a fresh-looking output, an agent's own report, a mock, or an old
screenshot, feels cheaper than looking at the real thing. Acting on a wrong
inference costs far more than checking.

## Check the real thing

- Run the feature the way a user would, through the real entry point.
- Read the actual value, not a cached or derived copy of it.
- Check that a process is alive directly, not through state it left behind.
- Inspect the actual output: the diff, the written files, the request sent, the
  rows saved.
- When a check fails, suspect the way you observed before you suspect the
  system.
- Watch for side effects the stand-in hides. A mock that "records fine" may
  still trigger real work, so look at what actually happened, such as new run
  folders, API usage, or written files.

Passing tests are a stand-in when they exercise a different path from the real
one. If the real flow sends a different field, ID, or payload than the test, the
test proves nothing about the real flow.

## Script the check when you can

The strongest proof is a small script that reruns the same comparison, not a
one-time look. Write it, run it, and keep its output where a reviewer can rerun
it instead of trusting your word.

Keep the proof cheap. One real run, a recorded replay, or a targeted check is
usually enough. A full benchmark or many paid calls is rarely needed to prove a
change works.

## You skipped this when

- Your "done" rests on tests passing, a build succeeding, or an agent saying so.
- You never ran the changed flow end to end.
- You cannot point to the output that shows the behavior.
