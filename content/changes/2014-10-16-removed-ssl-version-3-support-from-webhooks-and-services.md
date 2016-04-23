---
kind: change
title: Removed SSLv3 support from webhooks and services
created_at: 2014-10-16
author_name: kdaigle
---

This morning, we [removed support][github-services-pr] for the `ssl_version` webhook configuration
option and made `TLS 1.X` the default cryptographic protocol to address the [POODLE exploit][poodle].
You should no longer set or rely on the `ssl_version` configuration option.

If you have any questions or feedback, please [drop us a line][contact].

[github-services-pr]: https://github.com/github/github-services/pull/949
[poodle]: https://www.openssl.org/~bodo/ssl-poodle.pdf
[contact]: https://github.com/contact?form[subject]=Removed+SSLv3+support+from+webhooks+and+services
