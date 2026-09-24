# skills

My skills for coding agents (Claude Code, Codex, Cursor).

## Install

```bash
npx skills@latest add javierscode/skills
```

## Skills

### You invoke these

Typed as `/name`. Nothing else can reach them, so this list is what you have to remember.

- **[commit-work](./skills/commit-work/)** — cuts your working tree into one commit per intent, shows you the proposal, and commits once you approve.
- **[define-scope](./skills/define-scope/)** — interviews you one question at a time until every decision is settled, writing the glossary and the ADRs as it goes.
- **[implement-plan](./skills/implement-plan/)** — runs a plan's slices as parallel subagents, each one reviewed before it merges, into a single pull request.
- **[interview-me](./skills/interview-me/)** — interviews you one question at a time, working a design tree, until you agree on what you actually want.
- **[write-plan](./skills/write-plan/)** — turns what you decided in the session into a plan of vertical slices, one file per task, written once you approve the breakdown.

### The agent invokes these

Reached on its own when the task fits, or by the skills above. You can type them too.

- **[conventional-commits](./skills/conventional-commits/)** — where a commit is cut and how its message reads, so any skill that ends in commits writes them the same way.
- **[domain-modeling](./skills/domain-modeling/)** — sharpens your project's vocabulary while you talk, writing the glossary and the ADRs under it the moment they settle.
- **[interviewing](./skills/interviewing/)** — the design-tree interview itself, behind both `/interview-me` commands.

## License

MIT — see [LICENSE](./LICENSE).
