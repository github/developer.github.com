---
kind: change
title: Accepting organization invitations from the API
created_at: 2014-08-28
author_name: jakeboxer
---

The upcoming [Team Memberships API][team-memberships-api] gives you the power to [invite][org-invitations] new GitHub users to your organization via the API. We're expanding the API to also allow users to view their organization membership statuses and accept any invitations they've received.

### The new Organization Memberships API

When someone [invites][org-invitations] you to an organization, your membership with that organization begins in the "pending" state. The new [list organization memberships][list-org-memberships] endpoint allows you to find your pending memberships. You can then change them to "active" (accepting the invitation in the process) by using the [edit organization membership][edit-org-membership] endpoint.

### New Team Membership API response attribute

Previously, responses from the [add team membership][add-team-membership] and [get team membership][get-team-membership] endpoints included a "status" attribute, which could either be "active" or "pending". We've renamed this attribute from "status" to "state" for better consistency with our other API calls.

To give you time to update your apps, we'll keep the legacy "status" attribute around alongside the new "state" attribute until **September 4th, 2014**.

### Preview period

The new Organization Memberships API is available for developers to preview alongside the [Team Memberships API][team-memberships-api]. During this period, we may change aspects of these endpoints. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

While these new APIs are in their preview period, you'll need to provide the following custom media type in the `Accept` header:

    application/vnd.github.the-wasp-preview+json

We expect the preview period to last 30-60 days. At the end of the preview period, the Team and Organization Memberships APIs will become official components of GitHub API v3.

If you have any questions or feedback, please [get in touch with us][contact]!

[contact]: https://github.com/contact?form[subject]=Team+Memberships+API
[team-memberships-api]: /changes/2014-08-05-team-memberships-api/
[org-invitations]: https://help.github.com/articles/adding-or-inviting-members-to-a-team-in-an-organization
[list-org-memberships]: /v3/orgs/members/#list-your-organization-memberships
[edit-org-membership]: /v3/orgs/members/#edit-your-organization-membership
[add-team-membership]: /v3/orgs/teams/#add-team-membership
[get-team-membership]: /v3/orgs/teams/#get-team-membership
