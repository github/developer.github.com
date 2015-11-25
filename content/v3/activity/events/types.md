---
title: Event Types & Payloads | GitHub API
---

# Event Types & Payloads

Each event has a similar JSON schema, but a unique `payload` object that is
determined by its event type.

Event names are used by [repository webhooks](/v3/repos/hooks/) to specify
which events the webhook should receive. The included payloads below are from webhook deliveries but
match events returned by the [Events API](/v3/activity/events/) (except where noted). The Events API uses the CamelCased name (e.g. `CommitCommentEvent`) in the `type` field of an event object and does not include the `repository` or `sender` fields in the event payload object.


**Note:** Some of these events may not be rendered in timelines, they're only
created for various internal and webhook purposes.

* TOC
{:toc}

## CommitCommentEvent

Triggered when a [commit comment](/v3/repos/comments/#list-commit-comments-for-a-repository) is created.

### Events API payload

Key | Type | Description
----|------|-------------
`comment`|`object` | The [comment](/v3/repos/comments/#list-commit-comments-for-a-repository) itself.

### Webhook event name

`commit_comment`

### Webhook payload example

<%= webhook_payload "commit_comment" %>

## CreateEvent

Represents a created repository, branch, or tag.

Note: webhooks will not receive this event for created repositories.

### Events API payload

Key | Type | Description
----|------|-------------
`ref_type`|`string` | The object that was created. Can be one of "repository", "branch", or "tag"
`ref`|`string` | The git ref (or `null` if only a repository was created).
`master_branch`|`string` | The name of the repository's default branch (usually `master`).
`description`|`string` | The repository's current description.

### Webhook event name

`create`

### Webhook payload example

<%= webhook_payload "create" %>

## DeleteEvent

Represents a [deleted branch or tag](/v3/git/refs/#delete-a-reference).

### Events API payload

Key | Type | Description
----|------|-------------
`ref_type`|`string` | The object that was deleted. Can be "branch" or "tag".
`ref`|`string` | The full git ref.

### Webhook event name

`delete`

### Webhook payload example

<%= webhook_payload "delete" %>

## DeploymentEvent

Represents a [deployment](/v3/repos/deployments/#list-deployments).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Events API payload

Key | Type | Description
----|------|-------------
`deployment` |`object` | The [deployment](/v3/repos/deployments/#list-deployments).
`deployment`[`"sha"`] |`string` | The commit SHA for which this deployment was created.
`deployment`[`"payload"`] |`string` | The optional extra information for this deployment.
`deployment`[`"environment"`] |`string` | The optional environment to deploy to. Default: `"production"`
`deployment`[`"description"`] |`string` | The optional human-readable description added to the deployment.
`repository` |`object` | The [repository](/v3/repos/) for this deployment.

### Webhook event name

`deployment`

### Webhook payload example

<%= webhook_payload "deployment" %>

## DeploymentStatusEvent

Represents a [deployment status](/v3/repos/deployments/#list-deployment-statuses).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Events API payload

Key | Type | Description
----|------|-------------
`deployment_status` |`object` | The [deployment status](/v3/repos/deployments/#list-deployment-statuses).
`deployment_status["state"]` |`string` | The new state. Can be `pending`, `success`, `failure`, or `error`.
`deployment_status["target_url"]` |`string` | The optional link added to the status.
`deployment_status["description"]`|`string` | The optional human-readable description added to the status.
`deployment` |`object` | The [deployment](/v3/repos/deployments/#list-deployments) that this status is associated with.
`repository` |`object` | The [repository](/v3/repos/) for this deployment.

### Webhook event name

`deployment_status`

### Webhook payload example

<%= webhook_payload "deployment_status" %>

## DownloadEvent

Triggered when a new [download](/v3/repos/downloads/) is created.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Events API payload

Key | Type | Description
----|------|-------------
`download`|`object` | The [download](/v3/repos/downloads/) that was just created.

### Webhook event name

`download`

## FollowEvent

Triggered when a user [follows another user](/v3/users/followers/#follow-a-user).

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Events API payload

Key | Type | Description
----|------|-------------
`target`|`object` | The [user](/v3/users) that was just followed.

### Webhook event name

`follow`

## ForkEvent

Triggered when a user [forks a repository](/v3/repos/forks/#create-a-fork).

### Events API payload

Key | Type | Description
----|------|-------------
`forkee`|`object` | The created [repository](/v3/repos/).

### Webhook event name

`fork`

### Webhook payload example

<%= webhook_payload "fork" %>

## ForkApplyEvent

Triggered when a patch is applied in the Fork Queue.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Events API payload

Key | Type | Description
----|------|-------------
`head`|`string` | The branch name the patch is applied to.
`before`|`string` | SHA of the repository state before the patch.
`after`|`string` | SHA of the repository state after the patch.

### Webhook event name

`fork_apply`

## GistEvent

Triggered when a [Gist](/v3/gists/) is created or updated.

Events of this type are **no longer created**, but it's possible that they exist in timelines of some users.

### Events API payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be "create" or "update"
`gist`|`object` | The [gist](/v3/gists/) itself.

### Webhook event name

`gist`

## GollumEvent

Triggered when a Wiki page is created or updated.

### Events API payload

Key | Type | Description
----|------|-------------
`pages`|`array` | The pages that were updated.
`pages[][page_name]`|`string` | The name of the page.
`pages[][title]`|`string` | The current page title.
`pages[][action]`|`string` | The action that was performed on the page. Can be "created" or "edited".
`pages[][sha]`|`string` | The latest commit SHA of the page.
`pages[][html_url]`|`string` | Points to the HTML wiki page.

### Webhook event name

`gollum`

### Webhook payload example

<%= webhook_payload "gollum" %>

## IssueCommentEvent

Triggered when an [issue comment](/v3/issues/comments/) is created on an issue or pull request.

### Events API payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed on the comment. Currently, can only be "created".
`issue`|`object` | The [issue](/v3/issues/) the comment belongs to.
`comment`|`object` | The [comment](/v3/issues/comments/) itself.

### Webhook event name

`issue_comment`

### Webhook payload example

<%= webhook_payload "issue_comment" %>

## IssuesEvent

Triggered when an [issue](/v3/issues) is assigned, unassigned, labeled, unlabeled, opened, closed, or reopened.

### Events API payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be one of "assigned", "unassigned", "labeled", "unlabeled", "opened", "closed", or "reopened".
`issue`|`object` | The [issue](/v3/issues) itself.
`assignee`|`object` | The optional user who was assigned or unassigned from the issue.
`label`|`object` | The optional label that was added or removed from the issue.

### Webhook event name

`issues`

### Webhook payload example

<%= webhook_payload "issues" %>

## MemberEvent

Triggered when a user is [added as a collaborator](/v3/repos/collaborators/#add-collaborator) to a repository.

### Events API payload

Key | Type | Description
----|------|-------------
`member`|`object` | The [user](/v3/users/) that was added.
`action`|`string` | The action that was performed. Currently, can only be "added".

### Webhook event name

`member`

### Webhook payload example

<%= webhook_payload "member" %>

## MembershipEvent

Triggered when a user is added or removed from a team.

Events of this type are not visible in timelines, they are only used to trigger organization webhooks.

### Events API payload

Key | Type | Description
----|------|-------------
`action` |`string` | The action that was performed. Can be "added" or "removed".
`scope`  |`string` | The scope of the membership. Currently, can only be "team".
`member` |`object` | The [user](/v3/users/) that was added or removed.
`team`   |`object` | The [team](/v3/orgs/teams/) for the membership.

### Webhook event name

`membership`

### Webhook payload example

<%= webhook_payload "membership" %>

## PageBuildEvent

Represents an attempted build of a GitHub Pages site, whether successful or not.

Triggered on push to a GitHub Pages enabled branch (`gh-pages` for project pages, `master` for user and organization pages).

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Events API payload

Key | Type | Description
----|------|------------
`build` | `object` | The [page build](https://developer.github.com/v3/repos/pages/#list-pages-builds) itself.

### Webhook event name

`page_build`

### Webhook payload example

<%= webhook_payload "page_build" %>

## PublicEvent

Triggered when a private repository is [open sourced](/v3/repos/#edit).  Without a doubt: the best GitHub event.

### Events API payload

### Webhook event name

`public`

### Webhook payload example

<%= webhook_payload "public" %>

## PullRequestEvent

Triggered when a [pull request](/v3/pulls) is assigned, unassigned, labeled, unlabeled, opened, closed, reopened, or synchronized.

### Events API payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Can be one of "assigned", "unassigned", "labeled", "unlabeled", "opened", "closed", or "reopened", or "synchronize". If the action is "closed" and the `merged` key is `false`, the pull request was closed with unmerged commits. If the action is "closed" and the `merged` key is `true`, the pull request was merged.
`number`|`integer` | The pull request number.
`pull_request`|`object` | The [pull request](/v3/pulls) itself.

### Webhook event name

`pull_request`

### Webhook payload example

<%= webhook_payload "pull_request" %>

## PullRequestReviewCommentEvent

Triggered when a [comment is created on a portion of the unified diff](/v3/pulls/comments) of a pull request.

### Events API payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed on the comment. Currently, can only be "created".
`pull_request`|`object` | The [pull request](/v3/pulls/) the comment belongs to.
`comment`|`object` | The [comment](/v3/pulls/comments) itself.

### Webhook event name

`pull_request_review_comment`

### Webhook payload example

<%= webhook_payload "pull_request_review_comment" %>

## PushEvent

Triggered when a repository branch is pushed to. In addition to branch pushes, webhook [`push` events](/webhooks/#events) are also triggered when repository tags are pushed.

{{#tip}}

The Events API `PushEvent` payload is described in the table below. The example payload below that is from a webhook delivery and will differ from the Events API `PushEvent` payload.

{{/tip}}

### Events API payload

Key | Type | Description
----|------|-------------
`ref`|`string` | The full Git ref that was pushed. Example: `"refs/heads/master"`.
`head`|`string` | The SHA of the most recent commit on `ref` after the push.
`before`|`string` | The SHA of the most recent commit on `ref` before the push.
`size`|`integer` | The number of commits in the push.
`distinct_size`|`integer` | The number of distinct commits in the push.
`commits`|`array` | An array of commit objects describing the pushed commits. (The array includes a maximum of 20 commits. If necessary, you can use the [Commits API](/v3/repos/commits/) to fetch additional commits. This limit is applied to timeline events only and isn't applied to webhook deliveries.)
`commits[][sha]`|`string` | The SHA of the commit.
`commits[][message]`|`string` | The commit message.
`commits[][author]`|`object` | The git author of the commit.
`commits[][author][name]`|`string` | The git author's name.
`commits[][author][email]`|`string` | The git author's email address.
`commits[][url]`|`url` | Points to the commit API resource.
`commits[][distinct]`|`boolean` | Whether this commit is distinct from any that have been pushed before.

### Webhook event name

`push`

### Webhook payload example

<%= webhook_payload "push" %>

## ReleaseEvent

Triggered when a [release](/v3/repos/releases/#get-a-single-release) is published.

### Events API payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Currently, can only be "published".
`release`|`object` | The [release](/v3/repos/releases/#get-a-single-release) itself.

### Webhook event name

`release`

### Webhook payload example

<%= webhook_payload "release" %>

## RepositoryEvent

Triggered when a repository is created.

Events of this type are not visible in timelines, they are only used to trigger organization webhooks.

### Events API payload

Key | Type | Description
----|------|-------------
`action` |`string` | The action that was performed. Currently, can only be "created".
`repository`|`object` | The [repository](/v3/repos/) that was created.

### Webhook event name

`repository`

### Webhook payload example

<%= webhook_payload "repository" %>

## StatusEvent

Triggered when the status of a Git commit changes.

Events of this type are not visible in timelines, they are only used to trigger hooks.

### Events API payload

Key | Type | Description
----|------|-------------
`sha`|`string` | The Commit SHA.
`state`|`string` | The new state. Can be `pending`, `success`, `failure`, or `error`.
`description`|`string` | The optional human-readable description added to the status.
`target_url`|`string` | The optional link added to the status.
`branches`|`array` | An array of branch objects containing the status' SHA. Each branch contains the given SHA, but the SHA may or may not be the head of the branch. The array includes a maximum of 10 branches.

### Webhook event name

`status`

### Webhook payload example

<%= webhook_payload "status" %>

## TeamAddEvent

Triggered when a [repository is added to a team](/v3/orgs/teams/#add-team-repo).

Events of this type are not visible in timelines. These events are only used to trigger hooks.

### Events API payload

Key | Type | Description
----|------|-------------
`team`|`object` | The [team](/v3/orgs/teams/) that was modified.  Note: older events may not include this in the payload.
`repository`|`object` | The [repository](/v3/repos/) that was added to this team.

### Webhook event name

`team_add`

### Webhook payload example

<%= webhook_payload "team_add" %>

## WatchEvent

The WatchEvent is related to [starring a repository](/v3/activity/starring/#star-a-repository), not [watching](/v3/activity/watching/).
See [this API blog post](/changes/2012-09-05-watcher-api/) for an explanation.

The event’s actor is the [user](/v3/users/) who starred a repository, and the
event’s repository is the [repository](/v3/repos/) that was starred.

### Events API payload

Key | Type | Description
----|------|-------------
`action`|`string` | The action that was performed. Currently, can only be `started`.

### Webhook event name

`watch`

### Webhook payload example

<%= webhook_payload "watch" %>
