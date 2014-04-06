---
title: Meta | GitHub API
---

# Meta

This endpoint provides information about GitHub.com, the service.
Or, if you access this endpoint on your organization's [GitHub Enterprise](https://enterprise.github.com/) installation, this endpoint provides information about that installation.

    GET /meta

### Response

<%= headers 200 %>
<%= json :meta %>

### Body

Name | Type | Description
-----|------|--------------
`hooks`|`array` of `strings` | An Array of IP addresses in CIDR format specifying the addresses that incoming service hooks will originate from on GitHub.com.  Subscribe to the [API Changes blog](https://developer.github.com/changes/) or follow [@GitHubAPI](https://twitter.com/GitHubAPI) on Twitter to get updated when this list changes.
`git`|`array` of `strings` | An Array of IP addresses in CIDR format specifying the Git servers for GitHub.com.
`verifiable_password_authentication`|`boolean` | Whether authentication with username and password is supported. (GitHub Enterprise instances using CAS or OAuth for authentication will return `false`. Features like [Basic Authentication with a username and password](/v3/auth/#via-username-and-password), [sudo mode](https://help.github.com/articles/sudo-mode), and [two-factor authentication](https://help.github.com/articles/about-two-factor-authentication) are not supported on these servers.)
