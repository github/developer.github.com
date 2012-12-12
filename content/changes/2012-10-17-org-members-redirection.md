---
kind: change
title: Organization Members Resource Changes
created_at: 2012-10-17
author_name: pezra
---

Requesting the [member list](/v3/orgs/members/index.html#members-list) of an
organization of which you are not a member now redirects to the [public members
list](v3/orgs/members/index.html#public-members-list). Similarly, requests to
[membership check](/v3/orgs/members/index.html#check-membership) resources of
an organization of which you are not a member are redirected to the equivalent
[public membership check](/v3/orgs/members/index.html#check-public-membership).
One exception to the latter case is that if you are checking about your own
membership the request is not redirected. You are always allowed to know what
organizations you belong to.

The changes where made to clarify the purpose of these various resources. The
`/orgs/:org/members` resources are intended for use by members of the
organization in question. The `/orgs/:org/public_members` resources are for
acquiring information about the public membership of organizations. If you are
not a member you are not allowed to see private membership information so you
should be using the public membership resources.

If you have any questions or feedback, please drop us a line at
[support@github.com](mailto:support@github.com?subject=Org members API).
