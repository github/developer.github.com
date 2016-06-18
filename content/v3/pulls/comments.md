---
title: Review Comments
---

# Review Comments

{:toc}

Pull Request Review Comments are comments on a portion of the unified
diff.  These are separate from Commit Comments (which are applied
directly to a commit, outside of the Pull Request view), and Issue
Comments (which do not reference a portion of the unified diff).

Pull Request Review Comments use [these custom media
types](#custom-media-types). You can read more about the use of media types in the API
[here](/v3/media/).

## List comments on a pull request

    GET /repos/:owner/:repo/pulls/:number/comments

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:pull_comment) { |h| [h] } %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-pull-comments"></a>

  An additional `reactions` object in the review comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :pull_comment_reaction_summary %>
{% endif %}

## List comments in a repository

    GET /repos/:owner/:repo/pulls/comments

By default, Review Comments are ordered by ascending ID.

### Parameters

Name | Type | Description
-----|------|--------------
`sort`|`string` | Can be either `created` or `updated`. Default: `created`
`direction`|`string` | Can be either `asc` or `desc`. Ignored without `sort` parameter.
`since`|`string` | Only comments updated at or after this time are returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.


### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:pull_comment) { |h| [h] } %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-pulls-comments"></a>

  An additional `reactions` object in the review comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :pull_comment_reaction_summary %>
{% endif %}

## Get a single comment

    GET /repos/:owner/:repo/pulls/comments/:id

### Response

<%= headers 200 %>
<%= json :pull_comment %>

{% if page.version == 'dotcom' %}
#### Reactions summary

{{#tip}}

  <a name="preview-period-pull-comment"></a>

  An additional `reactions` object in the review comment payload is currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

  The `reactions` key will have the following payload where `url` can be used to construct the API location for [listing and creating](/v3/reactions) reactions.

{{/tip}}
<%= json :pull_comment_reaction_summary %>
{% endif %}

## Create a comment

    POST /repos/:owner/:repo/pulls/:number/comments

### Input

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The text of the comment
`commit_id`|`string` | **Required**. The SHA of the commit to comment on.
`path`|`string` | **Required**. The relative path of the file to comment on.
`position`|`integer` | **Required**. The line index in the diff to comment on.

{{#tip}}

When passing the `commit_id`, use the SHA of the latest commit in the pull request or your comment may appear as "outdated" if the specified `position` has been modified in a subsequent commit.

To comment on a specific line in a file, you will need to first determine the position in the diff. GitHub offers a `application/vnd.github.v3.diff` media type which you can use in a preceding request to view the pull request's diff. The diff needs to be [interpreted](https://en.wikipedia.org/wiki/Diff_utility#Unified_format) to translate from the *line in the file* to a *position in the diff*. The `position` value is the number of lines down from the first "@@" hunk header in the file you would like to comment on. The line just below the "@@" line is position 1, the next line is position 2, and so on. The position in the file's diff continues to increase through lines of whitespace and additional hunks until a new file is reached.

{{/tip}}

#### Example

<%= json \
  :body      => 'Nice change',
  :commit_id => '6dcb09b5b57875f334f61aebed695e2e4193db5e',
  :path      => 'file1.txt',
  :position  => 4
%>

### Alternative Input

Instead of passing `commit_id`, `path`, and `position` you can reply to
an existing Pull Request Comment like this:

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The text of the comment
`in_reply_to`|`integer` | **Required**. The comment id to reply to.


#### Example

<%= json \
  :body        => 'Nice change',
  :in_reply_to => 4
%>

### Response

<%= headers 201, :Location => get_resource(:pull_comment)['url'] %>
<%= json :pull_comment %>

## Edit a comment

    PATCH /repos/:owner/:repo/pulls/comments/:id

### Input

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The text of the comment


#### Example

<%= json \
  :body => 'Nice change'
%>

### Response

<%= headers 200 %>
<%= json :pull_comment %>

## Delete a comment

    DELETE /repos/:owner/:repo/pulls/comments/:id

### Response

<%= headers 204 %>

## Custom media types

These are the supported media types for pull request review comments. You can
read more about the use of media types in the API [here](/v3/media/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
