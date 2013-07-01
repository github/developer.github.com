---
title: Feeds | GitHub API
---

# Feeds

* TOC
{:toc}

## List Feeds

GitHub provides several timeline resources in [Atom][] format. The Feeds API
lists all the feeds available to the authenticating user.

**Note**: Private feeds are only returned when [authenticating via Basic
Auth][authenticating] since current feed URIs use the older, non revokable auth
tokens.

    GET /feeds

### Response

<%= headers 200 %>
<%= json :feeds %>

[Atom]: http://en.wikipedia.org/wiki/Atom_(standard)
[authenticating]: /v3/#basic-authentication
