---
title: Issues API v3 | dev.github.com
---

# Issues API

## List issues for this Repository

    GET /repos/:user/:repo/issues.json

### Parameters

milestone
: _Fixnum_

sort
: _String_

direction
: _String_

state
: open, closed, default: open

assignee
: _String_

mentioned
: _String_

labels
: _String_

## Create an Issue

    POST /repos/:user/:repo/issues.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  title: "String",
  body: "String",
  assignee: "String",
  milestone: "Fixnum"
}
</code></pre>

## Get a single Issue

    GET /repos/:user/:repo/issues/:id.json

## Edit an Issue

    PUT /repos/:user/:repo/issues/:id.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  title: "String",
  body: "String",
  assignee: "String",
  milestone: "Fixnum"
}
</code></pre>

## Delete an Issue

    DELETE /repos/:user/:repo/issues/:id.json

