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

A service is basically the name used to refer to a hook that has configuration
settings, a list of available events, and default events.

> For instance, the
[email](https://github.com/github/github-services/blob/master/lib/services/email.rb)
service is a built-in GitHub service that will send event [payloads](#payloads)
to, at most, two email addresses.  It will trigger for the `push`
event by default and supports the `public` event type as well.

A number of services have been integrated through the open source
[github-services](https://github.com/github/github-services) project.  When
[creating a hook](/webhooks/creating/), the `:name` parameter must refer to one of
these services.  A generic
[Web](https://github.com/github/github-services/blob/master/lib/services/web.rb)
service is available that can configured to trigger for any of the available
[events](#events).

Documentation for all available service hooks can be found in the
[docs directory](https://github.com/github/github-services/tree/master/docs)
of the github-services repository.  A JSON representation of their names,
default events, supported events, and configuration options can be seen
at [api.github.com/hooks](https://api.github.com/hooks).


## Events

Active hooks can be configured to trigger for one or more service supported
events. In other words, the service must support listening for the event you
want to trigger.

For example, the
[Web](https://github.com/github/github-services/blob/master/lib/services/web.rb)
service listens for all events, while the
[IRC](https://github.com/github/github-services/blob/master/lib/services/irc.rb)
service can only listen for `push`, `issues`, and `pull_request` events.

The available events are:

Name | Description
-----|-----------|
`push` | Any git push to a Repository. **This is the default event.**
`issues` | Any time an Issue is opened or closed.
`issue_comment` | Any time an Issue is commented on.
`commit_comment` | Any time a Commit is commented on.
`create` | Any time a Repository, Branch, or Tag is created.
`delete` | Any time a Branch or Tag is deleted.
`pull_request` | Any time a Pull Request is opened, closed, or synchronized (updated due to a new push in the branch that the pull request is tracking).
`pull_request_review_comment` | Any time a Commit is commented on while inside a Pull Request review (the Files Changed tab).
`gollum` | Any time a Wiki page is updated.
`watch` | Any time a User watches the Repository.
`release` | Any time a Release is published in the Repository.
`fork` | Any time a Repository is forked.
`member` | Any time a User is added as a collaborator to a non-Organization Repository.
`public` | Any time a Repository changes from private to public.
`team_add` | Any time a team is added or modified on a Repository.
`status` | Any time a Repository has a status update from the API
`deployment` | Any time a Repository has a new deployment created from the API.
`deployment_status` | Any time a deployment for the Repository has a status update from the API.


### Payloads

The payloads for all hooks mirror [the payloads for the Event
types](/v3/activity/events/types/), with the exception of [the original `push`
event](http://help.github.com/post-receive-hooks/),
which has a more detailed payload.

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
