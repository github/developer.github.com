---
kind: change
title: "An integrator's guide to organization application policies"
created_at: 2015-01-19
author_name: pengwynn
---

As we [announced over on the GitHub blog][ann], organization admins can now
control how third-party applications access their organization data. Allowing
admins to approve or deny applications will ultimately result in deeper trust
and increase overall adoption of integrations within organizations on GitHub.

As an integrator, here's what you need to know about organization application
policies and how this feature could impact your application.

### Guiding principles

We've tried to strike the right balance between organization privacy and the
user experience for integrators and end users. Organizations should be able to
prevent applications they do not trust from accessing their organization data
without creating a multitude of new edge cases for integrators.

With that goal in mind, the feature works like this: **if an organization's
application policy prevents an application from accessing its resources, the
API behaves as if the authenticating user is not a member of the
organization**. Specifically, this means an application authenticating on
behalf of a user using OAuth will have:

- **Read-only access to public resources.** Organization-owned public
    repositories, issues, and other resources will be visible via the API and
    show up in resource listings, but mutating methods (`POST`, `PATCH`, `PUT`,
    and `DELETE`) will return status `403`.
- **No access to private resources.** Organization-owned private repositories,
    issues, and other resources will not be visible via the API and will not
    show up in resource [listings][] that co-mingle public and private
    resources. Hooks for these private repositories are muted and will not be
    delivered as long as the application is restricted by the organization.

Since applications should already handle the scenario where a user loses access
to organization resources, this reduces the work integrators need to do.

### Checking organization access

As organization admins adopt application whitelists and restrict third-party
application access to organization resources, your application may lose access
to those resources. If an organization member is not aware of the new access
policy, they may wonder why their private repositories or other resources no
longer work or show up in your application.

There are a couple ways to help troubleshoot access for your end users.

- **Via the GitHub UI.** The simplest way to help end users understand how
    organization access policies affect their access to your application is to
    provide a link to [their authorization details][help-request-approval]
    under their GitHub account settings as [described in the OAuth
    documentation][auth-link].

- **Via the API.** For an even better user experience, [use the
    API][discovering-guide] to list which user organizations your application
    can access, and provide users with the link mentioned above to request
    access from their organization admins.

### Listing accessible organization resources

In addition to checking access to a user's organizations, you'll want to ensure
you're discovering their accessible resources in the most efficient way. Recent
changes to the [Repositories API][listing-repos] might reduce the API calls
your application needs to make to find a user's repositories across all of
their organization memberships.

### Ensuring uninterrupted SSH access

Since applications should already handle the scenario where a user loses access
to organization resources (e.g., when a user leaves an organization), this
reduces the work integrators need to do. Keys created by OAuth applications (or
those created before GitHub started tracking that information) will not have
access to repositories owned by organizations that restrict third-party
applications. If your application uses keys **created before February 24,
2014**, you [should replace those older keys][keys] to ensure things keep
running smoothly for your application.

### We're here to help

This is a big feature, and we're sure it will impact many of our integrators as
organizations adopt third-party application restrictions. We also think it
provides a huge net benefit for integrators as organizations choose to use
OAuth integrations with more confidence.

If you have any questions or feedback, please [get in touch][contact].

[ann]: https://github.com/blog/1941-organization-approved-applications
[auth-link]: /v3/oauth/#directing-users-to-review-their-access-for-an-application
[help-request-approval]: https://help.github.com/articles/requesting-organization-approval-for-your-authorized-applications/
[list-orgs]: /v3/orgs/#list-your-organizations
[contact]: https://github.com/contact?form[subject]=Organization+Access+Policies+help+for+integrators
[listing-repos]: /v3/repos/#list-your-repositories
[discovering-guide]: /guides/discovering-resources-for-a-user/
[keys]: /changes/2014-12-12-replace-older-ssh-keys-created-by-your-application/
[listings]: /v3/issues/#list-issues
