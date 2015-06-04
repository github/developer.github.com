---
kind: change
title: "Changes to Gist API response for large files"
created_at: 2014-05-06
author_name: leongersing
---

In order to provide a faster, more robust API for Gist, we are making two changes to better handle large files in [Gist API responses][gist-json-representation].

### Truncating file contents larger than one megabyte

The [Gist API response][gist-json-representation] includes data for every file in the Gist. That works well for Gists with reasonably-sized files. When a Gist contains large files, however, it can lead to timeouts when preparing or sending the API response.

To eliminate those timeouts, the API now limits the amount of content returned for each file. If a file is larger than one megabyte in size, the API response will include the first megabyte of content for that file. (Few Gists have files this large. As a result, most API clients won't notice any impact from this change.)

### New "truncated" attribute

The JSON snippet below illustrates the attributes provided for each file in the Gist API response. In it, you'll notice a new `truncated` attribute included as part of the file metadata. This Boolean attribute indicates whether the `content` value is truncated for this request.

    {
      files: {
        "my_large_file.md": {
          "size": 2097152,
          "content": "Large content. Truncated at end of first megabyte. [...]",
          "truncated": true,
          "raw_url": "https://raw.githubusercontent.com/[...]/my_large_file.md",
          "type": "text/plain",
          "language": "Markdown"
        }
      }
    }

### Getting the full content for truncated files

We recognize that sometimes you'll still want the full content for a file, even if it's too large to get returned in the standard Gist API response. For files under 10 megabytes, simply make a request to the URL specified in the `raw_url` attribute, and you'll receive the complete content for that file. For larger files, you'll need to clone the gist locally via the ```git_pull_url``` to access the full file contents.

If you have any questions, don’t hesitate to [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Gist+API+now+truncates+large+files
[gist-json-representation]: /v3/gists/#detailed-gist-representation
