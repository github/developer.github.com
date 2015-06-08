---
kind: change
title: Prepare for upcoming organization permissions changes
created_at: 2015-01-07
author_name: jakeboxer
---

**UPDATE (2015-06-10):** As [announced on June 10][2015-06-10-update], these changes will become an official part of GitHub API v3 on June 24. (This post originally announced that these changes would come to GitHub API v3 on February 24.)

Last month, we [released a preview][org-permissions-preview] of several API changes related to managing organization members and repositories. Today, we're finalizing these changes. This new functionality is now stable and suitable for production use. If your application relies on any of the affected functionality (described below), be sure to **update your code before June 24** to account for these changes.

## Breaking changes coming on June 24

If your application uses any of the following APIs, then you are affected by this change:

- APIs for managing your organization's admins through the Owners team
- The [List your repositories][list-your-repos] API
- The [List your organizations][list-your-organizations] API
- The [List user organizations][list-user-organizations] API

If your application uses these APIs, we urge you to update your application as soon as possible. (Read [last month's announcement][org-permissions-preview] for more details on the changes.)

Starting today, we're offering a migration period allowing applications to opt in to these changes (as described below). On June 24, these changes will become official parts of the GitHub API v3. At that time, these changes will apply to all API consumers.

## Migration period

During the migration period, you can opt-in to these changes using the following custom media type in the `Accept` header:

    application/vnd.github.moondragon+json

We want to make these updates as smooth as possible for everyone, and we hope that the migration period gives you flexibility to adopt these changes on your own schedule. If you have any questions or feedback, please [get in touch with us][contact]!

[org-permissions-preview]: /changes/2014-12-08-organization-permissions-api-preview/
[list-your-repos]: /v3/repos/#list-your-repositories
[list-user-organizations]: /v3/orgs/#list-user-organizations
[list-your-organizations]: /v3/orgs/#list-your-organizations
[contact]: https://github.com/contact?form[subject]=Organization+Permissions+API
[2015-06-10-update]: /changes/2015-06-10-breaking-changes-to-organization-permissions-coming-on-june-24/
