---
title: Legacy Search | GitHub API
---

# Legacy Search

* TOC
{:toc}

This is a listing of the Legacy Search API features from API v2 that have been ported to API
v3. There should be no changes, other than the new URL and JSON output format.

### Legacy Search API is Deprecated

<div class="alert">
  <p>
    The Legacy Search API (described below) is <a href="/v3/versions/#v3-deprecations">deprecated</a>
    and is scheduled for removal in the next major version of the API.

    We recommend using the <a href="/v3/search/">v3 Search API</a> instead.
    It contains new endpoints and much more functionality.
  </p>
</div>

## Search issues

Find issues by state and keyword.

    GET /legacy/issues/search/:owner/:repository/:state/:keyword

### Parameters

Name | Type | Description
-----|------|--------------
`state`|`string` | Indicates the state of the issues to return. Can be either `open` or `closed`.
`keyword`|`string`| The search term.


<%= headers 200 %>
<%= json(:issue_search_results) %>

## Search repositories

Find repositories by keyword. Note, this legacy method does not follow the
v3 pagination pattern. This method returns up to 100 results per page and
pages can be fetched using the `start_page` parameter.

    GET /legacy/repos/search/:keyword

### Parameters

Name | Type | Description
-----|------|--------------
`keyword`|`string`| The search term|
`language`|`string` | Filter results by language
`start_page`|`string` | The page number to fetch
`sort`|`string` | The sort field. One of `stars`, `forks`, or `updated`. Default: results are sorted by best match.
`order`|`string` | The sort field. if `sort` param is provided. Can be either `asc` or `desc`.


<%= headers 200 %>
<%= json(:repo_search_results) %>

## Search users

Find users by keyword.

    GET /legacy/user/search/:keyword

### Parameters

Name | Type | Description
-----|------|--------------
`keyword`|`string`| The search term
`start_page`|`string` | The page number to fetch
`sort`|`string`| The sort field. One of `stars`, `forks`, or `updated`. Default: results are sorted by best match.
`order`|`string`| The sort field. if `sort` param is provided. Can be either `asc` or `desc`.


<%= headers 200 %>
<%= json(:user_search_results) %>

## Email search

This API call is added for compatibility reasons only. There's no guarantee
that full email searches will always be available. The `@` character in the
address must be left unencoded. Searches only against public email addresses
(as configured on the user's GitHub profile).

    GET /legacy/user/email/:email

### Parameters

Name | Type | Description
-----|------|--------------
`email`|`string`| The email address


<%= headers 200 %>
<%= json(:email_search_results) %>
