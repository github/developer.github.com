---
kind: change
title: "Changes to Gist API response for large files"
created_at: 2014-04-22
author_name: leongersing
---

In order to provide the most robust, fast and accurate API for Gist, we are making two changes to better handle large files in Gist API responses.

### Truncating file contents larger than 1MB
This change imposes a sensible (according to our data) limit on the amount of raw file data that is returned in gist fetches via the API. This means faster response times while eliminating browser timeouts when fetching gists that contains large files. When you need the full contents of your gist's file, simply make a request to the url specified in the raw_url attribute.

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
