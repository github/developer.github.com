---
title: Pull Requests | GitHub API
---

# Pull Requests

* TOC
{:toc}

The Pull Request API allows you to list, view, edit, create, and even merge
pull requests. Comments on pull requests can be managed via the [Issue
Comments API](/v3/issues/comments/).

Pull Requests use [these custom media types](#custom-media-types). You
can read more about the use of media types in the API
[here](/v3/media/).

## Link Relations

Pull Requests have these possible link relations:

Name | Description
-----|-----------|
`self`| The API location of this Pull Request.
`html`| The HTML location of this Pull Request.
`issue`| The API location of this Pull Request's [Issue](/v3/issues/).
`comments`| The API location of this Pull Request's [Issue comments](/v3/issues/comments/).
`review_comments`| The API location of this Pull Request's [Review comments](/v3/pulls/comments/).
`review_comment`| The [URL template](/v3/#hypermedia) to construct the API location for a [Review comment](/v3/pulls/comments/) in this Pull Request's repository.
`commits`|The API location of this Pull Request's [commits](#list-commits-on-a-pull-request).
`statuses`| The API location of this Pull Request's [commit statuses](/v3/repos/statuses/), which are the statuses of its `head` branch.

## List pull requests

    GET /repos/:owner/:repo/pulls

### Parameters

Name | Type | Description
-----|------|--------------
`state`|`string` | Either `open`, `closed`, or `all` to filter by state. Default: `open`
`head`|`string` | Filter pulls by head user and branch name in the format of `user:ref-name`. Example: `github:new-script-format`.
`base`|`string` | Filter pulls by base branch name. Example: `gh-pages`.
`sort`|`string`|  What to sort results by. Can be either `created`, `updated`, `popularity` (comment count) or `long-running` (age, filtering by pulls updated in the last month). Default: `created`
`direction`|`string`| The direction of the sort. Can be either `asc` or `desc`. Default: `desc` when sort is `created` or sort is not specified, otherwise `asc`.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:pull) { |h| [h] } %>

## Get a single pull request

    GET /repos/:owner/:repo/pulls/:number

### Response

{{#tip}}

Each time the pull request receives new commits, GitHub creates a merge commit
to _test_ whether the pull request can be automatically merged into the base
branch. (This _test_ commit is not added to the base branch or the head branch.)
The `merge_commit_sha` attribute holds the SHA of the _test_ merge commit;
however, this attribute is [deprecated](/v3/versions/#v3-deprecations) and is scheduled for
removal in the next version of the API. The Boolean `mergeable` attribute will
remain to indicate whether the pull request can be automatically merged.

The value of the `mergeable` attribute can be `true`, `false`, or `null`. If
the value is `null`, this means that the mergeability hasn't been computed yet,
and a background job was started to compute it. Give the job a few moments to
complete, and then submit the request again. When the job is complete, the
response will include a non-`null` value for the `mergeable` attribute.

{{/tip}}

Pass the appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats.

<%= headers 200 %>
<%= json :full_pull %>

## Create a pull request

    POST /repos/:owner/:repo/pulls

### Input

Name | Type | Description
-----|------|-------------
`title`|`string` | **Required**. The title of the pull request.
`head`|`string` | **Required**. The name of the branch where your changes are implemented. For cross-repository pull requests in the same network, namespace `head` with a user like this: `username:branch`.
`base`|`string` | **Required**. The name of the branch you want your changes pulled into. This should be an existing branch on the current repository. You cannot submit a pull request to one repository that requests a merge to a base of another repository.
`body`|`string` | The contents of the pull request.


#### Example

<%= json \
  :title     => "Amazing new feature",
  :body      => "Please pull this in!",
  :head      => "octocat:new-feature",
  :base      => "master"
%>

### Alternative Input

You can also create a Pull Request from an existing Issue by passing an
Issue number instead of `title` and `body`.

Name | Type | Description
-----|------|--------------
`issue`|`integer` | **Required**. The issue number in this repository to turn into a Pull Request.

#### Example

<%= json \
  :issue => "5",
  :head  => "octocat:new-feature",
  :base  => "master"
%>

### Response

<%= headers 201, :Location => get_resource(:pull)['url'] %>
<%= json :pull %>

## Update a pull request

    PATCH /repos/:owner/:repo/pulls/:number

### Input

Name | Type | Description
-----|------|--------------
`title`|`string` | The title of the pull request.
`body`|`string` | The contents of the pull request.
`state`|`string` | State of this Pull Request. Either `open` or `closed`.

#### Example

<%= json \
  :title     => "new title",
  :body      => "updated body",
  :state     => "open"
%>

### Response

<%= headers 200 %>
<%= json :pull %>

## List commits on a pull request

    GET /repos/:owner/:repo/pulls/:number/commits

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:commit) { |h| [h] } %>

Note: The response includes a maximum of 250 commits. If you are working with a pull request larger than that, you can use the [Commit List API](/v3/repos/commits/#list-commits-on-a-repository) to enumerate all commits in the pull request.

## List pull requests files

    GET /repos/:owner/:repo/pulls/:number/files

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:file) { |h| [h] } %>

## Get if a pull request has been merged

    GET /repos/:owner/:repo/pulls/:number/merge

### Response if pull request has been merged

<%= headers 204 %>

### Response if pull request has not been merged

<%= headers 404 %>

## Merge a pull request (Merge Button)

    PUT /repos/:owner/:repo/pulls/:number/merge

### Input

Name | Type | Description
-----|------|-------------
`commit_message`|`string`| The message that will be used for the merge commit
`sha`|`string`| SHA that pull request head must match to allow merge


### Response if merge was successful

<%= headers 200 %>
<%= json \
  :sha     => '6dcb09b5b57875f334f61aebed695e2e4193db5e',
  :merged  => true,
  :message => 'Pull Request successfully merged'
%>

### Response if merge cannot be performed

<%= headers 405 %>
<%= json \
  :message => "Pull Request is not mergeable",
  :documentation_url => "https://developer.github.com/v3/pulls/#merge-a-pull-request-merge-button"
%>

### Response if sha was provided and pull request head did not match

<%= headers 409 %>
<%= json \
  :message => "Head branch was modified. Review and try the merge again.",
  :documentation_url => "https://developer.github.com/v3/pulls/#merge-a-pull-request-merge-button"
%>

### Labels, assignees, and milestones

Every pull request is an issue, but not every issue is a pull request. For this reason, "shared" actions for both features, like manipulating assignees, labels and milestones, are provided within [the Issues API](/v3/issues).

## Custom media types

These are the supported media types for pull requests. You can read more about the
use of media types in the API [here](/v3/media/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
    application/vnd.github.VERSION.diff
    application/vnd.github.VERSION.patch

<a id="diff-error">

If a diff is corrupt, <span class='not-enterprise'>please contact [GitHub Support](https://www.github.com/contact)</span><span class='enterprise-only'>contact your site administrator</span> to receive help. Be sure to include the repository name and pull request ID.
