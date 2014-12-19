---
title: Discovering resources for the authenticated user | GitHub API
---

# Discovering resources for the authenticated user

* TOC
{:toc}

When making authenticated requests to the GitHub API, applications often need to fetch the current user's repositories and organizations. In this guide, will explain how to reliably discover those resources.

## Discover the repositories that your app can access for a user

In addition to having their own personal repositories, a user may be a collaborator on repositories owned by other users and organizations. Collectively, these are the repositories where the user has *privileged* access (i.e., private repositories where the user has read or write access, and public repositories where the user has write access).

[OAuth scopes](/v3/oauth/#scopes) and [organization application policies](#todo) determine which of those repositories your app can access for a user. Use the workflow below to discover those repositories.

### Find the URL

TODO Describe the process of hitting the root endpoint and fetching the `current_user_repositories_url`.

### Fetch the repositories

TODO GET /user/repos

## Discover the organizations that your app can access for a user

Applications can perform all sorts of organization-related tasks for a user. To perform these tasks, the app needs an [OAuth authorization](/v3/oauth/#scopes) with sufficient permission (e.g., you can [list teams](/v3/orgs/teams/#list-teams) with `read:org` scope, you can [publicize the user’s organization membership](/v3/orgs/members/#publicize-a-users-membership) with `user` scope, etc.). Once a user has granted one or more of these scopes to your app, you're ready to fetch the user’s organizations.

### Find the URL

TODO Describe the process of hitting the root endpoint and fetching the `user_organizations_url`.
TODO For consistency, `user_organizations_url` should really be `current_user_organizations_url`.

### Fetch the organizations

TODO GET /user/orgs

### Don’t rely on public organizations

If you've read the docs from cover to cover, you may have noticed an [API method for listing a user's public organization memberships](/v3/orgs/#list-user-organizations). Most applications should avoid this API method. This method only returns the user's public organization memberships, not their private organization memberships. 

As an application, you typically want all of the user's organizations (public and private) that your app is authorized to access. The workflow above will give you exactly that.
