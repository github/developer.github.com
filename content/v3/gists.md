---
title: Gists | GitHub API
---

# Gists API

* TOC
{:toc}

## Authentication

You can read public gists and create them for anonymous users without a token; however, to read or write gists on a user's behalf the **gist** [OAuth scope][1] is required.

<!-- When an OAuth client does not have the gists scope, the API will return a 404 "Not Found" response regardless of the validity of the credentials.

The API will return a 401 "Bad credentials" response if the gists scope was given to the application but the credentials are invalid. -->

## List gists

List a user's gists:

    GET /users/:user/gists

List the authenticated user's gists or if called anonymously, this will
return all public gists:

    GET /gists

List all public gists:

    GET /gists/public

List the authenticated user's starred gists:

    GET /gists/starred

### Parameters

Name | Type | Description | Required? | Default
----|------|--------------|-----------|---------
`since`|`string` | A timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`. Only gists updated at or after this time are returned.| |


### Response

<%= headers 200, :pagination => true %>
<%= json(:gist) { |h| [h] } %>

## Get a single gist

    GET /gists/:id

_Note_: When using the [v3 media type][2] the "user" field will become "owner"

### Response

<%= headers 200 %>
<%= json :full_gist %>

## Create a gist

    POST /gists

### Input

Name | Type | Description | Required? | Default
----|------|--------------|-----------|---------
`description`|`string` | A description of the gist.| |
`public`|`boolean` | Indicates whether the gist is public. | |`false`
`files`|`hash` | Files that make up this gist.|**YES**|

The keys in the `files` hash are the `string` filename, and the value is another `hash` with a key of `contents`, and a value of the file contents. For example:

<%= json \
  :description => "the description for this gist",
  :public      => true,
  :files       => {
    "file1.txt" => {"content" => "String file contents"}
  }
%>

_Note:_ Don't name your files "gistfile" with a numerical suffix.  This is the
format of the automatic naming scheme that Gist uses internally.

### Response

<%= headers 201, :Location => "https://api.github.com/gists/1" %>
<%= json :full_gist %>

## Edit a gist

    PATCH /gists/:id

### Input

Name | Type | Description | Required? | Default
----|------|--------------|-----------|---------
`description`|`string` | A description of the gist.| |
`files`|`hash` | Files that make up this gist. The key of which should be an _optional_ **string** filename and the value another _optional_ **hash** with parameters:| |
`content`|`string` | Updated file contents.| |
`filename`|`string` | New name for this file.| |


NOTE: All files from the previous version of the gist are carried over by
default if not included in the hash. Deletes can be performed by
including the filename with a null hash.

<%= json \
  :description => "the description for this gist",
  :files => {
    "file1.txt"    => {"content"  => "updated file contents"},
    "old_name.txt" => {"filename" => "new_name.txt", "content" => "modified contents"},
    "new_file.txt" => {"content"  => "a new file"},
    "delete_this_file.txt" => nil,
  } %>

### Response

<%= headers 200 %>
<%= json :full_gist %>

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

**Note**: Previously `/gists/:id/fork`

### Response

<%= headers 201, :Location => "https://api.github.com/gists/2" %>
<%= json(:gist) %>

## Delete a gist

    DELETE /gists/:id

### Response

<%= headers 204 %>

[1]: /v3/oauth/#scopes
[2]: /v3/media
