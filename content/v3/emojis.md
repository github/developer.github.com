---
title: GitHub Emojis API | GitHub API
---

# GitHub Emojis API

Lists all the emojis available to use on GitHub.

    GET /emojis

### Response

<%= headers 200 %>
<%= json(:emojis)  %>
