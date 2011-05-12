---
title: Git DB Blobs API v3 | developer.github.com
---

# Blobs API

## Get a Blob

    GET /git/:user/:repo/blob/:sha

### Response

<%= headers 200 %>
<%= json :content => "Content of the blob" %>

## Create a Blob

    POST /git/:user/:repo/blob

### Input

<%= json :content => "Content of the blob" %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/git/:user/:repo/blob/:sha" %>
<%= json :sha => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15" %>
