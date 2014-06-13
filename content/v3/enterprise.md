---
title: Enterprise | GitHub API
---

# Enterprise

* TOC
{:toc}

GitHub Enterprise supports the same powerful API available on GitHub.com as well as its own set of API endpoints:

- Use the [Admin Stats][] API to get usage statistics
- Use the [License][] API to get license information
- Use the [Search Indexing][] API to queue up search indexing jobs
- Use the [Management Console][] API to perform common administrative tasks

[Admin Stats]: admin_stats/
[License]: license/
[Search Indexing]: search_indexing/
[Management Console]: management_console/

## Endpoint URLs

Every endpoint used by the GitHub API depends on your `hostname`, which is the name of your Enterprise installation.

Endpoints for the GitHub.com API and most of the Enterprise API start with the following URL:

<pre class="terminal">
http(s)://<em>hostname</em>/api/v3/
</pre>

Endpoints for the [Search Indexing][] API start with the following URL:

<pre class="terminal">
http(s)://<em>hostname</em>/api/v3/staff/
</pre>

Endpoints for the [Management Console][] API start with the following URL:

<pre class="terminal">
http(s)://<em>hostname</em>/setup/api/
</pre>

### Example

If your Enterprise host name is `ghe.local`, a call to [the Issues API](/v3/issues/) would be made to `https://ghe.local/api/v3/issues`.

## Authentication

Your Enterprise installation's API endpoints accept [the same authentication methods](http://developer.github.com/v3/#authentication) as the GitHub.com API. Specifically, you can authenticate yourself with **[OAuth tokens][]** (which can be created using the [Authorizations API][]) or **[basic authentication][]**.

[OAuth tokens]: /v3/oauth/
[basic authentication]: /v3/#basic-authentication

The [Admin Stats][], [License][], and [Search Indexing][] API endpoints are only accessible to GitHub Enterprise site admins. The [Management Console][] API endpoints are accessible to anyone with a valid license file.

[Authorizations API]: /v3/oauth_authorizations/#create-a-new-authorization
