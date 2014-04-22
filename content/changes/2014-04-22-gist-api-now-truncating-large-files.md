---
kind: change
title: "Gist API now truncates large files"
created_at: 2014-04-22
author_name: leongersing
---

In order to provide the most robust, fast and accurate API for Gist we recently decided to make a few small changes to the *files* payload.

### Truncating file contents > 1MB
Sometimes we need to put some large data into a gist. However, we don't always need to see the full content of that large gist when we're fetching the metadata for gists via the API. This change imposes a sensible (according to our data) limit on the amount of raw file data that is returned in gist fetches via the API. If you're relying on reading the full content of individual files from a gist then you may need to update your flow to perform a followup request for the ```raw_url``` resource in order to download the entire contents of the file. Which begs the question: *How do I know if the file's contents have been truncated?*

### New files.truncated property
On the packets that have been truncated you will notice a new key in the files segment of the payload.

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

In this small example payload, you'll notice the new *truncated* key has been added and the *content* key's value is empty. This would be a case for making a follow up request to the raw_url, if you are looking to get all of the data that would have normally showed up in the content field.

> Please note that in some cases you may have data in the content field but it has also been truncated. In this case, simply make a follow up request to the raw_url in order recieve the full contents of the file"

If you have any questions, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Gist+API+now+tuncates+large+files
