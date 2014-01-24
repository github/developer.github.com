---
title: Issue Labels | GitHub API
---

# Labels

* TOC
{:toc}

## List all labels for this repository

    GET /repos/:owner/:repo/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Get a single label

    GET /repos/:owner/:repo/labels/:name

### Response

<%= headers 200 %>
<%= json :label %>

## Create a label

    POST /repos/:owner/:repo/labels

### Parameters

Name | Type | Description 
-----|------|--------------
`name`|`string` | **Required**. The name of the label.
`color`|`string` |**Required**.  A 6 character hex code, without the leading `#`, identifying the color.


<%= json :name => "API", :color => "FFFFFF" %>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/user/repo/labels/foo" %>
<%= json :label %>

## Update a label

    PATCH /repos/:owner/:repo/labels/:name

### Parameters

Name | Type | Description 
-----|------|--------------
`name`|`string` | **Required**. The name of the label.
`color`|`string` |**Required**.  A 6 character hex code, without the leading `#`, identifying the color.


<%= json :name => "API", :color => "FFFFFF" %>

### Response

<%= headers 200 %>
<%= json :label %>

## Delete a label

    DELETE /repos/:owner/:repo/labels/:name

### Response

<%= headers 204 %>

## List labels on an issue

    GET /repos/:owner/:repo/issues/:number/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Add labels to an issue

    POST /repos/:owner/:repo/issues/:number/labels

### Input

<%= json({:array => %w(Label1 Label2)}) { |h| h['array'] } %>

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Remove a label from an issue

    DELETE /repos/:owner/:repo/issues/:number/labels/:name

### Response

<%= headers 204 %>

## Replace all labels for an issue

    PUT /repos/:owner/:repo/issues/:number/labels

### Input

<%= json(:array => %w(Label1 Label2)) { |h| h['array'] } %>

Sending an empty array (`[]`) will remove all Labels from the Issue.

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Remove all labels from an issue

    DELETE /repos/:owner/:repo/issues/:number/labels

### Response

<%= headers 204 %>

## Get labels for every issue in a milestone

    GET /repos/:owner/:repo/milestones/:number/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>
