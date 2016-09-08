---
title: Pre-receive Hooks
---

# Pre-receive Hooks

{{#tip}}

  <a name="preview-period"></a>

  APIs for managing pre-receive hooks are currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.eye-scream-preview
      
{{/tip}}

{:toc}

The Pre-receive Hooks API allows you to create, list, update and delete
pre-receive hooks. *It is only available to
[authenticated](/v3/#authentication) site administrators.* Normal users
will receive a `404` response if they try to access it.

Prefix all the endpoints for this API with the following URL:

``` command-line
http(s)://<em>hostname</em>/api/v3
```

## Object attributes

### Pre-receive Hook

| Name                             | Type      | Description                                                     |
|----------------------------------|-----------|-----------------------------------------------------------------|
| `name`                           | `string`  | The name of the hook.                                           |
| `script`                         | `string`  | The script that the hook runs.                                  |
| `script_repository`              | `object`  | The GitHub repository where the script is kept.                 |
| `environment`                    | `object`  | The pre-receive environment where the script is executed.       |
| `enforcement`                    | `string`  | The state of enforcement for this hook.                         |
| `allow_downstream_configuration` | `boolean` | Whether enforcement can be overridden at the org or repo level. |

Possible values for *enforcement* are `enabled`, `disabled` and`testing`. `disabled` indicates the pre-receive hook will not run. `enabled` indicates it will run and reject 
any pushes that result in a non-zero status. `testing` means the script will run but will not cause any pushes to be rejected.

## Get a single pre-receive hook

    GET /admin/pre-receive-hooks/:id

<%= headers 200 %> <%= json :pre_receive_hook %>

## List pre-receive hooks

    GET /admin/pre-receive-hooks

<%= headers 200, :pagination => default_pagination_rels %> 
<%= json :pre_receive_hooks %>

## Create a pre-receive hook

    POST /admin/pre-receive-hooks

### Parameters

| Name                             | Type      | Description                                                                      |
|----------------------------------|-----------|----------------------------------------------------------------------------------|
| `name`                           | `string`  | **Required**  The name of the hook.                                              |
| `script`                         | `string`  | **Required**  The script that the hook runs.                                     |
| `script_repository`              | `object`  | **Required**  The GitHub repository where the script is kept.                    |
| `environment`                    | `object`  | **Required**  The pre-receive environment where the script is executed.          |
| `enforcement`                    | `string`  | The state of enforcement for this hook. default: `disabled`                      |
| `allow_downstream_configuration` | `boolean` | Whether enforcement can be overridden at the org or repo level. default: `false` |

<%= json \
  :name => "Check Commits",
  :script =>  "scripts/commit_check.sh",
    :enforcement => "disabled",
    :allow_downstream_configuration => false,
  :script_repository => { :full_name => "DevIT/hooks" },
  :environment => { :id => 2 }
%>

### Response
<%= headers 201 %>
<%= json :pre_receive_hook %>

## Edit a pre-receive hook

    PATCH /admin/pre_receive_hooks/:id
    
<%= json \
  :name => "Check Commits",
  :environment => { :id => 1 },
  :allow_downstream_configuration => true
%>

### Response
<%= headers 200 %>
<%= json :pre_receive_hook_update %>

## Delete a pre-receive hook

    DELETE /admin/pre_receive_hooks/:id

### Response

<%= headers 204 %>
