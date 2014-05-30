---
title: Enterprise | GitHub API
---

# Enterprise

* TOC
{:toc}

GitHub Enterprise supports the same powerful API available on GitHub.com with no additional configuration required. In addition, the Enterprise installation has its own set of API endpoints, which are documented in this section.

## Accessing the API

To access both the GitHub.com and Enterprise API endpoints, requests are sent to the following URL:

<pre class="terminal">
http(s)://<em>hostname</em>/api/v3/
</pre>

`hostname` is the name of your Enterprise installation. Note that this differs from the GitHub.com API endpoint of `api.github.com`.

## Authentication

The API endpoints available on your Enterprise installation is an extension of the main GitHub.com API, so you can [use the same authentication methods](http://developer.github.com/v3/#authentication) for it. For example, you can use **OAuth tokens** (which can be created using the [Authorizations API][]) or **basic auth** for authenticating your user.

Enterprise API endpoints are only accessible to Admin users on a GitHub Enterprise installation.

[Authorizations API]: /v3/oauth_authorizations/#create-a-new-authorization
