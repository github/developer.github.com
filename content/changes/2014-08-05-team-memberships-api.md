---
kind: change
title: We're changing the way you add new members to your organization
created_at: 2014-08-05
author_name: jakeboxer
---

Today, we're announcing a change to the way organization owners add new members to their organization.

Previously, if you were an organization owner, you could use the [add team member][add-team-member] endpoint to add any GitHub user to any team on your organization without any sort of approval from them. Now, we're increasing user security by sending [invitations][org-invitations] to users when they're added to teams on organizations that they aren't yet a part of.

With this change, if you use the [add team member][add-team-member] endpoint to add a user to a team and that user isn't already on another team in your organization, the request will fail.

### The new Team Memberships API

You should change all your [add team member][add-team-member] requests to use the new [add team membership][add-team-membership] endpoint. This new endpoint works exactly the same as the old one, with one important change: if the membership being added is for a user who is unaffiliated with the team's organization, that user will be sent an invitation via email.

Unlike the [add team member][add-team-member] endpoint, a successful request to the [add team membership][add-team-membership] endpoint does *not* guarantee that the user is now a member of the team. If you're trying to migrate to the new endpoint and need to know when a user has been successfully added (not just invited) to a team, please check out [TeamAddEvent][team-add-event].

### Preview period

We're making the new Team Memberships API (and the breaking changes to the [add team member][add-team-member] API) available today for developers to preview. During this period, we may change aspects of these endpoints. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

While these new APIs are in their preview period, you'll need to provide the following custom media type in the `Accept` header:

    application/vnd.github.the-wasp-preview+json

We expect the preview period to last 30-60 days. At the end of the preview period, the Team Memberships API will become an official component of GitHub API v3, as will the [add team member][add-team-member] API's breaking changes.

If you have any questions or feedback, please [get in touch with us][contact]!

[contact]: https://github.com/contact?form[subject]=Team+Memberships+API
[org-invitations]: https://help.github.com/articles/adding-or-inviting-members-to-a-team-in-an-organization
[add-team-member]: /v3/orgs/teams/#add-team-member
[add-team-membership]: /v3/orgs/teams/#add-team-membership
[get-team-member]: /v3/orgs/teams/#get-team-member
[get-team-membership]: /v3/orgs/teams/#get-team-membership
[remove-team-member]: /v3/orgs/teams/#remove-team-member
[remove-team-member]: /v3/orgs/teams/#remove-team-membership
[team-add-event]: /v3/activity/events/types/#teamaddevent
