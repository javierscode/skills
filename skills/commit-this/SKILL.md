---
name: commit-this
description: Cuts your working tree into one commit per intent in Conventional Commits, shows you the proposal, and commits once you approve.
disable-model-invocation: true
---

# Commit this

Split everything uncommitted into commits, one per intent. That means everything `git status` reports, untracked files included. Decide the cuts first. Write the messages after.

## 1. Convention

**The types.** Prefer specific types over generic ones (e.g., perf over refactor for performance changes, build over feat for build system changes, ci over build for GitHub Actions workflows).

- `feat`: a new feature
- `fix`: a bug fix
- `docs`: documentation only
- `style`: formatting (not CSS/design, which are feat/fix/refactor)
- `refactor`: neither fixes a bug nor adds a feature
- `perf`: performance, without fixes or features
- `build`: build system or external dependencies
- `ci`: CI configuration files and scripts
- `chore`: does not modify src or test files
- `revert`: reverts a previous commit
- `test`: adds missing tests or corrects existing ones

**The scope.** Optional. Add a scope when the summary alone does not say where the change is. Take it from the area the commit touches: a module, a package. Use the vocabulary the codebase already has for it.

**The summary.** Imperative, lowercase, no trailing period, and the whole line stays under 100 characters.

**The body.** Optional. It explains the reasoning behind the change when the summary alone is not enough.

## 2. Cutting

A commit is one **intent**: what fits in a sentence with no "and" in it. Not one type and not one folder. Code and its test are a single intent, and one feature touching backend and frontend is one commit.

Files are the unit. When one file carries two intents, propose splitting it by hunk. The proposal records which hunks go where.

Then check the cuts for **dependencies** by reading the diff. Do not run tests or builds. If a commit would not build or make sense applied alone, merge it into the one it needs or place it after. Dependencies also set the order.

## 3. Approval

Stop and show the proposal: commits numbered in execution order, each with its full message and its files, partial-file cuts marked as such. Where a dependency forced a merge, or an order nobody would expect, say so in one line.

Then wait, and read the reply as approval, refusal, or correction. Approval commits the proposal as shown. Refusal leaves the repo untouched. A correction is applied, then show the proposal again and wait again.
