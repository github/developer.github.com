---
title: Issue Labels | GitHub API
---

# Labels API

## List all labels for this repository

    GET /repos/:user/:repo/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Get a single label

    GET /repos/:user/:repo/labels/:id

### Response

<%= headers 200 %>
<%= json :label %>

## Create a label

    POST /repos/:user/:repo/labels

### Input

name
: _Required_ **string**

color
: _Required_ **string** - 6 character hex code, without a leading `#`.

<%= json :name => "API", :color => "FFFFFF" %>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/user/repo/labels/foo" %>
<%= json :label %>

## Update a label

    PATCH /repos/:user/:repo/labels/:id

### Input

name
: _Required_ **string**

color
: _Required_ **string** - 6 character hex code, without a leading `#`.

<%= json :name => "API", :color => "FFFFFF" %>

### Response

<%= headers 200 %>
<%= json :label %>

## Delete a label

    DELETE /repos/:user/:repo/labels/:id

### Response

<%= headers 204 %>

## List labels on an issue

    GET /repos/:user/:repo/issues/:id/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Add labels to an issue

    POST /repos/:user/:repo/issues/:id/labels

### Input

<%= json({:array => %w(Label1 Label2)}) { |h| h['array'] } %>

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Remove a label from an issue

    DELETE /repos/:user/:repo/issues/:id/labels/:id

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Replace all labels for an issue

    PUT /repos/:user/:repo/issues/:id/labels

### Input

<%= json(:array => %w(Label1 Label2)) { |h| h['array'] } %>

Sending an empty array (`[]`) will remove all Labels from the Issue.

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Remove all labels from an issue

    DELETE /repos/:user/:repo/issues/:id/labels

### Response

<%= headers 204 %>

## Get labels for every issue in a milestone

    GET /repos/:user/:repo/milestones/:id/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>
