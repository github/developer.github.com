---
title: Releases | GitHub API
---

# Releases API

* TOC
{:toc}

## List releases for a repository

    GET /repos/:owner/:repo/releases

### Response

<%= headers 200 %>
<%= json(:release) { |h| [h] } %>

