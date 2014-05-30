---
title: License | GitHub API
---

# License

* TOC
{:toc}

You can use the licensing API to get information on your Enterprise license.

Note: only admin users can access Enterprise API endpoints. Normal users will receive a `404` response if they try to access it.

## Get licensing information

### Request

    GET /api/v3/enterprise/settings/license

### Response

<%= headers 200 %>
<%= json(:licensing) %>
