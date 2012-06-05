---
title: Search | GitHub API
---

# Search

This is a listing of the Search API features from API v2 that have been ported to API
v3. There should be no changes, other than the new URL and JSON output format.

## Search issues

Find issues by state and keyword.

    GET /legacy/issues/search/:owner/:repository/:state/:keyword

### Parameters

state
: `open` or `closed`

keyword
: Search term

<%= headers 200 %>
<%= json(:issue_search_results) %>

## Search repositories

Find repositories by keyword.

    GET /legacy/repos/search/:keyword

### Parameters

keyword
: Search term

<%= headers 200 %>
<%= json(:repo_search_results) %>

## Search users

Find users by keyword.

    GET /legacy/user/search/:keyword

### Parameters

keyword
: Keyword search parameters

<%= headers 200 %>
<%= json(:user_search_results) %>

## Email search

This API call is added for compatibility reasons only. There's no guarantee
that full email searches will always be available.

    GET /legacy/user/email/:email

### Parameters

email
: Email address

<%= headers 200 %>
<%= json(:email_search_results) %>
