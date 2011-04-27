---
title: Issue Milestones API v3 | dev.github.com
---

# Milestones API

## List Milestones for an Issue

    GET /repos/:user/:repo/milestones.json

sort
: `created`, `updated`, `comments`, default: `created`

direction
: `asc` or `desc`, default: `desc`.

state
: `open`, `closed`, default: `open`

## Create a Milestone

    POST /repos/:user/:repo/milestones.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  title: "String",
  state: "String",
  description: "String",
  due_on: "Time"
}
</code></pre>

## Get a single Milestone

    GET /repos/:user/:repo/milestones/:id.json

## Update a Milestone

    PATCH /repos/:user/:repo/milestones/:id.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  title: "String",
  state: "String",
  description: "String",
  due_on: "Time"
}
</code></pre>

## Delete a Milestone

    DELETE /repos/:user/:repo/milestones/:id.json

