---
kind: change
title: Previewing the new way to manage organization admins
created_at: 2014-11-20
author_name: jakeboxer
---
We have some upcoming changes that will affect the way organization members are managed. The most important change is that **on January 13, 2015, the Owners team will no longer be special**.

### What's happening to the Owners team?

Currently, members of your Owners team are administrators of your organization. On **January 13, 2015**, your Owners team will become a totally normal team. Adding and removing Owners team members won't change their administrator status anymore. Instead, you'll be able to directly grant admin permissions to your organization's members without adding them to any special teams.

We won't delete your Owners team, but you'll be able to delete or rename it yourself if you want. Organizations created after December 3 won't have an Owners team.

In preparation for this change, we're releasing a few new APIs. You'll be able to use these APIs to manage organization admins without relying on the Owners team.

### Adding an organization admin

To add a new organization admin, use the new [Add organization membership][add-org-membership] endpoint, specifying a role of `"admin"` in the request body. This replaces adding or inviting people to the Owners team.

### Listing organization admins

To get a list of all your organization's admins, use the [Organization members list][list-org-members] endpoint, specifying a role of `"admin"` in the query string. This replaces listing the members of the Owners team.

### Checking if someone is an organization admin

To check if a given user is an organization admin, use the new [Get organization membership][get-org-membership] endpoint. If the returned `"role"` attribute is set to `"admin"` and the returned `"state"` attribute is set to `"active"`, the user is an organization admin. This replaces checking if a user is on the Owners team.

### How long do I have to make the switch?

Starting **today**, these new APIs are available for developers to preview. We expect the preview period to last 21 days. On December 11, these additions will become official components of GitHub API v3.

Between **December 11, 2014 and January 12, 2015**, developers should update their applications to use the new APIs for managing organization admins. During this period, you will still be able to use the Owners team to manage your organization's admins, so that you have time to update your applications to use the new APIs without breakage.

On **January 13, 2015**, the Owners team will no longer be special. You'll no longer be able to rely on the Owners team for managing organization admins after this date.

### Preview period

While these additions are in their preview period, you'll need to provide the following custom media type in the `Accept` header:

    application/vnd.github.moondragon-preview+json

During the preview period, we may change aspects of these endpoints. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

If you have any questions or feedback, please [get in touch with us][contact]!

[contact]: https://github.com/contact?form[subject]=Organization+Admin+Pre-release+Preview
[add-org-membership]: /v3/orgs/members/#add-or-update-organization-membership
[list-org-members]: /v3/orgs/members/#members-list
[get-org-membership]: /v3/orgs/members/#get-organization-membership
