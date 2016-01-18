---
kind: change
title: Breaking changes to organization permissions are now official
created_at: 2015-06-24
author_name: jakeboxer
---

As [promised earlier this month][notice], the [API changes][api-changes] related to managing organization members and repositories are now official parts of the GitHub API.

During the migration period, you needed to [provide a custom media type in the `Accept` header][migration-period] to opt-in to the changes. Now that the migration period has ended, you no longer need to specify this custom [media type][media-types].

If you have any questions or feedback, please [get in touch with us][contact]!

[notice]: /changes/2015-06-10-breaking-changes-to-organization-permissions-coming-on-june-24
[api-changes]: /changes/2014-12-08-organization-permissions-api-preview/
[contact]: https://github.com/contact?form[subject]=Organization+Permissions+API
[media-types]: /v3/media
[migration-period]: /changes/2015-06-10-breaking-changes-to-organization-permissions-coming-on-june-24/#migration-period
