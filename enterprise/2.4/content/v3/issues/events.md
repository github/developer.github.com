---
title: Issue Events | GitHub API
---

# Events

* TOC
{:toc}

Records various events that occur around an Issue or Pull Request. This is
useful both for display on issue/pull request information pages and also to
determine who should be notified of comments.

### Attributes

id
: The Integer ID of the event.

url
: The API URL for fetching the event.

actor
: Always the User that generated the event.

commit_id
: The String SHA of a commit that referenced this Issue

event
: Identifies the actual type of Event that occurred.

created_at
: The timestamp indicating when the event occurred.

label
: The Label object including 'name' and 'color' attributes. Only provided for 'labeled'
  and 'unlabeled' events.

assignee
: The User object which was assigned to (or unassigned from) this Issue. Only provided for 'assigned'
  and 'unassigned' events.

milestone
: The Milestone object including a 'title' attribute. Only provided for 'milestoned' and
  'demilestoned' events.

rename:
: An object containing rename details including 'from' and 'to' attributes. Only
  provided for 'renamed' events.

### Events

closed
: The issue was closed by the actor. When the commit_id is present, it
  identifies the commit that closed the issue using "closes / fixes #NN"
  syntax.

reopened
: The issue was reopened by the actor.

subscribed
: The actor subscribed to receive notifications for an issue.

merged
: The issue was merged by the actor. The `commit_id` attribute is the SHA1 of
  the HEAD commit that was merged.

referenced
: The issue was referenced from a commit message. The `commit_id` attribute is
  the commit SHA1 of where that happened.

mentioned
: The actor was @mentioned in an issue body.

assigned
: The issue was assigned to the actor.

unassigned
: The actor was unassigned from the issue.

labeled
: A label was added to the issue.

unlabeled
: A label was removed from the issue.

milestoned
: The issue was added to a milestone.

demilestoned
: The issue was removed from a milestone.

renamed
: The issue title was changed.

locked
: The issue was locked by the actor.

unlocked
: The issue was unlocked by the actor.

head_ref_deleted
: The pull request's branch was deleted.

head_ref_restored
: The pull request's branch was restored.

## List events for an issue

    GET /repos/:owner/:repo/issues/:issue_number/events

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:issue_event) { |h| [h] } %>

## List events for a repository

    GET /repos/:owner/:repo/issues/events

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:full_issue_event) { |h| [h] } %>

## Get a single event

    GET /repos/:owner/:repo/issues/events/:id

### Response

<%= headers 200 %>
<%= json :full_issue_event %>

