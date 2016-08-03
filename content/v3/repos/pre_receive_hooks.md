---
title: Repository Pre-receive Hooks
---

# Repository Pre-receive Hooks (Enterprise)

{{#tip}}

  <a name="preview-period"></a>

  APIs for managing pre-receive hooks are currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.eye-scream-preview
      
{{/tip}}


{:toc}

The Repository Pre-receive Hooks API allows you to view and modify 
enforcement of the pre-receive hooks that are available to a repository. 

Prefix all the endpoints for this API with the following URL:

``` command-line
http(s)://<em>hostname</em>/api/v3
```

## Object attributes

| Name                | Type     | Description                                               |
|---------------------|----------|-----------------------------------------------------------|
| `name`              | `string` | The name of the hook.                                     |
| `enforcement`       | `string` | The state of enforcement for the hook on this repository. |
| `configuration_url` | `string` | URL for the endpoint where enforcement is set.            |

Possible values for *enforcement* are `enabled`, `disabled` and`testing`. `disabled` indicates the pre-receive hook will not run. `enabled` indicates it will run and reject 
any pushes that result in a non-zero status. `testing` means the script will run but will not cause any pushes to be rejected.

`configuration_url` may be a link to this repository, it's organization 
owner or global configuration. Authorization to access the endpoint at 
`configuration_url` is determined at the owner or site admin level.

## List pre-receive hooks

List all pre-receive hooks that are enabled or testing for this
repository as well as any disabled hooks that are allowed to be enabled
at the repository level. Pre-receive hooks that are disabled at a higher 
level and are not configurable will not be listed.

    GET /repos/:owner/:repo/pre-receive-hooks

<%= headers 200, :pagination => default_pagination_rels %> 
<%= json :pre_receive_hooks_repo %>

## Get a single pre-receive hook

    GET /repos/:owner/:repo/pre-receive-hooks/:id

<%= headers 200 %> <%= json :pre_receive_hook_repo %>

## Update pre-receive hook enforcement

For pre-receive hooks which are allowed to be configured at the repo level, you can set `enforcement`

    PATCH /repos/:owner/:repo/pre-receive-hooks/:id
    
<%= json :enforcement => "enabled" %>

### Response

<%= headers 200 %><%= json :pre_receive_hook_repo_update %>

## Remove enforcement overrides for a pre-receive hook

Deletes any overridden enforcement on this repository for the specified 
hook.

    DELETE /repos/:owner/:repo/pre-receive-hooks/:id
    
### Response

Responds with effective values inherited from owner and/or global level.

<%= headers 200 %> <%= json :pre_receive_hook_repo %>
