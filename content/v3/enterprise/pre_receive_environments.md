---
title: Pre-receive Environments
---

# Pre-receive Environments

{{#tip}}

  <a name="preview-period"></a>

  APIs for managing pre-receive hooks are currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.eye-scream-preview
      
{{/tip}}

{:toc}

The Pre-receive Environments API allows you to create, list, update and delete environments for pre-receive hooks. *It is only available to [authenticated](/v3/#authentication) site administrators.* Normal users will receive a `404` response if they try to access it.

Prefix all the endpoints for this API with the following URL:

``` command-line
http(s)://<em>hostname</em>/api/v3
```

## Object attributes

### Pre-receive Environment

| Name                  | Type      | Description                                                                |
|-----------------------|-----------|----------------------------------------------------------------------------|
| `name`                | `string`  | The name of the environment as displayed in the UI.                        |
| `image_url`           | `string`  | URL to the tarball that will be downloaded and extracted.                  |
| `default_environment` | `boolean` | Whether this is the default environment that ships with GitHub Enterprise. |
| `download`            | `object`  | This environment's download status.                                        |
| `hooks_count`         | `integer` | The number of pre-receive hooks that use this environment.                 |

### Pre-receive Environment Download

| Name            | Type     | Description                                             |
|-----------------|----------|---------------------------------------------------------|
| `state`         | `string` | The state of the most recent download.                  |
| `downloaded_at` | `string` | The time when the most recent download started.         |
| `message`       | `string` | On failure, this will have any error messages produced. |

Possible values for `state` are `not_started`, `in_progress`, `success`, `failed`.


## Get a single pre-receive environment

    GET /admin/pre-receive-environments/:id

<%= headers 200 %>
<%= json :pre_receive_environment %>

## List pre-receive environments

    GET /admin/pre_receive_environments

<%= headers 200, :pagination => default_pagination_rels %>
<%= json :pre_receive_environments %>

## Create a pre-receive environment

    POST /admin/pre_receive_environments

### Parameters

| Name        | Type     | Description                                                             |
|-------------|----------|-------------------------------------------------------------------------|
| `name`      | `string` | **Required**. The new pre-receive environment's name.                   |
| `image_url` | `string` | **Required**. URL from which to download a tarball of this environment. |

<%= json \
  :name => 'DevTools Hook Env',
  :image_url => 'https://my_file_server/path/to/devtools_env.tar.gz'
%>

### Response

<%= headers 201 %>
<%= json :pre_receive_environment_create %>

## Edit a pre-receive environment

    PATCH /admin/pre_receive_environments/:id

### Parameters

| Name        | Type     | Description                                               |
|-------------|----------|-----------------------------------------------------------|
| `name`      | `string` | This pre-receive environment's new name.                  |
| `image_url` | `string` | URL from which to download a tarball of this environment. |

### Response
<%= headers 200 %>
<%= json :pre_receive_environment %>

#### Client Errors

If you attempt to modify the default environment, you will get a response like this:

<%= headers 422 %>
<%=
  json :message => "Validation Failed",
    :errors => [{
      :resource => :PreReceiveEnvironment,
      :code     => :custom,
      :message    => 'Cannot modify or delete the default environment'
    }]
%>

## Delete a pre-receive environment

    DELETE /admin/pre_receive_environments/:id

### Response

<%= headers 204 %>

#### Client Errors

If you attempt to delete an environment that cannot be deleted, you will get a response like this:

<%= headers 422 %>
<%=
  json :message => "Validation Failed",
    :errors => [{
      :resource => :PreReceiveEnvironment,
      :code     => :custom,
      :message    => 'Cannot modify or delete the default environment'
    }]
%>

The possible error messages are:

- _Cannot modify or delete the default environment_
- _Cannot delete environment that has hooks_ 
- _Cannot delete environment when download is in progress_

## Get a pre-receive environment's download status

In addition to seeing the download status at the `/admin/pre-receive-environments/:id`, there is also a separate endpoint for just the status.

    GET /admin/pre-receive-environments/:id/downloads/latest

<%= headers 200 %>
<%= json :pre_receive_environment_download_2 %>

### Object attributes

| Name            | Type     | Description                                             |
|-----------------|----------|---------------------------------------------------------|
| `state`         | `string` | The state of the most recent download.                  |
| `downloaded_at` | `string` | The time when the most recent download started.         |
| `message`       | `string` | On failure, this will have any error messages produced. |

Possible values for `state` are `not_started`, `in_progress`, `success`, `failed`.

## Trigger a pre-receive environment download

Triggers a new download of the environment tarball from the environment's `image_url`.  When the download is finished, the newly downloaded tarball will overwrite the existing environment.

    POST /admin/pre_receive_environments/:id/downloads

### Response

<%= headers 202 %>
<%= json :pre_receive_environment_download %>

#### Client Errors

If a download cannot be triggered, you will get a reponse like this:

<%= headers 422 %>
<%=
  json :message => "Validation Failed",
    :errors => [{
      :resource => :PreReceiveEnvironment,
      :code     => :custom,
      :message    => 'Can not start a new download when a download is in progress'
    }]
%>

The possible error messages are:

- _Cannot modify or delete the default environment_
- _Can not start a new download when a download is in progress_

