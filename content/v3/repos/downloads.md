---
title: Downloads | GitHub API
---

# Downloads

* TOC
{:toc}

### Downloads API is Deprecated

<div class="alert">
  <p>
    The Downloads API (described below) was
    <a href="https://github.com/blog/1302-goodbye-uploads">deprecated on December 11, 2012</a>.
    It will be removed at a future date.

    We recommend using <a href="/v3/repos/releases/">Releases</a> instead.
  </p>
</div>

The downloads API is for package downloads only. If you want to get
source tarballs you should use [this](/v3/repos/contents/#get-archive-link)
instead.

## List downloads for a repository

    GET /repos/:owner/:repo/downloads

### Response

<%= headers 200 %>
<%= json(:download) { |h| [h] } %>

## Get a single download

    GET /repos/:owner/:repo/downloads/:id

### Response

<%= headers 200 %>
<%= json :download %>

## Delete a download

    DELETE /repos/:owner/:repo/downloads/:id

### Response

<%= headers 204 %>
