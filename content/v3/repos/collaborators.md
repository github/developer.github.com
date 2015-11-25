---
title: Collaborators | GitHub API
---

# Collaborators

* TOC
{:toc}

## List collaborators {#list}

    GET /repos/:owner/:repo/collaborators

When authenticating as an organization owner of an organization-owned
repository, all organization owners are included in the list of collaborators.
Otherwise, only users with access to the repository are returned in the
collaborators list.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user) { |h| [h] } %>

### Alternative response with extra repository information

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>
</div>

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:collaborator) { |h| [h] } %>

## Check if a user is a collaborator {#get}

    GET /repos/:owner/:repo/collaborators/:username

### Response if user is a collaborator

<%= headers 204 %>

### Response if user is not a collaborator

<%= headers 404 %>

## Add user as a collaborator {#add-collaborator}

    PUT /repos/:owner/:repo/collaborators/:username

### Parameters

Name | Type | Description
-----|------|--------------
`permission`|`string` | The permission to grant the team. **Only valid on organization-owned repositories.** Can be one of:<br/> * `pull` - can pull, but not push to or administer this repository.<br/> * `push` - can pull and push, but not administer this repository.<br/> * `admin` -  can pull, push and administer this repository.<br/>Default: `push`<br/>**This parameter requires a custom media type to be specified. Please see more in the alert below.**

<%= fetch_content(:optional_put_content_length) %>

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>

  <p>
    <strong>Warning:</strong> If you use this API to add a collaborator to a repository that's owned by an organization that hasn't had <a href="https://github.com/blog/2020-improved-organization-permissions">improved organization permissions</a> enabled yet, you will get a <code>422</code> error response.
  </p>
</div>

### Response

<%= headers 204 %>

## Remove user as a collaborator {#remove-collaborator}

    DELETE /repos/:owner/:repo/collaborators/:username

### Response

<%= headers 204 %>
