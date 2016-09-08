---
title: Organization Pre-receive Hooks
---

# Organization Pre-receive Hooks (Enterprise)

{{#tip}}

  <a name="preview-period"></a>

  APIs for managing pre-receive hooks are currently available for developers to preview.
  During the preview period, the APIs may change without advance notice.

  To access the API you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.eye-scream-preview
      
{{/tip}}

{:toc}

The Organization Pre-receive Hooks API allows you to view and modify 
enforcement of the pre-receive hooks that are available to an organization.

Prefix all the endpoints for this API with the following URL:

``` command-line
http(s)://<em>hostname</em>/api/v3
```

## Object attributes

| Name                             | Type      | Description                                               |
|----------------------------------|-----------|-----------------------------------------------------------|
| `name`                           | `string`  | The name of the hook.                                     |
| `enforcement`                    | `string`  | The state of enforcement for the hook on this repository. |
| `allow_downstream_configuration` | `boolean` | Whether repositories can override enforcement.            |
| `configuration_url`              | `string`  | URL for the endpoint where enforcement is set.            |

Possible values for *enforcement* are `enabled`, `disabled` and`testing`. `disabled` indicates the pre-receive hook will not run. `enabled` indicates it will run and reject 
any pushes that result in a non-zero status. `testing` means the script will run but will not cause any pushes to be rejected.

`configuration_url` may be a link to this endpoint or this hook's global 
configuration. Only site admins are able to access the global configuration.

## List pre-receive hooks

List all pre-receive hooks that are enabled or testing for this 
organization as well as any disabled hooks that can be configured at the
organization level. Globally disabled pre-receive hooks that do not allow
downstream configuration are not listed.

    GET /orgs/:org/pre-receive-hooks

<%= headers 200, :pagination => default_pagination_rels %> 
<%= json :pre_receive_hooks_org %>

## Get a single pre-receive hook

    GET /orgs/:org:pre-receive-hooks/:id
    
<%= headers 200 %> <%= json :pre_receive_hook_org %>

## Update pre-receive hook enforcement

For pre-receive hooks which are allowed to be configured at the org level, you can set 
`enforcement` and `allow_downstream_configuration`

    PATCH /orgs/:org/pre-receive-hooks/:id
    
<%= json :enforcement => "enabled", :allow_downstream_configuration => false %>

### Response

<%= headers 200 %><%= json :pre_receive_hook_org_update %>

## Remove enforcment overrides for a pre-receive hook

Removes any overrides for this hook at the org level for this org.

    DELETE /orgs/:org/pre-receive-hooks/:id
    
<%= headers 200 %> <%= json :pre_receive_hook_org %>
