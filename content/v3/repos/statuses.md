---
title: Statuses | GitHub API
---

# Repo Statuses API

## List Statuses for a specific SHA

  GET /repos/:user/:repo/statuses/:sha

### Parameters

sha
: **string** - Sha to list the statuses from

### Response

<%= headers 200 %>
<%= json(:status) { |h| [h] } %>

## Create Status for a SHA

