---
title: Pages
---

# Pages

{:toc}

The GitHub Pages API retrieves information about your GitHub Pages configuration, and
the statuses of your builds. Information about the site and the builds can only be
accessed by authenticated owners, even though the websites are public.

In JSON responses, `status` can be one of:

* `null`, which means the site has yet to be built
* `queued`, which means the build has been requested but not yet begun
* `building`, which means the build is in progress
* `built`, which means the site has been built
* `errored`, which indicates an error occurred during the build

## Get information about a Pages site

    GET /repos/:owner/:repo/pages

{% if page.version == 'dotcom' or page.version > 2.7 %}

{{#tip}}

  <a name="preview-period"></a>

  Additional functionality of the GitHub Pages API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.

  To access the additional functionality during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.mister-fantastic-preview+json

  When the [preview flag](#preview-period) is passed, the response will contain an additional field, `html_url`, which will contain the absolute URL (with scheme) to the rendered site (e.g., `https://username.github.io`, or `http://example.com`).

{{/tip}}

{% endif %}

### Response

<%= headers 200 %>
<%= json(:pages) %>

{% if page.version == 'dotcom' or page.version > 2.7 %}

## Request a page build

    POST /repos/:owner/:repo/pages/builds

{{#tip}}

  <a name="preview-period"></a>

  This endpoint is currently available for developers to preview.
  During the preview period, the API may change without advance notice.

  To access this endpoint during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.mister-fantastic-preview+json

{{/tip}}

You can request that your site be built from the latest revision on the default branch. This has the same effect as pushing a commit to your default branch, but does not require an additional commit. Manually triggering page builds can be helpful when diagnosing build warnings and failures.

Build requests are limited to one concurrent build per repository and one concurrent build per requester. If you request a build while another is still in progress, the second request will be queued until the first completes.

### Response

<%= headers 200 %>
<%= json(:pages_request_build) %>

{% endif %}

## List Pages builds

    GET /repos/:owner/:repo/pages/builds

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:pages_build) { |h| [h] } %>

## List latest Pages build

    GET /repos/:owner/:repo/pages/builds/latest

<%= headers 200 %>
<%= json(:pages_build) %>
