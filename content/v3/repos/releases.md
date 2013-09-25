---
title: Releases | GitHub API
---

# Releases API

* TOC
{:toc}

### Preview mode

<div class="alert">
  <p>
    The Releases API is currently available for developers to preview.
    During the preview period, the API may change without advance notice.
    Please see the <a href="/changes/2013-09-25-releases-api">blog post</a> for full details.
  </p>
  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.manifold-preview</pre>
  </p>
</div>

If you have any questions or feedback about this new API, please [get in
touch](https://github.com/contact?form[subject]=New+Releases+API).

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

Note: This returns an "upload_url" hypermedia relation that provides the [endpoint
that creates release assets](#upload-a-release-asset).

## Create a release

Users with push access to the repository can create a release.

    POST /repos/:owner/:repo/releases

### Input

tag_name
: _Required_ **string**

target_commitish
: _Optional_ **string** - Specifies the commitish value that determines where
the Git tag is created from.  Can be any branch or commit SHA.  Defaults to
the repository's default branch (usually "master").  Unused if the Git tag
already exists.

name
: _Optional_ **string**

body
: _Optional_ **string**

draft
: _Optional_ **boolean** - `true` to create a draft (unpublished)
release, `false` to create a published one. Default is `false`.

prerelease
: _Optional_ **boolean** - `true` to identify the release as a
prerelease. `false` to identify the release as a full release. Default is
`false`.

<%= json \
  :tag_name         => "v1.0.0",
  :target_commitish => "master",
  :name             => "v1.0.0",
  :description      => "Description of the release",
  :draft            => false,
  :prerelease       => false
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

target_commitish
: _Optional_ **string** - Specifies the commitish value that determines where
the Git tag is created from.  Can be any branch or commit SHA.  Defaults to
the repository's default branch (usually "master").  Unused if the Git tag
already exists.

name
: _Optional_ **string**

body
: _Optional_ **string**

draft
: _Optional_ **boolean** - `true` makes the release a draft, and `false`
publishes the release.

prerelease
: _Optional_ **boolean** - `true` to identify the release as a
prerelease. `false` to identify the release as a full release.

<%= json \
  :tag_name         => "v1.0.0",
  :target_commitish => "master",
  :name             => "v1.0.0",
  :description      => "Description of the release",
  :draft            => false,
  :prerelease       => false
%>

### Response

<%= headers 200 %>
<%= json :release %>

## Delete a release

Users with push access to the repository can delete a release.

    DELETE /repos/:owner/:repo/releases/:id

### Response

<%= headers 204 %>

## List assets for a release

    GET /repos/:owner/:repo/releases/:id/assets

### Response

<%= headers 200 %>
<%= json(:release_asset) { |h| [h] } %>

## Upload a release asset

This is a unique endpoint.  The domain of the request changes from "api.github.com"
to **"uploads.github.com"**.  The asset data is expected in its raw binary form,
instead of JSON.  Everything else about the endpoint is the same.  Pass your
authentication exactly the same as the rest of the API.

    POST https://uploads.github.com/repos/:owner/:repo/releases/assets?name=foo.zip

This endpoint is provided by a URI template in [the release's API response](#get-a-single-release).

### Input

The raw file is uploaded to GitHub.  Set the content type appropriately, and the
asset's name in a URI query parameter.

Content-Type (Header)
: _Required_ **string** - The content type of the asset.  Example:
"application/zip".  See this list of [common media types](http://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types).

name (URI query parameter)
: _Required_ **string** - The file name of the asset.

Send the raw binary content of the asset as the request body.

### Response

<%= headers 201 %>
<%= json :release_asset %>

## Get a single release asset

    GET /repos/:owner/:repo/releases/assets/:id

### Response

<%= headers 200 %>
<%= json :release_asset %>

If you want to download the asset's binary content, pass a media type of
"application/octet-stream".  The API will either redirect the client to the
location, or stream it directly if possible.  API clients should handle both a
200 or 302 response.

<%= headers 302 %>

## Edit a release asset

Users with push access to the repository can edit a release asset.

    PATCH /repos/:owner/:repo/releases/assets/:id

### Input

name
: _Required_ **string** - The file name of the asset.

label
: _Optional_ **string** - An alternate short description of the asset.  Used in
place of the filename.

<%= json \
  :name  => "foo-1.0.0-osx.zip",
  :label => "Mac binary"
%>

### Response

<%= headers 200 %>
<%= json :release_asset %>

## Delete a release asset

    DELETE /repos/:owner/:repo/releases/assets/:id

### Response

<%= headers 204 %>
