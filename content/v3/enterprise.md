---
title: Enterprise | GitHub API
---

# Enterprise <%= fetch_content(:latest_enterprise_version) %>

* TOC
{:toc}

[GitHub Enterprise](https://enterprise.github.com/) supports the same powerful API available on GitHub.com as well as its own set of API endpoints. You can find a list of these endpoints on the sidebar, with the exception of the [User Administration][] API, which is within its own section.

## Endpoint URLs

All API endpoints—except [Management Console][] API endpoints—are prefixed with the following URL:

<pre class="terminal">
http(s)://<em>hostname</em>/api/v3/
</pre>

[Management Console][] API endpoints are only prefixed with a hostname:

<pre class="terminal">
http(s)://<em>hostname</em>/
</pre>

## Authentication

Your Enterprise installation's API endpoints accept [the same authentication methods](http://developer.github.com/v3/#authentication) as the GitHub.com API. Specifically, you can authenticate yourself with **[OAuth tokens][]** (which can be created using the [Authorizations API][]) or **[basic authentication][]**.

Every Enterprise API endpoint is only accessible to GitHub Enterprise site administrators, with the exception of the [Management Console][] API, which is only accessible via the [Management Console password][].

[Authorizations API]: /v3/oauth_authorizations/#create-a-new-authorization
[OAuth tokens]: /v3/oauth/
[basic authentication]: /v3/#basic-authentication
[Management Console]: /v3/enterprise/management_console/
[User Administration]: /v3/users/administration/
[Management Console password]: https://help.github.com/enterprise/2.0/admin/articles/accessing-the-management-console/

## Past Releases

The latest release for GitHub Enterprise is <%= fetch_content(:latest_enterprise_version) %>. The GitHub APIs available to this release are located at <https://developer.github.com/enterprise/<%= fetch_content(:latest_enterprise_version) %>/>.

Documentation for the API that's bundled with your GitHub Enterprise appliance is available for past releases:

* [API documentation for 2.3](https://developer.github.com/enterprise/2.3/)
* [API documentation for 2.2](https://developer.github.com/enterprise/2.2/)
* [API documentation for 2.1](https://developer.github.com/enterprise/2.1/)
* [API documentation for 2.0](https://developer.github.com/enterprise/2.0/)
* [API documentation for 11.10.340](https://developer.github.com/enterprise/11.10.340/)
