---
title: Media Types | GitHub API
---
# Media Types

* TOC
{:toc}

Custom media types are used in the API to let consumers choose the format
of the data they wish to receive. This is done by adding one or more of
the following types to the `Accept` header when you make a request. Media types
are specific to resources, allowing them to change independently and support
formats that other resources don't.

All GitHub media types look like this:

    application/vnd.github[.version].param[+json]

The most basic media types the API supports are:

    application/json
    application/vnd.github+json

Neither of these specify a [version][versions], so you will always get the
current default JSON representation of resources.

<div class="alert" id="request-specific-version">
  <p>
    <strong>Important</strong>: The default version of the API may change in the
    future. If you're building an application and care about the stability of
    the API, be sure to request a specific version in the <code>Accept</code>
    header as shown in the examples below.
  </p>
</div>

You can specify a version like so:

    application/vnd.github.v3+json

If you're specifying a property (such as full/raw/etc defined below),
put the version before the property:

    application/vnd.github.v3.raw+json

You can check the current version through every response's headers.  Look
for the `X-GitHub-Media-Type` header:

    $ curl https://api.github.com/users/technoweenie -I
    HTTP/1.1 200 OK
    X-GitHub-Media-Type: github.v3

    $ curl https://api.github.com/users/technoweenie -I \
      -H "Accept: application/vnd.github.full+json"
    HTTP/1.1 200 OK
    X-GitHub-Media-Type: github.v3; param=full; format=json

    $ curl https://api.github.com/users/technoweenie -I \
      -H "Accept: application/vnd.github.v3.full+json"
    HTTP/1.1 200 OK
    X-GitHub-Media-Type: github.v3; param=full; format=json

## Comment Body Properties

The body of a comment can be written in [GitHub Flavored Markdown][gfm].
Issues, Issue Comments, Pull Request Comments, and Gist Comments all
accept these same media types:

### Raw

    application/vnd.github.VERSION.raw+json

Return the raw markdown body. Response will include `body`. This is the
default if you do not pass any specific media type.

### Text

    application/vnd.github.VERSION.text+json

Return a text only representation of the markdown body. Response will
include `body_text`.

### HTML

    application/vnd.github.VERSION.html+json

Return HTML rendered from the body's markdown. Response will include
`body_html`.

### Full

    application/vnd.github.VERSION.full+json

Return raw, text and HTML representations. Response will include `body`,
`body_text`, and `body_html`:

## Git Blob Properties

The following media types are allowed when getting a blob:

### JSON

    application/vnd.github.VERSION+json
    application/json

Return JSON representation of the blob with `content` as a base64
encoded string. This is the default if nothing is passed.

### Raw

    application/vnd.github.VERSION.raw

Return the raw blob data.

## Commits, Commit comparison, and Pull Requests

The Commit, Commit Comparison, and Pull Request resources support
[diff][git-diff] and [patch][git-patch] formats:

### diff

    application/vnd.github.VERSION.diff

### patch

    application/vnd.github.VERSION.patch


[gfm]:http://github.github.com/github-flavored-markdown/
[git-diff]: http://git-scm.com/docs/git-diff
[git-patch]: http://git-scm.com/docs/git-format-patch
[hypermedia]: /v3/#hypermedia
[versions]: /v3/versions
