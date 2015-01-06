---
kind: change
title: Finalizing the updated Organization Permissions API
created_at: 2015-01-07
author_name: jakeboxer
---

Last month, we [released][org-permissions-preview] a preview of the updated Organization Permissions API. Today, we're finalizing these API changes. As of today, these APIs are stable and suitable for production use.

### Breaking changes coming on February 24

On February 24, 2014, these API changes will become official parts of the GitHub API v3. At that time, the custom media type will no longer be required to access these API changes.

If your application does any of these things:

- Uses the API to manage your organization's admins through the Owners team
- Uses the [List your repositories][list-your-repos] API
- Uses the [List your organizations][list-your-organizations] API
- Uses the [List user organizations][list-user-organizations] API

We urge you to update your application as soon as possible. Read the [update Organization Permissions API][org-permissions-preview] blog post for more details on the changes.

### Migration period

While these changes are in their migration period, you'll need to provide the following custom media type in the `Accept` header:

    application/vnd.github.moondragon+json

If you have any questions or feedback, please [get in touch with us][contact]!

[org-permissions-preview]: /changes/2014-12-08-organization-permissions-api-preview/
[list-your-repos]: /v3/repos/#list-your-repositories
[list-user-organizations]: /v3/orgs/#list-user-organizations
[list-your-organizations]: /v3/orgs/#list-your-organizations
[contact]: https://github.com/contact?form[subject]=Organization+Permissions+API
