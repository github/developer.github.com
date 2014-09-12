---
kind: change
title: Finalizing the Organization and Team Membership APIs
created_at: 2014-09-15
author_name: jakeboxer
---

For the past few weeks, the [Organization Membership][org-membership-api] and [Team Membership][team-membership-api] APIs have been in preview periods, requiring special HTTP request headers to access. We also warned that these APIs were in-progress, and changes could come without advance notice.

Today, we're announcing that these new APIs have been finalized.

### What does "finalized" mean?

We do not expect any more changes to these APIs. If we do have to change them, we will provide notice a week in advance.

### When will these APIs become official?

On **September 22nd, 2014**, these APIs will become official parts of the GitHub API v3. The special preview media type header will no longer be required to access them, and the [breaking changes to the "Add team member" endpoint][add-team-member] will go into effect for all requests.

If you have any questions or feedback, please [get in touch with us][contact]!

[contact]: https://github.com/contact?form[subject]=Organization+and+Team+Membership+APIs
[org-membership-api]: /changes/2014-08-28-accepting-organization-invitations-from-the-api/
[team-membership-api]: /changes/2014-08-05-team-memberships-api/
[add-team-member]: /v3/orgs/teams/#add-team-member
