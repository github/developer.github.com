---
kind: change
title: The "Add team member" API breaking change will now happen next Monday
created_at: 2014-09-29
author_name: jakeboxer
---

Based on feedback from developers, we're delaying the breaking change to the ["Add team member" API][add-team-member] until next Monday.

The [breaking change to the "Add team member" API][finalizing] will go into effect for all requests on **October 6, 2014**. At that time, if you use [the "Add team member" API][add-team-member] to add a user to a team and that user isn't already on another team in your organization, the request will fail. To avoid this, be sure to use the [the "Add team membership" API][add-team-membership].

If you have any questions or feedback, please [get in touch with us][contact]!

[add-team-member]: /v3/orgs/teams/#add-team-member
[add-team-membership]: /v3/orgs/teams/#add-team-membership
[finalizing]: /changes/2014-09-16-finalizing-the-organization-and-team-membership-apis/
[contact]: https://github.com/contact?form[subject]=Organization+and+Team+Membership+APIs
