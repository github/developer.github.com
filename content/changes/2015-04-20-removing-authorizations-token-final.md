---
kind: change
title: Authorizations API response changes are now in effect
created_at: 2015-04-20
author_name: ptoomey3
---

Two months ago, we
[announced the migration period][migration-period-announcement]
for several [API changes related to managing OAuth authorizations][original-announcement].
As promised, the migration period concluded today, and these changes are
now in effect for all requests.

### Preview media type no longer needed

If you used the updated Authorizations API during the migration period, you needed
to provide a custom media type in the `Accept` header:

    application/vnd.github.mirage-preview+json

Now that the migration period has ended, you no longer need to pass this custom
media type.

Instead, we [recommend][media-types] that you specify `v3` as the version in the
`Accept` header:

    application/vnd.github.v3+json

### Feedback

As always, if you have any feedback, please don't hesitate to
[get in touch with us][contact].

[migration-period-announcement]: /changes/2015-02-20-migration-period-removing-authorizations-token
[original-announcement]: /changes/2014-12-08-removing-authorizations-token/
[docs]: /v3/oauth_authorizations
[media-types]: /v3/media
[contact]: https://github.com/contact?form[subject]=Removing+token+from+Authorizations+API
