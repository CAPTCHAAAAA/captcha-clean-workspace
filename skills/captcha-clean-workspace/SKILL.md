---
name: captcha-clean-workspace
description: Use when initializing a new project, structuring an engineering workspace, managing git worktrees, refactoring monolithic or tangled code, establishing clean rollback and delivery discipline, or standardizing AI handover and negative knowledge across any software codebase.
---

# CAPTCHA Clean Workspace & Engineering Governance Protocol

## Overview

**The gold standard for keeping codebases permanently clean, decoupled, and disciplined during AI-assisted development.**

This protocol codifies the battle-tested engineering methodologies derived from mission-critical multi-platform systems:
1. **Physical isolation between Git tracked source and untracked local artifacts (`Local/` paradigm)**.
2. **Strict Git worktree isolation with self-contained contracts (`WORKTREE.md`)**.
3. **Anti-slop architecture: Clean facade dispatcher (<=300 lines) + autonomous domain services**.
4. **Verifiable closed-loop delivery and clean rollback (no patch-on-broken-code hacks)**.
5. **Seamless AI handover via negative knowledge (archiving user rejections and forbidden traps)**.

---

## When to Use

- Initializing any new project from scratch (Web, Mobile, Desktop, Full-Stack, CLI).
- Structuring a repository to prevent AI from polluting the root directory with temporary scripts and build junk.
- Conducting major refactoring or branch experiments using Git worktrees.
- Resolving complex state conflicts or messy monolithic modules.
- Executing rollbacks or emergency reverts following broken releases.
- Handing over tasks across multiple AI chat sessions or teammates.

### When NOT to Use
- Single-file throwaway scripts or simple competitive programming exercises.
- Read-only code inspections without workspace mutations.

---

## The 5 Pillars of Governance

### Pillar 1: Local Headquarters Physical Isolation (`Local/` Paradigm)

**The Problem:** AI agents naturally dump scratch scripts, logs, intermediate bundles, mock data, and test reports directly into project roots or source directories, polluting version control and causing accidental commits.

**The Rule:** The project root MUST remain pristine. Only tracked source files and essential repo config exist in the root. **All untracked local operations MUST be strictly consolidated into a dedicated `Local/` headquarters (or equivalent private directory):**

```text
<project-root>/
├── src/                  # Tracked source code ONLY
├── package.json          # Standard configuration
└── Local/                # Dedicated local headquarters (100% gitignored)
    ├── cache/            # Dependencies & third-party upstream snapshots (mounted via junction/symlink)
    ├── artifacts/        # Validated final builds & release packages
    ├── evidence/         # Test run logs, profiling, diff proofs, screenshots
    ├── docs/             # Long-term local guides, CURRENT_STATE.md, AGENT_HANDOVER.md
    └── scratch/          # One-off scripts, throwaway test dirs (cleaned upon completion)
```

**Dependency Hygiene:** When working on submodules or isolated experiments, mount heavy `node_modules` or toolchains from `Local/cache/` using directory junctions/symlinks instead of bloating individual workspace folders.

---

### Pillar 2: Self-Contained Worktree Lifecycles (`.worktrees/` Standard)

**The Problem:** Developing directly on `main` or `master` leads to broken states, dirty Git statuses, merge disasters, and unfinished experiments polluting stable branches.

**The Rule:**
1. **Isolated Development:** All experimental features, refactorings, and release hardening MUST occur inside isolated Git worktrees under `.worktrees/<task-name>/`.
2. **Contract-on-Creation (`WORKTREE.md`):** The very first step of creating any worktree is generating a local `WORKTREE.md` declaring:
   - **Scope & Boundaries**: Exactly what this branch modifies and what it is forbidden from touching.
   - **Architectural Invariants**: Non-negotiable structural rules.
   - **Activity Log**: Chronological record of real actions and decisions.
   - **Delivery Gate**: Concrete verification commands required before merge.
3. **Double Cleanliness:** Intermediate notes and draft thoughts remain inside `WORKTREE.md`. Only final milestones are registered in the global project ledger.
4. **Clean Removal:** NEVER delete a worktree directory with `rm -rf` (which corrupts Git index metadata). Always retire it cleanly:
   ```bash
   git worktree remove .worktrees/<task-name>
   git worktree prune
   ```

---

### Pillar 3: Anti-Slop Architecture & Facade Decoupling (高内聚低耦合)

**The Problem:** When faced with a bug or feature request, AI agents routinely take the lazy path: injecting temporary boolean flags (`if (isLoading && !isOldMode)`), adding inline CSS hacks with `!important`, writing global window variables, or wrapping components in redundant container `div`s, bloating existing files into multi-thousand-line monolithic "slop".

**The Rule:**
1. **Root-Cause Cure Over Surface Patch:** Always cure the underlying system cause through architectural decoupling rather than papering over symptoms with boolean patches.
2. **Clean Facade Pattern (<= 300 Lines):** Central orchestrators and plugin interfaces MUST remain thin dispatchers/facades (strictly <= 300 lines of code). All heavy business logic, I/O, network requests, and data migrations MUST live inside autonomous domain services.
3. **State Mutex Decoupling (Instance Card Principle):** When two states conflict or exhibit divergent lifecycles, **split them into distinct single-responsibility components** (e.g., splitting a bloated card into `StoppedCard` and `RunningConsoleCard`), bound together by an outer coordinator handling smooth transitions.
4. **Strict Single-Source Contracts:** Inter-module, IPC, and API communications MUST use strongly typed contracts without implicit `any`, untyped tuples, or defensive `as unknown as Type` casts.

---

### Pillar 4: Verifiable Closed-Loop Delivery & Clean Rollback

**The Problem:** AI agents often edit a line of code and instantly proclaim "I have fixed the issue", without compiling, without building, and without verifying the real running application. Furthermore, when asked to revert, agents often write reverse diff-patches on top of broken code instead of performing a clean checkout.

**The Rule:**
1. **The 5-Step Delivery Loop:** No task is complete until it passes the closed loop:
   ```text
   Source Modification -> Static Typecheck -> Build/Sync -> Real Environment Execution -> Verifiable Evidence
   ```
2. **Clean Rollback Discipline:**
   - **Never patch on top of a broken build.**
   - A rollback means performing a clean `git checkout <baseline-commit>`.
   - Verify that the binary/AST/bytecode matches the target baseline with zero semantic loss before reapplying the single requested change.
3. **Source vs. Output Boundary:** NEVER directly edit generated build artifacts (`dist/`, `build/`, `public/bundle.js`). All edits must occur in the editable source files and flow through the official build pipeline.

---

### Pillar 5: Seamless AI Handover & Negative Knowledge Archive

**The Problem:** LLM context windows are stateless across sessions. When a new AI session takes over, it forgets past failures and repeatedly proposes solutions that the user already evaluated, criticized, or rejected.

**The Rule:**
1. **Pre-flight Harmless Self-Check SOP:** The first action upon entering any project is running non-destructive health checks:
   - Check clean Git status across repositories (`git status --short`).
   - Run the workspace compliance guard script (`Check-Workspace.ps1` or `npm run check:workspace`).
2. **Archive Negative Knowledge (User Rejections):** Maintain an explicit **"Hall of Mistakes & Rejected Solutions"** in the project's handover documentation:
   - Record what approach was attempted.
   - Record why it failed or why the user rejected it.
   - Enforce it as an absolute red line for future sessions.
3. **No Unsolicited "Micro-Innovations":** When existing production components or styles already exist, replicate their classes, tokens, and structure 100% identically. Do NOT invent new font sizes, button radii, or color variants unprompted.

---

## Red Flags - STOP and Correct Course

If any of these thoughts occur, you are violating the protocol. **STOP IMMEDIATELY:**

| Rationalization / Thought | Reality & Correct Action |
| :--- | :--- |
| *"I'll just put this temporary test script in the root directory for now."* | **Violation.** Put it in `Local/scratch/` or delete it immediately. |
| *"I'll just add an `if (isSpecialCase)` flag to this 1000-line file."* | **Violation.** Decouple the responsibility into a dedicated module or sub-component. |
| *"This is just a small bug, I don't need to create a worktree."* | **Violation.** If it touches core logic, isolate it in `.worktrees/`. |
| *"I can just undo the error by writing a patch that reverses the changes."* | **Violation.** Checkout the original clean baseline commit directly. |
| *"I edited the file, so the task is finished."* | **Violation.** You must compile, build, run, and collect evidence before claiming success. |
| *"I'll slightly tweak this button style to make it look cooler."* | **Violation.** Never introduce unrequested aesthetic changes. Match existing tokens 1:1. |

---

## Standard Checklist for New Projects

When initializing or governing a project with this protocol, verify:

- [ ] Project root contains only tracked source code, build configs, and `Local/` (gitignored).
- [ ] `Local/` directory created with `cache/`, `artifacts/`, `evidence/`, `docs/`, `scratch/`.
- [ ] Dependencies mapped via Junction/Symlink if developing in sub-modules.
- [ ] `.worktrees/` directory designated for all multi-step feature development.
- [ ] Each worktree initialized with a comprehensive `WORKTREE.md`.
- [ ] Dispatcher/Plugin files strictly constrained under 300 lines.
- [ ] Automated workspace guard script (`Check-Workspace`) established to prevent drift.
- [ ] `CURRENT_STATE.md` tracks ground-truth milestones, and `AGENT_HANDOVER.md` logs negative knowledge.
