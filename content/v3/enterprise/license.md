---
title: License
---

# License

{:toc}

The License API provides information on your Enterprise license. *It is only available to [authenticated](/v3/#authentication) site administrators.* Normal users will receive a `404` response if they try to access it.

Prefix all the endpoints for this API with the following URL:

``` command-line
{{ site.data.variables.product.api_url_pre }}
```

## Get license information

### Request

    GET /enterprise/settings/license

### Response

<%= headers 200 %>
<%= json(:licensing) %>
