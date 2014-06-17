---
title: License | GitHub API
---

# License

* TOC
{:toc}

The License API provides information on your Enterprise license. *It is only available to site admins.* Normal users will receive a `404` response if they try to access it.

## Get license information

### Request

    GET /api/v3/enterprise/settings/license

### Response

<%= headers 200 %>
<%= json(:licensing) %>
