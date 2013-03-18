---
title: Search | GitHub API
---

# Search

* TOC
{:toc}

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

Find repositories by keyword. Note, this legacy method does not follow the
v3 pagination pattern. This method returns up to 100 results per page and
pages can be fetched using the `start_page` parameter.

    GET /legacy/repos/search/:keyword

### Parameters

keyword
: Search term

language
: _Optional_ Filter results by [language](https://github.com/languages)

start_page
: _Optional_ Page number to fetch

sort
: _Optional_ Sort field. One of `stars`, `forks`, or `updated`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

<%= headers 200 %>
<%= json(:repo_search_results) %>

## Search users

Find users by keyword.

    GET /legacy/user/search/:keyword

### Parameters

keyword
: Keyword search parameters

start_page
: _Optional_ Page number to fetch

sort
: _Optional_ Sort field. One of `followers`, `joined`, or `repositories`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

<%= headers 200 %>
<%= json(:user_search_results) %>

## Email search

This API call is added for compatibility reasons only. There's no guarantee
that full email searches will always be available. The `@` character in the
address must be left unencoded. Searches only against public email addresses
(as configured on the user's GitHub profile).

    GET /legacy/user/email/:email

### Parameters

email
: Email address

<%= headers 200 %>
<%= json(:email_search_results) %>
