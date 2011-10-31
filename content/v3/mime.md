---
title: Custom Mime Types | GitHub API
---

# GitHub Mime Types

Custom mime types are used in the API to let consumers choose the format
of the data they wish to receive. This is done by adding one or more of
the following types to the `Accept` header when you make a request. Mime
types are specific to resources, allowing them to change independently
and support formats that other resources don't.

All GitHub mime types look like this:

    application/vnd.github[.version].param[+json]

The most basic mime types the API supports are:

    application/json
    application/vnd.github+json

Neither of these specify a version, so you will always get the latest
JSON representation of resources.  If you're building an application and
care about the stability of the API, specify a version like so:

    application/vnd.github.beta+json

If you're specifying a property (such as full/raw/etc defined below),
put the version before the property:

    application/vnd.github.beta.raw+json

For specifics on versions, check the [API changelog](/v3/changelog).

## Comment Body Properties

The body of a comments can be written in [GitHub Flavored Markdown][gfm].
Issues, Issue Comments, Pull Request Comments, and Gist Comments all
accept these same mime types:

### Raw

    application/vnd.github.VERSION.raw+json

Return the raw markdown body. Response will include `body`. This is the
default if you do not pass any specific mime type.

### Text

    application/vnd.github.VERSION.text+json

Return a text only representation of the markdown body. Response will
include `body_text`.

### Html

    application/vnd.github.VERSION.html+json

Return html rendered from the body's markdown. Response will include
`body_html`.

### Full

    application/vnd.github.VERSION.full+json

Return raw, text and html representations. Response will include `body`,
`body_text`, and `body_html`:

## Git Blob Properties

The following mime types are allowed when getting a blob:

### JSON

    application/vnd.github.VERSION+json
    application/json

Return JSON representation of the blob with `content` as a base64
encoded string. This is the default if nothing is passed.

### Raw

    application/vnd.github.VERSION.raw

Return the raw blob data.

[gfm]:http://github.github.com/github-flavored-markdown/
