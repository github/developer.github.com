---
title: Issue Events
---

# Events

{:toc}

Records various events that occur around an issue or pull request. This is
useful both for display on issue/pull request information pages and also to
determine who should be notified of comments.

### Attributes

<dl>
  <dt>id</dt>
  <dd>The Integer ID of the event.</dd>

  <dt>url</dt>
  <dd>The API URL for fetching the event.</dd>

  <dt>actor</dt>
  <dd>The User object that generated the event.</dd>

  <dt>commit_id</dt>
  <dd>The String SHA of a commit that referenced this Issue</dd>

  <dt>commit_url</dt>
  <dd>The GitHub API link to a commit that referenced this Issue</dd>

  <dt>event</dt>
  <dd>Identifies the actual type of Event that occurred.</dd>

  <dt>created_at</dt>
  <dd>The timestamp indicating when the event occurred.</dd>

  <dt>label</dt>
  <dd>The Label object including `name` and `color` attributes. Only provided for `labeled`
  and `unlabeled` events.</dd>

  <dt>assignee</dt>
  <dd>The User object which was assigned to (or unassigned from) this Issue. Only provided for 'assigned' and 'unassigned' events.</dd>

  {% if page.version == 'dotcom' or page.version > 2.5 %}
  <dt>assigner</dt>
  <dd>The User object that performed the assignment (or unassignment) for this Issue. Only provided for 'assigned' and 'unassigned' events.</dd>
  {% endif %}

  <dt>milestone</dt>
  <dd>The Milestone object including a `title` attribute. Only provided for `milestoned` and
  `demilestoned` events.</dd>

  <dt>rename</dt>
  <dd>An object containing rename details including `from` and `to` attributes. Only
  provided for `renamed` events.</dd>
</dl>

### Events

<dl>
  <dt>closed</dt>
  <dd>The issue was closed by the actor. When the commit_id is present, it
  identifies the commit that closed the issue using "closes / fixes #NN"
  syntax.</dd>


  <dt>reopened</dt>
  <dd>The issue was reopened by the actor.</dd>

  <dt>subscribed</dt>
  <dd>The actor subscribed to receive notifications for an issue.</dd>

  <dt>merged</dt>
  <dd>The issue was merged by the actor. The `commit_id` attribute is the SHA1 of
  the HEAD commit that was merged.</dd>

  <dt>referenced</dt>
  <dd>The issue was referenced from a commit message. The `commit_id` attribute is
  the commit SHA1 of where that happened.</dd>

  <dt>mentioned</dt>
  <dd>The actor was @mentioned in an issue body.</dd>

  <dt>assigned</dt>
  <dd>The issue was assigned to the actor.</dd>

  <dt>unassigned</dt>
  <dd>The actor was unassigned from the issue.</dd>

  <dt>labeled</dt>
  <dd>A label was added to the issue.</dd>

  <dt>unlabeled</dt>
  <dd>A label was removed from the issue.</dd>

  <dt>milestoned</dt>
  <dd>The issue was added to a milestone.</dd>

  <dt>demilestoned</dt>
  <dd>The issue was removed from a milestone.</dd>

  <dt>renamed</dt>
  <dd>The issue title was changed.</dd>

  <dt>locked</dt>
  <dd>The issue was locked by the actor.</dd>

  <dt>unlocked</dt>
  <dd>The issue was unlocked by the actor.</dd>

  <dt>head_ref_deleted</dt>
  <dd>The pull request's branch was deleted.</dd>

  <dt>head_ref_restored</dt>
  <dd>The pull request's branch was restored.</dd>
</dl>

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
