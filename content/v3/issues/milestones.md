---
title: Issue Milestones API v3 | dev.github.com
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

<%= json(:milestone) { |h| [h] } %>

## Create a Milestone

    POST /repos/:user/:repo/milestones.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  title: "String",
  state: "String", // "open" or "closed"
  description: "String",
  due_on: "Time"
}
</code></pre>

### Response

<%= json :milestone %>

## Get a single Milestone

    GET /repos/:user/:repo/milestones/:id.json

### Response

<%= json :milestone %>

## Update a Milestone

    PATCH /repos/:user/:repo/milestones/:id.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  title: "String",
  state: "String", // "open" or "closed"
  description: "String",
  due_on: "Time"
}
</code></pre>

### Response

<%= json :milestone %>

## Delete a Milestone

    DELETE /repos/:user/:repo/milestones/:id.json

### Response

    {}
