---
kind: change
title: Status API Limits
created_at: 2014-10-24
author_name: rsanheim
---

To ensure a high level of service for all API consumers, we will soon limit the number of [statuses]
to 1000 per commit SHA, repository, and context.  Attempts to create statuses beyond that limit will result in a validation error.

Beginning Monday, November 3rd, we will begin trimming existing data sets that exceed this limit, deleting the oldest 
records first.  We have discovered that most of these cases are a result of errant scripts re-publishing the same data over and over again.

If you have any feedback or questions, please don't hesistate to [contact] us.

[statuses]: /v3/repos/statuses/
[contact]: https://github.com/contact?form[subject]=Combined+Status+API
