---
kind: change
title: Gist comment URIs
created_at: 2012-10-30
author_name: pezra
---

The URIs of all gist comments are changing immediately. The new URI pattern for gist comments is `/gists/{gist-id}/comments/{id}`. (See [gist comments section of the docs](/v3/gists/comments/) for more details.) This change is necessary because the auto-incremented id of gist comments is easy to guess. This predictability allows anyone to view comments on private Gists with relative ease. Obviously, comments on private gists should be just as private as the gist itself.

Adding the id of the gist id to the URI makes it impossible, in practical terms, because that id is a very large random number. This is, unfortunately, a breaking change but one that cannot be avoided because of the security implications of the current URIs. We apologize for the inconvenience.
