---
title: Git Tags | GitHub API
---

# Tags API

* TOC
{:toc}

This tags API only deals with tag objects - so only annotated tags, not
lightweight tags.

## Get a Tag

    GET /repos/:owner/:repo/git/tags/:sha

### Response

<%= headers 200 %>
<%= json :gittag %>

## Create a Tag Object

Note that creating a tag object does not create the reference that
makes a tag in Git.  If you want to create an annotated tag in Git,
you have to do this call to create the tag object, and then
[create](/v3/git/refs/#create-a-reference) the `refs/tags/[tag]` reference.
If you want to create a lightweight tag, you only have to
[create](/v3/git/refs/#create-a-reference) the tag reference - this call
would be unnecessary.

    POST /repos/:owner/:repo/git/tags

### Parameters

tag
: _String_ of the tag

message
: _String_ of the tag message

object
: _String_ of the SHA of the git object this is tagging

type
: _String_ of the type of the object we're tagging. Normally this is a
`commit` but it can also be a `tree` or a `blob`.

tagger.name
: _String_ of the name of the author of the tag

tagger.email
: _String_ of the email of the author of the tag

tagger.date
: _Timestamp_ of when this object was tagged

### Example Input

<%= json "tag"=> "v0.0.1", \
    "message" => "initial version\n", \
    "object" => "c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c", \
    "type" => "commit", \
    "tagger"=> \
    {"name" => "Scott Chacon", "email" => "schacon@gmail.com", \
    "date" => "2011-06-17T14:53:35-07:00"} %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/repos/:owner/:repo/git/tags/:sha" %>
<%= json :gittag %>

