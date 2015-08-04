---
kind: change
title: Get the contents of a repository’s license
created_at: 2015-08-04
author_name: benbalter
---

The [License API](/v3/licenses/) now allows you to retrieve the contents of a repository's open source license. When the appropriate preview media type is passed, the repository endpoint will return information about the detected license, if any:

    GET /repos/:owner/:repo

You can also get the content's of the repository's license file, whether or not the license was successfully identified via the license contents endpoint:

    GET /repos/:owner/:repo/license

Similar to [the repository contents API](/v3/repos/contents/#get-contents), the license contents method also supports [custom media types](/v3/repos/contents/#custom-media-types) for retrieving the raw license content or rendered license HTML.

For more information, see [the license API documentation](/v3/licenses/#get-the-contents-of-a-repositorys-license).
