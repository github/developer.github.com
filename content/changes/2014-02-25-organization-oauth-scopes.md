---
kind: change
title: OAuth scopes for organization and team resources
created_at: 2014-02-25
author_name: pengwynn
---
As a follow up to [the new scopes][yesterday] we announced yesterday, we've
introduced even more OAuth scopes for working with organization and team
resources:

- `read:org` provides read-only access to organizations, teams, and membership.
- `write:org` allows an application to publicize and unpublicize an organization membership.
- `admin:org` enables an application to fully manage organizations, teams, and memberships.

Check out [the full list of OAuth scopes][scopes] supported by the API to
ensure your application asks for only the permissions it needs. As always, if
you have any questions or feedback, [get in touch][contact].

[yesterday]: http://developer.github.com/changes/2014-02-24-finer-grained-scopes-for-ssh-keys/
[scopes]: /v3/oauth/#scopes
[contact]: https://github.com/contact?form[subject]=API+org+scopes
