---
title: Issue Milestones | GitHub API
---

# Milestones API

## List milestones for a repository

    GET /repos/:user/:repo/milestones

state
: `open`, `closed`, default: `open`

sort
: `due_date`, `completeness`, default: `due_date`

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

title
: _Required_ **string**

state
: _Optional_ **string** - `open` or `closed`. Default is `open`.

description
: _Optional_ **string**

due\_on
: _Optional_ **string** - ISO 8601 time.

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

title
: _Required_ **string**

state
: _Optional_ **string** - `open` or `closed`. Default is `open`.

description
: _Optional_ **string**

due\_on
: _Optional_ **string** - ISO 8601 time.

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

