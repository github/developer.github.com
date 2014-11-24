---
kind: change
title: API Abuse Rate Limit Responses
created_at: 2014-11-31
author_name: bhuga
---

GitHub.com handles a huge number of abusive posts every day, largely without
issue. No classifier is perfect, though, and we occasionally misidentify
legitimate content and prevent its creation. In the case of API requests triggering
abuse detection, we've decided to expose the rare case of a false positive so
that integrators receive an informative message and can predict how to respond.

Because some kinds of abuse prevention result in temporary bans, we are
re-using the same 403 Forbidden response that existing applications receive
when exceeding the normal [API Rate Limits]. Both situations require the
application to wait before continuing.

Please read the documentation on the new [Abuse Rate Limit Responses]. If you
have any feedback or questions, please don't hesistate to [contact] us.

[API Rate Limits]: /v3/#rate-limiting
[Abuse Rate Limit Responses]: /v3/#abuse-rate-limits
[contact]: https://github.com/contact?form[subject]=API+Abuse+Rate+Limits
