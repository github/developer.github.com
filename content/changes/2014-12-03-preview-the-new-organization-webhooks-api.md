---
kind: change
title: Preview the New Organization Webhooks API
created_at: 2014-12-03
author_name: jdpace
---

Today we're very excited [to announce Organization Webhooks][dotcom-blog-post].
We're always looking for ways to improve the integration experience and give
you the tools needed to extend the GitHub experience. Organization Webhooks
allow you to easily subscribe to events that happen across an entire
organization, whether it's an issue being opened or a new repository being
created.

We’re making this new API for Organization Webhooks available today [for
developers to preview][docs-preview]. We think developers and existing
integrations are going to love it, but we want to [get your feedback][contact]
before we declare the Organization Webhooks API “final” and “unchangeable.” We
expect the preview period to last for roughly 30-60 days.

As we discover opportunities to improve the API during the preview period, we
may ship changes that break clients using the preview version of the API. We
want to iterate quickly. To do so, we will announce any changes here (on the
developer blog), but we will not provide any advance notice.

At the end of preview period, the Organization Webhooks API will become an
official component of GitHub API v3. At that point, the new Organization
Webhooks API will be stable and suitable for production use.

We hope you’ll take it for a spin and [send us your feedback][contact]. We
can't wait to see what you build.

[dotcom-blog-post]: https://github.com/blog/0000-announcing-organization-webhooks
[docs]: /v3/orgs/hooks/
[docs-preview]: /v3/orgs/hooks/#preview-period
[contact]: https://github.com/contact?form[subject]=Organization+Webhooks
