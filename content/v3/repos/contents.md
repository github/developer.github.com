---
title: Repo Contents | GitHub API
---

# Repo Contents API

* TOC
{:toc}

These API methods let you retrieve the contents of files within a repository as
Base64 encoded content. See [media types](#custom-media-types) for requesting raw format.

## Get the README

This method returns the preferred README for a repository.

    GET /repos/:owner/:repo/readme

READMEs support [a custom media type](#custom-media-types) for getting the raw content.

### Parameters

ref
: _Optional_ **string** - The String name of the Commit/Branch/Tag.  Defaults to `master`.

### Response

<%= headers 200 %>
<%= json :readme_content %>

## Get contents

This method returns the contents of a file or directory in a repository.

    GET /repos/:owner/:repo/contents/:path

Files and symlinks support [a custom media type](#custom-media-types) for getting the raw content.
Directories and submodules do _not_ support custom media types.

*Notes*:

- To get a repository's contents recursively, you can [recursively get the tree](/v3/git/trees/).
- This API supports files up to 1 megabyte in size.

### Parameters

path
: _Optional_ **string** - The content path.

ref
: _Optional_ **string** - The String name of the Commit/Branch/Tag.  Defaults to `master`.

### Response if content is a file

<%= headers 200 %>
<%= json :readme_content %>

### Response if content is a directory

<%= headers 200 %>
<%= json :directory_content %>

### Response if content is a symlink

If the requested `:path` points to a symlink, and the symlink's target is a normal file in the repository, then the API responds with the content of the file (in the [format shown above](#response-if-content-is-a-file)).

Otherwise, the API responds with a hash describing the symlink itself:

<%= headers 200 %>
<%= json :symlink_content %>

### Response if content is a submodule

<%= headers 200 %>
<%= json :submodule_content %>

The `submodule_git_url` identifies the location of the submodule repository, and the `sha` identifies a specific commit within the submodule repository.
Git uses the given URL when cloning the submodule repository, and checks out the submodule at that specific commit.

If the submodule repository is not hosted on github.com, the Git URLs (`git_url` and `_links["git"]`) and the github.com URLs (`html_url` and `_links["html"]`) will have null values.

## Create a file

This method creates a new file in a repository

    PUT /repos/:owner/:repo/contents/:path

### Parameters

path
: _Required_ **string** - The content path.

message
: _Required_ **string** - The commit message.

content
: _Required_ **string** - The new file content, Base64 encoded.

branch
: _Optional_ **string** - The branch name. If not provided, uses the repository's 
default branch (usually `master`).

### Optional Parameters

The `author` section is optional and is filled in with the `committer`
information if omitted. If the `committer` information is omitted, the authenticated 
user's information is used.

You must provide values for both `name` and `email`, whether you choose to use
`author` or `committer`. Otherwise, you'll receive a `500` status code.

author.name
: **string** - The name of the author of the commit

author.email
: **string** - The email of the author of the commit

committer.name
: **string** - The name of the committer of the commit

committer.email
: **string** - The email of the committer of the commit

### Example Input

<%= json "message" => "my commit message", \
    "committer" => \
    {"name" => "Scott Chacon", "email" => "schacon@gmail.com" }, \
    "content" => "bXkgbmV3IGZpbGUgY29udGVudHM=" %>

### Response

<%= headers 201 %>
<%= json :content_crud %>

## Update a file

This method updates a file in a repository

    PUT /repos/:owner/:repo/contents/:path

### Parameters

path
: _Required_ **string** - The content path.

message
: _Required_ **string** - The commit message.

content
: _Required_ **string** - The updated file content, Base64 encoded.

sha
: _Required_ **string** - The blob SHA of the file being replaced.

branch
: _Optional_ **string** - The branch name. If not provided, uses the repository's 
default branch (usually `master`).

### Optional Parameters

The `author` section is optional and is filled in with the `committer`
information if omitted. If the `committer` information is omitted, the authenticated 
user's information is used.

You must provide values for both `name` and `email`, whether you choose to use
`author` or `committer`. Otherwise, you'll receive a `500` status code.

author.name
: **string** - The name of the author of the commit

author.email
: **string** - The email of the author of the commit

committer.name
: **string** - The name of the committer of the commit

committer.email
: **string** - The email of the committer of the commit

### Example Input

<%= json "message" => "my commit message", \
    "committer" => \
    {"name" => "Scott Chacon", "email" => "schacon@gmail.com" }, \
    "content" => "bXkgdXBkYXRlZCBmaWxlIGNvbnRlbnRz", \
    "sha" => "329688480d39049927147c162b9d2deaf885005f" %>

### Response

<%= headers 200 %>
<%= json :content_crud %>

## Delete a file

This method deletes a file in a repository

    DELETE /repos/:owner/:repo/contents/:path

### Parameters

path
: _Required_ **string** - The content path.

message
: _Required_ **string** - The commit message.

sha
: _Required_ **string** - The blob SHA of the file being removed.

branch
: _Optional_ **string** - The branch name. If not provided, uses the repository's 
default branch (usually `master`).

### Optional Parameters

The `author` section is optional and is filled in with the `committer`
information if omitted. If the `committer` information is omitted, the authenticated 
user's information is used.

You must provide values for both `name` and `email`, whether you choose to use
`author` or `committer`. Otherwise, you'll receive a `500` status code.

author.name
: **string** - The name of the author of the commit

author.email
: **string** - The email of the author of the commit

committer.name
: **string** - The name of the committer of the commit

committer.email
: **string** - The email of the committer of the commit

### Example Input

<%= json "message" => "my commit message", \
    "committer" => \
    {"name" => "Scott Chacon", "email" => "schacon@gmail.com" }, \
    "sha" => "329688480d39049927147c162b9d2deaf885005f" %>

### Response

<%= headers 200 %>
<%=
  json :content_crud do |response|
    response['content'] = nil
    response
  end
%>

## Get archive link

This method will return a `302` to a URL to download a tarball
or zipball archive for a repository. Please make sure your HTTP framework
is configured to follow redirects or you will need to use the `Location` header
to make a second `GET` request.

*Note*: For private repositories, these links are temporary and expire quickly.

    GET /repos/:owner/:repo/:archive_format/:ref

### Parameters

archive_format
: Either `tarball` or `zipball`

ref
: _Optional_  **string** - valid Git reference, defaults to `master`

### Response

<%= headers 302, :Location => 'http://github.com/me/myprivate/tarball/master?SSO=thistokenexpires' %>

To follow redirects with curl, use the `-L` switch:

<pre class="terminal">
curl -L https://api.github.com/repos/pengwynn/octokit/tarball > octokit.tar.gz

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  206k  100  206k    0     0   146k      0  0:00:01  0:00:01 --:--:--  790k
</pre>

## Custom media types

[READMEs](#get-the-readme), [files](#get-contents), and [symlinks](#get-contents) support the following custom media type.

    application/vnd.github.VERSION.raw

You can read more about the use of media types in the API [here](/v3/media/).
