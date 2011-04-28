---
title: Issues API v3 | developer.github.com
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

<%= headers 200, :pagination => true %>
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

<%= headers 201,
      :Location =>
'https://api.github.com/repos/user/repo/issues/1.json' %>
<%= json :issue %>

## Get a single Issue

    GET /repos/:user/:repo/issues/:id.json

### Response

<%= headers 200 %>
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

<%= headers 200 %>
<%= json :issue %>

## Delete an Issue

    DELETE /repos/:user/:repo/issues/:id.json

### Response

<%= headers 204 %>
<%= json({}) %>
