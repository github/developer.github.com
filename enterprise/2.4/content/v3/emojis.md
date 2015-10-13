---
title: Emojis | GitHub API
---

# Emojis

Lists all the emojis available to use on GitHub.

    GET /emojis

### Response

<%= headers 200 %>
<%= json(:emojis)  %>
