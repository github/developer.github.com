---
title: Releases | GitHub API
---

# Releases API

* TOC
{:toc}

## List releases for a repository

Users with push access to the repository will receive all releases
(i.e., published releases and draft releases). Users with pull access
will receive published releases only.

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

Users with push access to the repository can create a release.

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

: _Optional_ **boolean** - `true` to identify the release as a
prerelase. `false` to identify the release as a full release. Default is
`false`.

<%= json \
  :tag_name    => "v1.0.0",
  :name        => "v1.0.0",
  :description => "Description of the release",
  :draft       => false,
  :prerelease  => false
%>

### Response

<%= headers 201,
  :Location => 'https://api.github.com/repos/octocat/Hello-World/releases/1' %>
<%= json(:release) %>

## Edit a release

Users with push access to the repository can edit a release.

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

## Delete a release

Users with push access to the repository can delete a release.

    DELETE /repos/:owner/:repo/releases/:id

### Response

<%= headers 204 %>
