---
title: Organization Webhooks | GitHub API
---

# Webhooks

* TOC
{:toc}

<div class="alert">
  <p>
    The Organization Webhooks API is currently available for developers to preview.
    During the preview period, the API may change without advance notice.
    Please see the <a href="/changes/#TODO">blog post <strong style="color:red;">[UPDATE LINK]</strong></a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.sersi-preview+json</pre>
  </p>
</div>


Organization webhooks allow you to receive HTTP POST payloads whenever certain events happen within the organization. Subscribing to these events makes it possible to build integrations that react to actions on GitHub.com.

## Scopes & Restrictions

All actions against organization hooks require that the authenticating user be an admin of the `:org` being managed. Additionally, OAuth tokens require the "admin:org_hook" [scope](/v3/oauth/#scopes).

In order to protect sensitive data which may be present in webhook configurations, we also enforce the following access control rules:

- Oauth applications cannot list, view, or edit webhooks which they did not create.
- Users cannot list, view, or edit webhooks which were created by Oauth applications.

## List hooks

    GET /orgs/:org/hooks

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:hook) { |h| [h] } %>


## Get single hook

    GET /orgs/:org/hooks/:id

### Response

<%= headers 200 %>
<%= json :hook %>


## Create a hook

    POST /orgs/:org/hooks

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the service that is being called. (See  <a href='https://api.github.com/hooks' data-proofer-ignore>/hooks</a> for the list of valid hook names.)
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

    PATCH /orgs/:org/hooks/:id

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


## Ping a hook

This will trigger a [ping event][ping-event-url] to be sent to the hook.

    POST /orgs/:org/hooks/:id/pings

### Response

<%= headers 204 %>


## Delete a hook

    DELETE /orgs/:org/hooks/:id

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


[guid]: http://en.wikipedia.org/wiki/Globally_unique_identifier
[pubsub]: http://code.google.com/p/pubsubhubbub/
[post-receive]: http://help.github.com/post-receive-hooks/
[ruby-secret]: https://github.com/github/github-services/blob/14f4da01ce29bc6a02427a9fbf37b08b141e81d9/lib/services/web.rb#L47-L50
[hub-signature]: https://github.com/github/github-services/blob/f3bb3dd780feb6318c42b2db064ed6d481b70a1f/lib/service/http_helper.rb#L77
[pshb-secret]: http://pubsubhubbub.googlecode.com/svn/trunk/pubsubhubbub-core-0.3.html#authednotify
[events-url]: /webhooks/#events
[ping-event-url]: /webhooks/#ping-event
