---
title: Issue Assignees
---

# Assignees

{:toc}

## List assignees

This call lists all the [available assignees][] to which issues may be assigned.

    GET /repos/:owner/:repo/assignees

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user) { |h| [h] } %>

## Check assignee

You may also check to see if a particular user is an assignee for a repository.

    GET /repos/:owner/:repo/assignees/:assignee

### Response

If the given `assignee` login belongs to an assignee for the repository, a
`204` header with no content is returned.

<%= headers 204 %>

Otherwise a `404` status code is returned.

<%= headers 404 %>

[available assignees]: https://help.github.com/articles/assigning-issues-and-pull-requests-to-other-github-users/

## Add assignees to an Issue

{{#tip}}

<a name="preview-period"></a>

This endpoint is currently available for developers to preview.
During the preview period, the API may change without advance notice.
Please see the [blog post](/changes/2016-5-27-multiple-assignees) for full details.

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

    application/vnd.github.cerberus-preview+json

{{/tip}}


This call adds the users passed in the `assignees` key (as their logins) to the issue.

    POST /repos/:owner/:repo/issues/:number/assignees

### Input

<%= json({"assignees" => %w(hubot other_assignee)}) %>

### Response

<%= headers 201 %>
<%= json :issue_with_assignees %>

## Remove assignees from an Issue

{{#tip}}

<a name="preview-period"></a>

This endpoint is currently available for developers to preview.
During the preview period, the API may change without advance notice.
Please see the [blog post](/changes/2016-5-27-multiple-assignees) for full details.

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

    application/vnd.github.cerberus-preview+json

{{/tip}}

This call removes the users passed in the `assignees` key (as their logins) from the issue.

    DELETE /repos/:owner/:repo/issues/:number/assignees

### Input

<%= json({"assignees" => %w(hubot other_assignee)}) %>

### Response

<%= headers 200 %>
<%= json :issue_with_assignees %>
