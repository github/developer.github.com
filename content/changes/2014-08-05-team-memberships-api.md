---
kind: change
title: The team memberships API
created_at: 2014-08-05
author_name: jakeboxer
---

Today we're announcing a new API preview feature: Team Memberships.

Previously, if you were an organization owner, you could use the [add team member][add-team-member] endpoint to add any GitHub user to any team on your organization without any sort of approval from them. Now, we're increasing user security by sending invitations to users the first time they're invited to organizations they're already a part of.

### Adding a user to a team

This means that, if you try to use the [add team member][add-team-member] endpoint to add a user to a team and that user isn't already on another team in your organization, the request will error.

You should change all your [add team member][add-team-member] requests to use the new [add team membership][add-team-membership] endpoint. This new endpoint works exactly the same as the old one, with one important change: if the membership being added is for a user who is unaffiliated with the team's organization, that user will be sent an invitation.

### Getting the status of a user's membership with a team

You should also consider changing your [get team member][get-team-member] requests to use the new [get team membership][get-team-membership] endpoint. This will tell you if the membership between the specified user and team is active (meaning the user is a member of the team) or pending (meaning the user has an invitation to the team).

### Removing a user's membership from a team

Finally, you should consider changing your [remove team member][remove-team-member] requests to use the new [remove team membership][remove-team-membership] endpoint. In addition to removing members from teams like the old endpoint did, this new endpoint will cancel invitations when appropriate.

### Preview period

We're making these new APIs (and the breaking changes to the [add team member][add-team-member] API) available today for developers to preview. During this period, we may change aspects of these four endpoints. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

While these new APIs are in their preview period, you'll need to provide the following custom media type in the `Accept` header:

    application/vnd.github.the-wasp-preview+json

We expect the preview period to last 30-60 days. At the end of the preview period, the Team Memberships API will become an official component of GitHub API v3, as will the [add team member][add-team-member] API's breaking changes.

If you have any questions or feedback, please [send it to us][contact]!

[contact]: https://github.com/contact?form[subject]=Team+Memberships+API
[add-team-member]: /v3/orgs/teams/#add-team-member
[add-team-membership]: /v3/orgs/teams/#add-team-membership
[get-team-member]: /v3/orgs/teams/#get-team-member
[get-team-membership]: /v3/orgs/teams/#get-team-membership
[remove-team-member]: /v3/orgs/teams/#remove-team-member
[remove-team-member]: /v3/orgs/teams/#remove-team-membership
