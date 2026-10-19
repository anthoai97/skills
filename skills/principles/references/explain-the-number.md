# Explain the number

Apply before you trust, report, or act on a number you measured: a speedup, a
regression, a latency, a throughput, or an eval score.

**Why:** A number without an explanation may measure something other than the
work you think. Acting on it spends effort on the wrong thing.

## Steps

1. **Name what limits the result.** Ask "why is it not twice as good?" Name the
   resource or code path that bounds it, such as a CPU core, a lock, the disk, the
   network, an API rate limit, or the load generator itself. Take it from a
   profile or from counters recorded during a run, then map it to source. A guess
   from reading the code is not a limiter.
2. **List what else the number could be measuring, and rule each one out with
   evidence.** The usual suspects:
   - errors or failed runs counted as fast runs
   - skipped or cached work
   - code that never ran
   - one side of a comparison left on default settings
   - noise from too few runs
   - a setup change, such as a different input, room, dataset, or model
   - a piece too small to matter end to end
3. **Keep the evidence with the number.** Report the run count, the spread
   across runs, and the limiter in the notes, PR, or a linked artifact.

For an eval or LLM result, ask the same of the trials. Did every run do the
task? Does the gap hold across trials and models? Does the scenario matter? One
run of a nondeterministic system proves little.

## You skipped this when

- The evidence behind a number has no run count, no spread, or no named limiter.
- The time saved is larger than the total time the changed piece took.
- A score moved after you also changed the test input or setup, and you credit
  the code change alone.

Distinct from [Prove it works](prove-it-works.md), which checks that an output is
real.
