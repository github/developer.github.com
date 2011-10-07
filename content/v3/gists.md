---
title: Gists | GitHub API
---

# Gists API

## List gists

List a user's gists:

    GET /users/:user/gists

List the authenticated user's gists or if called anonymously, this will
returns all public gists:

    GET /gists

List all public gists:

    GET /gists/public

List the authenticated user's starred gists:

    GET /gists/starred

### Response

<%= headers 200, :pagination => true %>
<%= json(:gist) { |h| [h] } %>

## Get a single gist

    GET /gists/:id

### Response

<%= headers 200 %>
<%= json :full_gist %>

## Create a gist

    POST /gists

### Input

description
: _Optional_ **string**

public
: _Required_ **boolean**

files
: _Required_ **hash** - Files that make up this gist. The key of which
should be a _required_ **string** filename and the value another
_required_ **hash** with parameters:

  content
  : _Required_ **string** - File contents.

<%= json \
  :description => "the description for this gist",
  :public      => true,
  :files       => {
    "file1.txt" => {"content" => "String file contents"}
  }
%>

### Response

<%= headers 201, :Location => "https://api.github.com/gists/1" %>
<%= json :full_gist %>

## Edit a gist

    PATCH /gists/:id

### Input

description
: _Optional_ **string**

files
: _Optional_ **hash** - Files that make up this gist. The key of which
should be an _optional_ **string** filename and the value another
_optional_ **hash** with parameters:

  content
  : _Optional_ **string** - Updated file contents.

  filename
  : _Optional_ **string** - New name for this file.

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

    POST /gists/:id/fork

### Response

<%= headers 201, :Location => "https://api.github.com/gists/2" %>
<%= json(:gist) %>

## Delete a gist

    DELETE /gists/:id

### Response

<%= headers 204 %>
