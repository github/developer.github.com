---
title: Issues API v3 | dev.github.com
---

# Issues API

## List issues for this Repository

    GET /repos/:user/:repo/issues.json

### Parameters

milestone
: Optional _Integer_ ID of the milestone.

sort
: `created`, `updated`, `comments`, default: `created`

direction
: `asc` or `desc`, default: `desc`.

state
: `open`, `closed`, default: `open`

assignee
: _String_ User login.

mentioned
: _String_ User login.

labels
: _String_ list of comma separated Label names.  Example:
`bug,ui,@high`

## Create an Issue

    POST /repos/:user/:repo/issues.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  title: "String",
  body: "String",
  assignee: "String",
  milestone: "Integer"
}
</code></pre>

## Get a single Issue

    GET /repos/:user/:repo/issues/:id.json

## Edit an Issue

    PATCH /repos/:user/:repo/issues/:id.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  title: "String",
  body: "String",
  assignee: "String",
  milestone: "Integer"
}
</code></pre>

## Delete an Issue

    DELETE /repos/:user/:repo/issues/:id.json

