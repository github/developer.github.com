---
title: Admin Stats | GitHub API
---

# Admin Stats

* TOC
{:toc}

The Admin Stats API is available to pull a variety of metrics about your installation.

Note: only admin users can access Enterprise API endpoints. Normal users will receive a `404` response if they try to access it.

## Get statistics

### Request

    GET /api/v3/enterprise/stats/:type

There are a variety of types to choose from:

* `all` - returns all available stats
* `repos` - returns only repository-related stats
* `hooks` - returns only hooks-related stats
* `pages` - returns only pages-related stats
* `orgs` - returns only organization-related stats
* `users` - returns only user-related stats
* `pulls` - returns only pull request-related stats
* `issues` - returns only issue-related stats
* `milestones` - returns only milestone-related stats
* `gists` - returns only gist-related stats
* `comments` - returns only comment-related stats

These stats are cached and update roughly every 10 minutes.

### Response

<%= headers 200 %>
<%= json(:admin_stats) %>
