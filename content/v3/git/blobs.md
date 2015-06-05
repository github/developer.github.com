---
title: Git Blobs | GitHub API
---

# Blobs

* TOC
{:toc}

Blobs leverage [these custom media types](#custom-media-types). You can
read more about the use of media types in the API [here](/v3/media/).

## Get a Blob

    GET /repos/:owner/:repo/git/blobs/:sha

The `content` in the response will always be Base64 encoded.

*Note*: This API supports blobs up to 100 megabytes in size.

### Response

<%= headers 200 %>
<%= json(:blob) %>

## Create a Blob

    POST /repos/:owner/:repo/git/blobs

### Parameters

Name | Type | Description
-----|------|-------------
`content`|`string` | **Required**. The new blob's content.
`encoding`|`string` | The encoding used for `content`. Currently, `"utf-8"` and `"base64"` are supported. Default: `"utf-8"`.

### Example Input

<%= json :content => "Content of the blob", :encoding => "utf-8" %>

### Response

<%= headers 201, :Location => get_resource(:blob_after_create)['url'] %>
<%= json :blob_after_create %>

## Custom media types

These are the supported media types for blobs. You can read more about the
use of media types in the API [here](/v3/media/).

    application/json
    application/vnd.github.VERSION.raw
