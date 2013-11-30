---
title: Meta | GitHub API
---

# Meta

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
`verifiable_password_authentication`|`boolean` | Whether [Basic Authentication with a username and password](/v3/auth/#via-username-and-password) is supported. Some [GitHub Enterprise](https://enterprise.github.com/) servers may return `false` here.
