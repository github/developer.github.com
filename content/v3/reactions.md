---
title: Reactions
---

{% if page.version == 'dotcom' or page.version >= 2.7 %}

# Reactions

{{#tip}}

  <a name="preview-period"></a>

  APIs for managing reactions are currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-05-12-reactions-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.squirrel-girl-preview

{{/tip}}

{:toc}


## Reaction types

  When creating a reaction, the allowed values for the `content` parameter are as follows (with the corresponding emoji for reference):

content | emoji 
-----|------
`+1` | :+1:
`-1` | :-1:
`laugh` | :smile:
`confused` | :confused:
`heart` | :heart:
`hooray` | :tada:


## List reactions for a commit comment

    GET /repos/:owner/:repo/comments/:id/reactions

### Parameters

Name | Type | Description
-----|------|--------------
`content`|`string` | Indicates which type of reaction to return.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:reaction) { |h| [h] } %>


## Create reaction for a commit comment

    POST /repos/:owner/:repo/comments/:id/reactions

### Parameters

Name | Type | Description
-----|------|--------------
`content`|`string` | **Required**. The reaction type

<%= json :content => 'heart' %>

### Response

{{#tip}}

  If you have already created a reaction of type `content`, the previously created reaction will be returned with `Status: 200 OK`.

{{/tip}}

<%= headers 201 %>
<%= json :reaction %>


## List reactions for an issue

    GET /repos/:owner/:repo/issues/:number/reactions

### Parameters

Name | Type | Description
-----|------|--------------
`content`|`string` | Indicates which type of reaction to return.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:reaction) { |h| [h] } %>


## Create reaction for an issue

    POST /repos/:owner/:repo/issues/:number/reactions

### Parameters

Name | Type | Description
-----|------|--------------
`content`|`string` | **Required**. The reaction type

<%= json :content => 'heart' %>

### Response

{{#tip}}

  If you have already created a reaction of type `content`, the previously created reaction will be returned with `Status: 200 OK`.

{{/tip}}

<%= headers 201 %>
<%= json :reaction %>


## List reactions for an issue comment

    GET /repos/:owner/:repo/issues/comments/:id/reactions

### Parameters

Name | Type | Description
-----|------|--------------
`content`|`string` | Indicates which type of reaction to return.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:reaction) { |h| [h] } %>


## Create reaction for an issue comment

    POST /repos/:owner/:repo/issues/comments/:id/reactions

### Parameters

Name | Type | Description
-----|------|--------------
`content`|`string` | **Required**. The reaction type

<%= json :content => 'heart' %>

### Response

{{#tip}}

  If you have already created a reaction of type `content`, the previously created reaction will be returned with `Status: 200 OK`.

{{/tip}}

<%= headers 201 %>
<%= json :reaction %>


## List reactions for a pull request review comment

    GET /repos/:owner/:repo/pulls/comments/:id/reactions

### Parameters

Name | Type | Description
-----|------|--------------
`content`|`string` | Indicates which type of reaction to return.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:reaction) { |h| [h] } %>


## Create reaction for a pull request review comment

    POST /repos/:owner/:repo/pulls/comments/:id/reactions

### Parameters

Name | Type | Description
-----|------|--------------
`content`|`string` | **Required**. The reaction type

<%= json :content => 'heart' %>

### Response

{{#tip}}

  If you have already created a reaction of type `content`, the previously created reaction will be returned with `Status: 200 OK`.

{{/tip}}

<%= headers 201 %>
<%= json :reaction %>


## Delete a reaction

    DELETE /reactions/:id

### Response

<%= headers 204 %>

{% endif %}
