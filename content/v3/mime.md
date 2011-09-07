---
title: Custom Mime Types | developer.github.com
---

# Custom Mime Types

Custom mime types are used in the API to let consumers choose the format
of the data they wish to receive. This is done by adding one or more of
the following types to the `Accept` header when you make a request. Mime
types are specific to resources, allowing them to change independently
and support formats that other resources don't.

## Issue

The body of an issue can be written in [GitHub Flavored Markdown][gfm].
These mime types are allowed:

### Raw

    application/vnd.github-issue.raw+json

Return the raw markdown body. Response will include `body`. This is the
default if you do not pass any specific mime type.

### Text

    application/vnd.github-issue.text+json

Return a text only representation of the markdown body. Response will
include `body_text`.

### Html

    application/vnd.github-issue.html+json

Return html rendered from the body's markdown. Response will include
`body_html`.

### Full

    application/vnd.github-issue.full+json

Return raw, text and html representations. Response will include `body`,
`body_text`, and `body_html`:

## Issue Comment

The body of an issue comment can also be written in [GitHub Flavored
Markdown][gfm]. The semantics are identical to the Issue resource
described above. These mime types are allowed:

    application/vnd.github-issuecomment.raw+json
    application/vnd.github-issuecomment.text+json
    application/vnd.github-issuecomment.html+json
    application/vnd.github-issuecomment.full+json

## Commit Comment

The body of an commit comment can also be written in [GitHub Flavored
Markdown][gfm]. The semantics are identical to the Issue resource
described above. These mime types are allowed:

    application/vnd.github-commitcomment.raw+json
    application/vnd.github-commitcomment.text+json
    application/vnd.github-commitcomment.html+json
    application/vnd.github-commitcomment.full+json

## Pull Request

The body of an pull request can also be written in [GitHub Flavored
Markdown][gfm]. The semantics are identical to the Issue resource
described above. These mime types are allowed:

    application/vnd.github-pull.raw+json
    application/vnd.github-pull.text+json
    application/vnd.github-pull.html+json
    application/vnd.github-pull.full+json

## Pull Request Comment

The body of an pull request comment can also be written in [GitHub
Flavored Markdown][gfm]. The semantics are identical to the Issue
resource described above. These mime types are allowed:

    application/vnd.github-pullcomment.raw+json
    application/vnd.github-pullcomment.text+json
    application/vnd.github-pullcomment.html+json
    application/vnd.github-pullcomment.full+json

## Gist Comment

The body of an gist comment can also be written in [GitHub
Flavored Markdown][gfm]. The semantics are identical to the Issue
resource described above. These mime types are allowed:

    application/vnd.github-gistcomment.raw+json
    application/vnd.github-gistcomment.text+json
    application/vnd.github-gistcomment.html+json
    application/vnd.github-gistcomment.full+json

## Git Blob

The following mime types are allowed when getting a blob:

### JSON

    application/json

Return JSON representation of the blob with `content` as a base64
encoded string. This is the default if nothing is passed.

### Raw

    application/vnd.github-blob.raw

Return the raw blob data.

[gfm]:http://github.github.com/github-flavored-markdown/
