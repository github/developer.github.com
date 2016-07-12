---
title: Issues
---

# Issues

{:toc}

Issues use [these custom media types](#custom-media-types). You can
read more about the use of media types in the API [here](/v3/media/).

## List issues

<%= fetch_content(:prs_as_issues) %>

List all issues **assigned** to the authenticated user across all visible repositories
including owned repositories, member repositories, and organization
repositories:

    GET /issues

{{#tip}}

You can use the `filter` query parameter to fetch issues that are not necessarily assigned to you. See the table below for more information.

{{/tip}}

List all issues across owned and member repositories assigned to the authenticated user:

    GET /user/issues

List all issues for a given organization assigned to the authenticated user:

    GET /orgs/:org/issues

### Parameters

Name | Type | Description
-----|------|--------------
`filter`|`string`| Indicates which sorts of issues to return. Can be one of:<br/>* `assigned`: Issues assigned to you<br/>* `created`: Issues created by you<br/>* `mentioned`: Issues mentioning you<br/>* `subscribed`: Issues you're subscribed to updates for<br/>* `all`: All issues the authenticated user can see, regardless of participation or creation<br/> Default: `assigned`
`state`|`string`| Indicates the state of the issues to return. Can be either `open`, `closed`, or `all`. Default: `open`
`labels`|`string`| A list of comma separated label names.  Example: `bug,ui,@high`
`sort`|`string`|  What to sort results by. Can be either `created`, `updated`, `comments`. Default: `created`
`direction`|`string`| The direction of the sort. Can be either `asc` or `desc`. Default: `desc`
`since`|`string` | Only issues updated at or after this time are returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:issue) { |h| [h] } %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-org-issues"></a>

  An additional `reactions` object in the issue payload is currently available for developers to preview. During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :issue_reaction_summary %>
{% endif %}

## List issues for a repository

<%= fetch_content(:prs_as_issues) %>

    GET /repos/:owner/:repo/issues

### Parameters

Name | Type | Description
-----|------|--------------
`milestone`|`integer` or `string`| If an `integer` is passed, it should refer to a milestone by its `number` field. If the string `*` is passed, issues with any milestone are accepted. If the string `none` is passed, issues without milestones are returned.
`state`|`string`| Indicates the state of the issues to return. Can be either `open`, `closed`, or `all`. Default: `open`
`assignee`|`string`| Can be the name of a user. Pass in `none` for issues with no assigned user, and `*` for issues assigned to any user.
`creator`|`string`| The user that created the issue.
`mentioned`|`string`| A user that's mentioned in the issue.
`labels`|`string`| A list of comma separated label names.  Example: `bug,ui,@high`
`sort`|`string`|  What to sort results by. Can be either `created`, `updated`, `comments`. Default: `created`
`direction`|`string`| The direction of the sort. Can be either `asc` or `desc`. Default: `desc`
`since`|`string` |Only issues updated at or after this time are returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:issue) { |h| [h] } %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-repo-issues"></a>

  An additional `reactions` object in the issue payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :issue_reaction_summary %>
{% endif %}

## Get a single issue

<%= fetch_content(:prs_as_issues) %>

    GET /repos/:owner/:repo/issues/:number

### Response

<%= headers 200 %>
<%= json :full_issue %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-issue"></a>

  An additional `reactions` object in the issue payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :issue_reaction_summary %>
{% endif %}

## Create an issue

Any user with pull access to a repository can create an issue.

    POST /repos/:owner/:repo/issues

### Parameters

Name | Type | Description
-----|------|--------------
`title`|`string` | **Required**. The title of the issue.
`body`|`string` | The contents of the issue.
`assignee`|`string` | Login for the user that this issue should be assigned to. _NOTE: Only users with push access can set the assignee for new issues. The assignee is silently dropped otherwise. **This field is [deprecated](https://developer.github.com/v3/versions/#v3-deprecations).**_
`milestone`|`integer` | The `number` of the milestone to associate this issue with. _NOTE: Only users with push access can set the milestone for new issues. The milestone is silently dropped otherwise._
`labels`|`array` of `strings` | Labels to associate with this issue. _NOTE: Only users with push access can set labels for new issues. Labels are silently dropped otherwise._
`assignees`|`array` of `strings` | Logins for Users to assign to this issue. _NOTE: Only users with push access can set assignees for new issues. Assignees are silently dropped otherwise._

#### Example

<%= json \
  :title     => "Found a bug",
  :body      => "I'm having a problem with this.",
  :assignee  => "octocat",
  :assignees => [get_resource(:user)],
  :milestone => 1,
  :labels    => %w(bug)
%>

### Response

<%= headers 201, :Location => get_resource(:full_issue)['url'] %>
<%= json :full_issue %>

## Edit an issue

Issue owners and users with push access can edit an issue.

    PATCH /repos/:owner/:repo/issues/:number

### Parameters

Name | Type | Description
-----|------|--------------
`title`|`string` | The title of the issue.
`body`|`string` | The contents of the issue.
`assignee`|`string` | Login for the user that this issue should be assigned to. **This field is [deprecated](https://developer.github.com/v3/versions/#v3-deprecations).**
`state`|`string` | State of the issue. Either `open` or `closed`.
`milestone`|`integer` | The `number` of the milestone to associate this issue with or `null` to remove current. _NOTE: Only users with push access can set the milestone for issues. The milestone is silently dropped otherwise._
`labels`|`array` of `strings` | Labels to associate with this issue. Pass one or more Labels to _replace_ the set of Labels on this Issue. Send an empty array (`[]`) to clear all Labels from the Issue. _NOTE: Only users with push access can set labels for issues. Labels are silently dropped otherwise._
`assignees`|`array` of `strings` | Logins for Users to assign to this issue. Pass one or more user logins to _replace_ the set of assignees on this Issue. .Send an empty array (`[]`) to clear all assignees from the Issue. _NOTE: Only users with push access can set assignees for new issues. Assignees are silently dropped otherwise._

#### Example

<%= json \
  :title     => "Found a bug",
  :body      => "I'm having a problem with this.",
  :assignee  => "octocat",
  :assignees => [get_resource(:user)],
  :milestone => 1,
  :state     => "open",
  :labels    => %w(bug)
%>

### Response

<%= headers 200 %>
<%= json :full_issue %>

{% if page.version == 'dotcom' or page.version >= 2.6 %}
## Lock an issue

{% if page.version == 2.6 %}
{{#tip}}

  <a name="preview-period"></a>

  The API to lock an issue is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post](/changes/2016-02-11-issue-locking-api) for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.the-key-preview+json

{{/tip}}
{% endif %}

Users with push access can lock an issue's conversation.

    PUT /repos/:owner/:repo/issues/:number/lock

<%= fetch_content(:put_content_length) %>

### Response

<%= headers 204 %>

## Unlock an issue

{% if page.version == 2.6 %}
{{#tip}}

  <a name="preview-period"></a>

  The API to unlock an issue is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post](/changes/2016-02-11-issue-locking-api) for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.the-key-preview+json

{{/tip}}
{% endif %}

Users with push access can unlock an issue's conversation.

    DELETE /repos/:owner/:repo/issues/:number/lock

### Response

<%= headers 204 %>

{% endif %}

## Custom media types

These are the supported media types for issues. You can read more about the
use of media types in the API [here](/v3/media/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
