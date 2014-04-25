---
kind: change
title: "Changes to Gist API response for large files"
created_at: 2014-04-22
author_name: leongersing
---

In order to provide the most robust, fast and accurate API for Gist, we are making two changes to better handle large files in [Gist API responses][gist-json-representation].

### Truncating file contents larger than one megabyte

The [Gist API response][gist-json-representation] includes data for every file in the Gist. That works well for Gists with reasonably-sized files. When a Gist contains large files, however, it can lead to timeouts when preparing or sending the API response.

To eliminate those timeouts, the API now limits the amount of content returned for each file. If a file is larger than one megabyte in size, the API response will include the first megabyte of content for that file. (Few Gists have files this large. As a result, most API clients won't notice any impact from this change.)

When you need the full contents of the file, simply make a request to the URL specified in the `raw_url` attribute.

### "truncated" attribute

    {
      files: {
        "my_large_file.md": {
          "size": 2097152,
          "raw_url": "https://raw.githubusercontent.com/[...]/my_large_file.md",
          "type": "text/plain",
          "language": "Markdown",
          "content": "",
          "truncated": true
        }
      }
    }

In this small example payload, you'll notice the new **truncated** attribute has been added to each file's payload. It is a boolean attribute indicating if the content attribute's value has been truncated for this request.

If you have any questions, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Gist+API+now+tuncates+large+files
