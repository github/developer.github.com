---
title: Management Console | GitHub API
---

# Management Console

* TOC
{:toc}

The Management Console API helps you manage your GitHub Enterprise installation.

{{#tip}}

You must explicitly set the port number when making API calls to the Management Console. If SSL is enabled on your Enterprise instance, the port number is `8443`; otherwise, the port number is `8080`.

If you don't want to provide a port number, you'll need to configure your tool to automatically follow redirects.

{{/tip}}

## Authentication

You need to pass your [Management Console password](https://help.github.com/enterprise/2.0/admin/articles/accessing-the-management-console/) as an authentication token to every Management Console API endpoint except [`/setup/api/start`](#upload-a-license-for-the-first-time).

Use the `api_key` parameter to send this token with each request. For example:

<pre class="terminal">
$ curl -L 'http://<em>hostname</em>:<em>admin_port</em>/setup/api?api_key=<em>your-amazing-password</em>'
</pre>

You can also use standard HTTP authentication to send this token. For example:

<pre class="terminal">
$ curl -L 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api'
</pre>

## Upload a license for the first time

When you boot a virtual machine for the first time, you can use the following endpoint to upload a license:

    POST /setup/api/start

Note that you need to POST to [`/setup/api/configure`](#start-a-configuration-process) to start the actual configuration process.

{{#warning}}

When using this endpoint, your Enterprise instance must have a password set. This can be accomplished two ways:

1. If you're working directly with the API before accessing the web interface, you must pass in the password parameter to set your password.
2. If you set up your instance via the web interface before accessing the API, your calls to this endpoint do not need the password parameter.

{{/warning}}

### Parameters

Name | Type | Description
-----|------|--------------
`license`|`string` | **Required**. The content of your *.ghl* license file.
`password`|`string` | You **must** provide a password *only if* you are uploading your license for the first time. If you previously set a password through the web interface, you don't need this parameter.
`settings`| `string`| Optional path to a JSON file containing your installation settings.

For a list of the available settings, see [the `/setup/api/settings` endpoint](#retrieve-settings).

### Response

<pre class="terminal">
HTTP/1.1 202 Created
Location: http://<em>hostname</em>:<em>admin_port</em>/setup/api/configcheck
</pre>

### Example

<pre class="terminal">
curl -L -X POST 'http://<em>hostname</em>:<em>admin_port</em>/setup/api/start' -F license=@<em>/path/to/github-enterprise.ghl</em> -F "password=<em>your-amazing-password</em>" -F settings=&lt;<em>/path/to/settings.json</em>
</pre>

## Upgrade a license

This API upgrades your license and also triggers the configuration process:

    POST /setup/api/upgrade

### Parameters

Name | Type | Description
-----|------|--------------
`license`|`string` |  The content of your new *.ghl* license file.

### Response

<pre class="terminal">
HTTP/1.1 202 Accepted
Location: http://<em>hostname</em>:<em>admin_port</em>/setup/api/configcheck
</pre>

### Example

<pre class="terminal">
curl -L -X POST 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/upgrade'
</pre>

## Check configuration status

This endpoint allows you to check the status of the most recent configuration process:

    GET /setup/api/configcheck

Note that you may need to wait several seconds after you start a process before you can
check its status.

### Response

<%= headers 200 %>
<%= json(:config_statuses) %>

The different statuses are:

Status        | Description
--------------|----------------------------------
`PENDING`     | The job has not started yet
`CONFIGURING` | The job is running
`DONE`        | The job has finished correctly
`FAILED`      | The job has finished unexpectedly

### Example

<pre class="terminal">
curl -L 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/configcheck'
</pre>

## Start a configuration process

This endpoint allows you to start a configuration process at any time for your updated settings to take effect:

    POST /setup/api/configure

### Response

<pre class="terminal">
HTTP/1.1 202 Accepted
Location: http://<em>hostname</em>:<em>admin_port</em>/setup/api/configcheck
</pre>

### Example

<pre class="terminal">
curl -L -X POST 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/configure'
</pre>

## Retrieve settings

    GET /setup/api/settings

### Response

<%= headers 200 %>
<%= json(:fetch_settings) %>

### Example

<pre class="terminal">
curl -L 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/settings'
</pre>

## Modify settings

    PUT /setup/api/settings

### Parameters

Name | Type | Description
-----|------|--------------
`settings`|`string` | **Required**. A JSON string with the new settings.

### Response

<pre class="terminal">
HTTP/1.1 204 No Content
</pre>

### Example

<pre class="terminal">
curl -L -X PUT 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/settings' --data-urlencode "settings=`cat /path/to/settings.json`"
</pre>

## Check maintenance status

Check your installation's maintenance status:

    GET /setup/api/maintenance

### Response

<%= headers 200 %>
<%= json(:check_maintenance_status) %>

### Example

<pre class="terminal">
curl -L 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/maintenance'
</pre>

## Enable or disable maintenance mode

    POST /setup/api/maintenance

### Parameters

Name | Type | Description
-----|------|--------------
`maintenance`|`string` | **Required**. A JSON string with the attributes `enabled` and `when`.

The possible values for `enabled` are `true` and `false`. When it's `false`,
the attribute `when` is ignored and the maintenance mode is turned off. `when` defines the time period when the maintenance was enabled.

The possible values for `when` are `now` or any date parseable by
[mojombo/chronic](https://github.com/mojombo/chronic).

### Response

<%= headers 200 %>
<%= json(:set_maintenance_status) %>

### Example

<pre class="terminal">
curl -L -X POST 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/maintenance' -d 'maintenance=<em>{"enabled":true, "when":"now"}</em>'
</pre>

## Retrieve authorized SSH keys

    GET /setup/api/settings/authorized-keys

### Response

<%= headers 200 %>
<%= json(:get_authorized_ssh_keys) %>

### Example

<pre class="terminal">
curl -L 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/settings/authorized-keys'
</pre>

## Add a new authorized SSH key

    POST /setup/api/settings/authorized-keys

### Parameters

Name | Type | Description
-----|------|--------------
`authorized_key`|`string` | **Required**. The path to the public SSH key.

### Response

<%= headers 201 %>
<%= json(:get_authorized_ssh_keys) { |h| h.push({"key" => "ssh-rsa AAAAB3NzaC1yc2EAAAAB...", "pretty-print" => "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"}); h }%>

### Example

<pre class="terminal">
curl -L -X POST 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/settings/authorized-keys' -F authorized_key=@<em>/path/to/key.pub</em>
</pre>

## Remove an authorized SSH key

    DELETE /setup/api/settings/authorized-keys

### Parameters

Name | Type | Description
-----|------|--------------
`authorized_key`|`string` | **Required**. The path to the public SSH key.

### Response

<%= headers 200 %>
<%= json(:get_authorized_ssh_keys) { |h| h.shift; h } %>

### Example

<pre class="terminal">
curl -L -X DELETE 'http://api_key:<em>your-amazing-password</em>@<em>hostname</em>:<em>admin_port</em>/setup/api/settings/authorized-keys' -F authorized_key=@<em>/path/to/key.pub</em>
</pre>
