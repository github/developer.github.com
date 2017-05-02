---
title: Traffic
---

# Traffic
{{#tip}}

  <a name="preview-period"></a>

  APIs for repository traffic are currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.
  Please see the [blog post](/changes/2016-08-15-traffic-api-preview) for full details.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.spiderman-preview

{{/tip}}

{:toc}

For repositories that you have push access to, the traffic API provides access
to the information provided in the [graphs section](https://help.github.com/articles/about-repository-graphs/#traffic).

<a id="list" />

## List referrers

Get the top 10 referrers over the last 14 days.

    GET /repos/:owner/:repo/traffic/popular/referrers

### Response

<%= headers 200 %>
<%= json(:traffic_referrers) %>

## List paths

Get the top 10 popular contents over the last 14 days.

    GET /repos/:owner/:repo/traffic/popular/paths

### Response

<%= headers 200%>
<%= json(:traffic_contents) %>

## Views

Get the total number of views and breakdown per day or week for the last 14 days.

    GET  /repos/:owner/:repo/traffic/views

### Parameters
Name | Type | Description
-----|------|--------------
`per`|string|Must be one of: `day`, `week`. Default: `day`


### Response
<%= headers 200 %>
<%= json(:traffic_views) %>

## Clones

Get the total number of clones and breakdown per day or week for the last 14 days.

    GET  /repos/:owner/:repo/traffic/clones

### Parameters
Name | Type | Description
-----|------|--------------
`per`|string|Must be one of: `day`, `week`. Default: `day`

### Response

<%= headers 200 %>
<%= json(:traffic_clones) %>
