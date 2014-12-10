---
kind: change
title: Replace older SSH keys created by your application
created_at: 2014-12-12
author_name: jasonrudolph
---
Back in February, we [improved the security audit trail for SSH keys](/changes/2014-02-24-finer-grained-scopes-for-ssh-keys/#keys-are-now-immutable). Soon, organizations will be able to block access for SSH keys that were created prior to those improvements. If your application relies on [deploy keys](/guides/managing-deploy-keys/#deploy-keys) or [user keys](/v3/users/keys/) for repository access, we recommend replacing any keys created before February 24, 2014.

To ensure that your application is not affected by organizations blocking access to these keys, **you should replace the affected keys by January 15, 2015**.

## How should you replace these keys?

We recommend the following steps for identifying and replacing the affected keys.

### 1. Identify the affected keys

You only need to replace keys that your application created prior to February 24, 2014. If you don't know when your app created a given key, you can get the creation timestamp from the API. The `created_at` property is available for [deploy keys](/v3/repos/keys/) and for [user keys](/v3/users/keys/#list-your-public-keys).

### 2. Inform the affected users

Once you know which keys you need to replace, we recommend that you inform the affected users.

For security, GitHub automatically sends an email to a user whenever a new SSH key is added to their account. Similarly, when a new deploy key is added to a repository, GitHub sends an email to the repository's administrators. When you replace your application's old keys with new ones, GitHub will email the affected users. To avoid surprising those users, you should alert them that you'll be replacing your keys. You may want to include a link to this post in your message.

### 3. Add a new key

Use the API to add the new [deploy key](/v3/repos/keys/#create) or [user key](/v3/users/keys/#create-a-public-key).

### 4. Delete the old key

Once your application is using the new key, use the API to delete the old one. There's an [API for deleting deploy keys](/v3/repos/keys/#delete) and an [API for deleting user keys](/v3/users/keys/#delete-a-public-key).

## We're here to help

As always, if you have any questions or concerns, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Replace+SSH+keys+created+by+application
