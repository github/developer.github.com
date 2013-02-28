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

## Get a single release

    GET /repos/:owner/:repo/releases/:id

### Response

<%= headers 200 %>
<%= json :release %>

## Create a release

    POST /repos/:owner/:repo/releases

### Input

tag_name
: _Required_ **string**

name
: _Optional_ **string**

body
: _Optional_ **string**

draft
: _Optional_ **boolean** - `true` to create a draft (unpublished)
release, `false` to create a published one. Default is `false`.

prerelease
: _Optional_ **boolean** - `true` to identify the release as a
prerelase. Default is `false`.

<%= json \
  :tag_name    => "v1.0.0",
  :name        => "v1.0.0",
  :description => "Description of the release"
%>

### Response

<%= headers 201,
  :Location => 'https://api.github.com/repos/octocat/Hello-World/releases/1' %>
<%= json(:release) %>

## Edit a release

    PATCH /repos/:owner/:repo/releases/:id

### Input

tag_name
: _Optional_ **string**

name
: _Optional_ **string**

body
: _Optional_ **string**

draft
: _Optional_ **boolean** - `true` makes the release a draft, and `false`
publishes the release.

prerelease
: _Optional_ **boolean** - `true` to identify the release as a
prerelase. `false` to identify the release as a full release.

<%= json \
  :tag_name    => "v1.0.0",
  :name        => "v1.0.0",
  :description => "Description of the release",
  :draft       => false,
  :prerelease  => false
%>

### Response

<%= headers 200 %>
<%= json :release %>
