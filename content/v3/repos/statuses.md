---
title: Statuses | GitHub API
---

# Statuses

* TOC
{:toc}

The Status API allows external services to mark commits with a success,
failure, error, or pending `state`, which is then reflected in pull requests
involving those commits.

Statuses can also include an optional `description` and `target_url`, and
we highly recommend providing them as they make statuses much more
useful in the GitHub UI.

As an example, one common use is for continuous integration
services to mark commits as passing or failing builds using Status.  The
`target_url` would be the full URL to the build output, and the
`description` would be the high level summary of what happened with the
build.

Note that the `repo:status` [OAuth scope](/v3/oauth/#scopes) grants targeted
access to Statuses **without** also granting access to repository code, while the
`repo` scope grants permission to code as well as statuses.

## Create a Status

Users with push access can create commit statuses for a given ref:

    POST /repos/:owner/:repo/statuses/:sha

### Parameters

Name | Type | Description
-----|------|--------------
`state`|`string` | **Required**. The state of the status. Can be one of `pending`, `success`, `error`, or `failure`.
`target_url`|`string` | The target URL to associate with this status.  This URL will be linked from the GitHub UI to allow users to easily see the 'source' of the Status.<br/>For example, if your Continuous Integration system is posting build status, you would want to provide the deep link for the build output for this specific SHA:<br/>`http://ci.example.com/user/repo/build/sha`.
`description`|`string` | A short description of the status.
`context`|`string` | A string label to differentiate this status from the status of other systems. Default: `"default"`

#### Example

<%= json \
  :state         => "success",
  :target_url    => "https://example.com/build/status",
  :description   => "The build succeeded!",
  :context       => "continuous-integration/jenkins"
%>

### Response

<%= headers 201,
      :Location =>
'https://api.github.com/repos/octocat/example/statuses/1' %>
<%= json :status %>

<% combined_media_type = "application/vnd.github.she-hulk-preview+json" %>

## List Statuses for a specific Ref

Users with pull access can view commit statuses for a given ref:

    GET /repos/:owner/:repo/statuses/:ref

<div class="alert">
  <p>
    If you send an <code>Accept</code> header with the Combined Status API preview
    <a href="/v3/media/">media type</a>, <code><%= combined_media_type %></code>,
    this endpoint is also available at <code>/repos/:owner/:repo/commits/:ref/statuses</code>.
  </p>
</div>

Statuses are returned in reverse chronological order. The first status in the
list will be the latest one.

### Parameters

Name | Type | Description
-----|------|--------------
`ref`|`string` | **Required**. Ref to list the statuses from. It can be a SHA, a branch name, or a tag name.


### Response

<%= headers 200 %>
<%= json(:status) { |h| [h] } %>

## Get the combined Status for a specific Ref

<div class="alert">
  <p>
    The Combined status endpoint is currently available for developers to preview.
    During the preview period, the API may change without advance notice.
    Please see the <a href="/changes/2014-03-27-combined-status-api/">blog post</a> for full details.
  </p>
  <p>
    To access this endpoint during the preview period, you must provide a custom
    <a href="/v3/media/">media type</a> in the <code>Accept</code> header:
    <pre><%= combined_media_type %></pre>
  </p>
</div>

Users with pull access can access a combined view of commit statuses for a given ref.

    GET /repos/:owner/:repo/commits/:ref/status

The most recent status for each context is returned, up to 100. This field
[paginates](/v3/#pagination) if there are over 100 contexts.

Additionally, a combined `state` is returned. The `state` is one of:

 * **failure** if any of the contexts report as error or failure
 * **pending** if there are no statuses or a context is pending
 * **success** if the latest status for all contexts is success

### Parameters

Name | Type | Description
-----|------|--------------
`ref`|`string` | **Required**. Ref to fetch the status for. It can be a SHA, a branch name, or a tag name.

### Response
<%= headers 200 %>
<%= json(:combined_status) { |h| [h] } %>
