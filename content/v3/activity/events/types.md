---
title: Event Types | GitHub API
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

Triggered when a [commit comment](/v3/repos/comments/#list-commit-comments-for-a-repository) is created.

### Hook name

`commit_comment`

### Payload

Key | Type | Description
----|------|-------------
`comment`|`object` | The [comment](/v3/repos/comments/#list-commit-comments-for-a-repository) itself.


## CreateEvent

Represents a created repository, branch, or tag.

Note: webhooks will not receive this event for created repositories.

### Hook name

`create`

### Payload

Key | Type | Description
----|------|-------------
`ref_type`|`string` | The object that was created. Can be one of "repository", "branch", or "tag"
`ref`|`string` | The git ref (or `null` if only a repository was created).
`master_branch`|`string` | The name of the repository's default branch (usually `master`).
`description`|`string` | The repository's current description.


## DeleteEvent

Represents a [deleted branch or tag](/v3/git/refs/#delete-a-reference).

### Hook name

`delete`

### Payload

Key | Type | Description
----|------|-------------
`ref_type`|`string` | The object that was deleted. Can be "branch" or "tag".
`ref`|`string` | The full git ref.

## DeploymentEvent

Represents a [deployment](/v3/repos/deployments/#list-deployments).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Hook name

`deployment`

### Payload

Key | Type | Description
----|------|-------------
`sha`        |`string` | The commit SHA for which this deployment was created.
`name`       |`string` | Name of repository for this deployment, formatted as `:owner/:repo`.
`payload`    |`string` | The optional extra information for this deployment.
`description`|`string` | The optional human-readable description added to the deployment.


## DeploymentStatusEvent

Represents a [deployment status](/v3/repos/deployments/#list-deployment-statuses).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Hook name

`deployment_status`

### Payload

Key | Type | Description
----|------|-------------
`sha`        |`string` | The commit SHA for the associated deployment.
`name`       |`string` | Name of repository for the associated deployment, formatted as `:owner/:repo`.
`state`      |`string` | The new state. Can be `pending`, `success`, `failure`, or `error`.
`payload`    |`string` | The optional extra information for the associated deployment.
`target_url` |`string` | The optional link added to the status.
`description`|`string` | The optional human-readable description added to the status.


## DownloadEvent

Triggered when a new [download](/v3/repos/downloads/) is created.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Hook name

`download`

### Payload

Key | Type | Description
----|------|-------------
`download`|`object` | The [download](/v3/repos/downloads/) that was just created.


## FollowEvent

Triggered when a user [follows another user](/v3/users/followers/#follow-a-user).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Hook name

`follow`

### Payload

Key | Type | Description
----|------|-------------
`target`|`object` | The [user](/v3/users) that was just followed.


## ForkEvent

Triggered when a user [forks a repository](/v3/repos/forks/#create-a-fork).

### Hook name

`fork`

### Payload

Key | Type | Description
----|------|-------------
`forkee`|`object` | The created [repository](/v3/repos/).


## ForkApplyEvent

Triggered when a patch is applied in the Fork Queue.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Hook name

`fork_apply`

### Payload

Key | Type | Description
----|------|-------------
`head`|`string` | The branch name the patch is applied to.
`before`|`string` | SHA of the repository state before the patch.
`after`|`string` | SHA of the repository state after the patch.


## GistEvent

Triggered when a [Gist](/v3/gists/) is created or updated.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Hook name

`gist`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be "create" or "update"
`gist`|`object` | The [gist](/v3/gists/) itself.


## GollumEvent

Triggered when a Wiki page is created or updated.

### Hook name

`gollum`

### Payload

Key | Type | Description
----|------|-------------
`pages`|`array` | The pages that were updated.
`pages[][page_name]`|`string` | The name of the page.
`pages[][title]`|`string` | The current page title.
`pages[][action]`|`string` | The action that was performed on the page. Can be "created" or "edited".
`pages[][sha]`|`string` | The latest commit SHA of the page.
`pages[][html_url]`|`string` | Points to the HTML wiki page.


## IssueCommentEvent

Triggered when an [issue comment](/v3/issues/comments/) is created.

### Hook name

`issue_comment`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed on the comment. Currently, can only be "created".
`issue`|`object` | The [issue](/v3/issues/) the comment belongs to.
`comment`|`object` | The [comment](/v3/issues/comments/) itself.


## IssuesEvent

Triggered when an [issue](/v3/issues) is created, closed or reopened.

### Hook name

`issues`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be one of "opened", "closed", or "reopened".
`issue`|`object` | The [issue](/v3/issues) itself.


## MemberEvent

Triggered when a user is [added as a collaborator](/v3/repos/collaborators/#add-collaborator) to a repository.

### Hook name

`member`

### Payload

Key | Type | Description
----|------|-------------
`member`|`object` | The [user](/v3/users/) that was added.
`action`|`string` | The action that was performed. Currently, can only be "added".


## PublicEvent

Triggered when a private repository is [open sourced](/v3/repos/#edit).  Without a doubt: the best GitHub event.

### Hook name

`public`

### Payload

(empty payload)

## PullRequestEvent

Triggered when a [pull request](/v3/pulls) is created, closed, reopened or synchronized.

### Hook name

`pull_request`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be one of "opened", "closed", "synchronize", or "reopened".
`number`|`integer` | The pull request number.
`pull_request`|`object` | The [pull request](/v3/pulls) itself.


## PullRequestReviewCommentEvent

Triggered when a [comment is created on a portion of the unified diff](/v3/pulls/comments) of a pull request.

### Hook name

`pull_request_review_comment`

### Payload

Key | Type | Description
----|------|-------------
`comment`|`object` | The [comment](/v3/pulls/comments) itself.


## PushEvent

Triggered when a repository branch is pushed to.

### Hook name

`push`

### Payload

Key | Type | Description
----|------|-------------
`head`|`string` | The SHA of the HEAD commit on the repository.
`ref`|`string` | The full Git ref that was pushed.  Example: "refs/heads/master"
`size`|`integer` | The number of commits in the push.
`commits`|`array` | An array of commit objects describing the pushed commits. (The array includes a maximum of 20 commits. If necessary, you can use the [Commits API](/v3/repos/commits/) to fetch additional commits.)
`commits[][sha]`|`string` | The SHA of the commit.
`commits[][message]`|`string` | The commit message.
`commits[][author]`|`object` | The git author of the commit.
`commits[][author][name]`|`string` | The git author's name.
`commits[][author][email]`|`string` | The git author's email address.
`commits[][url]`|`url` | Points to the commit API resource.
`commits[][distinct]`|`boolean` | Whether this commit is distinct from any that have been pushed before.

## ReleaseEvent

Triggered when a [release](/v3/repos/releases/#get-a-single-release) is published.

### Hook name

`release`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Currently, can only be "published".
`release`|`object` | The [release](/v3/repos/releases/#get-a-single-release) itself.


## StatusEvent

Triggered when the status of a Git commit changes.

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Hook name

`status`

### Payload

Key | Type | Description
----|------|-------------
`sha`|`string` | The Commit SHA.
`state`|`string` | The new state. Can be `pending`, `success`, `failure`, or `error`.
`description`|`string` | The optional human-readable description added to the status.
`target_url`|`string` | The optional link added to the status.
`branches`|`array` | An array of branch objects containing the status' SHA. Each branch contains the given SHA, but the SHA may or may not be the head of the branch. The array includes a maximum of 10 branches.


## TeamAddEvent

Triggered when a [user is added to a team](/v3/orgs/teams/#add-team-member) or when a [repository is added to a team](/v3/orgs/teams/#add-team-repo).

Note: this event is created in [users' organization timelines](/v3/activity/events/#list-events-for-an-organization).

### Hook name

`team_add`

### Payload

Key | Type | Description
----|------|-------------
`team`|`object` | The [team](/v3/orgs/teams/) that was modified.  Note: older events may not include this in the payload.
`user`|`object` | The [user](/v3/users/) that was added to this team.
`repo`|`object` | The [repository](/v3/repos/) that was added to this team.


## WatchEvent

The WatchEvent is related to [starring a repository](/v3/activity/starring/#star-a-repository), not [watching](/v3/activity/watching/).
See [this API blog post](/changes/2012-9-5-watcher-api/) for an explanation.

The event’s actor is the [user](/v3/users/) who starred a repository, and the
event’s repository is the [repository](/v3/repos/) that was starred.

### Hook name

`watch`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Currently, can only be `started`.
