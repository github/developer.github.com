---
title: Admin Stats | GitHub API
---

# Admin Stats

* TOC
{:toc}

The Admin Stats API provides a variety of metrics about your installation. *It is only available to site admins.* Normal users will receive a `404` response if they try to access it.

## Get statistics

### Request

    GET /api/v3/enterprise/stats/:type

There are a variety of types to choose from:

Type         | Description
-------------|-------------------------------------
`issues`     | The number of open and closed issues.
`hooks`      | The number of active and inactive hooks.
`milestones` | The number of open and closed milestones.
`orgs`       | The number of organizations, teams, team members, and disabled organizations.
`comments`   | The number of comments on issues, pull requests, commits, and gists.
`pages`      | The number of GitHub Pages sites.
`users`      | The number of suspended and admin users.
`gists`      | The number of private and public gists.
`pulls`      | The number of merged, mergeable, and unmergeable pull requests.
`repos`      | The number of organization-owned repositories, root repositories, forks, pushed commits, and wikis.
`all`        | All of the statistics listed above.

These statistics are cached and will be updated approximately every 10 minutes.

### Response

<%= headers 200 %>
<%= json(:admin_stats) %>
