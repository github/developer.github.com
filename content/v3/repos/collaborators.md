---
title: Collaborators
---

# Collaborators

{:toc}

<a id="list" />

## List collaborators

    GET /repos/:owner/:repo/collaborators

When authenticating as an organization owner of an organization-owned
repository, all organization owners are included in the list of collaborators.
Otherwise, only users with access to the repository are returned in the
collaborators list.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user) { |h| [h] } %>

### Alternative response with extra repository information

{{#tip}}

We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the [blog post](/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/) for full details.

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

```
application/vnd.github.ironman-preview+json
```

{{/tip}}

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:collaborator) { |h| [h] } %>

## Check if a user is a collaborator

    GET /repos/:owner/:repo/collaborators/:username

### Response if user is a collaborator

<%= headers 204 %>

### Response if user is not a collaborator

<%= headers 404 %>

## Add user as a collaborator

    PUT /repos/:owner/:repo/collaborators/:username

### Parameters

Name | Type | Description
-----|------|--------------
`permission`|`string` | The permission to grant the team. **Only valid on organization-owned repositories.** Can be one of:<br/> * `pull` - can pull, but not push to or administer this repository.<br/> * `push` - can pull and push, but not administer this repository.<br/> * `admin` -  can pull, push and administer this repository.<br/>Default: `push`<br/>**This parameter requires a custom media type to be specified. Please see more in the alert below.**

<%= fetch_content(:optional_put_content_length) %>


{{#tip}}

We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the [blog post](/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/) for full details.

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

```
application/vnd.github.ironman-preview+json
```

**Warning:** If you use this API to add a collaborator to a repository that's owned by an organization that hasn't had [improved organization permissions](https://github.com/blog/2020-improved-organization-permissions) enabled yet, you will get a `422` error response.

{{/tip}}

### Response

<%= headers 204 %>

## Remove user as a collaborator

    DELETE /repos/:owner/:repo/collaborators/:username

### Response

<%= headers 204 %>
