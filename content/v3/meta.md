---
title: GitHub Meta API | GitHub API
---

# GitHub Meta API

This gives some information about the GitHub server.

    GET /meta

### Response

<%= headers 200 %>
<%= json :meta %>

### Body

Name | Type | Description
-----|------|--------------
`hooks`|`array` of `strings` | An Array of IP addresses in CIDR format specifying the addresses that incoming service hooks will originate from on GitHub.com.  Subscribe to the [API Changes blog](http://developer.github.com/changes/) or follow [@GitHubAPI](https://twitter.com/GitHubAPI) on Twitter to get updated when this list changes.
`git`|`array` of `strings` | An Array of IP addresses in CIDR format specifying the Git servers for GitHub.com.
`verifiable_password_authentication`|`boolean` | Whether [Basic Authentication](v3/auth/#basic-authentication) is supported. Some [GitHub Enterprise](https://enterprise.github.com/) servers may return `false` here.

