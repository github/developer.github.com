---
title: Repo Contributors | GitHub API
---

# Repo Contributors API

## List

    GET /repos/:user/:repo/contributors

### Response

<%= headers 200 %>
<%= json(:contributor) { |h| [h] } %>