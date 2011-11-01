---
title: Issues | GitHub API
---

# Issues API

Issues leverage [these](#custom-mime-types) custom mime types. You can
read more about the use of mime types in the API [here](/v3/mime/).

## List your issues

    GET /issues

### Parameters

filter
: * `assigned`: Issues assigned to you (default)
  * `created`: Issues created by you
  * `mentioned`: Issues mentioning you
  * `subscribed`: Issues you're subscribed to updates for

state
: `open`, `closed`, default: `open`

labels
: _String_ list of comma separated Label names.  Example:
`bug,ui,@high`

sort
: `created`, `updated`, `comments`, default: `created`

direction
: `asc` or `desc`, default: `desc`.

since
: _Optional_ **string** of a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ

### Response

<%= headers 200, :pagination => true %>
<%= json(:issue) { |h| [h] } %>

## List issues for a repository

    GET /repos/:user/:repo/issues

### Parameters

milestone
: * _Integer_ Milestone number
  * `none` for Issues with no Milestone.
  * `*` for Issues with any Milestone.

state
: `open`, `closed`, default: `open`

assignee
: * _String_ User login
  * `none` for Issues with no assigned User.
  * `*` for Issues with any assigned User.

mentioned
: _String_ User login.

labels
: _String_ list of comma separated Label names.  Example:
`bug,ui,@high`

sort
: `created`, `updated`, `comments`, default: `created`

direction
: `asc` or `desc`, default: `desc`.

since
: _Optional_ **string** of a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ

### Response

<%= headers 200, :pagination => true %>
<%= json(:issue) { |h| [h] } %>

## Get a single issue

    GET /repos/:user/:repo/issues/:number

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
: _Optional_ **string** - Login for the user that this issue should be
assigned to.

milestone
: _Optional_ **number** - Milestone to associate this issue with.

labels
: _Optional_ **array** of **strings** - Labels to associate with this
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
: _Optional_ **string**

body
: _Optional_ **string**

assignee
: _Optional_ **string** - Login for the user that this issue should be
assigned to.

state
: _Optional_ **string** - State of the issue: `open` or `closed`.

milestone
: _Optional_ **number** - Milestone to associate this issue with.

labels
: _Optional_ **array** of **strings** - Labels to associate with this
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

## Custom Mime Types

These are the supported mime types for issues. You can read more about the
use of mime types in the API [here](/v3/mime/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
