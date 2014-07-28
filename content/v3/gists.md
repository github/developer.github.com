---
title: Gists | GitHub API
---

# Gists

* TOC
{:toc}

## Authentication

You can read public gists and create them for anonymous users without a token; however, to read or write gists on a user's behalf the **gist** [OAuth scope][1] is required.

<!-- When an OAuth client does not have the gists scope, the API will return a 404 "Not Found" response regardless of the validity of the credentials.

The API will return a 401 "Bad credentials" response if the gists scope was given to the application but the credentials are invalid. -->

## List gists

List a user's gists:

    GET /users/:username/gists

List the authenticated user's gists or if called anonymously, this will
return all public gists:

    GET /gists

List all public gists:

    GET /gists/public

List the authenticated user's starred gists:

    GET /gists/starred

### Parameters

Name | Type | Description
-----|------|--------------
`since`|`string` | A timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`. Only gists updated at or after this time are returned.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:gist) { |h| [h] } %>

## Get a single gist

    GET /gists/:id

### Response {#detailed-gist-representation}

<%= headers 200 %>
<%= json :full_gist %>

## Create a gist

    POST /gists

### Input

Name | Type | Description
-----|------|--------------
`files`|`hash` | **Required**. Files that make up this gist.
`description`|`string` | A description of the gist.
`public`|`boolean` | Indicates whether the gist is public. Default: `false`

The keys in the `files` hash are the `string` filename, and the value is another `hash` with a key of `content`, and a value of the file contents. For example:

<%= json \
  :description => "the description for this gist",
  :public      => true,
  :files       => {
    "file1.txt" => {"content" => "String file contents"}
  }
%>

<div class="alert">
  <p>
    <strong>Note</strong>: Don't name your files "gistfile" with a numerical suffix.  This is the format of the automatic naming scheme that Gist uses internally.
	</p>
</div>

### Response

<%= headers 201, :Location => "https://api.github.com/gists/1" %>
<%= json :full_gist %>

## Edit a gist

    PATCH /gists/:id

### Input

Name | Type | Description
-----|------|--------------
`description`|`string` | A description of the gist.
`files`|`hash` | Files that make up this gist.
`content`|`string` | Updated file contents.
`filename`|`string` | New name for this file.

The keys in the `files` hash are the `string` filename. The value is another `hash` with a key of `content` (indicating the new contents), or `filename` (indicating the new filename). For example:

<%= json \
  :description => "the description for this gist",
  :files => {
    "file1.txt"    => {"content"  => "updated file contents"},
    "old_name.txt" => {"filename" => "new_name.txt", "content" => "modified contents"},
    "new_file.txt" => {"content"  => "a new file"},
    "delete_this_file.txt" => nil,
  } %>

<div class="alert">
  <p>
    <strong>Note</strong>: All files from the previous version of the gist are carried over by default if not included in the hash. Deletes can be performed by including the filename with a `null` hash.
	</p>
</div>


### Response

<%= headers 200 %>
<%= json :full_gist %>


## List gist commits

    GET /gists/:id/commits

### Response

<%= headers 200 %>
<%= json(:gist_history) %>

## Star a gist

    PUT /gists/:id/star

### Response

<%= headers 204 %>

## Unstar a gist

    DELETE /gists/:id/star

### Response

<%= headers 204 %>

## Check if a gist is starred

    GET /gists/:id/star

### Response if gist is starred

<%= headers 204 %>

### Response if gist is not starred

<%= headers 404 %>

## Fork a gist

    POST /gists/:id/forks

<div class="alert">
  <p>
    <strong>Note</strong>: This was previously <code>/gists/:id/fork</code>
	</p>
</div>

### Response

<%= headers 201, :Location => "https://api.github.com/gists/2" %>
<%= json(:gist) %>

## List gist forks

    GET /gists/:id/forks

### Response

<%= headers 200 %>
<%= json(:gist_forks) %>

## Delete a gist

    DELETE /gists/:id

### Response

<%= headers 204 %>

[1]: /v3/oauth/#scopes
