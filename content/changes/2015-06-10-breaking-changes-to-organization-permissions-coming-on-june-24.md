---
kind: change
title: Breaking changes to organization permissions coming on June 24
created_at: 2015-06-10
author_name: jakeboxer
---

Back in January, we [encouraged developers to update their applications][org-permissions-finalization] to prepare for [upcoming API changes][org-permissions-preview] related to managing organization members and repositories. In order to support the upcoming [improvements to organization permissions][direct-org-membership-blog-post], these changes will become official parts of GitHub API v3 on **June 24**.

If your application relies on any of the affected functionality (described below), be sure to **update your code before June 24** to account for these changes.

## Breaking changes coming on June 24

If your application uses any of the following APIs, then you are affected by this change:

- APIs for managing your organization's admins through the Owners team
- The [List your repositories][list-your-repos] API
- The [List your organizations][list-your-organizations] API
- The [List user organizations][list-user-organizations] API

If your application uses these APIs, we urge you to update your application as soon as possible. (Read [December's announcement][org-permissions-preview] for full details on the changes.)

In January, we [announced a migration period][org-permissions-finalization] allowing API consumers to opt in to these changes. If you haven't already opted in to these changes, you still do so as described below. On June 24, these changes will become official parts of GitHub API v3. At that time, these changes will apply to all API consumers.

## Migration period

During these final days of the migration period, you can opt in to these changes using the following custom media type in the `Accept` header:

    application/vnd.github.moondragon+json

We want to make these updates as smooth as possible for everyone, and we hope that the migration period gives you flexibility to adopt these changes on your own schedule. If you have any questions or feedback, please [get in touch with us][contact]!

[org-permissions-finalization]: /changes/2015-01-07-prepare-for-organization-permissions-changes/
[org-permissions-preview]: /changes/2014-12-08-organization-permissions-api-preview/
[direct-org-membership-blog-post]: https://github.com/blog/2020-improved-organization-permissions/
[list-your-repos]: /v3/repos/#list-your-repositories
[list-user-organizations]: /v3/orgs/#list-user-organizations
[list-your-organizations]: /v3/orgs/#list-your-organizations
[contact]: https://github.com/contact?form[subject]=Organization+Permissions+API
