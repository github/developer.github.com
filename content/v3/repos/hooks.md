---
title: Repo Hooks | GitHub API
---

# Repo Hooks API

* TOC
{:toc}

The Repository Hooks API allows repository admins to manage the post-receive
web and service hooks for a repository.  There are two main APIs to manage
these hooks: a JSON HTTP API, and [PubSubHubbub](#pubsubhubbub).

Active hooks can be configured to trigger for one or more events.
The default event is `push`.  The available events are:

* `push` - Any git push to a Repository.
* `issues` - Any time an Issue is opened or closed.
* `issue_comment` - Any time an Issue is commented on.
* `commit_comment` - Any time a Commit is commented on.
* `pull_request` - Any time a Pull Request is opened, closed, or
  synchronized (updated due to a new push in the branch that the pull
request is tracking).
* `pull_request_review_comment` - Any time a Commit is commented on
  while inside a Pull Request review (the Files Changed tab).
* `gollum` - Any time a Wiki page is updated.
* `watch` - Any time a User watches the Repository.
* `download` - Any time a Download is added to the Repository.
* `fork` - Any time a Repository is forked.
* `fork_apply` - Any time a patch is applied to the Repository from the
  Fork Queue.
* `member` - Any time a User is added as a collaborator to a
  non-Organization Repository.
* `public` - Any time a Repository changes from private to public.
* `team_add` - Any time a team is added or modified on a Repository.
* `status` - Any time a Repository has a status update from the API

The payloads for all of the hooks mirror [the payloads for the Event
types](/v3/activity/events/types/), with the exception of [the original `push`
event](http://help.github.com/post-receive-hooks/).

A number of external services have already been integrated through the open source
[github-services](https://github.com/github/github-services) project, including the generic
[Web Service](https://github.com/github/github-services/blob/master/lib/services/web.rb) service which can be used to
define your own custom hooks. All possible names for hooks, the events they support, and their configuration can be seen at [/hooks](https://api.github.com/hooks).

For a Hook to go through, the Hook needs to be configured to trigger for
an event, and the Service has to listen to it.   Most of the Services only listen for `push` events.  However, the generic [Web Service](https://github.com/github/github-services/blob/master/lib/services/web.rb) listens for all events.  Other services like the [IRC Service](https://github.com/github/github-services/blob/master/lib/services/irc.rb) may only listen for `push`, `issues`, and `pull_request` events.

## List

    GET /repos/:owner/:repo/hooks

### Response

<%= headers 200, :pagination => true %>
<%= json(:hook) { |h| [h] } %>

## Get single hook

    GET /repos/:owner/:repo/hooks/:id

### Response

<%= headers 200 %>
<%= json :hook %>

## Create a hook

    POST /repos/:owner/:repo/hooks

### Input

`name`
: _Required_ **string** - The name of the service that is being called.
See [/hooks](https://api.github.com/hooks) for the possible names.

`config`
: _Required_ **hash** - A Hash containing key/value pairs to provide
settings for this hook.  These settings vary between the services and
are defined in the
[github-services](https://github.com/github/github-services) repo.
Booleans are stored internally as "1" for true, and "0" for false.  Any
JSON true/false values will be converted automatically.

`events`
: _Optional_ **array** - Determines what events the hook is triggered
for.  Default: `["push"]`.

`active`
: _Optional_ **boolean** - Determines whether the hook is actually
triggered on pushes.

Example:  The ["web" service hook](https://github.com/github/github-services/blob/master/lib/services/web.rb#L4-11)
takes these fields:

* `url`
* `content_type`
* `secret`

Here's how you can setup a hook that posts raw JSON (instead of the default
legacy format):

<%= json \
      :name => "web",
      :active => true,
      :events => ['push', 'pull_request'],
      :config => {
        :url => 'http://example.com/webhook',
        :content_type => 'json'}
%>

### Response

<%= headers 201,
      :Location => 'https://api.github.com/repos/user/repo/hooks/1' %>
<%= json :hook %>

## Edit a hook

    PATCH /repos/:owner/:repo/hooks/:id

### Input

`config`
: _Optional_ **hash** - A Hash containing key/value pairs to provide
settings for this hook.  Modifying this will replace the entire config
object.  These settings vary between the services and
are defined in the
[github-services](https://github.com/github/github-services) repo.
Booleans are stored internally as "1" for true, and "0" for false.  Any
JSON true/false values will be converted automatically.

`events`
: _Optional_ **array** - Determines what events the hook is triggered
for.  This replaces the entire array of events.  Default: `["push"]`.

`add_events`
: _Optional_ **array** - Determines a list of events to be added to the
list of events that the Hook triggers for.

`remove_events`
: _Optional_ **array** - Determines a list of events to be removed from the
list of events that the Hook triggers for.

`active`
: _Optional_ **boolean** - Determines whether the hook is actually
triggered on pushes.

#### Example

<%= json \
      :active => true,
      :add_events => ['pull_request']
%>

### Response

<%= headers 200 %>
<%= json :hook %>

## Test a `push` hook

This will trigger the hook with the latest push to the current
repository if the hook is subscribed to `push` events. If the
hook is not subscribed to `push` events, the server will respond
with 204 but no test POST will be generated.

    POST /repos/:owner/:repo/hooks/:id/tests

**Note**: Previously `/repos/:owner/:repo/hooks/:id/test`

### Response

<%= headers 204 %>

## Delete a hook

    DELETE /repos/:owner/:repo/hooks/:id

### Response

<%= headers 204 %>

## PubSubHubbub

GitHub can also serve as a [PubSubHubbub][pubsub] hub for all repositories.  PSHB is a simple publish/subscribe protocol that lets servers register to receive updates when a topic is updated.  The updates are sent with an HTTP POST request to a callback URL.  Topic URLs for a GitHub repository's pushes are in this format:

    https://github.com/:owner/:repo/events/:event

The event can be any Event string that is listed at the top of this
document.

The default format is what [existing post-receive hooks should
expect][post-receive]: A JSON body sent as the `payload` parameter in a
POST.  You can also specify to receive the raw JSON body with either an
`Accept` header, or a `.json` extension.

    Accept: application/json
    https://github.com/:owner/:repo/events/push.json

Callback URLs can use either the `http://` protocol, or `github://`.
`github://` callbacks specify a GitHub service.

    # Send updates to postbin.org
    http://postbin.org/123

    # Send updates to Campfire
    github://campfire?subdomain=github&room=Commits&token=abc123

The GitHub PubSubHubbub endpoint is: https://api.github.com/hub.
(GitHub Enterprise users should use http://yourhost/api/v3/hub as the
PubSubHubbub endpoint, but not change the `hub.topic` URI format.) A
successful request with curl looks like:

    curl -u "user" -i \
      https://api.github.com/hub \
      -F "hub.mode=subscribe" \
      -F "hub.topic=https://github.com/:owner/:repo/events/push" \
      -F "hub.callback=http://postbin.org/123"

PubSubHubbub requests can be sent multiple times.  If the hook already
exists, it will be modified according to the request.

### Parameters

`hub.mode`
: _Required_ **string** - Either `subscribe` or `unsubscribe`.

`hub.topic`
: _Required_ **string** - The URI of the GitHub repository to subscribe
to.  The path must be in the format of `/:owner/:repo/events/:event`.

`hub.callback`
: _Required_ **string** - The URI to receive the updates to the topic.

`hub.secret`
: _Optional_ **string** - A shared secret key that generates a SHA1 HMAC
of the outgoing body content.  You can verify a push came from GitHub by
comparing the raw request body with the contents of the `X-Hub-Signature`
header.  You can see [our Ruby implementation][ruby-secret], or [the
PubSubHubbub documentation][pshb-secret] for more details.

[pubsub]: http://code.google.com/p/pubsubhubbub/
[post-receive]: http://help.github.com/post-receive-hooks/
[ruby-secret]: https://github.com/github/github-services/blob/14f4da01ce29bc6a02427a9fbf37b08b141e81d9/lib/services/web.rb#L47-L50
[pshb-secret]: http://pubsubhubbub.googlecode.com/svn/trunk/pubsubhubbub-core-0.3.html#authednotify

