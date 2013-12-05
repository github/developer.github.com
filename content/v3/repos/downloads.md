---
title: Downloads | GitHub API
---

# Downloads

* TOC
{:toc}

### Downloads API is Deprecated

<div class="alert">
  <p>
    The Downloads API (described below) is <a href="/v3/#deprecations">deprecated</a>
    and is scheduled for removal in the next version of the API.

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
