---
title: Issue Comments API v3 | dev.github.com
---

# Issue Comments API

## Get Comments for an Issue

    GET /repos/:user/:repo/issues/:id/comments.json

## Create a Comment for an Issue

    POST /repos/:user/:repo/issues/:id/comments.json

### Input

<pre class="highlight"><code class="language-javascript">
{
  body: "String",
}
</code></pre>
