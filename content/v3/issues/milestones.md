---
title: Issue Milestones API v3 | developer.github.com
---

# Milestones API

## List Milestones for an Issue

    GET /repos/:user/:repo/milestones.json

state
: `open`, `closed`, default: `open`

sort
: `created`, `updated`, `comments`, default: `created`

direction
: `asc` or `desc`, default: `desc`.

### Response

<%= headers 200, :pagination => true %>
<%= json(:milestone) { |h| [h] } %>

## Create a Milestone

    POST /repos/:user/:repo/milestones.json

### Input

<%= json \
  :title => "String",
  :state => "open or closed",
  :description => "String",
  :due_on => "Time"
%>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/user/repo/milestones/1.json" %>
<%= json :milestone %>

## Get a single Milestone

    GET /repos/:user/:repo/milestones/:id.json

### Response

<%= headers 200 %>
<%= json :milestone %>

## Update a Milestone

    PATCH /repos/:user/:repo/milestones/:id.json

### Input

<%= json \
  :title => "String",
  :state => "open or closed",
  :description => "String",
  :due_on => "Time"
%>

### Response

<%= headers 200 %>
<%= json :milestone %>

## Delete a Milestone

    DELETE /repos/:user/:repo/milestones/:id.json

### Response

<%= headers 204 %>
