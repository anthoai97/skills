# Encode lessons in structure

Apply when you catch yourself writing the same instruction a second time, or
when you notice a correction that keeps coming back.

Turn the rule into something that enforces itself instead of more text.

**Why:** Text depends on someone reading and remembering it. Agents and people
skip text, especially when another instruction says the opposite. A check runs
every time.

## Pick the structure

- **Lint or type check** for code patterns that must never appear.
- **Git hook** for commit messages, branch names, or PR targets. For example, a
  `commit-msg` hook that rejects a forbidden trailer, or a check that blocks
  `gh pr create` without the right `--base`.
- **Test fixture** for environment rules. For example, a `conftest.py` fixture
  that clears API keys so unit tests cannot call a paid service, with an
  explicit opt-in for the suites that need it.
- **Runtime check or metadata flag** for invariants the code must hold.
- **Script** for a procedure that must run the same way every time.

## Rules

- If the fix is structural, use only the structural fix. The repeated
  instruction is the symptom; delete it once the check exists.
- If the lesson needs judgment and cannot be encoded, make the instruction more
  prominent and add an example of the failure.
- Rules written in capitals are a sign that text alone has not worked. Those are
  the first candidates for a check.

Distinct from [Build the lever](build-the-lever.md), which scripts the work in
front of you. This one makes a recurring rule a lasting guardrail.
