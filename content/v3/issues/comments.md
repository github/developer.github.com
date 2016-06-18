---
title: Issue Comments
---

# Comments

{:toc}

The Issue Comments API supports listing, viewing, editing, and creating
comments on issues and pull requests.

Issue Comments use [these custom media types](#custom-media-types).
You can read more about the use of media types in the API
[here](/v3/media/).

## List comments on an issue

    GET /repos/:owner/:repo/issues/:number/comments

Issue Comments are ordered by ascending ID.

### Parameters

Name | Type | Description
-----|------|--------------
`since`|`string` | Only comments updated at or after this time are returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:issue_comment) { |h| [h] } %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-issue-comments"></a>

  An additional `reactions` object in the issue comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :issue_comment_reaction_summary %>
{% endif %}

## List comments in a repository

    GET /repos/:owner/:repo/issues/comments

By default, Issue Comments are ordered by ascending ID.

### Parameters

Name | Type | Description
-----|------|--------------
`sort`|`string` | Either `created` or `updated`. Default: `created`
`direction`|`string` | Either `asc` or `desc`. Ignored without the `sort` parameter.
`since`|`string` | Only comments updated at or after this time are returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.


### Response

<%= headers 200 %>
<%= json(:issue_comment) { |h| [h] } %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-issues-comments"></a>

  An additional `reactions` object in the issue comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :issue_comment_reaction_summary %>
{% endif %}

## Get a single comment

    GET /repos/:owner/:repo/issues/comments/:id

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json :issue_comment %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-issue-comment"></a>

  An additional `reactions` object in the issue comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :issue_comment_reaction_summary %>
{% endif %}

## Create a comment

    POST /repos/:owner/:repo/issues/:number/comments

### Input

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The contents of the comment.


<%= json :body => "Me too" %>

### Response

<%= headers 201, :Location => get_resource(:issue_comment)['url'] %>
<%= json :issue_comment %>

## Edit a comment

    PATCH /repos/:owner/:repo/issues/comments/:id

### Input

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The contents of the comment.


<%= json :body => "Me too" %>

### Response

<%= headers 200 %>
<%= json :issue_comment %>

## Delete a comment

    DELETE /repos/:owner/:repo/issues/comments/:id

### Response

<%= headers 204 %>

## Custom media types

These are the supported media types for issue comments. You can read more
about the use of media types in the API [here](/v3/media/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
