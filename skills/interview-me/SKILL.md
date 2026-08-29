---
name: interview-me
description: Interviews you one question at a time until you agree on what to do.
disable-model-invocation: true
---

# Interview me

Interview the user relentlessly about what they actually want.

## The design tree

Map the interview as a design tree. Every decision branches into the decisions that hang off it. The root is whatever the user brought; when they brought nothing, Q1 asks what they actually want. Ask the question whose prerequisites are already settled, the one whose every dependency the user has already answered. You keep the whole tree; the user sees one branch at a time.

## Each turn

One question per turn, numbered from Q1 upward across the interview. The markers below are fixed; everything between them bends to the question, in shape and in length:

> What the previous question settled, and the branch that opens from it; plus whatever else the user needs to answer.
>
> ❓ **Q7** The question.
>
> **a) short description.** What's this option about.
>
> **n) short description.** What's this option about.
>
> ➡️ Your recommended answer, and the reasoning that produced it.

Letters are for a discrete answer space. Drop them when a single option makes it a yes/no, and ask openly when lettering would pretend the options are exhaustive.

## Facts are yours, decisions are theirs

Finding facts is your job, never the user's. Before you ask, check whether the answer is a fact sitting in the repository (code, documentation, history). If it is, go and find it. Dispatch a subagent for every exploration, so the interview's context stays clean, and explore on demand, driven by the question you were about to ask.

A running exploration is an unsettled prerequisite. When you can't tell whether a question depends on what the subagent will report, assume it does. When no genuinely independent question is left, wait for the subagent.

## Closing

A branch stays open while its answer could still change what you would do. Keep asking until none is left open.

Then write the whole tree out, one decision per line, so the user can correct a line instead of refuting a paragraph:

- **Decisions**: one line per settled decision: the decision, and what was chosen. Every answered question appears; a reader counts the lines against the questions asked.
- **Roads not taken**: one line per decision that had a real contender: the option you were closest to picking, and the answer that ruled it out.
- **Assumptions**: what you settled yourself rather than asking, so the user can challenge it.
- **Out of scope**: what this explicitly does not cover.

A correction reopens that branch, and the interview resumes there. Anything else ends the run. The tree is what this produces, and the user decides what it becomes.
