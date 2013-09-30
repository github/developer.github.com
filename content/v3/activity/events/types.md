---
title: Event types | GitHub API
---

# Event Types

Each event has a similar JSON schema, but a unique `payload` object that is
determined by its event type.  [Repository hook](/v3/repos/hooks/) names relate to event types, and will have the exact same payload.  The only exception to this is the `push` hook, which has a larger, more detailed payload.

This describes just the payload of an event.  A full event will also
show the user that performed the event (actor), the repository, and the
organization (if applicable).

Note that some of these events may not be rendered in timelines.
They're only created for various internal and repository hooks.

* TOC
{:toc}

## CommitCommentEvent

Hook name: `commit_comment`

comment
: **object** - The [comment](/v3/repos/comments/#list-commit-comments-for-a-repository) itself.

## CreateEvent

Represents a created repository, branch, or tag.

Hook name: `create`

ref\_type
: **string** - The object that was created. Can be one of "repository", "branch", or
"tag"

ref
: **string** - The git ref (or `null` if only a repository was created).

master\_branch
: **string** - The name of the repository's master branch.

description
: **string** - The repository's current description.

## DeleteEvent

Represents a deleted branch or tag.

Hook name: `delete`

ref\_type
: **string** - The object that was deleted. Can be "branch" or "tag".

ref
: **string** - The full git ref.

## DownloadEvent

Hook name: `download`

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

download
: **object** - The [download](/v3/repos/downloads/) that was just
created.

## FollowEvent

Hook name: `follow`

target
: **object** - The [user](/v3/users) that was just followed.

## ForkEvent

Hook name: `fork`

forkee
: **object** - The created [repository](/v3/repos/).

## ForkApplyEvent

Triggered when a patch is applied in the Fork Queue.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

Hook name: `fork_apply`

head
: **string** - The branch name the patch is applied to.

before
: **string** - SHA of the repo state before the patch.

after
: **string** - SHA of the repo state after the patch.

## GistEvent

Hook name: `gist`

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

action
: **string** - The action that was performed. Can be "create" or "update"

gist
: **object** - The [gist](/v3/gists/) itself.

## GollumEvent

Hook name: `gollum`

pages
: **array** - The pages that were updated.

pages[][page_name]
: **string** - The name of the page.

pages[][title]
: **string** - The current page title.

pages[][action]
: **string** - The action that was performed on the page. Can be "created" or "edited".

pages[][sha]
: **string** - The latest commit SHA of the page.

pages[][html_url]
: **string** - Points to the HTML wiki page.

## IssueCommentEvent

Hook name: `issue_comment`

action
: **string** - The action that was performed on the comment. Currently, can only be "created".

issue
: **object** - The [issue](/v3/issues/) the comment belongs to.

comment
: **object** - The [comment](/v3/issues/comments/) itself.

## IssuesEvent

Hook name: `issues`

action
: **string** - The action that was performed. Can be one of "opened", "closed", or
"reopened".

issue
: **object** - The [issue](/v3/issues) itself.

## MemberEvent

Triggered when a user is added as a collaborator to a repository.

Hook name: `member`

member
: **object** - The [user](/v3/users/) that was added.

action
: **string** - The action that was performed. Currently, can only be "added".

## PublicEvent

This is triggered when a private repo is open sourced.  Without a doubt: the
best GitHub event.

Hook name: `public`

(empty payload)

## PullRequestEvent

Hook name: `pull_request`

action
: **string** - The action that was performed. Can be one of "opened", "closed",
"synchronize", or "reopened".

number
: **integer** - The pull request number.

pull\_request
: **object** - The [pull request](/v3/pulls) itself.

## PullRequestReviewCommentEvent

Hook name: `pull_request_review_comment`

comment
: **object** - The [comment](/v3/pulls/comments) itself.

## PushEvent

Hook name: `push`

head
: **string** - The SHA of the HEAD commit on the repository.

ref
: **string** - The full Git ref that was pushed.  Example:
"refs/heads/master"

size
: **integer** - The number of commits in the push.

commits
: **array** - The list of pushed commits.

commits[][sha]
: **string** - The SHA of the commit.

commits[][message]
: **string** - The commit message.

commits[][author]
: **object** - The git author of the commit.

commits[][author][name]
: **string** - The git author's name.

commits[][author][email]
: **string** - The git author's email address.

commits[][url]
: **url** - Points to the commit API resource.

commits[][distinct]
: **boolean** - Whether this commit is distinct from any that have been pushed
before.

## ReleaseEvent

Hook name: `release`

action
: **string** - The action that was performed. Currently, can only be "published".

release
: **object** - The [release](/v3/repos/releases/#get-a-single-release) itself.

## TeamAddEvent

Hook name: `team_add`

team
: **object** - The [team](/v3/orgs/teams/) that was modified.  Note:
older events may not include this in the payload.

user
: **object** - The [user](/v3/users/) that was added to this team.

repo
: **object** - The [repository](/v3/repos/) that was added to this team.

## WatchEvent

The WatchEvent is related to starring a repository, not watching.
See [this API blog post](http://developer.github.com/changes/2012-9-5-watcher-api/)
for an explanation.

The event’s actor is the user who starred a repository, and the event’s repo is
the repository that was starred.

Hook name: `watch`

action
: **string** - The action that was performed. Currently, can only be "started".
