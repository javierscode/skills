---
name: address-review
description: Works through your pull request's review comments one at a time, with approval before commits, pushes and replies.
argument-hint: "Nothing, or the number or URL of the pull request."
disable-model-invocation: true
---

# Address review

Work through what reviewers left on your PR, one comment at a time, until none is **pending**. Each comment gets a reply, and a change when it calls for one. Get the user's approval before committing a change and before pushing it or posting a reply.

**You** are the account `gh` is authenticated as. Your PR is the argument, or the PR of the current branch when there is none.

## 1. Gather context

Read your PR: its body, its diff, and its whole conversation, meaning the review bodies, the inline threads and the conversation comments.

Then find the **related PRs**: PRs in other repositories whose URL appears in your PR's body or conversation. Read each one's body, diff and conversation the same way. A related PR is context. Its comments stay out of the queue, but a comment on your PR can ask for a change in a related PR's repository.

## 2. Align

Align your PR's repository. Switch to the PR's head branch and fast-forward it to the remote.

When a repository has uncommitted changes, or its branch has commits the remote lacks, stop. Say which repository and what you found, touch nothing, and wait for the user to settle it.

You end when your PR's repository is checked out on the PR's head branch and matches the remote.

## 3. Build the queue

Only comments by accounts other than yours can be pending.

- An **inline thread** is pending when it is unresolved and its last comment is not yours. Only the GraphQL API reports whether a thread is resolved. Page through the PR's `reviewThreads` for each thread's `id`, `isResolved`, `path`, `line` and comment authors.
- A **review body** with text, or a **conversation comment**, is pending when no later comment of yours links to its URL.

Queue every pending comment: review bodies first, then inline threads by file and line, then conversation comments oldest first.

## 4. Address each comment

Take the queue in order. For each comment, decide whether it calls for a change or only a reply. When the right approach is genuinely unclear, ask the user before writing anything.

Before the first change in a related PR's repository, align its local clone following step 2, using that PR's head branch. Until then, read that PR through GitHub and leave its local clone untouched.

**A change.** Make it in the repository the comment points at. Run the project's existing checks for the area you changed. Fix failures caused by your change. If an unrelated failure blocks validation, report it and ask the user how to proceed.

Then show the comment, the diff and the checks you ran, and wait. Treat the user's response as approval, correction or refusal:

- On approval, use the conventional-commits skill before committing the approved change.
- On a correction, apply it, run the checks again, and show it again.
- On refusal, revert the change and answer the comment with a reply only.

When an earlier commit already answers a comment, its reply cites that commit and nothing changes.

**The reply.** Write the reply in the comment's language. Keep it short and direct. Start replies to review bodies and conversation comments with the original comment's URL. If you made a change, cite its commit. Use the short SHA for your PR's repository and `owner/repo@sha` for a related repository. Show the draft and wait for approval or a correction.

On approval, push every repository holding a new commit, then post the reply. Reply to an inline thread with the `addPullRequestReviewThreadReply` mutation on the thread's `id`. Reply to a review body or conversation comment with a new conversation comment. Leave every thread unresolved; resolving it is the reviewer's call.

The user can skip a comment at any point. It stays pending for the next session.

## 5. Close

When the queue empties, build it again from the PR, since reviewers may have answered while you worked, and carry on at step 4 with anything new.

You end when the rebuilt queue holds only the comments the user skipped. Report each comment addressed, with its commit when there was one, and each comment skipped.
