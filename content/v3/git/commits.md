---
title: Git Commits
---

# Commits

{:toc}

## Get a Commit

    GET /repos/:owner/:repo/git/commits/:sha

### Response

<%= headers 200 %>
<%= json :git_commit %>

## Create a Commit

    POST /repos/:owner/:repo/git/commits

### Parameters

Name | Type | Description
-----|------|--------------
`message`|`string` | **Required**. The commit message
`tree`|`string` | **Required**. The SHA of the tree object this commit points to
`parents`|`array` of `string`s| **Required**. The SHAs of the commits that were the parents of this commit.  If omitted or empty, the commit will be written as a root commit.  For a single parent, an array of one SHA should be provided; for a merge commit, an array of more than one should be provided.


### Optional Parameters

You can provide an additional `committer` parameter, which is an object containing
information about the committer. Or, you can provide an `author` parameter, which
is an object containing information about the author.

The `committer` section is optional and will be filled with the `author`
data if omitted. If the `author` section is omitted, it will be filled
in with the authenticated user's information and the current date.

Both the `author` and `committer` parameters have the same keys:

Name | Type | Description
-----|------|-------------
`name`|`string` | The name of the author (or committer) of the commit
`email`|`string` | The email of the author (or committer) of the commit
`date`|`string` | Indicates when this commit was authored (or committed). This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.

### Example Input

<%= json "message"=> "my commit message", \
    "author"=> \
    {"name" => "Scott Chacon", "email" => "schacon@gmail.com", \
    "date" => "2008-07-09T16:13:30+12:00"}, \
    "parents"=>["7d1b31e74ee336d15cbd21741bc88a537ed063a0"], \
    "tree"=>"827efc6d56897b048c772eb4087f854f46256132" %>

### Response

<%= headers 201, :Location => get_resource(:new_commit)['url'] %>
<%= json :new_commit %>

{% if page.version == 'dotcom' %}

## Commit signature verification

{{#tip}}

Commit response objects including signature verification data are currently available for developers to preview.
During the preview period, the object formats may change without advance notice.
Please see the [blog post](/changes/2016-04-04-git-signing-api-preview) for full details.

To receive signature verification data in commit objects you must provide a custom [media type](/v3/media) in the `Accept` header:

    application/vnd.github.cryptographer-preview+sha

{{/tip}}

    GET /repos/:owner/:repo/git/commits/:sha

### Response

<%= headers 200 %>
<%= json(:signed_git_commit) %>

{% endif %}
