---
kind: change
title: Finer-grained OAuth scopes for SSH keys
created_at: 2014-02-24
author_name: pengwynn
---
As [we announced][blog], we've made some important changes to the way that API consumers manage SSH keys.

## Finer-grained OAuth scopes

To help third party applications request only permissions that they need, the API now supports three new [scopes][] for working with a user's public SSH keys.

- `read:public_key` provides read access to the user's SSH keys
- `write:public_key` allows an app to read existing keys and create new ones
- `admin:public_key` enables an app to read, write, and delete keys

## Changes to `user` scope

Historically, `user` scope has provided full access to manage a user's SSH keys. Now that we have dedicated scopes for managing a user's SSH keys, we have removed those permissions from the `user` scope. Now `user` scope will no longer provide access to SSH keys. Applications that need this access should request one of the new scopes described above.

## Keys are now immutable

To simplify the security audit trail for SSH keys, we're making keys immutable. API consumers can continue to create keys and delete keys as needed, but keys can no longer be changed. To change an existing key, API consumers should delete the existing key and create a new one with the desired attributes. This change applies both to a [user's SSH keys][user-keys] and a [repository's deploy keys][deploy-keys].

## Deleting keys when revoking a token

Also any keys created via an OAuth token from this point forward will be deleted when that token is revoked.

As always, if you have any questions or feedback, [please get in touch][contact].

[contact]: https://github.com/contact?form[subject]=API+improvements+for+SSH+keys
[scopes]: /v3/oauth/#scopes
[user-keys]: /v3/users/keys/
[deploy-keys]: /v3/repos/keys/
[blog]: https://github.com/blog/1786-enhanced-oauth-security-for-ssh-keys
