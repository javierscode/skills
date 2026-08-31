# skills

My skills for coding agents (Claude Code, Codex, Cursor).

## Install

```bash
npx skills@latest add javierscode/skills
```

## Skills

### You invoke these

Typed as `/name`. Nothing else can reach them, so this list is what you have to remember.

- **[commit-this](./skills/commit-this/)** — cuts your working tree into one commit per intent, shows you the proposal, and commits once you approve.
- **[interview-me](./skills/interview-me/)** — interviews you one question at a time, working a design tree, until you agree on what you actually want.
- **[interview-me-with-docs](./skills/interview-me-with-docs/)** — the same interview, with the glossary and the ADRs written as the decisions settle.

### The agent invokes these

Reached on its own when the task fits, or by the skills above. You can type them too.

- **[domain-modeling](./skills/domain-modeling/)** — sharpens your project's vocabulary while you talk, writing the glossary and the ADRs under it the moment they settle.
- **[interviewing](./skills/interviewing/)** — the design-tree interview itself, behind both `/interview-me` commands.

## License

MIT — see [LICENSE](./LICENSE).
