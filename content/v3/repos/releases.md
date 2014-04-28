---
title: Releases | GitHub API
---

# Releases

* TOC
{:toc}

## List releases for a repository

Information about published releases are available to everyone. 
Only users with push access will receive listings for draft releases.

    GET /repos/:owner/:repo/releases

**Note:** This returns a list of releases, which does not include regular
Git tags that have not been associated with a release.
(To get a list of Git tags, use the [Repository Tags API][repo tags api].)

### Response

<%= headers 200 %>
<%= json(:release) { |h| [h] } %>

## Get a single release

    GET /repos/:owner/:repo/releases/:id

### Response

<%= headers 200 %>
<%= json :release %>

**Note:** This returns an `"upload_url"` hypermedia relation that provides the 
[endpoint that creates release assets](#upload-a-release-asset).

## Create a release

Users with push access to the repository can create a release.

    POST /repos/:owner/:repo/releases

### Input

Name | Type | Description
-----|------|--------------
`tag_name`|`string` | **Required**. The name of the tag.
`target_commitish`|`string` | Specifies the commitish value that determines where the Git tag is created from.  Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch (usually `master`).
`name`|`string` | The name of the release.
`body`|`string` | Text describing the contents of the tag.
`draft`|`boolean` | `true` to create a draft (unpublished) release, `false` to create a published one. Default: `false`
`prerelease`|`boolean` | `true` to identify the release as a prerelease. `false` to identify the release as a full release. Default: `false`

#### Example

<%= json \
  :tag_name         => "v1.0.0",
  :target_commitish => "master",
  :name             => "v1.0.0",
  :body             => "Description of the release",
  :draft            => false,
  :prerelease       => false
%>

### Response

<%= headers 201,
  :Location => 'https://api.github.com/repos/octocat/Hello-World/releases/1' %>
<%= json(:created_release) %>

## Edit a release

Users with push access to the repository can edit a release.

    PATCH /repos/:owner/:repo/releases/:id

### Input

Name | Type | Description
-----|------|--------------
`tag_name`|`string` | The name of the tag.
`target_commitish`|`string` | Specifies the commitish value that determines where the Git tag is created from.  Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch (usually `master`).
`name`|`string` | The name of the release.
`body`|`string` | Text describing the contents of the tag.
`draft`|`boolean` | `true` makes the release a draft, and `false` publishes the release.
`prerelease`|`boolean` | `true` to identify the release as a prerelease, `false` to identify the release as a full release.

#### Example

<%= json \
  :tag_name         => "v1.0.0",
  :target_commitish => "master",
  :name             => "v1.0.0",
  :body             => "Description of the release",
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

This is a unique endpoint. The request's domain changes from `"api.github.com"`
to **`"uploads.github.com"`**. You need to use an HTTP client which supports
[SNI](http://en.wikipedia.org/wiki/Server_Name_Indication) to make calls to this
endpoint.

The asset data is expected in its raw binary form, rather than JSON. 
Everything else about the endpoint is the same. 
Pass your authentication exactly the same as the rest of the API. 

    POST https://uploads.github.com/repos/:owner/:repo/releases/:id/assets?name=foo.zip

This endpoint is provided by a URI template in [the release's API response](#get-a-single-release).

### Input

The raw file is uploaded to GitHub.  Set the content type appropriately, and the
asset's name in a URI query parameter.

Name | Type | Description
-----|------|--------------
`Content-Type`|`string` | **Required**. The content type of the asset. This should be set in the Header. Example: `"application/zip"`. For a list of acceptable types, refer this list of [common media types](http://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types).
`name`|`string` | **Required**. The file name of the asset. This should be set in the URI query parameter.


Send the raw binary content of the asset as the request body.

### Response for successful upload

<%= headers 201 %>
<%= json :release_asset %>

### Response for upstream failure

This may leave an empty asset with a state of `"new"`.  It can be safely deleted.

<%= headers 502 %>

## Get a single release asset

    GET /repos/:owner/:repo/releases/assets/:id

### Response

<%= headers 200 %>
<%= json :release_asset %>

If you want to download the asset's binary content, pass a media type of
`"application/octet-stream"`.  The API will either redirect the client to the
location, or stream it directly if possible.  API clients should handle both a
`200` or `302` response.

<%= headers 302 %>

## Edit a release asset

Users with push access to the repository can edit a release asset.

    PATCH /repos/:owner/:repo/releases/assets/:id

### Input

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The file name of the asset.
`label`|`string` | An alternate short description of the asset.  Used in place of the filename.

#### Example

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

[repo tags api]: /v3/repos/#list-tags
