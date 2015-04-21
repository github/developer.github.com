---
title: Organization Webhooks | GitHub API
---

# Webhooks

* TOC
{:toc}

Organization webhooks allow you to receive HTTP `POST` payloads whenever certain events happen within the organization. Subscribing to these events makes it possible to build integrations that react to actions on GitHub.com. For more information on actions you can subscribe to, check out our [Events documentation][webhook-events].

## Scopes & Restrictions

All actions against organization webhooks require the authenticated user to be an admin of the organization being managed. Additionally, OAuth tokens require [the `admin:org_hook` scope](/v3/oauth/#scopes).

In order to protect sensitive data which may be present in webhook configurations, we also enforce the following access control rules:

- OAuth applications cannot list, view, or edit webhooks which they did not create.
- Users cannot list, view, or edit webhooks which were created by OAuth applications.

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
`config`|`object` | **Required**. Key/value pairs to provide settings for this webhook. [These are defined below](#create-hook-config-params).
`events`|`array` | Determines what [events][event-types] the hook is triggered for.  Default: `["push"]`.
`active`|`boolean` | Determines whether the hook is actually triggered on pushes.

<a name="create-hook-config-params"></a>
The `config` object can accept the following keys:

<%= fetch_content(:org_hook_config_hash) %>

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

<%= headers 201, :Location => get_resource(:org_hook)['url'] %>
<%= json :org_hook %>


## Edit a hook

    PATCH /orgs/:org/hooks/:id

### Parameters

Name | Type | Description
-----|------|--------------
`config`|`object` | **Required**. Key/value pairs to provide settings for this webhook. [These are defined below](#update-hook-config-params).
`events`|`array` | Determines what [events][event-types] the hook is triggered for.  Default: `["push"]`.
`active`|`boolean` | Determines whether the hook is actually triggered on pushes.

<a name="update-hook-config-params"></a>
The `config` object can accept the following keys:

<%= fetch_content(:org_hook_config_hash) %>


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

For more best practices, [see our guide][best-integration-practices].

### Webhook Headers

GitHub will send along several HTTP headers to differentiate between event types and payload identifiers.

Name | Description
-----|-----------|
`X-GitHub-Event` | The [event type](/v3/activity/events/types/) that was triggered.
`X-GitHub-Delivery` | A [guid][guid] to identify the payload and event being sent.
`X-Hub-Signature` | The value of this header is computed as the HMAC hex digest of the body, using the `secret` config option as the key.


[guid]: http://en.wikipedia.org/wiki/Globally_unique_identifier
[hub-signature]: https://github.com/github/github-services/blob/f3bb3dd780feb6318c42b2db064ed6d481b70a1f/lib/service/http_helper.rb#L77
[ping-event-url]: /webhooks/#ping-event
[webhook-events]: /webhooks/#events
[event-types]: /v3/activity/events/types/
[media-type]: /v3/media
[best-integration-practices]: /guides/best-practices-for-integrators/
[developer-blog-post]: /changes/2014-12-03-preview-the-new-organization-webhooks-api/
