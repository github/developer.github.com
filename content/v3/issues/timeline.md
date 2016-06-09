---
title: Issue Timeline
---

{{#tip}}

  <a name="preview-period"></a>

  The API to get issue timeline events is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-23-timeline-preview-api/) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.mockingbird-preview

{{/tip}}

# Timeline

{:toc}

Records various events that occur around an issue or pull request. This is
useful both for display on issue and pull request information pages, as well as to
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
  <dd>The String SHA of a commit that referenced this Issue.</dd>

  <dt>event</dt>
  <dd>Identifies the actual type of Event that occurred.</dd>

  <dt>created_at</dt>
  <dd>The timestamp indicating when the event occurred.</dd>

  <dt>label</dt>
  <dd>The Label object including `name` and `color` attributes. Only provided for `labeled`
  and `unlabeled` events.</dd>

  <dt>assignee</dt>
  <dd>The User object which was assigned to (or unassigned from) this Issue. Only provided for `assigned` and `unassigned` events.</dd>

  <dt>milestone</dt>
  <dd>The Milestone object including a `title` attribute. Only provided for `milestoned` and
  `demilestoned` events.</dd>

  <dt>source</dt>
  <dd>The `id`, `actor`, and `url` for the source of a reference from
another issue. Only provided for `cross-referenced` events.</dd>

  <dt>rename</dt>
  <dd>An object containing rename details including `from` and `to` attributes. Only
  provided for `renamed` events.</dd>
</dl>

### Events

<dl>
  <dt>assigned</dt>
  <dd>The issue was assigned to the assignee.</dd>

  <dt>closed</dt>
  <dd>The issue was closed by the actor. When the commit_id is present, it
  identifies the commit that closed the issue using "closes / fixes #NN"
  syntax.</dd>

  <dt>commented</dt>
  <dd>A comment was added to the issue.</dd>

  <dt>committed</dt>
  <dd>A commit was added to the pull request's `HEAD` branch. Only
provided for pull requests.</dd>

  <dt>cross-referenced</dt>
  <dd>The issue was referenced from another issue. The `source`
attribute contains the `id`, `actor`, and `url` of the reference's
source.</dd>

  <dt>demilestoned</dt>
  <dd>The issue was removed from a milestone.</dd>

  <dt>head_ref_deleted</dt>
  <dd>The pull request's branch was deleted.</dd>

  <dt>head_ref_restored</dt>
  <dd>The pull request's branch was restored.</dd>

  <dt>labeled</dt>
  <dd>A label was added to the issue.</dd>

  <dt>locked</dt>
  <dd>The issue was locked by the actor.</dd>

  <dt>mentioned</dt>
  <dd>The actor was @mentioned in an issue body.</dd>

  <dt>merged</dt>
  <dd>The issue was merged by the actor. The `commit_id` attribute is the SHA1 of
  the HEAD commit that was merged.</dd>

  <dt>milestoned</dt>
  <dd>The issue was added to a milestone.</dd>

  <dt>referenced</dt>
  <dd>The issue was referenced from a commit message. The `commit_id` attribute is
  the commit SHA1 of where that happened.</dd>

  <dt>renamed</dt>
  <dd>The issue title was changed.</dd>

  <dt>reopened</dt>
  <dd>The issue was reopened by the actor.</dd>

  <dt>subscribed</dt>
  <dd>The actor subscribed to receive notifications for an issue.</dd>

  <dt>unassigned</dt>
  <dd>The assignee was unassigned from the issue.</dd>

  <dt>unlabeled</dt>
  <dd>A label was removed from the issue.</dd>

  <dt>unlocked</dt>
  <dd>The issue was unlocked by the actor.</dd>

  <dt>unsubscribed</dt>
  <dd>The actor unsubscribed to stop receiving notifications for an issue.</dd>
</dl>

## List events for an issue

    GET /repos/:owner/:repo/issues/:issue_number/timeline

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:issue_event) { |h| [h] } %>
