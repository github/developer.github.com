---
title: Pages | GitHub API
---

# Pages

The Pages API retrieves information about your GitHub Pages configuration, and
the statuses of your builds. Information about the site and the builds can only be
accessed by authenticated owners, even thought the websites are public.

* TOC
{:toc}

## Get information about a Pages site

    GET /repos/:owner/:repo/pages

### Response

<%= headers 200 %>
<%= json(:pages) %>

## List Pages builds

    GET /repos/:owner/:repo/pages/builds

<%= headers 200 %>
<%= json(:pages_build) { |h| [h] } %>

## List latest Pages build

    GET /repos/:owner/:repo/pages/builds/latest

<%= headers 200 %>
<%= json(:pages_build) %>