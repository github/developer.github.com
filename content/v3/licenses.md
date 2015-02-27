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

The Licenses API returns metadata about popular open source licenses and information about a particular project's license file.

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

When passed the preview media type, requests to get a repository will also return the repository's license, if it can be detected from the repository's license file.

It's important to note that the API simply attempts to identity the project's license by the contents of the a `LICENSE` file, if any, and does not take into account the licenses of project dependencies or other means of documenting a project's license such as references in the documentation.

    GET /repos/github/hubot

### Response

<%= headers 200 %>
<%= json(:licensee)  %>
