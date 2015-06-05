---
title: Git Blobs | GitHub API
---

# Blobs

* TOC
{:toc}

Since blobs can be any arbitrary binary data, the input and responses
for the blob API takes an encoding parameter that can be either `utf-8`
or `base64`.  If your data cannot be losslessly sent as a UTF-8 string,
you can base64 encode it.

Blobs leverage [these custom media types](#custom-media-types). You can
read more about the use of media types in the API [here](/v3/media/).

## Get a Blob

    GET /repos/:owner/:repo/git/blobs/:sha

*Note*: This API supports blobs up to 100 megabytes in size.

### Response

<%= headers 200 %>
<%= json(:blob) %>

## Create a Blob

    POST /repos/:owner/:repo/git/blobs

### Input

<%= json :content => "Content of the blob", :encoding => "utf-8" %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/repos/octocat/example/git/blobs/3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15" %>
<%= json :blob_after_create %>

## Custom media types

These are the supported media types for blobs. You can read more about the
use of media types in the API [here](/v3/media/).

    application/json
    application/vnd.github.VERSION.raw
