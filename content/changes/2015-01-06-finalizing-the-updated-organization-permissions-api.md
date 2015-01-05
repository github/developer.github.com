---
kind: change
title: Finalizing the updated Organization Permissions API
created_at: 2015-01-06
author_name: jakeboxer
---

Last month, we [released][org-permissions-preview] a preview of the updated Organization Permissions API. As of today, these API changes are official parts of the GitHub API v3. The preview media type is no longer required to access these changes.

## What's changing today?

### The "List your repositories" API

Previously, the [List your repositories][list-your-repos] API only returned repositories that are owned by users, not by organizations. If you wanted a list of *all* the repositories that the authenticated user has access to, you needed to use multiple API methods.

Now, this API includes all repositories that the authenticated user has access to (whether they're owned by a user or by an organization).

### The "List user organizations" API

The [List user organizations][list-user-organizations] API is intended provide [public organization memberships][public-org-membership] for any user. Previously, when you used this API to fetch *your own* organizations, it returned your public and private organization memberships.

Now, this API will only return public organization memberships.

### The "List your organizations" API

Previously, the [List your organizations][list-your-organizations] API always included your [public organization memberships][public-org-membership], regardless of the OAuth scopes associated with your request. If you had `user`, `read:org`, `write:org`, or `admin:org` scope, the response also included your private organization memberships.

Now, this API will only return organizations that your authorization allows you to operate on in some way (e.g., you can list teams with `read:org` scope, you can publicize your organization membership with `user` scope, etc.). Therefore, this API will require at least `user` or `read:org` scope. (`write:org` and `admin:org` scope implicitly include `read:org` scope.) OAuth requests with insufficient scope will receive a `403 Forbidden` response.

## What's new today?

We've released a few new APIs that allow you to manage organization admins without relying on the Owners team. If you're using the API to manage organization admins through the Owners team, we recommend updating your application to use these new APIs.

### Adding an organization admin

To add a new organization admin, use the new [Add or update organization membership][add-org-membership] endpoint, specifying a role of `"admin"` in the request body. This replaces adding or inviting people to the Owners team.

### Removing an organization admin

To remove someone from the organization role but keep them as a member of their teams, use the new [Add or update organization membership][add-org-membership] endpoint, specifying a role of `"member"` in the request body. This replaces removing people from the Owners team.

### Listing organization admins

To get a list of all your organization's admins, use the [Organization members list][list-org-members] endpoint, specifying a role of `"admin"` in the query string. This replaces listing the members of the Owners team.

### Checking if someone is an organization admin

To check if a given user is an organization admin, use the new [Get organization membership][get-org-membership] endpoint. If the returned `"role"` attribute is set to `"admin"` and the returned `"state"` attribute is set to `"active"`, the user is an organization admin. This replaces checking if a user is on the Owners team.

## Reminder: upcoming changes to the Owners team

In February 2015, your Owners team will lose its special status and become a totally normal team. At this point, using the API to manage organization admins through the Owners team will no longer work; your API requests will still succeed, but changing Owners team membership will have no impact on organization admin status. To keep your application working correctly, update it as soon as possible to use the new APIs described above.

If you have any questions or feedback, please [get in touch with us][contact]!

[org-permissions-preview]: /changes/2014-12-08-organization-permissions-api-preview/
[list-your-repos]: /v3/repos/#list-your-repositories
[list-user-organizations]: /v3/orgs/#list-user-organizations
[public-org-membership]: https://help.github.com/articles/publicizing-or-concealing-organization-membership
[list-your-organizations]: /v3/orgs/#list-your-organizations
[add-org-membership]: /v3/orgs/members/#add-or-update-organization-membership
[list-org-members]: /v3/orgs/members/#members-list
[get-org-membership]: /v3/orgs/members/#get-organization-membership
[contact]: https://github.com/contact?form[subject]=Organization+Permissions+API
