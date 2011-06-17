---
title: Issues API v3 | developer.github.com
---

# Issues API

## List issues for a repository

    GET /repos/:user/:repo/issues

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

## Get a single issue

    GET /repos/:user/:repo/issues/:id

### Response

<%= headers 200 %>
<%= json :issue %>

## Create an issue

    POST /repos/:user/:repo/issues

### Input

title
: _Required_ **string**

body
: _Optional_ **string**

assignee
: _Optional_ **string** - login for the user that this issue should be
assigned to.

milestone
: _Optional_ **number** - milestone to associate this issue with.

lables
: _Optional_ **array** of **strings** - labels to associate with this
issue.

<%= json \
  :title     => "Found a bug",
  :body      => "I'm having a problem with this.",
  :assignee  => "octocat",
  :milestone => 1,
  :labels    => %w(Label1 Label2)
%>

### Response

<%= headers 201,
      :Location =>
'https://api.github.com/repos/user/repo/issues/1' %>
<%= json :issue %>

## Edit an issue

    PATCH /repos/:user/:repo/issues/:id

### Input

title
: _Required_ **string**

body
: _Optional_ **string**

assignee
: _Optional_ **string** - login for the user that this issue should be
assigned to.

state
: _Optional_ **string** - change the state of the issue to `open` or
`closed`.

milestone
: _Optional_ **number** - milestone to associate this issue with.

lables
: _Optional_ **array** of **strings** - labels to associate with this
issue. Pass one or more Labels to _replace_ the set of Labels on this
Issue. Send an empty array (`[]`) to clear all Labels from the Issue.

<%= json \
  :title     => "Found a bug",
  :body      => "I'm having a problem with this.",
  :assignee  => "octocat",
  :milestone => 1,
  :state     => "open",
  :labels    => %w(Label1 Label2)
%>

### Response

<%= headers 200 %>
<%= json :issue %>

