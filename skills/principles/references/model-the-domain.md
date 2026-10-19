# Model the domain

Apply when you write stateful logic, or when code branches a lot or repeats the
same assumption across files.

Put the real domain in a data structure instead of scattering it across
conditionals. A structure that matches the domain makes invalid states
impossible and deletes branches. Choosing it while writing is cheap. Recovering
it later looks like a refactor and gets postponed.

## Reach for

- A state machine instead of scattered booleans, phases, or lifecycle checks.
- A typed model instead of loose parameters or repeated shape assumptions.
- A table, map, registry, or discriminated union instead of branching spread
  across files. For example, one policy table per kind of thing (room type,
  plan tier, region) instead of the same rules split across one module per kind
  and again across each pipeline stage. A rule change then becomes one edit.
- A reducer or command/event model instead of ad hoc state changes.
- A module organized around one body of domain knowledge instead of a sequence
  such as load, validate, transform, save. Execution order is not ownership.
- A queue, cache, index, graph, or tree where the access pattern calls for it.
- When nothing fits, work out what the code must never allow and how the data is
  read, then pick the structure that encodes exactly that.

## Do not force it

Prefer plain code when the current shape is clear, local, and unlikely to grow.
Be skeptical of an abstraction that adds indirection without removing branches,
duplicated rules, invalid states, or lifecycle risk.

## You skipped this when

- A new feature grows an existing if/else chain by one more branch.
- A second boolean must stay in sync with the first.
- Finding where a rule lives takes a map of several files.
- Modules named after phases repeat the same domain rules at each step.
