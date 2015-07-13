---
title: Forks | GitHub API
---

# Forks

* TOC
{:toc}

## List forks

    GET /repos/:owner/:repo/forks

### Parameters

Name | Type | Description
-----|------|-------------
`sort`|`string` | The sort order. Can be either `newest`, `oldest`, or `stargazers`. Default: `newest`


### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:repo) { |h| h['fork'] = true; [h] } %>

## Create a fork

Create a fork for the authenticated user.

    POST /repos/:owner/:repo/forks

POST a JSON document with the field `org`

### Parameters

Name | Type | Description
-----|------|-------------
`org`|`string` | The username or organization into which the repository will be forked.


### Response

Forking a Repository happens asynchronously.  Therefore, you may have to wait
a short period before accessing the git objects.  If this takes longer than
5 minutes, be sure to [contact Support](https://github.com/contact?form[subject]=APIv3).

<%= headers 202 %>
<%= json(:repo) { |h| h['fork'] = true; h } %>
