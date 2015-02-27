---
title: Licenses | GitHub API
---

# Licenses

* TOC
{:toc}

{{#tip}}

  <a name="preview-period"></a>

  The Licenses API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post][#] for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.drax-preview+json

{{/tip}}

## List all licenses

    GET /licenses

### Response

<%= headers 200 %>
<%= json(:licenses)  %>

## Get an individual license

    GET /licenses/mit

### Response

<%= headers 200 %>
<%= json(:mit)  %>

## Get a repository's license

When passed the preview media type, requests to get a repository will also return the repository's license, if known.

    GET /repos/github/hubot

### Response

<%= headers 200 %>
<%= json(:licensee)  %>
