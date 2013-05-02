---
title: GitHub Meta API | GitHub API
---

# GitHub Meta API

This gives some information about GitHub.com, the service.

    GET /meta

### Response

<%= headers 200 %>
<%= json :meta %>

### Body

hooks
: An Array of IP addresses in CIDR format specifying the addresses that incoming
service hooks will originate from.  Subscribe to the [API Changes blog](http://developer.github.com/changes/)
or follow [@GitHubAPI](https://twitter.com/GitHubAPI) on Twitter to get
updated when this list changes.

git
: An Array of IP addresses in CIDR format specifying the Git servers at GitHub.
