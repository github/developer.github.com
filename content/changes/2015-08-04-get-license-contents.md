---
kind: change
title: Get the contents of a repository’s license
created_at: 2015-08-04
author_name: benbalter
---

The [License API Preview](/v3/licenses/) now allows you to retrieve the contents of a repository's open source license. As before, when the appropriate preview media type is passed, the repository endpoint will return information about the detected license, if any:

{:.terminal}
    curl -H "Accept: application/vnd.github.drax-preview+json" https://api.github.com/repos/benbalter/gman

You can now also get the contents of the repository's license file, whether or not the license was successfully identified via the license contents endpoint:

{:.terminal}
    curl -H "Accept: application/vnd.github.drax-preview+json" https://api.github.com/repos/benbalter/gman/license

Similar to [the repository contents API](/v3/repos/contents/#get-contents), the license contents method also supports [custom media types](/v3/repos/contents/#custom-media-types) for retrieving the raw license content or rendered license HTML.

{:.terminal}
    curl -H "Accept: application/vnd.github.drax-preview.raw" https://api.github.com/repos/benbalter/gman/license

For more information, see [the license API documentation](/v3/licenses/#get-the-contents-of-a-repositorys-license), and as always, if you have any questions or feedback, please [get in touch with us](https://github.com/contact?form%5Bsubject%5D=License+API).
