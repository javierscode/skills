# Constitution

A catalog of Agent Skills, published as `javierscode/skills` and installed with `npx skills@latest add javierscode/skills`. Everything here, this file included, is written in English, whatever language the conversation runs in.

Skills follow the open [Agent Skills spec](https://agentskills.io/specification) and must work unchanged in Claude Code, Codex and Cursor.

## Layout

```
skills/<name>/
├── SKILL.md          # Required: metadata + instructions
├── agents/openai.yaml  # required: Codex interface and invocation
├── scripts/          # Optional: executable code
├── references/       # Optional: documentation
├── assets/           # Optional: templates, resources
└── ...               # Any additional files or directories
```

`<name>` matches the frontmatter `name`: lowercase letters, digits and single hyphens, never leading or trailing.

## Invocation

Every skill is one of two kinds, and you declare the kind twice because no single field is portable.

**Model-invoked.** The agent fires it on its own, and the human can still type `/<name>`. The `description` is what gets loaded in every session of every project where the skill is installed. Declare nothing. Both agents default to this.

**User-invoked.** Only the human typing `/<name>` reaches it, and no other skill can. It costs no context. The cost is that only you remember it exists. Declare it in both places:

- In `SKILL.md` frontmatter, set `disable-model-invocation: true`
- In `agents/openai.yaml`, set `allow_implicit_invocation: false`

`disable-model-invocation` is a Claude Code field the spec does not define, so a strict spec validator flags it as unexpected. Keep it anyway. It is the only way to say this in Claude Code.

Cursor implements neither field. It reads the `description` and decides for itself, so a user-invoked skill can fire on its own there. That is the accepted price of portability, not a bug to work around.

Reach for model-invocation when the agent must find the skill by itself, or another skill must reach it. A skill you only ever type is user-invoked and costs no context.

## Writing the description

The `description` does different work in each kind, so write it differently.

**Model-invoked.** Says what the material is, plus one trigger per branch the skill handles. Front-load the leading word; the opening is where the triggering happens. Collapse synonyms. Two words naming one branch is one branch written twice. Cut identity the body already carries. Name the skip case when there is a real one the agent would otherwise grab.

**User-invoked.** A human-facing one-liner for the skill picker. No trigger list; the frontmatter already says nothing may fire it.

## Done

Add the skill to the list in `README.md` with the one-line hook a reader picks it by, then run:

```bash
./scripts/validate.sh
```

It checks the directory name against `name`, a non-empty `description`, `agents/openai.yaml` present, the two invocation declarations agreeing, and the skill listed in the README. The skill is not done until it passes.
