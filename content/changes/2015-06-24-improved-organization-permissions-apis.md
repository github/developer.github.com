---
kind: change
title: Improved organization permissions APIs
created_at: 2015-06-24
author_name: jakeboxer
---

We're introducing some API enhancements to supplement the [improved organization permissions][dotcom-blog-post] we've begun to roll out.

## API improvements

### Team permissions

In our improved permissions system, a team no longer has a single permission that applies to all of its repositories. Instead, each repository is added to a team with its own permission. For example, an organization could use a single team to grant pull access to one repository, push access to a second, and admin access to a third.

To support this, we've added a `permission` parameter to the [Add team repository][add-team-repo] API. You can use this parameter to specify a permission when adding a new repository to a team, or to update a team's permission on a repository that is already associated with the team.

We've also added a `permissions` attribute to the responses for the [List team repos][list-team-repos] and [Check if a team manages a repository][get-team-repo] APIs, so that you can tell what permissions a team grants on a given repository.

### Team privacy

We now allow you to modify the privacy level of your teams. A "secret" team can only be seen by organization owners and people who are members of that team (which is how all teams used to work), while a "closed" team can be seen by every member of the organization (which makes it easier to use @mentions throughout your organization).

To support this, we've added a `privacy` parameter to the [Create team][create-team] and [Edit team][edit-team] APIs, and a `privacy` attribute to the responses of all APIs that return team objects.

### Team maintainers

We've added the ability for you to to delegate team maintenance to non-owners, reducing the workload for your organization's owners. You can now promote a non-owner member a team to be a "maintainer" of that team. This gives them the ability to add and remove team members, and to change that team's title and description.

To support this new team maintainer concept, we've added a `role` parameter to the [Add team membership][add-team-membership] API, so that you can specify whether a given team member should be a maintainer or not. We've also added a `role` parameter to the [List team members][list-team-members] API, so that you can request to see only the maintainers (or regular members) of a team. Finally, we've added a `role` attribute to the responses for the [Get team membership][get-team-membership] and [Add team membership][add-team-membership] APIs, so that you can figure out whether a user is a maintainer or a regular member of a team.

### Filtering organization members by role

The organization [Members list][org-members-list] API now accepts a `role` parameter, so that you can request to see only the owners (or non-owners) of your organization.

### Repository collaborators

We now allow you to add collaborators to organization-owned repositories, just like we always have for user-owned repositories. This means the [Add user as a collaborator][add-collab] API now works for organization-owned repositories. We've even added a `permission` parameter to it (currently valid for organization-owned repositories only), so that you can specify what level of access the collaborator should have on the repository.

We've also added a `permissions` attribute to the responses for the [List collaborators][list-collabs] API, so that you can tell what permissions each collaborator has on your organization's repositories.

## Preview period

Starting **today**, these new APIs are available for developers to preview. At the end of the preview period, these additions will become official components of the GitHub API.

While these additions are in their preview period, you'll need to provide the following custom media type in the `Accept` header:

    application/vnd.github.ironman-preview+json

During the preview period, we may change aspects of these endpoints. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

If you have any questions or feedback, please [get in touch with us][contact]!

[dotcom-blog-post]: /this-should-404-until-we-ship-the-dotcom-blog-post
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
