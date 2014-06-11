---
title: Enterprise | GitHub API
---

# Enterprise

* TOC
{:toc}

GitHub Enterprise supports the same powerful API available on GitHub.com as well as its own set of API endpoints:

- [Admin Stats][]
- [License][]
- [Search Indexing][]
- [Management Console][]

[Admin Stats]: admin_stats/
[License]: license/
[Search Indexing]: search_indexing/
[Management Console]: management_console/

## Endpoint URLs

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

Replace `hostname` with the name of your Enterprise installation. Note that this is `api.github.com` for GitHub.com.

## Authentication

Your Enterprise installation's API endpoints accept [the same authentication methods](http://developer.github.com/v3/#authentication) as the GitHub.com API. Specifically, you can authenticate yourself with **[OAuth tokens][]** (which can be created using the [Authorizations API][]) or **[basic authentication][]**.

[OAuth tokens]: /v3/oauth/
[basic authentication]: /v3/#basic-authentication

Enterprise-specific API endpoints ([Admin Stats][], [License][], [Search Indexing][], and [Management Console][]) are only accessible to GitHub Enterprise site admins.

[Authorizations API]: /v3/oauth_authorizations/#create-a-new-authorization
