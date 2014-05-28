---
title: Enterprise | GitHub API
---

# Enterprise

* TOC
{:toc}

GitHub Enterprise supports the same powerful API available on GitHub.com with no additional configuration required. In addition, the Enterprise installation has its own set of API endpoints.

## Accessing the API

To access the API, just send requests to the following URL:

The Admin Stats API is available to pull a variety of metrics about your installation. Any admin user can access the API. Normal users will receive a 404 response if they try to access it. To access the API, hit the following endpoint:

    http(s)://<hostname>/api/v3/

## Authentication

The GitHub Enterprise API is an extension of the main GitHub.com API, so you can [use the same authentication methods](http://developer.github.com/v3/#authentication) for it. The main difference between them is that the Enterprise API is only accessible to Admin users on a GitHub Enterprise installation.

You can use **OAuth tokens** (which can be created using the [Authorizations API][]) or **basic auth** for authenticating your user.

### Usage Examples

Below, you'll find some example Ruby scripts that demonstrate using the API on an Enterprise installation.

### Creating a Gist

<script src="https://gist.github.com/2581996.js?file=gist-api-example.rb">
</script>
<noscript>[View gist](https://gist.github.com/watsonian/2581996)</noscript>

##### Getting User Information

<script src="https://gist.github.com/2582006.js?file=user-api-example.rb">
</script>
<noscript>[View gist](https://gist.github.com/watsonian/2582006)</noscript>

[Authorizations API]: /v3/oauth_authorizations/#create-a-new-authorization
