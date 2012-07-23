---
title: Repo Contributors | GitHub API
---

# Repo Contributors API

## List

    GET /repos/:user/:repo/contributors

### Parameters

anonymous
: _Optional_ **Boolean** Include anonymous contributors

### Response

<%= headers 200 %>
<%= json(:contributor) { |h| [h] } %>
