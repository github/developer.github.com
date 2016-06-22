---
title: New webhook event actions are now live
author_name: davidcelis
---

As [promised last month][notice], we've expanded several webhook events with new functionality. Webhook events involving repositories, issues, and comments have all been updated to include new actions.

Repository events will now fire when a repository is deleted, made public, or made private. In addition, while repository creation events will still only fire for organizations, the new repository event actions can be delivered for user-owned repositories.

Events for issues, pull requests, and comments have also been updated and will now fire when these objects are edited or deleted. When an issue, pull request, or a comment has been edited, the event's payload will include a "changes" object. For example, if you've updated the title and body of an issue, the webhook payload informs you of what the issue used to look like:

```json
{
  "action": "edited",
  "changes": {
    "title": { "from": "This is the old title." },
    "body": { "from": "This is the old body." }
  },
  "issue": {
    "title": "This is the new title.",
    "body": "This is the new body."
  }
}
```

The new values will be present in the `issue` object itself, as detailed above. Unchanged values will not be present within the `changes` object. Comment edits follow a similar pattern, though because they have no titles, the only change included in the payload would be the comment's body.

## List of comprehensive changes

New actions were added to five events, all of which are detailed below.

### [RepositoryEvent][repository-event]

* `deleted`: sent when a user-owned or organization-owned repository is deleted.
* `publicized`: sent when a user-owned or organization-owned repository is switched from private to public.
* `privatized`: sent when a user-owned or organization-owned repository is switched from public to private.

### [IssuesEvent][issues-event]

* `edited`: sent when the title and/or body of an issue is edited.

### [IssueCommentEvent][issue-comment-event]

* `edited`: sent when a comment on an issue or pull request is edited
* `deleted`: sent when a comment on an issue or pull request is deleted

### [PullRequestEvent][pull-request-event]

* `edited`: sent when the title and/or body of a pull request is edited.

### [PullRequestReviewCommentEvent][pull-request-review-comment-event]

* `edited`: sent when a comment on a pull request's unified diff (in the Files Changed tab) is edited
* `deleted`: sent when a comment on a pull request's unified diff (in the Files Changed tab) is deleted

Take a look at [the documentation][docs] for full details. If you have any questions or feedback, please [get in touch][get-in-touch].

[docs]: https://developer.github.com/webhooks/
[get-in-touch]: https://github.com/contact?form[subject]=New+Webhook+Actions
[issue-comment-event]: https://developer.github.com/v3/activity/events/types/#issuecommentevent
[issues-event]: https://developer.github.com/v3/activity/events/types/#issuesevent
[notice]: https://developer.github.com/changes/2016-03-15-new-webhook-actions/
[pull-request-event]: https://developer.github.com/v3/activity/events/types/#pullrequestevent
[pull-request-review-comment-event]: https://developer.github.com/v3/activity/events/types/#pullrequestreviewcommentevent
[repository-event]: https://developer.github.com/v3/activity/events/types/#repositoryevent
