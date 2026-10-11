# 🛡️ CAPTCHA Clean Workspace Protocol

> **The Industrial Clean Workspace, Anti-Slop Architecture & Engineering Discipline Protocol for AI Coding Agents.**  
> *Author: CAPTCHA (@CAPTCHAAAAA)*

[![Protocol Version](https://img.shields.io/badge/Protocol-v1.0.0-blue.svg)](#)
[![Antigravity Ready](https://img.shields.io/badge/Antigravity-Plugin%20%26%20Skill-emerald.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](#)

---

## 🌟 Why This Exists (The Problem with AI Coding)

When AI coding assistants (Claude, Codex, Gemini, GPT) work on complex projects over multiple turns, they almost invariably degrade the codebase:
1. **Directory Pollution**: Dumping scratch scripts, temporary bundles, test logs, and intermediate mocks directly into the project root.
2. **"Slop" Architecture**: Rather than solving problems at the root, AIs love "patching" symptoms by stuffing boolean flags (`if (isSpecialCase)`), CSS `!important` hacks, and redundant wrapper divs into already bloated 1,000-line files.
3. **Broken Rollbacks**: Reverting a mistake by writing reverse diff-patches on top of broken code, introducing secondary regression bugs.
4. **Session Amnesia**: New AI chat sessions routinely propose solutions that the human developer already evaluated, criticized, and firmly rejected.

**`captcha-clean-workspace`** codifies the battle-tested engineering methodologies derived from production multi-platform software. It forces AI agents to adhere to rigorous physical isolation, anti-slop decoupling, verifiable delivery, and negative knowledge retention.

---

## 🏛️ The 5 Pillars of Governance

```text
┌────────────────────────────────────────────────────────────────────────┐
│                      CAPTCHA WORKSPACE TOPOLOGY                        │
├────────────────────────────────┬───────────────────────────────────────┤
│    TRACKED SOURCE CODE         │      LOCAL HEADQUARTERS (Local/)      │
│  (Pure, Minimal, Versioned)    │   (100% Gitignored Private Base)      │
├────────────────────────────────┼───────────────────────────────────────┤
│  ├── src/                      │  ├── cache/      (Junctioned npm/deps)│
│  ├── package.json              │  ├── artifacts/  (Builds & Installers)│
│  └── .worktrees/               │  ├── evidence/   (Diffs, Logs, Proofs)│
│      ├── feature-a/            │  ├── docs/       (Handover & Records) │
│      │   └── WORKTREE.md       │  └── scratch/    (Throwaway Scripts)  │
│      └── feature-b/            │                                       │
└────────────────────────────────┴───────────────────────────────────────┘
```

### 1. Local Headquarters Physical Isolation (`Local/` Paradigm)
The project root MUST remain pristine. Only version-controlled source files exist in the root. All local operations, dependency caches, and build outputs MUST live inside a dedicated `Local/` headquarters directory.

### 2. Self-Contained Worktree Lifecycles (`.worktrees/` Standard)
Never develop directly on `main`. All feature development and refactoring takes place inside isolated Git worktrees under `.worktrees/<task>/`. Every worktree must declare its boundaries and invariants in a `WORKTREE.md` file.

### 3. Anti-Slop Architecture & Facade Decoupling (高内聚低耦合)
- **Thin Facade**: Central orchestrators and dispatchers MUST stay <= 300 lines of code.
- **Autonomous Services**: Heavy logic lives in autonomous domain services.
- **State Mutex Decoupling**: Mutually exclusive states (e.g., Stopped vs. Running) MUST be split into distinct single-responsibility components, not managed via tangled boolean flags.

### 4. Verifiable Closed-Loop Delivery & Clean Rollback
- **The 5-Step Loop**: Edit Source -> Static Typecheck -> Build/Sync -> Real Execution -> Collect Evidence.
- **True Rollback**: Reverts are strictly performed via clean `git checkout <baseline>`. Never patch on top of a broken build.

### 5. Seamless AI Handover & Negative Knowledge Archive
A session handover document (`AGENT_HANDOVER.md`) MUST explicitly record **"The Hall of Mistakes & Rejected Solutions"**—documenting what the user rejected and why—ensuring future AI sessions never repeat the same blunder.

---

## 🚀 Installation & Usage

### As an Antigravity Plugin / Skill
Clone or place this repository into your global Antigravity customizations directory:
```bash
git clone https://github.com/CAPTCHAAAAA/captcha-clean-workspace.git ~/.gemini/config/plugins/captcha-clean-workspace
```
Or use the skill directly:
```bash
cp -r skills/captcha-clean-workspace ~/.gemini/config/skills/
```

### Triggering in Any Project
Whenever you ask your AI assistant:
> *"Initialize this project with the CAPTCHA clean workspace structure"*  
> *"Set up an isolated worktree for this feature"*  
> *"Refactor this monolithic module following anti-slop governance"*

The agent will automatically load this protocol and enforce strict discipline.

---

## 📄 License
MIT © CAPTCHA
