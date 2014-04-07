---
title: Feeds | GitHub API
---

# Feeds

* TOC
{:toc}

## List Feeds

GitHub provides several timeline resources in [Atom][] format. The Feeds API
lists all the feeds available to the authenticating user:

* **Timeline**: The GitHub global public timeline
* **User**: The public timeline for any user, using [URI template][]
* **Current user public**: The public timeline for the authenticated user
* **Current user**: The private timeline for the authenticated user
* **Current user actor**: The private timeline for activity created by the authenticated user
* **Current user organization**: The private timeline for the authenticated user for a given organization, using [URI template][]

**Note**: Private feeds are only returned when [authenticating via Basic
Auth][authenticating] since current feed URIs use the older, non revokable auth
tokens.

    GET /feeds

### Response

<%= headers 200 %>
<%= json :feeds %>

[Atom]: http://en.wikipedia.org/wiki/Atom_(standard)
[authenticating]: /v3/#basic-authentication
[URI template]: https://developer.github.com/v3/#hypermedia
