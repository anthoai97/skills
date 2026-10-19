---
name: principles
description: Engineering principles for planning, implementing, debugging, testing, and reporting results. Use when designing or changing code, writing tests, debugging repeated failures, or trusting a measured result.
---

# Principles

Each line is the short rule. Read the linked file for the full principle when it
applies to the task: why it matters, the steps, and the signs you skipped it.

| Principle | Short rule | Apply when |
| --- | --- | --- |
| [Explain the number](references/explain-the-number.md) | State the run count, the spread, and what limits a result, and rule out other explanations. | Trusting or reporting a measured result |
| [Prove it works](references/prove-it-works.md) | Check the real result, not tests, mocks, or self-reports. | Before calling a task done |
| [Attack the premise](references/attack-the-premise.md) | After two failed fixes on one assumption, test the assumption. | Repeated failures on the same check |
| [Encode lessons in structure](references/encode-lessons-in-structure.md) | Turn a repeated rule into a lint, hook, fixture, or script. | Writing the same instruction twice |
| [Boundary discipline](references/boundary-discipline.md) | Validate data once where it enters, then trust it inside. | Adding validation or error handling |
| [Type system discipline](references/type-system-discipline.md) | Give values that mean different things their own types. | Designing types or signatures |
| [Model the domain](references/model-the-domain.md) | Put each rule in one data structure, not scattered branches. | Stateful or heavily branching logic |
| [Test behavior, not implementation](references/test-behavior-not-implementation.md) | A test fails when behavior breaks and passes when only internals change. | Writing, changing, or keeping a test |
| [Build the lever](references/build-the-lever.md) | Write a small rerunnable script instead of working by hand. | Non-trivial edits, comparisons, or checks |
