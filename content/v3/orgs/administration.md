---
title: Organization Administration | GitHub API
---

# Administration (Enterprise)

* TOC
{:toc}

The Organization Administration API allows you to create organizations on a GitHub Enterprise appliance. *It is only available to [authenticated](/v3/#authentication) site administrators.* Normal users will receive a `403` response if they try to access it.

Prefix all the endpoints for this API with the following URL:

<pre class="terminal">
http(s)://<em>hostname</em>/api/v3
</pre>

## Create an organization

    POST /admin/organizations

### Parameters

Name | Type | Description
-----|------|--------------
`login`|`string` | The organization's username
`profile_name`|`string` | The organization's display name
`admin`|`string`| The login of the user who will manage this organization

#### Example

<%= json \
    :login           => "github",
    :profile_name    => "GitHub, Inc.",
    :admin           => "monalisaoctocat"
%>

### Response

<%= headers 201 %>
<%= json :organization %>
