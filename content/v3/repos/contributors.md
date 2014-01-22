---
title: Contributors | GitHub API
---

# Contributors

* TOC
{:toc}

## List contributors {#list}

This provides the lists all GitHub users who have contributed to a project, 
sorted by number of commits.

    GET /repos/:owner/:repo/contributors

### Parameters

Name | Type | Description
-----|------|-------------
`anon`|`string` | Set to `1` or `true` to include anonymous contributors in results.

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>
