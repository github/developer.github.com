---
kind: change
title: The updated Authorizations API is official
created_at: 2015-04-20
author_name: ptoomey3
---

A couple weeks ago we
[announced the migration period][migration-period-removing-authorizations-token]
for several API changes related to managing OAuth application authorizations.
Today we're happy to announce that the updated [Authorizations API][docs] is
officially part of GitHub API v3. We now consider it stable for production use.
Thanks to everyone who provided feedback and updated their applications during
the preview period.

### Preview media type no longer needed

If you used the updated Authorizations API during the preview period, you needed
to provide a custom media type in the `Accept` header:

    application/vnd.github.mirage-preview+json

Now that the preview period has ended, you no longer need to pass this custom
media type.

Instead, we [recommend][media-types] that you specify `v3` as the version in the
`Accept` header:

    application/vnd.github.v3+json

### Feedback

As always, if you have any feedback, please don't hesitate to
[get in touch with us][contact].

[migration-period-removing-authorizations-token]: /changes/2015-02-20-migration-period-removing-authorizations-token
[docs]: /v3/oauth_authorizations
[media-types]: /v3/media
[contact]: https://github.com/contact?form[subject]=Removing+authorizations+token
