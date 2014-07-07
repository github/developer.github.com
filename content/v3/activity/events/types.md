---
title: Event Types | GitHub API
---

# Event Types & Payloads

Each event has a similar JSON schema, but a unique `payload` object that is
determined by its event type.  

Event names are used by [repository webhooks](/v3/repos/hooks/) to specify
which events the webhook should receive. The included payloads below are from webhook deliveries but
match events returned by the [Events API](/v3/activity/events/) (except where noted).


Note that some of these events may not be rendered in timelines.
They're only created for various internal and repository hooks.

* TOC
{:toc}

## CommitCommentEvent

Triggered when a [commit comment](/v3/repos/comments/#list-commit-comments-for-a-repository) is created.

### Event name

`commit_comment`

### Payload

Key | Type | Description
----|------|-------------
`comment`|`object` | The [comment](/v3/repos/comments/#list-commit-comments-for-a-repository) itself.


<%= webhook_payload "commit_comment" %>

## CreateEvent

Represents a created repository, branch, or tag.

Note: webhooks will not receive this event for created repositories.

### Event name

`create`

### Payload

Key | Type | Description
----|------|-------------
`ref_type`|`string` | The object that was created. Can be one of "repository", "branch", or "tag"
`ref`|`string` | The git ref (or `null` if only a repository was created).
`master_branch`|`string` | The name of the repository's default branch (usually `master`).
`description`|`string` | The repository's current description.

<%= webhook_payload "create" %>

## DeleteEvent

Represents a [deleted branch or tag](/v3/git/refs/#delete-a-reference).

### Event name

`delete`

### Payload

Key | Type | Description
----|------|-------------
`ref_type`|`string` | The object that was deleted. Can be "branch" or "tag".
`ref`|`string` | The full git ref.

<%= webhook_payload "delete" %>

## DeploymentEvent

Represents a [deployment](/v3/repos/deployments/#list-deployments).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Event name

`deployment`

### Payload

Key | Type | Description
----|------|-------------
`sha`        |`string` | The commit SHA for which this deployment was created.
`name`       |`string` | Name of repository for this deployment, formatted as `:owner/:repo`.
`payload`    |`string` | The optional extra information for this deployment.
`environment`|`string` | The optional environment to deploy to. Default: `"production"`
`description`|`string` | The optional human-readable description added to the deployment.


<%= webhook_payload "deployment" %>

## DeploymentStatusEvent

Represents a [deployment status](/v3/repos/deployments/#list-deployment-statuses).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Event name

`deployment_status`

### Payload

Key | Type | Description
----|------|-------------
`state`      |`string` | The new state. Can be `pending`, `success`, `failure`, or `error`.
`target_url` |`string` | The optional link added to the status.
`deployment` |`hash`   | The deployment that this status is associated with.
`description`|`string` | The optional human-readable description added to the status.

<%= webhook_payload "deployment_status" %>

## DownloadEvent

Triggered when a new [download](/v3/repos/downloads/) is created.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Event name

`download`

### Payload

Key | Type | Description
----|------|-------------
`download`|`object` | The [download](/v3/repos/downloads/) that was just created.


## FollowEvent

Triggered when a user [follows another user](/v3/users/followers/#follow-a-user).

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Event name

`follow`

### Payload

Key | Type | Description
----|------|-------------
`target`|`object` | The [user](/v3/users) that was just followed.


## ForkEvent

Triggered when a user [forks a repository](/v3/repos/forks/#create-a-fork).

### Event name

`fork`

### Payload

Key | Type | Description
----|------|-------------
`forkee`|`object` | The created [repository](/v3/repos/).

<%= webhook_payload "fork" %>

## ForkApplyEvent

Triggered when a patch is applied in the Fork Queue.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Event name

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

### Event name

`gist`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be "create" or "update"
`gist`|`object` | The [gist](/v3/gists/) itself.


## GollumEvent

Triggered when a Wiki page is created or updated.

### Event name

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

<%= webhook_payload "gollum" %>

## IssueCommentEvent

Triggered when an [issue comment](/v3/issues/comments/) is created.

### Event name

`issue_comment`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed on the comment. Currently, can only be "created".
`issue`|`object` | The [issue](/v3/issues/) the comment belongs to.
`comment`|`object` | The [comment](/v3/issues/comments/) itself.

<%= webhook_payload "issue_comment" %>

## IssuesEvent

Triggered when an [issue](/v3/issues) is created, closed or reopened.

### Event name

`issues`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be one of "opened", "closed", or "reopened".
`issue`|`object` | The [issue](/v3/issues) itself.

<%= webhook_payload "issues" %>

## MemberEvent

Triggered when a user is [added as a collaborator](/v3/repos/collaborators/#add-collaborator) to a repository.

### Event name

`member`

### Payload

Key | Type | Description
----|------|-------------
`member`|`object` | The [user](/v3/users/) that was added.
`action`|`string` | The action that was performed. Currently, can only be "added".

<%= webhook_payload "member" %>

## PageBuildEvent

Represents an attempted build of a GitHub Pages site, whether successful or not.

Triggered on push to a GitHub Pages enabled branch (`gh-pages` for project pages, `master` for user and organization pages).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Hook Name

`page_build`

### Payload

Key | Type | Description
----|------|------------
`build` | `object` | The [page build](https://developer.github.com/v3/repos/pages/#list-pages-builds) itself.

<%= webhook_payload "page_build" %>

## PublicEvent

Triggered when a private repository is [open sourced](/v3/repos/#edit).  Without a doubt: the best GitHub event.

### Event name

`public`

### Payload

<%= webhook_payload "public" %>

## PullRequestEvent

Triggered when a [pull request](/v3/pulls) is created, closed, reopened or synchronized.

### Event name

`pull_request`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be one of "opened", "closed", "synchronize", or "reopened".
`number`|`integer` | The pull request number.
`pull_request`|`object` | The [pull request](/v3/pulls) itself.

<%= webhook_payload "pull_request" %>

## PullRequestReviewCommentEvent

Triggered when a [comment is created on a portion of the unified diff](/v3/pulls/comments) of a pull request.

### Event name

`pull_request_review_comment`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed on the comment. Currently, can only be "created".
`pull_request`|`object` | The [pull request](/v3/pulls/) the comment belongs to.
`comment`|`object` | The [comment](/v3/pulls/comments) itself.

<%= webhook_payload "pull_request_review_comment" %>

## PushEvent

Triggered when a repository branch is pushed to.

Note: the example payload below is from a webhook delivery. The Event API `PushEvent` payload will differ.

### Event name

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

<%= webhook_payload "push" %>

## ReleaseEvent

Triggered when a [release](/v3/repos/releases/#get-a-single-release) is published.

### Event name

`release`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Currently, can only be "published".
`release`|`object` | The [release](/v3/repos/releases/#get-a-single-release) itself.

<%= webhook_payload "release" %>

## StatusEvent

Triggered when the status of a Git commit changes.

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Event name

`status`

### Payload

Key | Type | Description
----|------|-------------
`sha`|`string` | The Commit SHA.
`state`|`string` | The new state. Can be `pending`, `success`, `failure`, or `error`.
`description`|`string` | The optional human-readable description added to the status.
`target_url`|`string` | The optional link added to the status.
`branches`|`array` | An array of branch objects containing the status' SHA. Each branch contains the given SHA, but the SHA may or may not be the head of the branch. The array includes a maximum of 10 branches.

<%= webhook_payload "status" %>

## TeamAddEvent

Triggered when a [user is added to a team](/v3/orgs/teams/#add-team-member) or when a [repository is added to a team](/v3/orgs/teams/#add-team-repo).

Note: this event is created in [users' organization timelines](/v3/activity/events/#list-events-for-an-organization).

### Event name

`team_add`

### Payload

Key | Type | Description
----|------|-------------
`team`|`object` | The [team](/v3/orgs/teams/) that was modified.  Note: older events may not include this in the payload.
`user`|`object` | The [user](/v3/users/) that was added to this team.
`repository`|`object` | The [repository](/v3/repos/) that was added to this team.

<%= webhook_payload "team_add" %>

## WatchEvent

The WatchEvent is related to [starring a repository](/v3/activity/starring/#star-a-repository), not [watching](/v3/activity/watching/).
See [this API blog post](/changes/2012-9-5-watcher-api/) for an explanation.

The event’s actor is the [user](/v3/users/) who starred a repository, and the
event’s repository is the [repository](/v3/repos/) that was starred.

### Event name

`watch`

### Payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Currently, can only be `started`.

<%= webhook_payload "watch" %>
