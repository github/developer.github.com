---
title: Issue Milestones API v3 | developer.github.com
---

# Milestones API

## List milestones for an issue

    GET /repos/:user/:repo/milestones

state
: `open`, `closed`, default: `open`

sort
: `created`, `updated`, `comments`, default: `created`

direction
: `asc` or `desc`, default: `desc`.

### Response

<%= headers 200, :pagination => true %>
<%= json(:milestone) { |h| [h] } %>

## Get a single milestone

    GET /repos/:user/:repo/milestones/:id

### Response

<%= headers 200 %>
<%= json :milestone %>

## Create a milestone

    POST /repos/:user/:repo/milestones

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
"https://api.github.com/repos/user/repo/milestones/1" %>
<%= json :milestone %>

## Update a milestone

    PATCH /repos/:user/:repo/milestones/:id

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

## Delete a milestone

    DELETE /repos/:user/:repo/milestones/:id

### Response

<%= headers 204 %>

