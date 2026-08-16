# Context Manager Skill for Codex

This package installs a user-level Codex skill that maintains compact project-local context across repositories.

## Install on Windows

Open PowerShell in this extracted folder and run:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

The installer:

1. installs the skill to `$HOME\.agents\skills\context-manager`;
2. backs up any existing skill with the same name;
3. adds an idempotent auto-context block to `$HOME\.codex\AGENTS.md`;
4. preserves and backs up any existing global `AGENTS.md`.

Restart Codex if needed. Then use `/skills` to confirm `context-manager` is visible.

## Per-project state

For each repository the skill maintains:

```text
.context/
  PROJECT_CONTEXT.md
  DECISIONS.md
  OPEN_ITEMS.md
  SOURCE_MAP.md
  SESSION_HANDOFF.md
```

These files remain inside the project, so facts from one research/code project do not leak into another.

## Optional manual initialization

Normally Codex creates `.context/` when it first needs it. To initialize explicitly:

```powershell
& "$HOME\.agents\skills\context-manager\scripts\init-project-context.ps1" -ProjectRoot "D:\path\to\project"
```

## Why Skill instead of MCP

The core problem is a reusable behavior/workflow, which is a Skill's job. MCP becomes useful later if you want a central external context database shared across machines, users, or applications. The skill can later call such an MCP without changing the per-project workflow.
