---
kind: change
title: Preview the New Organization Webhooks API
created_at: 2014-12-03
author_name: jdpace
---

Today we're very excited [to announce Organization Webhooks][dotcom-blog-post].
Organization Webhooks allow you to subscribe to events that happen across an
entire organization.

In addition to being able to subscribe to the existing repository oriented
events across an organization, we're also adding some new events which are
exclusive to organization webhooks. The new [`repository`
event][repository-event] allows you to receive webhook payloads when a new
repository is created. By subscribing to the [`membership`
event][membership-event], you'll be notified whenever a user is added or
removed from a team.

We’re making this new API for Organization Webhooks available today [for
developers to preview][docs-preview]. The preview period will allow us to [get
your feedback][contact] before declaring the Organization Webhooks API final.
We expect the preview
period to last for roughly 30-60 days.

As we discover opportunities to improve the API during the preview period, we
may ship changes that break clients using the preview version of the API. We
want to iterate quickly. To do so, we will announce any changes here (on the
developer blog), but we will not provide any advance notice.

At the end of preview period, the Organization Webhooks API will become an
official component of GitHub API v3. At that point, the new Organization
Webhooks API will be stable and suitable for production use.

We hope you’ll take it for a spin and [send us your feedback][contact].

[dotcom-blog-post]: https://github.com/blog/1933-introducing-organization-webhooks
[repository-event]: /v3/activity/events/types/#repositoryevent
[membership-event]: /v3/activity/events/types/#membershipevent
[docs]: /v3/orgs/hooks/
[docs-preview]: /v3/orgs/hooks/
[contact]: https://github.com/contact?form[subject]=Organization+Webhooks
