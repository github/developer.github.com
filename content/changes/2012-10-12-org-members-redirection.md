---
kind: change
title: Organization Members Resource Changes
created_at: 2012-10-12
author_name: pezra
---

Requesting the [member list](/v3/orgs/members/index.html#members-list) of an organization of which you are not a member now redirects to the [public members list](v3/orgs/members/index.html#public-members-list). Requests to [membership check](/v3/orgs/members/index.html#check-membership) resources of an organization of which you are not a member are similarly redirected to the equivalent [public membership check](/v3/orgs/members/index.html#check-public-membership) unless it is a check about yourself, in which case it is treated as a request by a member.

The changes where made to clarify the purpose of these various resources. The `/orgs/{org}/members` resources are intended for use by members of the organization in question. The `/orgs/{org}/public_members` resources are intended for acquiring information about organizations of which you are not a member.
