# Test behavior, not implementation

Apply when you write, change, or keep a test.

A test is a claim about what the code does for its users: a caller, an end user,
or another service. Behavior is what those users can observe through the
interface they use: return values, errors, state they can read back, and effects
outside the code, such as a request sent, a row written, or a message emitted.
Implementation is what they cannot observe: private helpers, internal call
order, intermediate data, and which internal piece did the work.

## Two checks

Judge each test against two imagined edits:

1. **Break the behavior.** Make the code return a wrong value, skip an effect,
   or do it twice. If the test still passes, it proves nothing. Common causes:
   - an assertion looser than the contract
   - an expected value computed by the code under test
   - a restated constant or prompt string that never runs the code that reads it
   - an assertion on data the test built itself
2. **Change the internals.** Keep every observable result the same and
   restructure the code. If the test now fails, it is pinned to the
   implementation. It needs a rewrite on every refactor and still catches no bug.

Keep a test that catches the first edit and survives the second. Rewrite or
delete the rest.

## Writing a good test

Drive the code through its users' interface with a concrete input. Derive the
expected value from the requirement, not from a run of the code. Assert what the
contract promises, no less and no more.

Example: `assert PULL_OUT == 0.56` restates a constant and tests nothing. "A
four-chair dining set is rejected in a room too small to pull the chairs out"
tests behavior, and it still passes if the constant moves into a config table.

## The contract decides

- When "an empty cart never charges" is the promise, asserting that the payment
  client got no call is behavior. Pair it with a case where the charge happens,
  so the test shows it can see a call.
- The payload a mocked external service receives is behavior, because that
  service sees it. A call to an internal helper is implementation.
- An exact error message pins wording no caller reads. The error type callers
  branch on is the contract.
- A test can pin an invariant instead of a call, such as a key that must exist in
  two tables, or a type check. The invariant is the behavior.
