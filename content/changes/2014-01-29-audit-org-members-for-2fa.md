---
kind: change
title: Audit organization members for two-factor authentication
created_at: 2014-01-29
author_name: pengwynn
---

We've added a [new filter][filter] for listing members of an organization without
[two-factor authentication][2fa-blog] enabled:


<pre class="terminal">
$ curl -H "Authorization: token [yours]" \
       https://api.github.com/orgs/[orgname]/members\?filter\=2fa_disabled
</pre>

The new filter is available for owners of organizations with private
repositories. Happy auditing and [send us your feedback or questions][contact].

[filter]: /v3/orgs/members/#audit-two-factor-auth
[2fa-blog]: https://github.com/blog/1614-two-factor-authentication
[contact]: https://github.com/contact?form[subject]=API+2FA+filter

