---
title: Commits
---

# Commits

{:toc}

The Repo Commits API supports listing, viewing, and comparing commits in a repository.

## List commits on a repository

    GET /repos/:owner/:repo/commits

### Parameters

Name | Type | Description
-----|------|--------------
`sha`|`string` | SHA or branch to start listing commits from. Default: the repository’s default branch (usually `master`).
`path`|`string` | Only commits containing this file path will be returned.
`author`|`string` | GitHub login or email address by which to filter by commit author.
`since`|`string` | Only commits after this date will be returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
`until`|`string` | Only commits before this date will be returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.


### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:commit) { |h| [h] } %>

## Get a single commit

    GET /repos/:owner/:repo/commits/:sha

### Response

Diffs with binary data will have no 'patch' property. Pass the
appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and
patch formats.

<%= headers 200 %>
<%= json(:full_commit) %>

## Get the SHA-1 of a commit reference

Users with read access can get the SHA-1 of a commit reference:

    GET /repos/:owner/:repo/commits/:ref

To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

    application/vnd.github.VERSION.sha

To check if a remote reference's SHA-1 is the same as your local reference's SHA-1, make a `GET` request and provide the current SHA-1 for the local reference as the ETag.

### Response

The SHA-1 of the commit reference.

<%= headers 200 %>
<pre>
814412cfbd631109df337e16c807207e78c0d24e
</pre>

## Compare two commits

    GET /repos/:owner/:repo/compare/:base...:head

Both `:base` and `:head` must be branch names in `:repo`. To compare branches across other repositories in the same network as `:repo`, use the format `<USERNAME>:branch`. For example:

    GET /repos/:owner/:repo/compare/hubot:branchname...octocat:branchname

### Response

The response from the API is equivalent to running the `git log base..head` command; however, commits are returned in reverse chronological order.

Pass the appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats.

<%= json :commit_comparison %>

### Working with large comparisons

The response will include a comparison of up to 250 commits. If you are working with a larger commit range, you can use the [Commit List API](/v3/repos/commits/#list-commits-on-a-repository) to enumerate all commits in the range.

For comparisons with extremely large diffs, you may receive an error response indicating that the diff took too long to generate. You can typically resolve this error by using a smaller commit range.

{% if page.version == 'dotcom' %}

## Commit signature verification

{{#tip}}

Commit response objects including signature verification data are currently available for developers to preview.
During the preview period, the object formats may change without advance notice.
Please see the [blog post](/changes/2016-04-04-git-signing-api-preview) for full details.

To receive signature verification data in commit objects you must provide a custom [media type](/v3/media) in the `Accept` header:

    application/vnd.github.cryptographer-preview

{{/tip}}

    GET /repos/:owner/:repo/commits/:sha

### Response

<%= headers 200 %>
<%= json(:signed_commit) %>

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
`unkown_signature_type` | A non-PGP signature was found in the commit.
`no_user` | No user was associated with the `committer` email address in the commit.
`unverified_email` | The `committer` email address in the commit was associated with a user, but the email address is not verified on her/his account.
`bad_email` | The `committer` email address in the commit is not included in the identities of the PGP key that made the signature.
`unknown_key` | The key that made the signature has not been registered with any user's account.
`malformed_signature` | There was an error parsing the signature.
`invalid` | The signature could not be cryptographically verified using the key whose key-id was found in the signature.
`valid` | None of the above errors applied, so the signature is considered to be verified.

{% endif %}
