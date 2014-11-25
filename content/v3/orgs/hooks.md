---
title: Organization Webhooks | GitHub API
---

# Webhooks

* TOC
{:toc}

{{#tip}}

  The Organization Webhooks API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the <a href="/changes/#TODO">blog post <strong style="color:red;">[UPDATE LINK]</strong></a> for full details.

  To access the API during the preview period, you must provide a custom [media type][media-type] in the `Accept` header:

      application/vnd.github.sersi-preview+json

{{/tip}}


Organization webhooks allow you to receive HTTP `POST` payloads whenever certain events happen within the organization. Subscribing to these events makes it possible to build integrations that react to actions on GitHub.com.

## Scopes & Restrictions

All actions against organization webhooks require the authenticated user to be an admin of the organization being managed. Additionally, OAuth tokens require [the `admin:org_hook` scope](/v3/oauth/#scopes).

In order to protect sensitive data which may be present in webhook configurations, we also enforce the following access control rules:

- Oauth applications cannot list, view, or edit webhooks which they did not create.
- Users cannot list, view, or edit webhooks which were created by Oauth applications.

## List hooks

    GET /orgs/:org/hooks

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:org_hook) { |h| [h] } %>


## Get single hook

    GET /orgs/:org/hooks/:id

### Response

<%= headers 200 %>
<%= json :org_hook %>


## Create a hook

    POST /orgs/:org/hooks

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. Must be passed as "web".
`config`|`hash` | **Required**. Key/value pairs to provide settings for this webhook (documented below).
`config[url]`          | `string` | **Required** The URL to which the payloads will be delivered.
`config[content_type]` | `string` | The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
`config[secret]`       | `string` | If given payloads will be delivered with an `X-Hub-Signature` header. The value of this header is computed as the [HMAC hex digest of the body, using the `secret` as the key][hub-signature].
`config[insecure_ssl]` | `string` | Determines whether the SSL certificate of the host for `url` will be verified when delivering payloads. Supported values include `"0"` (verification is performed) and `"1"` (verification is not performed). The default is `"0"`. We strongly recommend not setting this to "1" as you are subject to man-in-the-middle and other attacks.
`events`|`array` | Determines what [events][event-types] the hook is triggered for.  Default: `["push"]`
`active`|`boolean` | Determines whether the hook is actually triggered on pushes.

#### Example

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
      :Location => 'https://api.github.com/orgs/octocat/hooks/1' %>
<%= json :org_hook %>


## Edit a hook

    PATCH /orgs/:org/hooks/:id

### Parameters

Name | Type | Description
-----|------|--------------
`config`|`hash` | **Required**. Key/value pairs to provide settings for this webhook (documented below).
`config[url]`          | `string` | **Required** The URL to which the payloads will be delivered.
`config[content_type]` | `string` | The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
`config[secret]`       | `string` | If given payloads will be delivered with an `X-Hub-Signature` header. The value of this header is computed as the [HMAC hex digest of the body, using the `secret` as the key][hub-signature].
`config[insecure_ssl]` | `string` | Determines whether the SSL certificate of the host for `url` will be verified when delivering payloads. Supported values include `"0"` (verification is performed) and `"1"` (verification is not performed). The default is `"0"`. We strongly recommend not setting this to "1" as you are subject to man-in-the-middle and other attacks.
`events`|`array` | Determines what [events][event-types] the hook is triggered for.  Default: `["push"]`
`active`|`boolean` | Determines whether the hook is actually triggered on pushes.


#### Example

<%= json \
      :active => true,
      :events => ['pull_request']
%>

### Response

<%= headers 200 %>
<%= json(:org_hook) { |h| h.merge "events" => %w(pull_request) } %>


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
[hub-signature]: https://github.com/github/github-services/blob/f3bb3dd780feb6318c42b2db064ed6d481b70a1f/lib/service/http_helper.rb#L77
[ping-event-url]: /webhooks/#ping-event
[event-types]: /v3/activity/events/types/
[media-type]: /v3/media
