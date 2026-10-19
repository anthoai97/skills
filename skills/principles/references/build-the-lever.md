# Build the lever

Apply to any work that is not trivial: edits, migrations, comparisons, analyses,
and checks.

Build the tool that does or proves the work instead of doing it by hand.

**Why:** A script, codemod, or generator does the work the same way every time
and reruns for free. It is one artifact a reviewer can read and rerun. Work done
by hand can only be checked by doing it again. A script turns "trust me" into
"run this".

## How

- Do the first unit by hand to learn the recipe, then build the tool. Prove it by
  running it on that unit and diffing against your hand-done version. Make it
  safe to rerun.
- Use a codemod or script for edits, a generator for repetitive files, a query
  for analysis, and a rerunnable check for verification.
- For a comparison you will repeat, such as old values against new ones, write a
  short script instead of a hand-made table, so it reruns when the inputs change.
- Prefer one script over many agents. If the tool can process every unit in one
  pass, run it yourself instead of fanning out agents to apply it by hand.
- When you do fan work out to agents, write the recipe, the verification, and
  the do-not-touch limits in one file they all read, outside their write scope.
- Commit the tool when the work outlives the session.

## Keep it small

Build the smallest script that does or proves the job, never a framework. Skip
the lever only when the task is trivial, a couple of obvious edits you can see at
a glance. The bar is triviality, not repetition: a one-off still earns a script
when the script is what makes the work checkable.

## You skipped this when

You cite this principle and the diff has no script, codemod, generator, or shared
recipe file.

Distinct from [Encode lessons in structure](encode-lessons-in-structure.md),
which turns a recurring rule into a lasting guardrail.
