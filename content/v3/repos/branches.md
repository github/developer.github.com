---
title: Branches
---

# Branches

{:toc}

{% if page.version != 'dotcom' and page.version >= 2.5 and page.version < 2.7 %}

## List Branches

    GET /repos/:owner/:repo/branches

### Parameters

Name | Type | Description
-----|------|-------------
`protected`| `boolean` | Set to `true` to only return protected branches

{{#tip}}

  <a name="preview-period"></a>

  The Protected Branch API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post](/changes/2015-11-11-protected-branches-api) for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.loki-preview+json

  The `protection` key will only be present in branch payloads if this header is passed.

{{/tip}}

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:branches) { |a| a.each { |b| b.merge!("protection" => {
  "enabled" => false,
  "required_status_checks" => {
    "enforcement_level" => "off",
    "contexts" => []
  }
}) } } %>

## Get Branch

    GET /repos/:owner/:repo/branches/:branch

### Response

{{#tip}}

  <a name="preview-period"></a>

  The Protected Branch API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post](/changes/2015-11-11-protected-branches-api) for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.loki-preview+json

  The `protection` key will only be present in branch payloads if this header is passed.

{{/tip}}

<%= headers 200 %>
<%= json(:branch) { |h| h.merge!("protection" => {
  "enabled" => false,
  "required_status_checks" => {
    "enforcement_level" => "off",
    "contexts" => []
  }
}) } %>

## Enabling and disabling branch protection

{{#tip}}

  <a name="preview-period"></a>

  The Protected Branch API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post](/changes/2015-11-11-protected-branches-api) for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.loki-preview+json

{{/tip}}

Protecting a branch requires admin access.

    PATCH /repos/:owner/:repo/branches/:branch

### Parameters

You need to pass a `protection` object.

Name | Type | Description
-----|------|-------------
`enabled`|`boolean` | **Required**. Should this branch be protected or not
`required_status_checks`|`object`| Configure required status checks here

The `required_status_checks` object must have the following keys:

Name | Type | Description
-----|------|-------------
`enforcement_level`|`string` | **Required**. Who required status checks apply to. Options are `off`, `non_admins` or `everyone`.
`contexts`|`array` | **Required**. The list of status checks to require in order to merge into this branch

The `enforcement_level` key can have the following values:

Name  | Description
------|------------
`off` | Turn off required status checks for this branch.
`non_admins` | Required status checks will be enforced for non-admins.
`everyone` | Required status checks will be enforced for everyone (including admins).

#### Example

<%= json \
  "protection" => {
    "enabled" => true,
    "required_status_checks" => {
      "enforcement_level" => "everyone",
      "contexts" => ["continuous-integration/travis-ci"]
    }
  }
%>

{% endif %}

{% if page.version == 'dotcom' or page.version >= 2.7 %}

{{#tip}}

  <a name="preview-period"></a>

  The Protected Branch API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post](/changes/2016-06-27-protected-branches-api-update) for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.loki-preview+json

{{/tip}}

## List Branches

    GET /repos/:owner/:repo/branches

### Parameters

Name | Type | Description
-----|------|-------------
`protected` | `boolean` | Set to `true` to only return protected branches

{{#tip}}

  <a name="preview-period"></a>

  The Protected Branch API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post](/changes/2016-06-27-protected-branches-api-update) for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.loki-preview+json

  The `protected` key will only be present in branch payloads if this header is passed.

{{/tip}}

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:branches) { |a| a.each { |b| b.merge!(
  "protected": true,
  "protection_url": "https://api.github.com/repos/octocat/Hello-World/branches/#{b["name"]}/protection",
) } } %>

## Get Branch

    GET /repos/:owner/:repo/branches/:branch

### Response

{{#tip}}

  <a name="preview-period"></a>

  The Protected Branch API is currently available for developers to preview.
  During the preview period, the API may change without advance notice.
  Please see the [blog post](/changes/2016-06-27-protected-branches-api-update) for full details.

  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.loki-preview+json

  The `protected` key will only be present in branch payloads if this header is passed.

{{/tip}}

<%= headers 200 %>
<%= json(:branch) { |h| h.merge!(
  "protected": true,
  "protection_url": "https://api.github.com/repos/octocat/Hello-World/branches/#{h["name"]}/protection",
) } %>


## Get branch protection

    GET /repos/:owner/:repo/branches/:branch/protection

<%= headers 200 %>
<%= json(:repo_branch_protection) %>

## Update branch protection

Protecting a branch requires admin access.

    PUT /repos/:owner/:repo/branches/:branch/protection

### Parameters

You must pass two objects: `required_status_checks` and `restrictions`. Both can have the value `null` for disabled.

The `required_status_checks` object must have the following keys:

Name | Type | Description
-----|------|-------------
`include_admins` | `boolean` | **Required**. Enforce required status checks for repository administrators.
`strict` | `boolean` | **Required**. Require branches to be up to date before merging.
`contexts` | `array` | **Required**. The list of status checks to require in order to merge into this branch

The `restrictions` object must have the following keys:

Name | Type | Description
-----|------|-------------
`users` | `array` | The list of user `login`s with push access
`teams` | `array` | The list of team `slug`s with push access

{{#tip}}

* Teams and users `restrictions` are only available for organization-owned repositories.
* The list of users and teams in total is limited to 100 items.

{{/tip}}

### Example

<%= json \
  "required_status_checks" => {
    "include_admins" => true,
    "strict" => true,
    "contexts" => ["continuous-integration/travis-ci"]
  },
  "restrictions" => {
    "users" => ["octocat"],
    "teams" => ["justice-league"]
  }
%>

### Response

<%= headers 200 %>
<%= json(:repo_branch_protection) %>

## Remove branch protection

    DELETE /repos/:owner/:repo/branches/:branch/protection

<%= headers 204 %>

## Get required status checks of protected branch

    GET /repos/:owner/:repo/branches/:branch/protection/required_status_checks

<%= headers 200 %>
<%= json(:repo_branch_protection_required_status_checks) %>

## Update required status checks of protected branch

Updating required status checks requires admin access and branch protection to be enabled.

    PATCH /repos/:owner/:repo/branches/:branch/protection/required_status_checks

### Parameters

The object passed can have the following keys:

Name | Type | Description
-----|------|-------------
`include_admins`|`boolean` | Enforce required status checks for repository administrators.
`strict`|`boolean` | Require branches to be up to date before merging.
`contexts`|`array` | The list of status checks to require in order to merge into this branch

### Example

<%= json \
  "include_admins" => true,
  "strict" => true,
  "contexts" => ["continuous-integration/travis-ci"]
%>

### Response

<%= headers 200 %>
<%= json(:repo_branch_protection_required_status_checks) %>

## Remove required status checks of protected branch

    DELETE /repos/:owner/:repo/branches/:branch/protection/required_status_checks

<%= headers 204 %>

## List required status checks contexts of protected branch

    GET /repos/:owner/:repo/branches/:branch/protection/required_status_checks/contexts

<%= headers 200 %>
<%= json ["continuous-integration/travis-ci"] %>

## Replace required status checks contexts of protected branch

    PUT /repos/:owner/:repo/branches/:branch/protection/required_status_checks/contexts

### Example

<%= json ["continuous-integration/travis-ci"] %>

### Response

<%= headers 200 %>
<%= json ["continuous-integration/travis-ci"] %>

## Add required status checks contexts of protected branch

    POST /repos/:owner/:repo/branches/:branch/protection/required_status_checks/contexts

### Example

<%= json ["continuous-integration/jenkins"] %>

### Response

<%= headers 200 %>
<%= json ["continuous-integration/travis-ci", "continuous-integration/jenkins"] %>

## Remove required status checks contexts of protected branch

    DELETE /repos/:owner/:repo/branches/:branch/protection/required_status_checks/contexts

### Example

<%= json ["continuous-integration/jenkins"] %>

### Response

<%= headers 200 %>
<%= json ["continuous-integration/travis-ci"] %>


## Get restrictions of protected branch

{{#tip}}

Teams and users `restrictions` are only available for organization-owned repositories.

{{/tip}}

    GET /repos/:owner/:repo/branches/:branch/protection/restrictions

<%= headers 200 %>
<%= json(:repo_branch_protection_restrictions) %>

## Remove restrictions of protected branch

    DELETE /repos/:owner/:repo/branches/:branch/protection/restrictions

<%= headers 204 %>

## List team restrictions of protected branch

    GET /repos/:owner/:repo/branches/:branch/protection/restrictions/teams

<%= headers 200 %>
<%= json(:team) { |h| [h] } %>

## Replace team restrictions of protected branch

    PUT /repos/:owner/:repo/branches/:branch/protection/restrictions/teams

### Body parameters

Pass the list of team `slug`s with push access.

{{#tip}}

  The list of users and teams in total is limited to 100 items.

{{/tip}}

### Example

<%= json ["justice-league"] %>

### Response

<%= headers 200 %>
<%= json(:team) { |h| [h] } %>

## Add team restrictions of protected branch

    POST /repos/:owner/:repo/branches/:branch/protection/restrictions/teams

### Body parameters

Pass the list of team `slug`s with push access.

{{#tip}}

The list of users and teams in total is limited to 100 items.

{{/tip}}

### Example

<%= json ["justice-league"] %>

### Response

<%= headers 200 %>
<%= json(:team) { |h| [h] } %>

## Remove team restrictions of protected branch

    DELETE /repos/:owner/:repo/branches/:branch/protection/restrictions/teams

### Example

<%= json ["octocats"] %>

### Response

<%= headers 200 %>
<%= json(:team) { |h| [h] } %>


## List user restrictions of protected branch

    GET /repos/:owner/:repo/branches/:branch/protection/restrictions/users

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Replace user restrictions of protected branch

    PUT /repos/:owner/:repo/branches/:branch/protection/restrictions/users

### Body parameters

Pass the list of user `login`s with push access.

{{#tip}}

The list of users and teams in total is limited to 100 items.

{{/tip}}

### Example

<%= json ["octocat"] %>

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Add user restrictions of protected branch

    POST /repos/:owner/:repo/branches/:branch/protection/restrictions/users

### Body parameters

Pass the list of user `login`s with push access.

{{#tip}}

The list of users and teams in total is limited to 100 items.

{{/tip}}

### Example

<%= json ["octocat"] %>

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Remove user restrictions of protected branch

    DELETE /repos/:owner/:repo/branches/:branch/protection/restrictions/users

### Example

<%= json ["defunkt"] %>

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>


{% endif %}
