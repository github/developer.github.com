---
title: User GPG Keys
---

{% if page.version == 'dotcom' %}

# GPG Keys

{{#tip}}

  <a name="preview-period"></a>

  APIs for managing user GPG keys are currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-04-04-git-signing-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.cryptographer-preview

{{/tip}}

{:toc}

## List your GPG keys

    GET /user/gpg_keys

Lists the current user's GPG keys. Requires that you are authenticated via
Basic Auth or via OAuth with at least `read:gpg_key`
[scope](/v3/oauth/#scopes).

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:gpg_key) { |h| [h] } %>

## Get a single GPG key

View extended details for a single GPG key. Requires that you are
authenticated via Basic Auth or via OAuth with at least `read:gpg_key`
[scope](/v3/oauth/#scopes).

    GET /user/gpg_keys/:id

### Response

<%= headers 200 %>
<%= json :gpg_key %>

## Create a GPG key

Creates a GPG key. Requires that you are authenticated via Basic Auth,
or OAuth with at least `write:gpg_key` [scope](/v3/oauth/#scopes).

    POST /user/gpg_keys

### Input

<%= json :armored_public_key => "-----BEGIN PGP PUBLIC KEY BLOCK-----\n...\n-----END PGP PUBLIC KEY BLOCK-----" %>

### Response

<%= headers 201, :Location => get_resource(:gpg_key)['url'] %>
<%= json :gpg_key %>

## Delete a GPG key

Removes a GPG key. Requires that you are authenticated via Basic Auth
or via OAuth with at least `admin:gpg_key` [scope](/v3/oauth/#scopes).

    DELETE /user/gpg_keys/:id

### Response

<%= headers 204 %>

{% endif %}
