---
title: Issues API v3 | dev.github.com
---

# Issues API

## List issues for this Repository

    GET /repos/:user/:repo/issues.json

### Parameters

milestone
: Optional _Integer_ Milestone number.

state
: `open`, `closed`, default: `open`

assignee
: _String_ User login.

mentioned
: _String_ User login.

labels
: _String_ list of comma separated Label names.  Example:
`bug,ui,@high`

sort
: `created`, `updated`, `comments`, default: `created`

direction
: `asc` or `desc`, default: `desc`.

### Response

<%= json(:issue) { |h| [h] } %>

## Create an Issue

    POST /repos/:user/:repo/issues.json

### Input

<%= json \
  :title     => "String",
  :body      => "String",
  :assignee  => "String User login",
  :milestone => "Integer Milestone number"
%>

### Response

<%= json :issue %>

## Get a single Issue

    GET /repos/:user/:repo/issues/:id.json

### Response

<%= json :issue %>

## Edit an Issue

    PATCH /repos/:user/:repo/issues/:id.json

### Input

<%= json \
  :title => "String",
  :body => "String",
  :assignee => "String",
  :milestone => "Integer"
%>

### Response

<%= json :issue %>

## Delete an Issue

    DELETE /repos/:user/:repo/issues/:id.json

### Response

    {}
