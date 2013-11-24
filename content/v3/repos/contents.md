---
title: Contents | GitHub API
---

# Contents

* TOC
{:toc}

These API methods let you retrieve the contents of files within a repository as
Base64 encoded content. See [media types](#custom-media-types) for requesting raw format.

## Get the README

This method returns the preferred README for a repository.

    GET /repos/:owner/:repo/readme

READMEs support [a custom media type](#custom-media-types) for getting the raw content.

### Parameters

Name | Type | Description 
-----|------|--------------
`ref`|`string` | The name of the commit/branch/tag. Default: the repository’s default branch (usually `master`)

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

Name | Type | Description 
-----|------|--------------
`path`|`string` | The content path.
`ref`|`string` | The name of the commit/branch/tag. Default: the repository’s default branch (usually `master`)

### Response if content is a file

<%= headers 200 %>
<%= json :readme_content %>

### Response if content is a directory

<%= headers 200 %>
<%= json :directory_content %>

Note: When listing the contents of a directory, submodules have their "type"
specified as "file". Logically, the value *should* be "submodule". This behavior
exists in API v3 [for backwards compatibility purposes](https://github.com/github/developer.github.com/commit/1b329b04cece9f3087faa7b1e0382317a9b93490).
In the next major version of the API, the type will be returned as "submodule".

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

Name | Type | Description 
-----|------|-------------
`path`|`string` | **Required**. The content path.
`message`|`string` | **Required**. The commit message.
`content`|`string` | **Required**. The new file content, Base64 encoded.
`branch` | `string` | The branch name. Default: the repository’s default branch (usually `master`)

### Optional Parameters

You can provide an additional `commiter` parameter, which is a hash containing
information about the committer. Or, you can provide an `author` parameter, which
is a hash containing information about the author.

The `author` section is optional and is filled in with the `committer`
information if omitted. If the `committer` information is omitted, the authenticated
user's information is used.

You must provide values for both `name` and `email`, whether you choose to use
`author` or `committer`. Otherwise, you'll receive a `500` status code.

Both the `author` and `commiter` parameters have the same keys:

Name | Type | Description 
-----|------|--------------
`name`|`string` | The name of the author (or commiter) of the commit
`email`|`string` | The email of the author (or commiter) of the commit

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

Name | Type | Description 
-----|------|--------------
`path`|`string` | **Required**. The content path.
`message`|`string` | **Required**. The commit message.
`content`|`string` | **Required**. The updated file content, Base64 encoded.
`sha` | `string` | **Required**. The blob SHA of the file being replaced. 
`branch` | `string` | The branch name. Default: the repository’s default branch (usually `master`)

### Optional Parameters

You can provide an additional `commiter` parameter, which is a hash containing
information about the committer. Or, you can provide an `author` parameter, which
is a hash containing information about the author.

The `author` section is optional and is filled in with the `committer`
information if omitted. If the `committer` information is omitted, the authenticated
user's information is used.

You must provide values for both `name` and `email`, whether you choose to use
`author` or `committer`. Otherwise, you'll receive a `500` status code.

Both the `author` and `commiter` parameters have the same keys:

Name | Type | Description 
-----|------|--------------
`name`|`string` | The name of the author (or commiter) of the commit
`email`|`string` | The email of the author (or commiter) of the commit

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


Name | Type | Description 
-----|------|--------------
`path`|`string` | **Required**. The content path.
`message`|`string` | **Required**. The commit message.
`sha` | `string` | **Required**. The blob SHA of the file being replaced. 
`branch` | `string` | The branch name. Default: the repository’s default branch (usually `master`)

### Optional Parameters

You can provide an additional `commiter` parameter, which is a hash containing
information about the committer. Or, you can provide an `author` parameter, which
is a hash containing information about the author.

The `author` section is optional and is filled in with the `committer`
information if omitted. If the `committer` information is omitted, the authenticated
user's information is used.

You must provide values for both `name` and `email`, whether you choose to use
`author` or `committer`. Otherwise, you'll receive a `500` status code.

Both the `author` and `commiter` parameters have the same keys:

Name | Type | Description 
-----|------|--------------
`name`|`string` | The name of the author (or commiter) of the commit
`email`|`string` | The email of the author (or commiter) of the commit

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

Name | Type | Description 
-----|------|--------------
`archive_format`|`string` | Can be either `tarball` or `zipball`. Default: `tarball`
`ref`| `string` | A valid Git reference. Default: the repository’s default branch (usually `master`)


### Response

<%= headers 302, :Location => 'https://codeload.github.com/me/myprivate/legacy.zip/master?login=me&token=thistokenexpires' %>

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
