---
title: Webhooks | GitHub API
---

# Webhooks

* TOC
{:toc}

The Repository Webhooks API allows repository admins to manage the post-receive
hooks for a repository.  Webhooks can be managed using the JSON HTTP API,
or the [PubSubHubbub API](#pubsubhubbub).

## List hooks

    GET /repos/:owner/:repo/hooks

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:hook) { |h| [h] } %>

## Get single hook

    GET /repos/:owner/:repo/hooks/:id

### Response

<%= headers 200 %>
<%= json :hook %>

## Create a hook

    POST /repos/:owner/:repo/hooks

**Note**: Repositories can have more than one webhook configured, but all other services can have at most one configuration. Creating hooks for a service that already has one configured will [update the existing hook](#edit-a-hook).

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the service that is being called. (See [/hooks](https://api.github.com/hooks) for the list of valid hook names.)
`config`|`hash` | **Required**. Key/value pairs to provide settings for this hook.  These settings vary between the services and are defined in the [github-services](https://github.com/github/github-services) repository. Booleans are stored internally as "1" for true, and "0" for false.  Any JSON `true`/`false` values will be converted automatically.
`events`|`array` | Determines what events the hook is triggered for.  Default: `["push"]`
`active`|`boolean` | Determines whether the hook is actually triggered on pushes.

#### Example

To create [a webhook](/webhooks), [the following fields are required](https://github.com/github/github-services/blob/master/lib/services/web.rb#L4-11) by the `config`:

* `url`: A required string defining the URL to which the payloads will be delivered.
* `content_type`: An optional string defining the media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
* `secret`: An optional string that's passed with the HTTP requests as an `X-Hub-Signature` header. The value of this header is computed as the [HMAC hex digest of the body, using the `secret` as the key][hub-signature].
* `insecure_ssl`: An optional string that determines whether the SSL certificate of the host for `url` will be verified when delivering payloads. Supported values include `"0"` (verification is performed) and `"1"` (verification is not performed). The default is `"0"`.

Here's how you can create a hook that posts payloads in JSON format:

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

### Parameters

Name | Type | Description
-----|------|--------------
`config`|`hash` | Key/value pairs to provide settings for this hook.  Modifying this will replace the entire config object.  These settings vary between the services and are defined in the [github-services](https://github.com/github/github-services) repository. Booleans are stored internally as "1" for true, and "0" for false.  Any JSON `true`/`false` values will be converted automatically.
`events`|`array` | Determines what events the hook is triggered for.  This replaces the entire array of events.  Default: `["push"]`
`add_events`|`array` | Determines a list of events to be added to the list of events that the Hook triggers for.
`remove_events`|`array` | Determines a list of events to be removed from the list of events that the Hook triggers for.
`active`|`boolean` | Determines whether the hook is actually triggered on pushes.


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

## Ping a hook

This will trigger a [ping event][ping-event-url] to be sent to the hook.

    POST /repos/:owner/:repo/hooks/:id/pings

### Response

<%= headers 204 %>

## Delete a hook

    DELETE /repos/:owner/:repo/hooks/:id

### Response

<%= headers 204 %>

## Receiving Webhooks

In order for GitHub to send webhook payloads, your server needs to be accessible from the Internet. We also highly suggest using SSL so that we can send encrypted payloads over HTTPS.

### Webhook Headers

GitHub will send along a few HTTP headers to differentiate between event types and payload identifiers.

Name | Description
-----|-----------|
`X-GitHub-Event` | The [event type](/v3/activity/events/types/) that was triggered.
`X-GitHub-Delivery` | A [guid][guid] to identify the payload and event being sent.
`X-Hub-Signature` | The value of this header is computed as the HMAC hex digest of the body, using the `secret` config option as the key.

## PubSubHubbub

GitHub can also serve as a [PubSubHubbub][pubsub] hub for all repositories.
PSHB is a simple publish/subscribe protocol
that lets servers register to receive updates when a topic is updated.
The updates are sent with an HTTP POST request to a callback URL.
Topic URLs for a GitHub repository's pushes are in this format:

    https://github.com/:owner/:repo/events/:event

The event can be any [event][events-url] string that is listed at the top of this
document.

### Response format

The default format is what [existing post-receive hooks should
expect][post-receive]: A JSON body sent as the `payload` parameter in a
POST.  You can also specify to receive the raw JSON body with either an
`Accept` header, or a `.json` extension.

    Accept: application/json
    https://github.com/:owner/:repo/events/push.json

### Callback URLs

Callback URLs can use either the `http://` protocol, or `github://`.
`github://` callbacks specify a GitHub service.

    # Send updates to postbin.org
    http://postbin.org/123

    # Send updates to Campfire
    github://campfire?subdomain=github&room=Commits&token=abc123

### Subscribing

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

#### Parameters

Name | Type | Description
-----|------|--------------
``hub.mode``|`string` | **Required**. Either `subscribe` or `unsubscribe`.
``hub.topic``|`string` |**Required**.  The URI of the GitHub repository to subscribe to.  The path must be in the format of `/:owner/:repo/events/:event`.
``hub.callback``|`string` | The URI to receive the updates to the topic.
``hub.secret``|`string` | A shared secret key that generates a SHA1 HMAC of the outgoing body content.  You can verify a push came from GitHub by comparing the raw request body with the contents of the `X-Hub-Signature` header.  You can see [our Ruby implementation][ruby-secret], or [the PubSubHubbub documentation][pshb-secret] for more details.


[guid]: http://en.wikipedia.org/wiki/Globally_unique_identifier
[pubsub]: http://code.google.com/p/pubsubhubbub/
[post-receive]: http://help.github.com/post-receive-hooks/
[ruby-secret]: https://github.com/github/github-services/blob/14f4da01ce29bc6a02427a9fbf37b08b141e81d9/lib/services/web.rb#L47-L50
[hub-signature]: https://github.com/github/github-services/blob/f3bb3dd780feb6318c42b2db064ed6d481b70a1f/lib/service/http_helper.rb#L77
[pshb-secret]: http://pubsubhubbub.googlecode.com/svn/trunk/pubsubhubbub-core-0.3.html#authednotify
[events-url]: /webhooks/#events
[ping-event-url]: /webhooks/#ping-event
