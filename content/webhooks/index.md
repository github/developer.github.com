---
title: Webhooks | GitHub API
layout: webhooks
---

# Webhooks

* TOC
{:toc}

Every GitHub repository has the option to communicate with a web server whenever
the repository is pushed to. These "webhooks" can be used to update an external
issue tracker, trigger CI builds, update a backup mirror, or even deploy to your
production server.

Each hook can be configured for a specific [service](#services) and one or
more [events](#events), regardless of the API used to do so. Repository admins
can configure hooks programmatically [via the API](/v3/repos/hooks/).

## Services

A service is basically the name used to refer to a webhook that has configuration
settings, a list of available events, and default events.

For instance, the
[email](https://github.com/github/github-services/blob/master/lib/services/email.rb)
service is a built-in GitHub service that will send event [payloads](#payloads)
to, at most, two email addresses.  It will trigger for the `push`
event by default and supports the `public` event type as well.

A number of services have been integrated through the open source
[github-services](https://github.com/github/github-services) project.  When
[creating a hook](/webhooks/creating/), the `:name` parameter must refer to one of
these services.

Documentation for all available service hooks can be found in the
[docs directory](https://github.com/github/github-services/tree/master/docs)
of the github-services repository.  A JSON representation of their names,
default events, supported events, and configuration options can be seen
at [api.github.com/hooks](https://api.github.com/hooks).


## Events

Active hooks can be configured to trigger for one or more service supported
events. In other words, the service must support listening for the event you
want to trigger.

For example, generic webhooks supports listening for all events, while the
[IRC](https://github.com/github/github-services/blob/master/lib/services/irc.rb)
service can only listen for `push`, `issues`, `pull_request`, `commit_comment`,
`pull_request_review_comment`, and `issue_comment` events.

Each service also has a set of default events for which it listens if it isn't
configured. For example, generic webhooks listen only for `push` events by
default, while the IRC service listens on `push` and `pull_requests` events.
Service hooks set up via the repository settings UI listen only for the default
set of events, but can be
[re-configured via the API](/v3/repos/hooks/#edit-a-hook).

The available events are:

Name | Description
-----|-----------|
`*` | Any time any event is triggered ([Wildcard Event](#wildcard-event)).
`commit_comment` | Any time a Commit is commented on.
`create` | Any time a Branch or Tag is created.
`delete` | Any time a Branch or Tag is deleted.
`deployment` | Any time a Repository has a new deployment created from the API.
`deployment_status` | Any time a deployment for the Repository has a status update from the API.
`fork` | Any time a Repository is forked.
`gollum` | Any time a Wiki page is updated.
`issue_comment` | Any time an Issue is commented on.
`issues` | Any time an Issue is opened or closed.
`member` | Any time a User is added as a collaborator to a non-Organization Repository.
`page_build` | Any time a Pages site is built or results in a failed build.
`public` | Any time a Repository changes from private to public.
`pull_request_review_comment` | Any time a Commit is commented on while inside a Pull Request review (the Files Changed tab).
`pull_request` | Any time a Pull Request is opened, closed, or synchronized (updated due to a new push in the branch that the pull request is tracking).
`push` | Any git push to a Repository. **This is the default event.**
`release` | Any time a Release is published in the Repository.
`status` | Any time a Repository has a status update from the API
`team_add` | Any time a team is added or modified on a Repository.
`watch` | Any time a User watches the Repository.

### Payloads

The payloads for all hooks mirror [the payloads for the Event
types](/v3/activity/events/types/), with the exception of [the original `push`
event](https://developer.github.com/v3/activity/events/types/#pushevent),
which has a more detailed payload.

A full payload will also show the user who performed the event (`sender`),
the repository (`repository`), and the organization (`organization`) if applicable.

#### Delivery headers

HTTP requests made to your server's endpoint will contain several special
headers:

Header | Description
-------|-------------|
`X-Github-Event`| Name of the [event](#events) that triggered this delivery.
`X-Hub-Signature`| HMAC hex digest of the payload, using [the hook's `secret`](/v3/repos/hooks/#create-a-hook) as the key (if configured).
`X-Github-Delivery`| Unique ID for this delivery.

Also, the `User-Agent` for the requests will have the prefix `GitHub Hookshot`.

#### Example delivery

<pre class="terminal">
POST /payload HTTP/1.1

Host: localhost:4567
X-Github-Delivery: 72d3162e-cc78-11e3-81ab-4c9367dc0958
User-Agent: GitHub Hookshot 044aadd
Content-Type: application/json
Content-Length: 6615
X-Github-Event: issue

{
  "action": "opened",
  "issue": {
    "url": "https://api.github.com/repos/octocat/Hello-World/issues/1347",
    "number": 1347,
    ...
  },
  "repository" : {
    "id": 1296269,
    "full_name": "octocat/Hello-World",
    "owner": {
      "login": "octocat",
      "id": 1,
      ...
    },
    ...
  },
  "sender": {
    "login": "octocat",
    "id": 1,
    ...
  }
}
</pre>

## Wildcard Event

We also support a wildcard (`*`) that will match all supported events. When you
add the wildcard event, we'll replace any existing events you have configured with
the wildcard event and send you payloads for all supported events. You'll also
automatically get any new events we might add in the future.

## Ping Event

When you create a new webhook, we'll send you a simple `ping` event to let you
know you've set up the webhook correctly. This event isn't stored so it isn't
retrievable via the [Events API](/v3/activity/events/). You can trigger a `ping`
again by calling the [ping endpoint](/v3/repos/hooks/#ping-a-hook).

### Ping Event Payload

Key | Value |
----| ----- |
zen | Random string of GitHub zen |
hook_id | The ID of the webhook that triggered the ping |
