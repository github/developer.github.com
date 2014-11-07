---
kind: change
title: Previewing the new way to manage organization admins
created_at: 2014-11-10
author_name: jakeboxer
---
We have some upcoming changes that will affect the way organization members are managed. We'll reveal more in the coming weeks, but for now, the most important change is that **the Owners team will no longer be special**. Adding users to the Owners team won't make them admins, and removing users from the Owners team won't remove their admin status.

In preparation for this change, we're pre-releasing a few new APIs. You'll be able to use these APIs to manage organization admins without relying on the Owners team.

### Adding an organization admin

To add a new organization admin, use the new [Add organization membership][add-org-membership] endpoint, specifying a role of `"admin"` in the request body. This replaces adding or inviting people to the Owners team.

### Listing organization admins

To get a list of all your organization's admins, use the [Organization members list][list-org-members] endpoint, specifying a role of `"admin"` in the query string. This replaces listing the members of the Owners team.

### Checking if someone is an organization admin

To check if a given user is an organization admin, use the new [Get organization membership][get-org-membership] endpoint. If the returned `"role"` attribute is set to `"admin"` and the returned `"state"` attribute is set to `"active"`, the user is an organization admin. This replaces checking if a user is on the Owners team.

### Preview period

We're making these additions available today for developers to preview. During this period, we may change aspects of these endpoints. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

While these additions are in their preview period, you'll need to provide the following custom media type in the `Accept` header:

    application/vnd.github.moondragon-preview+json

We expect the preview period to last 7-14 days. At the end of the preview period, these additions will become official components of GitHub API v3.

If you have any questions or feedback, please [get in touch with us][contact]!

[contact]: https://github.com/contact?form[subject]=Organization+Admin+Pre-release+Preview
[add-org-membership]: /v3/orgs/members/#add-organization-membership
[list-org-members]: /v3/orgs/members/#members-list
[get-org-membership]: /v3/orgs/members/#get-organization-membership
