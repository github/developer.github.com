---
kind: change
title: Breaking changes to Authorizations API responses on April 20
created_at: 2015-02-19
author_name: ptoomey3
---

A couple weeks ago we [extended the preview period][removing-authorizations-token-extended-preview] of several API changes related to managing OAuth application authorizations. Today, we're finalizing these changes. This new functionality is now stable and suitable for production use. If your application relies on any of the affected functionality (described below), be sure to **update your code before April 20** to account for these changes.

### Breaking changes coming on April 20

If your application uses any of the following APIs, then you may be affected by this change:

- The [List your authorizations][list-your-authorizations] API
- The [Get a single authorization][get-a-single-authorization] API
- The [Get-or-create an authorization for a specific app][get-or-create-an-authorization-for-a-specific-app] API (`token` is still returned for "create")
- The [Get-or-create an authorization for a specific app and fingerprint][get-or-create-an-authorization-for-a-specific-app-and-fingerprint] API (`token` is still returned for "create")
- The [Update an existing authorization][update-an-existing-authorization] API


If your application uses these APIs, we urge you to update your application as soon as possible. (Read [the December announcement][removing-authorizations-token] for more details on the changes.)

Starting today, we're offering a migration period allowing applications to opt in to these changes (as described below). On April 20, these changes will become official parts of the GitHub API v3. At that time, these changes will apply to all API consumers.

### Migration period

During the migration period, you can opt-in to these changes using the following custom media type in the `Accept` header:

    application/vnd.github.mirage-preview+json

We want to make these updates as smooth as possible for everyone, and we hope that the migration period gives you flexibility to adopt these changes on your own schedule. If you have any questions or feedback, please [get in touch with us][contact]!

[removing-authorizations-token-extended-preview]: /changes/2015-02-03-removing-authorizations-token-update/
[removing-authorizations-token]: /changes/2014-12-08-removing-authorizations-token/
[list-your-authorizations]: /v3/oauth_authorizations/#list-your-authorizations
[get-a-single-authorization]: /v3/oauth_authorizations/#get-a-single-authorization
[get-or-create-an-authorization-for-a-specific-app]: /v3/oauth_authorizations/#get-or-create-an-authorization-for-a-specific-app
[get-or-create-an-authorization-for-a-specific-app-and-fingerprint]: /v3/oauth_authorizations/#get-or-create-an-authorization-for-a-specific-app-and-fingerprint
[update-an-existing-authorization]: /v3/oauth_authorizations/#update-an-existing-authorization
[contact]: https://github.com/contact?form[subject]=Removing+authorizations+token
