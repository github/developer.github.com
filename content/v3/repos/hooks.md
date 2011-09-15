---
title: Repo Hooks API v3 | developer.github.com
---

# Repo Hooks API

The Repository Hooks API manages the post-receive web and service hooks
for a repository.  There are two main APIs to manage these hooks: a JSON
HTTP API, and [PubSubHubbub](#pubsubhubbub).

## List

    GET /repos/:user/:repo/hooks

### Response

<%= headers 200, :pagination => true %>
<%= json(:hook) { |h| [h] } %>

## Get single hook

    GET /repos/:user/:repo/hooks/:id

### Response

<%= headers 200 %>
<%= json :full_hook %>

## Create a hook

    POST /repos/:user/:repo/hooks

### Input

name
: _Required_ **string** - The name of the service that is being called.
See [/hooks](https://api.github.com/hooks) for the possible names.

config
: _Required_ **hash** - A Hash containing key/value pairs to provide
settings for this hook.  These settings vary between the services and
are defined in the
[github-services](https://github.com/github/github-services) repo.

active
: _Optional_ **boolean** - Determines whether the hook is actually
triggered on pushes.

<%= json \
      :name => "campfire",
      :active => true,
      :config => {
        :subdomain => 'github',
        :room => 'Commits',
        :token => 'abc123'}
%>

### Response

<%= headers 201,
      :Location => 'https://api.github.com/repos/user/repo/hooks/1' %>
<%= json :full_hook %>

### Edit a hook

    PATCH /repos/:user/:repo/hooks/:id

### Input

name
: _Required_ **string** - The name of the service that is being called.
See [/hooks](https://api.github.com/hooks) for the possible names.

config
: _Required_ **hash** - A Hash containing key/value pairs to provide
settings for this hook.  These settings vary between the services and
are defined in the
[github-services](https://github.com/github/github-services) repo.

active
: _Optional_ **boolean** - Determines whether the hook is actually
triggered on pushes.

<%= json \
      :name => "campfire",
      :active => true,
      :config => {
        :subdomain => 'github',
        :room => 'Commits',
        :token => 'abc123'}
%>

### Response

<%= headers 200 %>
<%= json :full_hook %>

## Test a hook

This will trigger the hook with the latest push to the current
repository.

    POST /repos/:user/:repo/hooks/:id/test

### Response

<%= headers 204 %>

## Delete a hook

    DELETE /repos/:user/:repo/hooks/:id

### Response

<%= headers 204 %>

## PubSubHubbub

GitHub can also serve as a [PubSubHubbub][pubsub] hub for all repositories.  PSHB is a simple publish/subscribe protocol that lets servers register to receive updates when a topic is updated.  The updates are sent with an HTTP POST request to a callback URL.  Topic URLs for a GitHub repository's pushes are in this format:

    https://github.com/:user/:repo/events/push 

The default format is what [existing post-receive hooks should
expect][post-receive]: A JSON body sent as the `payload` parameter in a
POST.  You can also specify to receive the raw JSON body with either an
`Accept` header, or a `.json` extension.

    Accept: application/json
    https://github.com/:user/:repo/events/push.json

Callback URLs can use either the `http://` protocol, or `github://`.
`github://` callbacks specify a GitHub service.

    # Send updates to postbin.org
    http://postbin.org/123

    # Send updates to Campfire
    github://campfire?subdomain=github&room=Commits&token=abc123

The GitHub PubSubHubbub endpoint is: https://api.github.com/hub.  A
successful request with curl looks like:

    curl -u "user:password" -i \
      https://api.github.com/hub \
      -F "hub.mode=subscribe" \
      -F "hub.topic=https://github.com/:user/:repo/events/push" \
      -F "hub.callback=http://postbin.org/123"

PubSubHubbub requests can be sent multiple times.  If the hook already
exists, it will be modified according to the request.

### Parameters

hub.mode
: _Required_ **string** - Either `subscribe` or `unsubscribe`.

hub.topic
: _Required_ **string** - The URI of the GitHub repository to subscribe
to.  The path must be in the format of `/:user/:repo/events/push`.

hub.callback
: _Required_ **string** - The URI to receive the updates to the topic.

hub.secret
: _Optional_ **string** - A shared secret key that generates a SHA1 HMAC
of the payload content.  You can verify a push came from GitHub by
comparing the received body with the contents of the `X-Hub-Signature`
header.

[pubsub]: http://code.google.com/p/pubsubhubbub/
[post-receive]: http://help.github.com/post-receive-hooks/

