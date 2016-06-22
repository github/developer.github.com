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

    application/vnd.github.cryptographer-preview

{{/tip}}

    GET /repos/:owner/:repo/git/commits/:sha

### Response

<%= headers 200 %>
<%= json(:signed_git_commit) %>

### The `verification` object

The response will include a `verification` field whose value is an object describing the result of verifying the commit's signature. The following fields are included in the `verification` object:

Name | Type | Description
-----|------|--------------
`verified`|`boolean` | Does GitHub consider the signature in this commit to be verified?
`reason`|`string` | The reason for `verified` value. Possible values and their meanings are enumerated in the table below.
`signature`|`string` | The signature that was extracted from the commit.
`payload`|`string` | The value that was signed.

#### The `reason` field

The following are possible `reason`s that may be included in the `verification` object:

Value | Description
------|------------
`expired_key` | The key that made the signature is expired.
`not_signing_key` | The "signing" flag is not among the usage flags in the GPG key that made the signature.
`gpgverify_error` | There was an error communicating with the signature-verification service.
`gpgverify_unavailable` | The signature-verification service is currently unavailable.
`unsigned` | The object does not include a signature.
`unknown_signature_type` | A non-PGP signature was found in the commit.
`no_user` | No user was associated with the `committer` email address in the commit.
`unverified_email` | The `committer` email address in the commit was associated with a user, but the email address is not verified on her/his account.
`bad_email` | The `committer` email address in the commit is not included in the identities of the PGP key that made the signature.
`unknown_key` | The key that made the signature has not been registered with any user's account.
`malformed_signature` | There was an error parsing the signature.
`invalid` | The signature could not be cryptographically verified using the key whose key-id was found in the signature.
`valid` | None of the above errors applied, so the signature is considered to be verified.

{% endif %}
