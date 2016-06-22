---
title: Comments
---

# Comments

{:toc}

## List commit comments for a repository

Commit Comments use [these custom media types](#custom-media-types). You can
read more about the use of media types in the API [here](/v3/media/).

Comments are ordered by ascending ID.

    GET /repos/:owner/:repo/comments

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:commit_comment) { |h| [h] } %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-commits-comments"></a>

  An additional `reactions` object in the commit comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :commit_comment_reaction_summary %>
{% endif %}

## List comments for a single commit

    GET /repos/:owner/:repo/commits/:ref/comments

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:commit_comment) { |h| [h] } %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-commit-comments"></a>

  An additional `reactions` object in the commit comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :commit_comment_reaction_summary %>
{% endif %}

## Create a commit comment

    POST /repos/:owner/:repo/commits/:sha/comments

### Input

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The contents of the comment.
`path`|`string` | Relative path of the file to comment on.
`position`|`integer` | Line index in the diff to comment on.
`line`|`integer` | **Deprecated**. Use **position** parameter instead. Line number in the file to comment on.


#### Example

<%= json \
  :body      => 'Great stuff',
  :path      => 'file1.txt',
  :position  => 4,
  :line      => nil
%>

### Response

<%= headers 201, :Location => get_resource(:commit_comment)['url'] %>
<%= json :commit_comment %>

## Get a single commit comment

    GET /repos/:owner/:repo/comments/:id

### Response

<%= headers 200 %>
<%= json :commit_comment %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-commit-comment"></a>

  An additional `reactions` object in the commit comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :commit_comment_reaction_summary %>
{% endif %}

## Update a commit comment

    PATCH /repos/:owner/:repo/comments/:id

### Input

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The contents of the comment


#### Example

<%= json \
  :body => 'Nice change'
%>

### Response

<%= headers 200 %>
<%= json(:commit_comment) { |h| h.merge('body' => 'Nice change') } %>

## Delete a commit comment

    DELETE /repos/:owner/:repo/comments/:id

### Response

<%= headers 204 %>

## Custom media types

These are the supported media types for commit comments. You can read more
about the use of media types in the API [here](/v3/media/).

    application/vnd.github-commitcomment.raw+json
    application/vnd.github-commitcomment.text+json
    application/vnd.github-commitcomment.html+json
    application/vnd.github-commitcomment.full+json
