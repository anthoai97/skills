# Type system discipline

Apply when you design types, review a function signature, or write code in a
typed language.

Make the type checker reject impossible states, mixed-up values, and unhandled
cases. Prefer designing errors and special cases out of existence over adding
handlers for them. For TypeScript syntax, see the `typescript-best-practices`
skill.

## Rules

- **Give values that mean different things their own types.** Two kinds of ID
  are both strings underneath but must not be interchangeable. Use a branded
  type in TypeScript, `NewType` in Python, or a newtype elsewhere. Validate once
  when the value is created, then trust the type. If two arguments share a
  primitive type but mean different things, give them distinct types.

  Example: when one flow sends an `asset_id` and the backend expects a
  `source_id`, plain strings let the mistake compile and pass tests. Distinct
  types make it a type error.
- **External data is untyped until parsed.** API payloads, JSON, LLM output, CLI
  arguments, config, environment variables, and database rows all need a parse
  function at the boundary that produces the typed model. See
  [Boundary discipline](boundary-discipline.md).
- **Make illegal states unrepresentable.** Use a discriminated union instead of
  several optional fields that must agree. Use an enum or literal type instead of
  a free string.
- **Handle every case.** Switch over a union exhaustively so a new case fails to
  compile until it is handled.
- **Derive types from the schema that owns the shape.** When an OpenAPI spec,
  database migration, Pydantic model, protobuf, or contract file defines a shape,
  derive from it instead of writing a parallel type by hand.

## You skipped this when

- A function takes two or more arguments of the same primitive type that mean
  different things.
- The same shape is defined by hand in two places.
- A new variant can be added without the compiler pointing to every place that
  must handle it.
