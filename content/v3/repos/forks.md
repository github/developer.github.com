---
title: Repo Forks | GitHub API
---

# Repo Forks API

* TOC
{:toc}

The same method is used for listing and creating forks. The only difference is to list is sent as GET and to create is sent as POST. 

## List forks

    GET /repos/:owner/:repo/forks

### Parameters

sort
: `newest`, `oldest`, `watchers`, default: `newest`.

### Response

<%= headers 200 %>
<%= json(:repo) { |h| [h] } %>

## Create a fork

Create a fork for the authenticated user.

    POST /repos/:owner/:repo/forks

One can either use the `organization` parameter or POST a JSON document with
the field `organization`

### Parameters

organization
: _Optional_ **String** - Organization login. The repository will be
forked into this organization.

### Response

Forking a Repository happens asynchronously.  Therefore, you may have to wait
a short period before accessing the git objects.  If this takes longer than
5 minutes, be sure to [contact Support](https://github.com/contact).

<%= headers 202 %>
<%= json :repo %>
