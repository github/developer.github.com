---
kind: change
title: API enhancements for working with organization permissions
created_at: 2015-06-24
author_name: jakeboxer
---

We're introducing several enhancements to allow API developers to take advantage of the [improved organization permissions][dotcom-blog-post] that we are rolling out. Learn about these enhancements and how you can try them out below.

Since we're rolling out the [improved organization permissions][dotcom-blog-post] improvements slowly, these enhancements will only apply to certain organizations at first. Most of these enhancements will degrade gracefully (returning an empty array or something similar) if used on an organization that doesn't support improved organization permissions yet. Check the documentation for your specific API to see if errors are possible.

## API enhancements

### Team permissions

In our improved permissions system, a team no longer has a single permission that applies to all of its repositories. Instead, each repository is added to a team with its own permission. For example, an organization could use a single team to grant pull access to one repository, push access to a second, and admin access to a third.

The team APIs now support this more granular notion of permissions:

- The [Add team repository][add-team-repo] API accepts a `permission` parameter, so that you can specify whether a team should grant `pull`, `push`, or `admin` access on a given repository.
- In the [List team repositories][list-team-repos] and [Check if a team manages a repository][get-team-repo] API, the response includes a `permissions` attribute, indicating whether the team grants `pull`, `push`, or `admin` access on each repository.
- The `permission` parameter in the [Create team][create-team] and [Edit team][edit-team] APIs is deprecated. Since teams can grant a different permission on each repository, this parameter no longer dictates what permission a team grants on all of its repositories. Instead, it dictates the default permission that the [Add team repository][add-team-repo] API will use for requests where no `permission` parameter is specified.

### Team privacy

We now allow you to modify the privacy level of your teams. A "secret" team can only be seen by organization owners and people who are members of that team (which is how all teams have worked historically), while a "closed" team is visible to every member of the organization (which makes it easier to use [@mentions][team-mentions] throughout your organization).

The team APIs now support this new team privacy concept:

- The [Create team][create-team] and [Edit team][edit-team] APIs accept a `privacy` parameter, so that you can specify whether a team should be `secret` or `closed`.
- All team resources in the API now include a `privacy` attribute, indicating whether the team is `secret` or `closed`.

### Team maintainers

We've added the ability for you to delegate team maintenance to non-owners, reducing the workload for your organization's owners. You can now promote a non-owner member of a team to be a "maintainer" of that team. A maintainer can add and remove team members and change the team's title and description.

The team membership APIs now support this new team maintainer concept:

- The [Add team membership][add-team-membership] API accepts a `role` parameter, so that you can specify whether a given team member should be a `maintainer` or a regular `member`.
- The [List team members][list-team-members] API accepts an optional `role` parameter, allowing you to fetch only `maintainer`s or only regular `member`s.
- In the [Get team membership][get-team-membership] and [Add team membership][add-team-membership] APIs, the response includes a `role` attribute, indicating whether a user is a `maintainer` or a regular `member` of the team.

For more information on our improved team permissions, check out our [documentation][understanding-team-permissions].

### Filtering organization members by role

The organization [Members list][org-members-list] API now accepts a `role` parameter, so that you can request to see only the owners (or non-owners) of your organization.

### Repository collaborators

We now allow you to add collaborators directly to organization-owned repositories, just like we always have for user-owned repositories.

The collaborator APIs now support organization-owned repositories:

- The [Add user as a collaborator][add-collab] API works for organization-owned repositories. We've also added a `permission` parameter to it (currently valid for organization-owned repositories only), so that you can specify what level of access the collaborator should have on the repository.
- In the [List collaborators][list-collabs] API, the response includes a `permissions` attribute describing the permissions that each collaborator has on your organization's repositories.

## Preview period

Starting today, these API enhancements are available for developers to preview. At the end of the preview period, these enhancements will become official components of the GitHub API.

While these enhancements are in their preview period, you'll need to provide the following [custom media type][custom-media-types] in the `Accept` header:

    application/vnd.github.ironman-preview+json

During the preview period, we may change aspects of these enhancements. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

## Send us your feedback

We would love to hear your thoughts on these enhancements. If you have any questions or feedback, please [get in touch with us][contact]!

[dotcom-blog-post]: https://github.com/blog/2020-improved-organization-permissions
[understanding-team-permissions]: https://help.github.com/articles/improved-organization-permissions/#understanding-team-permissions
[create-team]: /v3/orgs/teams/#create-team
[edit-team]: /v3/orgs/teams/#edit-team
[list-team-members]: /v3/orgs/teams/#list-team-members
[get-team-membership]: /v3/orgs/teams/#get-team-membership
[add-team-membership]: /v3/orgs/teams/#add-team-membership
[list-team-repos]: /v3/orgs/teams/#list-team-repos
[get-team-repo]: /v3/orgs/teams/#get-team-repo
[add-team-repo]: /v3/orgs/teams/#add-team-repo
[org-members-list]: /v3/orgs/members/#members-list
[org-public-members-list]: /v3/orgs/members/#public-members-list
[list-collabs]: /v3/repos/collaborators/#list
[add-collab]: /v3/repos/collaborators/#add-collaborator
[contact]: https://github.com/contact?form[subject]=Organization+Permissions+API
[team-mentions]: https://github.com/blog/1121-introducing-team-mentions
[custom-media-types]: /v3/media/
