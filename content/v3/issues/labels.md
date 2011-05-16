---
title: Issue Labels API v3 | developer.github.com
---

# Labels API

## List all Labels for this Repository

    GET /repos/:user/:repo/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Create a Label

    POST /repos/:user/:repo/labels

### Input

<%= json :name => "String", :color => "hex" %>

*Note*: `color` takes a 6 character hex code, without a leading `#`.

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/user/repo/labels/foo" %>
<%= json :label %>

## Get a single Label

    GET /repos/:user/:repo/labels/:id

### Response

<%= headers 200 %>
<%= json :label %>

## Update a Label

    PATCH /repos/:user/:repo/labels/:id

### Input

<%= json :name => "String", :color => "hex" %>

*Note*: `color` takes a 6 character hex code, without a leading `#`.

### Response

<%= headers 200 %>
<%= json :label %>

## Delete a label

    DELETE /repos/:user/:repo/labels/:id

### Response

<%= headers 204, :no_response => true %>

## List labels on the Issue

    GET /repos/:user/:repo/issues/:id/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Add Labels to an Issue

    POST /repos/:user/:repo/issues/:id/labels

### Input
<%= json({:array => %w(Label1 Label2)}) { |h| h['array'] } %>

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Remove a Label from an Issue

    DELETE /repos/:user/:repo/issues/:id/labels/:id

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Replace all Labels for an Issue

    PUT /repos/:user/:repo/issues/:id/labels

### Input
<%= json(:array => %w(Label1 Label2)) { |h| h['array'] } %>

Sending an empty array (`[]`) will remove all Labels from the Issue.

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>

## Remove all Labels from an Issue

    DELETE /repos/:user/:repo/issues/:id/labels

### Response

<%= headers 204, :no_response => true %>

## Get Labels for every Issue in a Milestone

    GET /repos/:user/:repo/milestones/:id/labels

### Response

<%= headers 200 %>
<%= json(:label) { |h| [h] } %>
