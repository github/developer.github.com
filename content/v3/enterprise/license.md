---
title: License | GitHub API
---

# License

* TOC
{:toc}

## Get licensing information

You can use the licensing API to get information on your Enterprise license.

### Request

    GET /api/v3/enterprise/settings/license

### Response

<%= headers 200 %>
<%= json(:licensing) %>
