---
title: Git Tags
---

# Tags

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

Name | Type | Description
-----|------|--------------
`tag`|`string`| The tag
`message`|`string`| The tag message
`object`|`string`| The SHA of the git object this is tagging
`type`|`string`| The type of the object we're tagging. Normally this is a `commit` but it can also be a `tree` or a `blob`.
`tagger`|`object`| An object with information about the individual creating the tag.

The `tagger` object contains the following keys:

Name | Type | Description
-----|------|--------------
`name`|`string`| The name of the author of the tag
`email`|`string`| The email of the author of the tag
`date`|`string`| When this object was tagged. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.


### Example Input

<%= json "tag"=> "v0.0.1", \
    "message" => "initial version\n", \
    "object" => "c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c", \
    "type" => "commit", \
    "tagger"=> \
    {"name" => "Scott Chacon", "email" => "schacon@gmail.com", \
    "date" => "2011-06-17T14:53:35-07:00"} %>

### Response

<%= headers 201, :Location => get_resource(:gittag)['url'] %>
<%= json :gittag %>

{% if page.version == 'dotcom' %}

## Tag signature verification

{{#tip}}

Tag response objects including signature verification data are currently available for developers to preview.
During the preview period, the object formats may change without advance notice.
Please see the [blog post](/changes/2016-04-04-git-signing-api-preview) for full details.

To receive signature verification data in tag objects you must provide a custom [media type](/v3/media) in the `Accept` header:

    application/vnd.github.cryptographer-preview

{{/tip}}

    GET /repos/:owner/:repo/git/tags/:sha

### Response

<%= headers 200 %>
<%= json(:signed_gittag) %>

### The `verification` object

The response will include a `verification` field whose value is an object describing the result of verifying the tag's signature. The following fields are included in the `verification` object:

Name | Type | Description
-----|------|--------------
`verified`|`boolean` | Does GitHub consider the signature in this tag to be verified?
`reason`|`string` | The reason for `verified` value. Possible values and their meanings are enumerated in the table below.
`signature`|`string` | The signature that was extracted from the tag.
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
`unkown_signature_type` | A non-PGP signature was found in the tag.
`no_user` | No user was associated with the `tagger` email address in the tag.
`unverified_email` | The `tagger` email address in the tag was associated with a user, but the email address is not verified on her/his account.
`bad_email` | The `tagger` email address in the tag is not included in the identities of the PGP key that made the signature.
`unknown_key` | The key that made the signature has not been registered with any user's account.
`malformed_signature` | There was an error parsing the signature.
`invalid` | The signature could not be cryptographically verified using the key whose key-id was found in the signature.
`valid` | None of the above errors applied, so the signature is considered to be verified.

{% endif %}
