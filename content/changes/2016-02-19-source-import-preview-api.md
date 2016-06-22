---
title: Preview the Source Import API
author_name: spraints
---

We've added an API for source imports, which will let you start an import from a Git, Subversion, Mercurial, or Team Foundation Server source repository. This is the same functionality as [the GitHub Importer](https://help.github.com/articles/importing-from-other-version-control-systems-to-github/).

To access [the Source Import API][docs] during the preview period, you must provide a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.barred-rock-preview

During the preview period, we may change aspects of these API methods based on developer feedback. If we do, we will announce the changes here on the developer blog, but we will not provide any advance notice.

If you have any questions or feedback, please [let us know][contact]!

[media-type]: /v3/media
[docs]: /v3/migration/source_imports/
[contact]: https://github.com/contact?form%5Bsubject%5D=Source+Import+API
