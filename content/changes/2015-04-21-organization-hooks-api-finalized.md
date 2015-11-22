---
kind: change
title: Organization Webhooks API finalized
created_at: 2015-04-21
author_name: pengwynn
---

After [four months in preview release][ann], the [Organization Webhooks API][docs] is now considered stable and ready for production use. 

### Preview media type no longer needed

During the preview period, you needed to provide a custom media type in the `Accept` header when using the Organization Webhooks API:

    application/vnd.github.sersi-preview+json

Now that the preview  has ended, you no longer need to pass this custom
media type, though providing an explicit [media type][media-types] is recommended:

    application/vnd.github.v3+json

### Feedback

If you have any questions or feedback on this API, please [get in touch][contact].

[ann]: /changes/2014-12-03-preview-the-new-organization-webhooks-api/
[docs]: /v3/orgs/hooks
[media-types]: /v3/media
[contact]: https://github.com/contact?form%5Bsubject%5D=Organization+Webhooks


