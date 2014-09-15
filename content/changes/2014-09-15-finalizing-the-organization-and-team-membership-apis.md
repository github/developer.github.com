---
kind: change
title: Finalizing the Organization and Team Membership APIs
created_at: 2014-09-15
author_name: jakeboxer
---

For the past few weeks, the new [Organization Membership][org-membership-api] and [Team Membership][team-membership-api] APIs have been available for early access via a preview media type.  As of today, these APIs are stable and suitable for production use.

### Preview period ends on September 22

On September 22, 2014, these APIs will become official parts of the GitHub API v3. At that time, the preview media type will no longer be required to access these APIs.

### Reminder: Breaking change to legacy endpoint

The [breaking change to the "Add team member" endpoint][add-team-member] will also go into effect for all requests on **September 22, 2014**. At that time, if you use the [add team member][add-team-member] endpoint to add a user to a team and that user isn't already on another team in your organization, the request will fail. To avoid this, be sure to use the [add team membership][add-team-membership] endpoint.

If you have any questions or feedback, please [get in touch with us][contact]!

[contact]: https://github.com/contact?form[subject]=Organization+and+Team+Membership+APIs
[org-membership-api]: /changes/2014-08-28-accepting-organization-invitations-from-the-api/
[team-membership-api]: /changes/2014-08-05-team-memberships-api/
[add-team-member]: /v3/orgs/teams/#add-team-member
[add-team-membership]: /v3/orgs/teams/#add-team-membership
