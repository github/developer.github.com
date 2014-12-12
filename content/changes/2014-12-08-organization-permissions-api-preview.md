---
kind: change
title: Preview the upcoming organization permission changes
created_at: 2014-12-08
author_name: jakeboxer
---
**UPDATE (2014-12-12):** The [List your organizations][list-your-organizations] API is now included in this preview as well.

We have some upcoming changes that will affect the way organization members and repositories are managed. The most important changes are:

- The Owners team will no longer be special.
- The [List your repositories][list-your-repos] API will include organization-owned repositories.
- The [List user organizations][list-user-organizations] API will only include public organization memberships.
- The [List your organizations][list-your-organizations] API will require `user` scope or `read:org` scope.

## What's happening to the Owners team?

Currently, members of your Owners team are administrators of your organization. Soon, your Owners team will become a totally normal team. Adding and removing Owners team members won't change their administrator status anymore. Instead, you'll be able to directly grant admin permissions to your organization's members without adding them to any special teams.

We won't delete your Owners team, but you'll be able to delete or rename it yourself if you want. Organizations created after the change won't have an Owners team.

### What should you do?

In preparation for this change to the Owners team, we're releasing a few new APIs. You'll be able to use these APIs to manage organization admins without relying on the Owners team.

#### Adding an organization admin

To add a new organization admin, use the new [Add or update organization membership][add-org-membership] endpoint, specifying a role of `"admin"` in the request body. This replaces adding or inviting people to the Owners team.

#### Removing an organization admin

To remove someone from the organization role but keep them as a member of their teams, use the new [Add or update organization membership][add-org-membership] endpoint, specifying a role of `"member"` in the request body. This replaces removing people from the Owners team.

#### Listing organization admins

To get a list of all your organization's admins, use the [Organization members list][list-org-members] endpoint, specifying a role of `"admin"` in the query string. This replaces listing the members of the Owners team.

#### Checking if someone is an organization admin

To check if a given user is an organization admin, use the new [Get organization membership][get-org-membership] endpoint. If the returned `"role"` attribute is set to `"admin"` and the returned `"state"` attribute is set to `"active"`, the user is an organization admin. This replaces checking if a user is on the Owners team.

## What's happening to the "List your repositories" API?

Currently, the [List your repositories][list-your-repos] API only returns repositories that are owned by users, not by organizations. If you want a list of *all* the repositories that the authenticated user has access to, you need to use multiple API methods.

Soon, this API will include all repositories that the authenticated user has access to (whether they're owned by a user or by an organization).

### What should you do?

Many apps use the [List your repositories][list-your-repos] API in conjunction with the [List your organizations][list-your-orgs] and [List organization repositories][list-org-repos] APIs to build up a list of all the repositories the authenticated user has access to. If your app is doing this, you'll be able to get rid of all the organization-related API calls and just use the [List your repositories][list-your-repos] API.

If your app uses the [List your repositories][list-your-repos] API for another purpose, you'll need to update your app to handle the new organization-owned repositories we'll be returning.

## What's happening to the "List user organizations" API?

The [List user organizations][list-user-organizations] API is intended provide [public organization memberships][public-org-membership] for any user. When you use this API to fetch *your own* organizations, this API currently returns your public and private organization memberships.

Soon, this API will only return public organization memberships.

### What should you do?

If your app uses the [List user organizations][list-user-organizations] API to fetch all of the organization memberships (public and private) for the authenticated user, you'll need to update your app to use the [List your organizations][list-your-organizations] API instead. The [List your organizations][list-your-organizations] API returns all organizations (public and private) that your app is authorized to access.

## What's happening to the "List your organizations" API?

OAuth requests will soon require minimum [scopes][] in order to access the [List your organizations][list-your-organizations] API.

Currently, the API response always includes your [public organization memberships][public-org-membership], regardless of the OAuth scopes associated with your request. If you have `user`, `read:org`, `write:org`, or `admin:org` scope, the response also includes your private organization memberships.

Soon, this API will only return organizations that your authorization allows you to operate on in some way (e.g., you can list teams with `read:org` scope, you can publicize your organization membership with `user` scope, etc.). Therefore, this API will require at least `user` or `read:org` scope. (`write:org` and `admin:org` scope implicitly include `read:org` scope.) OAuth requests with insufficient scope will receive a `403 Forbidden` response.

### What should you do?

If you [authenticate via username and password][username-password-authn], you are not affected by this change.

If your app only needs to fetch the user's public organization memberships, you should use the [List user organizations][list-user-organizations] API instead. Since that API only returns public information, it does not require any scopes.

## Preview period

Starting **today**, these new APIs are available for developers to preview. We expect the preview period to last for four weeks. (Stay tuned to the developer blog for updates.) At the end of the preview period, these additions will become official components of the GitHub API.

While these additions are in their preview period, you'll need to provide the following custom media type in the `Accept` header:

    application/vnd.github.moondragon-preview+json

During the preview period, we may change aspects of these endpoints. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

## Migration period

At the end of the preview period, we will announce the start of a migration period. At that time, developers should update their applications to use the new APIs for managing organization admins. During this period, you will still be able to use the Owners team to manage your organization's admins, so that you have time to update your applications to use the new APIs without breakage. We expect the migration period to last for four weeks.

At the end of the migration period, the Owners team will no longer be special, and you'll no longer be able to rely on it for managing organization admins.

If you have any questions or feedback, please [get in touch with us][contact]!

[contact]: https://github.com/contact?form[subject]=Organization+Admin+Pre-release+Preview
[list-your-repos]: /v3/repos/#list-your-repositories
[list-your-orgs]: /v3/orgs/#list-your-organizations
[list-org-repos]: /v3/repos/#list-organization-repositories
[add-org-membership]: /v3/orgs/members/#add-or-update-organization-membership
[list-org-members]: /v3/orgs/members/#members-list
[get-org-membership]: /v3/orgs/members/#get-organization-membership
[list-user-organizations]: /v3/orgs/#list-user-organizations
[list-your-organizations]: /v3/orgs/#list-your-organizations
[public-org-membership]: https://help.github.com/articles/publicizing-or-concealing-organization-membership
[username-password-authn]: /v3/auth/#via-username-and-password
[scopes]: /v3/oauth/#scopes
