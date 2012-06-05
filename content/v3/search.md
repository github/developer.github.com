---
title: Search | GitHub API
---

# Search

This is a listing of the Search API features from API v2 that have been ported to API
v3. There should be no changes, other than the new URL and JSON output format.

## Search issues

    GET /legacy/issues/search/:owner/:repository/:state/:keyword

### Parameters

state
: `open` or `closed`

keyword
: Search term

<%= headers 200 %>
<%= json(:issue_search_results) %>

## Search repositories

    GET /legacy/repos/search/:keyword

### Parameters

keyword
: Search term

<%= headers 200 %>
<%= json(:repo_search_results) %>

## Search users

    GET /legacy/user/search/:keyword

### Parameters

keyword
: Keyword search parameters

<%= headers 200 %>
<%= json(:user_search_results) %>


