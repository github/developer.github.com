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
- Use the [User Administration][] API to promote, demote, suspend, and unsuspend users

[Admin Stats]: admin_stats/
[License]: license/
[Search Indexing]: search_indexing/
[Management Console]: management_console/
[User Administration]: /v3/users/administration/

## Endpoint URLs

All API endpoints—except for [Management Console][] API endpoints!—are prefixed with the following URL:

<pre class="terminal">
http(s)://<em>hostname</em>/api/v3/
</pre>

Endpoints for the [Management Console][] API are only prefixed with a hostname:

<pre class="terminal">
http(s)://<em>hostname</em>/
</pre>

## Authentication

Your Enterprise installation's API endpoints accept [the same authentication methods](http://developer.github.com/v3/#authentication) as the GitHub.com API. Specifically, you can authenticate yourself with **[OAuth tokens][]** (which can be created using the [Authorizations API][]) or **[basic authentication][]**.

[OAuth tokens]: /v3/oauth/
[basic authentication]: /v3/#basic-authentication

The [Admin Stats][], [License][], [Search Indexing][], and [User Administration][] API endpoints are only accessible to GitHub Enterprise site administrators. The [Management Console][] API endpoints are only accessible with a valid license file.

[Authorizations API]: /v3/oauth_authorizations/#create-a-new-authorization
