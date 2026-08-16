---
name: context-manager
description: Use at the beginning and end of every substantive Codex task in any repository to load, maintain, compress, and persist project-specific context. Trigger when starting work, resuming a project, receiving user corrections or confirmed decisions, discovering important project facts, changing goals/constraints, creating important artifacts, or preparing a handoff. Keep projects isolated and never mix facts across repositories.
---

# Context Manager

Maintain a small, durable, project-local context layer so future Codex sessions can resume work without rereading the whole repository or relying on chat history.

## Core principles

1. Project context is local to the current repository. Never copy domain facts, decisions, paths, datasets, assumptions, or TODOs from another repository unless the user explicitly asks.
2. Current explicit user instructions outrank stored context. If they conflict, follow the new instruction and update the stored context.
3. Persist only information that will materially improve future work. Do not turn logs, transient debugging output, or speculative ideas into durable facts.
4. Separate facts from hypotheses. Mark uncertain items explicitly.
5. Keep context compact. Prefer summaries and pointers to source files over copying large source text.
6. Do not silently rewrite history. Record material reversals in the decision log.
7. Never store secrets, credentials, tokens, private keys, or unnecessary sensitive data.

## Project context location

Use this project-local directory by default:

```text
.context/
  PROJECT_CONTEXT.md
  DECISIONS.md
  OPEN_ITEMS.md
  SOURCE_MAP.md
  SESSION_HANDOFF.md
```

If the repository already has an established context/memory convention, reuse it rather than creating a duplicate system.

## Startup workflow

At the beginning of every substantive task:

1. Determine the repository/workspace root.
2. Look for `.context/` and project `AGENTS.md` files.
3. If `.context/` does not exist, create it from the templates in this skill when workspace writes are allowed. Do not block the user's task merely because initialization is unavailable.
4. Read in this order:
   - `.context/PROJECT_CONTEXT.md`
   - `.context/OPEN_ITEMS.md`
   - `.context/SESSION_HANDOFF.md`
   - only the relevant portions of `.context/DECISIONS.md` and `.context/SOURCE_MAP.md`
5. Build a working snapshot containing only:
   - current project identity and goal;
   - current task;
   - confirmed constraints and conventions;
   - relevant decisions;
   - relevant files/data/sources;
   - unresolved blockers;
   - next likely actions.
6. Cross-check the snapshot against the user's current request. The current request wins on conflict.
7. Do not reread the entire repository unless the task actually requires it.

## What belongs in durable context

Persist an item when at least one condition is true:

- The user explicitly confirms or corrects an important fact.
- A technical or methodological decision is made and future work depends on it.
- A stable project convention is established: units, naming, folder structure, plotting rules, coding conventions, data schema, validation criteria, model assumptions, etc.
- A key file, dataset, standard, script, experiment, or output becomes the canonical source.
- A milestone is completed.
- A blocker or missing input must survive across sessions.
- A future task would otherwise require rediscovering the same information.

Do not persist:

- temporary console output;
- one-off guesses;
- failed approaches with no future value, unless the failure prevents repeated mistakes;
- duplicated text already captured by a concise source pointer;
- secrets or credentials.

## Update triggers

Update context immediately after any of these events:

1. User correction: update the canonical fact and, if material, append a decision entry.
2. User confirms a choice: append to `DECISIONS.md` and reflect the current state in `PROJECT_CONTEXT.md`.
3. Important file/source discovered or created: update `SOURCE_MAP.md`.
4. New blocker/question: update `OPEN_ITEMS.md`.
5. Milestone completed: update `PROJECT_CONTEXT.md` and remove resolved open items.
6. Before a natural task handoff or session end: rewrite `SESSION_HANDOFF.md` so another Codex session can continue directly.

## File responsibilities

### PROJECT_CONTEXT.md

Keep this as the compact canonical snapshot. Target roughly 1–3 pages, not a chronological diary.

Required sections:

- Project
- Primary objective
- Current phase
- Confirmed facts
- Constraints and conventions
- Current workflow
- Key artifacts
- Validation / definition of done
- Current status

### DECISIONS.md

Append only material decisions. Use newest-first entries:

```markdown
## YYYY-MM-DD — Decision title
- Decision:
- Why:
- Replaces: none | prior decision/date
- Affects:
```

Distinguish user-confirmed decisions from assistant recommendations.

### OPEN_ITEMS.md

Keep only unresolved items. Each item should have:

```markdown
- [ ] Item
  - Type: blocker | missing input | question | follow-up
  - Needed for:
  - Next action:
```

Delete or mark resolved items once closed; do not let this become an archive.

### SOURCE_MAP.md

Map important information to canonical sources instead of copying source content:

```markdown
| Topic | Canonical source | Location | Status | Notes |
|---|---|---|---|---|
```

Use paths, sheet names, section names, URLs, IDs, or commands as appropriate.

### SESSION_HANDOFF.md

Rewrite rather than append. Keep it short and operational:

- What was just done
- What changed
- What remains
- Exact next step
- Files to open first
- Known pitfalls / do-not-repeat failures

## Conflict handling

Use this precedence:

1. Current user instruction
2. More recent explicit user decision
3. Project-specific `AGENTS.md` / `AGENTS.override.md`
4. `.context/PROJECT_CONTEXT.md`
5. `.context/DECISIONS.md`
6. Older notes, comments, or inferred assumptions

When two durable sources disagree and the correct value cannot be established, do not choose silently. Record the conflict in `OPEN_ITEMS.md` and continue only where safe.

## Compression rules

When context grows too large:

1. Preserve current truths and active constraints.
2. Replace repeated history with a single canonical statement.
3. Move rationale/history to `DECISIONS.md` rather than bloating `PROJECT_CONTEXT.md`.
4. Replace copied source material with pointers in `SOURCE_MAP.md`.
5. Remove resolved open items from active context.
6. Keep only failures that teach a reusable "do not repeat" lesson.

## Cross-project isolation

Before persisting any fact, ask: "Is this true for this repository/project, or only for another project?"

Never migrate domain-specific content between repositories automatically. Global preferences may live in the global `AGENTS.md`, but project facts must stay project-local.

## User interaction policy

Do not interrupt normal work merely to announce routine context maintenance. Mention context changes only when they resolve a conflict, materially change the plan, or the user asks what was saved.

Do not ask the user to repeat information that is already present in the current project context or repository.

## End-of-task checklist

Before finishing a substantive task:

1. Did the user correct or confirm anything durable?
2. Did a key file/source/command become canonical?
3. Did any open item get resolved or created?
4. Did the current phase/status change?
5. Can a fresh Codex session continue from `SESSION_HANDOFF.md` without rereading the whole thread?

If yes to any item, update the relevant `.context/` files before finalizing the task.
