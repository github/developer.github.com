---
title: Management console | GitHub API
---

# Management console

* TOC
{:toc}

You can use this API to manage your GitHub Enterprise installation. We've included some parameters, responses, and examples to help you understand and use the API to manage your Enterprise installation.

Note: only admin users can access Enterprise API endpoints. Normal users will receive a `404` response if they try to access it.

## Authentication

Every call to this API needs to be authenticated. The MD5 of the license is used as the authentication token.

<pre class="terminal">
$ md5sum github-enterprise.ghl
5d10ffffa442a336061daee294536234  github-enterprise.ghl
</pre>

This token can be sent in each request using the `license_md5` parameter. For example:

<pre class="terminal">
$ curl 'http://<em>hostname</em>/setup/api?license_md5=<em>5d10ffffa442a336061daee294536234</em>'
</pre>

Or using the standard http basic authentication. For example:

<pre class="terminal">
$ curl 'http://license:<em>5d10ffffa442a336061daee294536234</em>@<em>hostname</em>/setup/api'
</pre>

The only time that you're not required to pass this token is when you're [uploading the license and package for the first time](#upload-license-and-package-for-the-first-time).

## Upload license and package for the first time

Once the virtual machine is booted for the first time, you can use the API to
upload the new license and package:

    POST /setup/api/start

### Parameters

Name | Type | Description
-----|------|--------------
`license`|`string` | **Required**. The path to your *.ghl* license file.
`package`|`string`|**Required**. The path to your *.ghp* license file.
`settings`| `string`| Optional path to a JSON file containing your installation settings

### Response

<%= headers 202 %>

### Example

<pre class="terminal">
curl -X POST 'http://<em>hostname</em>/setup/api/start' -F package=@<em>/path/to/package.ghp</em> -F license=@<em>/path/to/github-enterprise.ghl</em> -F settings=&lt;<em>/path/to/settings.json</em>
</pre>

#### Configuration status

Once the configuration process is running, we can check its status using
this endpoint:

<pre class="terminal">
GET /setup/api/configcheck
</pre>

##### Response:

<pre class="terminal">
Status: 200 OK
[
  {
    "key": "Appliance core components",
    "status": "DONE"
  },
  {
    "key": "GitHub utilities",
    "status": "DONE"
  },
  {
    "key": "GitHub applications",
    "status": "DONE"
  },
  {
    "key": "GitHub services",
    "status": "CONFIGURING"
  },
  {
    "key": "Reloading appliance services",
    "status": "PENDING"
  }
]
</pre>

The different statuses are:

* `PENDING`: When a job has not started yet.
* `CONFIGURING`: When a job is running.
* `DONE`: When a job has finished correctly.
* `FAILED`: When a job has finished unexpectedly.

##### Example:

<pre class="terminal">
curl 'http://<em>hostname</em>/setup/api/configcheck?license_md5=<em>md5-checksum-of-license</em>'
</pre>

### Settings

Using this endpoint, we can retrieve and modify the installation settings.

#### Retrieve current settings:

<pre class="terminal">
GET /setup/api/settings
</pre>

##### Response:

<pre class="terminal">
Status: 200 OK
{
  "device": {
    "path": "/dev/xyz"
  },
  "smtp": {
    "enabled": true,
    "address": "smtp.example.com",
    "authentication": "plain",
    "port": "1234",
    "domain": "blah",
    "username": "foo",
    "password": "bar",
    "support_address": "enterprise@github.com",
    "noreply_address": "noreply@github.com"
  },
  "dns": {
    "primary_nameserver": "8.8.8.8"
  },
  "private_mode": true,
  "ldap": {
    "host": "ldap.example.com",
    "port": 389,
    "base": "ou=People,dc=github,dc=com",
    "uid": "github"
  },
  "github_hostname": "github.example.com",
  "github_ssl": {
    "enabled": false
  },
  "storage_mode": "rootfs",
  "cas": {
    "url" : "cas.example.com"
  },
  "auth_mode": "default",
  "snmp": {
    "enabled": true
  },
  "rsyslog": {
    "enabled": false
  }
}
</pre>

##### Example:

<pre class="terminal">
curl 'http://<em>hostname</em>/setup/api/settings?license_md5=<em>md5-checksum-of-license</em>'
</pre>

#### Modify settings:

<pre class="terminal">
PUT /setup/api/settings
</pre>

##### Parameters:

* `settings`: JSON string with the new settings.

##### Response:

<pre class="terminal">
Status 204 No Content
</pre>

##### Example:

<pre class="terminal">
curl -X PUT 'http://<em>hostname</em>/setup/api/settings?license_md5=<em>md5-checksum-of-license</em>' --data-urlencode "settings=`cat /path/to/settings.json`"
</pre>

### Configuration

This endpoint allows you to start a configuration process at any time:

<pre class="terminal">
POST /setup/api/configure
</pre>

##### Parameters:

* `complete`: If this parameter is set to `1` the process is executed completely. For example, if we were upgrading to a new version. _Optional_

##### Response:

<pre class="terminal">
Status: 202 Accepted
Location: http://hostname/setup/api/configcheck
</pre>

##### Example:

<pre class="terminal">
curl -X POST 'http://<em>hostname</em>/setup/api/configure?license_md5=<em>md5-checksum-of-license</em>'
</pre>

### Upgrade license or package

This call upgrades your license or package and also triggers the configuration process.

<pre class="terminal">
POST /setup/api/upgrade
</pre>

##### Parameters:

* `license`: new license file. _Optional_
* `package`: new ghp. _Optional_

##### Response:

<pre class="terminal">
Status: 202 Accepted
Location: http://hostname/setup/api/configcheck
</pre>

##### Example:

<pre class="terminal">
curl -X POST 'http://<em>hostname</em>/setup/api/upgrade?license_md5=<em>md5-checksum-of-license</em>' -F package=@<em>/path/to/package.ghp</em>
</pre>

### Maintenance status

Check and modify the installation's maintenance status:

#### Check

<pre class="terminal">
GET /setup/api/maintenance
</pre>

##### Response:

<pre class="terminal">
Status: 200 OK
{
  "status": "scheduled",
  "scheduled_time": "Tuesday, January 22 at 15:34 -0800",
  "connection_services": [
    {
      "name": "git operations", "number": 0
    },
    {
      "name": "mysql queries", "number": 233
    },
    {
      "name": "resque jobs", "number": 54
    }
  ]
}
</pre>

##### Example:

<pre class="terminal">
curl 'http://<em>hostname</em>/setup/api/maintenance?license_md5=<em>md5-checksum-of-license</em>'
</pre>

#### Modify

<pre class="terminal">
POST /setup/api/maintenance
</pre>

##### Parameters:

* `maintenance`: JSON string with the attributes `enabled` and `when`.

The possible values for `enabled` are `true` and `false`. When it's `false`,
the attribute `when` is ignored and the maintenance mode is turned off.

The possible values for `when` are `now` or any date parseable by
[mojombo/chronic](https://github.com/mojombo/chronic).

##### Response:

<pre class="terminal">
Status: 200 OK
{
  "status": "scheduled",
  "scheduled_time": "Tuesday, January 22 at 15:34 -0800",
  "connection_services": [
    {
      "name": "git operations", "number": 0
    },
    {
      "name": "mysql queries", "number": 233
    },
    {
      "name": "resque jobs", "number": 54
    }
  ]
}
</pre>

##### Example:

<pre class="terminal">
curl -X POST 'http://<em>hostname</em>/setup/api/maintenance?license_md5=<em>md5-checksum-of-license</em>' -d 'maintenance=<em>{"enabled":true, "when":"now"}</em>'
</pre>

### Authorized SSH keys

You can add, delete, or retrieve the public SSH keys authorized in the installation.

#### Retrieve keys

<pre class="terminal">
GET /setup/api/settings/authorized-keys
</pre>

##### Response:

<pre class="terminal">
Status: 200 OK
[
  {
    "key": ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
    "pretty-print": "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
  },
  {
    "key": ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
    "pretty-print": "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
  }
]
</pre>

##### Example:

<pre class="terminal">
curl 'http://<em>hostname</em>/setup/api/settings/authorized-keys?license_md5=<em>md5-checksum-of-license</em>'
</pre>

#### Add a new authorized key

<pre class="terminal">
POST /setup/api/settings/authorized-keys
</pre>

##### Parameters:

* `authorized_key`: public ssh key.

##### Response:

<pre class="terminal">
Status: 201 Created
[
  {
    "key": ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
    "pretty-print": "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
  },
  {
    "key": ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
    "pretty-print": "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
  },
  {
    "key": ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
    "pretty-print": "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
  }
]
</pre>

##### Example:

<pre class="terminal">
curl -X POST 'http://<em>hostname</em>/setup/api/settings/authorized-keys?license_md5=<em>md5-checksum-of-license</em>' -F authorized_key=@<em>/path/to/key.pub</em>
</pre>

#### Remove an authorized-key

<pre class="terminal">
DELETE /setup/api/settings/authorized-keys
</pre>

##### Parameters:

* `authorized_key`: public ssh key.

##### Response:

<pre class="terminal">
Status: 200 OK
[
  {
    "key": ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
    "pretty-print": "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
  },
  {
    "key": ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
    "pretty-print": "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
  }
]
</pre>

##### Example:

<pre class="terminal">
curl -X DELETE 'http://<em>hostname</em>/setup/api/settings/authorized-keys?license_md5=<em>md5-checksum-of-license</em>' -F authorized_key=@<em>/path/to/key.pub</em>
</pre>
