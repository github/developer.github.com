---
kind: change
title: One more week before the "Add team member" API breaking change
created_at: 2014-09-23
author_name: jakeboxer
---

**UPDATE (2014-09-30):** In response to feedback from developers, we're delaying the breaking change to the ["Add team member" API][add-team-member] until Monday, **October 6, 2014**. The change will go into effect for all requests on that date.

Starting October 6, if you use [the "Add team member" API][add-team-member] to add a user to a team and that user isn't already on another team in your organization, the request will fail. To avoid this, be sure to use the ["Add team membership" API][add-team-membership].

### The Organization and Team Membership APIs are now official

As promised in [our blog post earlier this month][finalizing], the [Organization Membership][org-membership-api] and [Team Membership][team-membership-api] APIs are now an official part of the GitHub API! The preview media type is no longer required to access them.

If you have any questions or feedback, please [get in touch with us][contact]!

[add-team-member]: /v3/orgs/teams/#add-team-member
[add-team-membership]: /v3/orgs/teams/#add-team-membership
[finalizing]: /changes/2014-09-16-finalizing-the-organization-and-team-membership-apis/
[org-membership-api]: /changes/2014-08-28-accepting-organization-invitations-from-the-api/
[team-membership-api]: /changes/2014-08-05-team-memberships-api/
[contact]: https://github.com/contact?form[subject]=Organization+and+Team+Membership+APIs
