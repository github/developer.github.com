---
kind: change
title: Status API Limits
created_at: 2014-10-29
author_name: rsanheim
---

To ensure a high level of service for all API consumers, we will soon limit the number of [statuses]
to 1000 per commit SHA, repository, and context.

Beginning Monday, November 3rd, we will trim existing data sets that exceed this limit, deleting the oldest 
records first.  Attempts to create statuses beyond that limit will result in a [validation error].

If you have any feedback or questions, please don't hesistate to [contact] us.

[statuses]: /v3/repos/statuses/
[validation error]: https://developer.github.com/v3/#client-errors
[contact]: https://github.com/contact?form[subject]=Combined+Status+API
