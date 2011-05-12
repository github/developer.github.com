---
title: Git DB Commits API v3 | developer.github.com
---

# Commits API

## Get a Commit

    GET /git/:user/:repo/commit/:sha

### Response

<%= headers 200 %>
<%= json :commit %>

