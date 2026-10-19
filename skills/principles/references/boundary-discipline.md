# Boundary discipline

Apply when you add validation, error handling, or framework wiring.

Put validation, type narrowing, and error handling at the system's boundaries.
Trust the data inside. Keep business logic in plain functions and keep the
framework layer thin.

**Why:** Validation scattered through the code is noisy, repeats itself, and
gives a false sense of safety. Logic tangled with framework wiring cannot be
tested without the framework.

## Where the boundaries are

Data enters the system at: CLI arguments, config files, environment variables,
HTTP requests, external APIs, network messages, database rows, files, and LLM
output. LLM output is external data, so parse and validate it like any other
untrusted input.

## The pattern

- **At a boundary:** validate, parse raw data into domain types, return clear
  errors, and handle failures defensively.
- **Inside the system:** pass typed data, let errors propagate, and do not
  validate again. Trust the types.
- **Across a boundary:** expose domain concepts, not the other side's private
  format. Do not pass transport, storage, or framework types through the core.

## Applications

- Validate config when it is parsed, not inside business logic.
- Do not add null checks deep in a call chain when the boundary already checked.
- Keep business rules in plain functions with no framework imports.
- Parsing is a plain transform from raw input to typed state.
- Prompt building is a plain transform from structured state to a string.
- Scoring is a plain transform from state to results.

## Tests

- "Is this data crossing a system boundary right now?" If not, the validation is
  redundant.
- "Can this be a plain function that the framework layer only calls?" If yes,
  extract it.
