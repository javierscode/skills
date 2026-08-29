---
name: interview-me
description: Interviews you one question at a time until you agree on what to do.
disable-model-invocation: true
---

# Interview me

Interview the user relentlessly about what they actually want.

## The design tree

The interview is a design tree. The root is whatever the user brought; when they brought nothing, Q1 asks what they actually want. Every question hangs off the decisions above it, so ask an unblocked one: every prerequisite settled, nothing pending. When an answer opens branches you had not mapped, add them and carry on. The user sees one question; you hold the tree.

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

Finding facts is your job, never the user's. Before you ask, check whether the answer is a fact sitting in the repository. If it is, go and find it. Dispatch a subagent for every exploration, so the interview's context stays clean, and explore on demand, driven by the question you were about to ask.

A running exploration is an unsettled prerequisite. When you can't tell whether a question depends on what the subagent will report, assume it does. When no genuinely independent question is left, wait for the subagent.

## Closing

While one branch is open, you are interviewing. The interview ends when every decision the user would have to make to execute this is settled. Having enough to proceed is not the bar; nothing left for them to decide is.

The interview ends in a **brief**: the whole tree, one decision per line, so the user can correct a line instead of refuting a paragraph:

- **Decisions.** One line per settled decision, with what was chosen. Every answered question appears; a reader counts the lines against the questions asked.
- **Roads not taken.** One line per decision that had a real contender: the option you were closest to picking, and the answer that ruled it out.
- **Assumptions.** What you settled yourself rather than asking, so the user can challenge it.
- **Out of scope.** What this explicitly does not cover.

A correction reopens that branch, and the interview resumes there.
