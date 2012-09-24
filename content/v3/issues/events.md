---
title: Issue Events | GitHub API
---

# Issue Events API

* TOC
{:toc}

Records various events that occur around an Issue or Pull Request. This is
useful both for display on issue/pull request information pages and also to
determine who should be notified of comments.

### Attributes

actor
: Always the User that generated the event.

commit_id
: The String SHA of a commit that referenced this Issue

event
: Identifies the actual type of Event that occurred.

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

## List events for an issue

    GET /repos/:owner/:repo/issues/:issue_number/events

### Response

<%= headers 200, :pagination => true %>
<%= json(:issue_event) { |h| [h] } %>

## List events for a repository

    GET /repos/:owner/:repo/issues/events

### Response

<%= headers 200, :pagination => true %>
<%= json(:full_issue_event) { |h| [h] } %>

## Get a single event

    GET /repos/:owner/:repo/issues/events/:id

### Response

<%= headers 200 %>
<%= json :full_issue_event %>

