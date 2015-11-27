---
title: Migrations | GitHub API
---

# Migrations

* TOC
{:toc}

{{#enterprise-only}}

{{#warning}}

This API is not currently available on GitHub Enterprise.

{{/warning}}

{{/enterprise-only}}

{{#tip}}

  To access the Migrations API, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.wyandotte-preview+json

{{/tip}}

## Start a migration

Initiates the generation of a migration archive.

    POST /orgs/:org/migrations

### Parameters

Name    | Type    | Description
--------|---------|--------------
`repositories` | `array` of `strings` | **Required**. A list of arrays indicating which repositories should be migrated.
`lock_repositories`|`boolean` | Indicates whether repositories should be locked (to prevent manipulation) while migrating data. Default: `false`.
`exclude_attachments`|`boolean` | Indicates whether attachments should be excluded from the migration (to reduce migration archive file size). Default: `false`.

### Example

<%= json \
  :repositories       => ["octocat/Hello-World"],
  :lock_repositories  => true
%>

### Response

<%= headers 201 %>
<%= json(:migrations) %>

## Get a list of migrations

Lists the most recent migrations.

    GET /orgs/:org/migrations

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:migrations) { |h| [h] } %>

## Get the status of a migration

Fetches the status of a migration.

    GET /orgs/:org/migrations/:id

### Response

The `state` of a migration can be one of the following values:

* `pending`, which means the migration hasn't started yet.
* `exporting`, which means the migration is in progress.
* `exported`, which means the migration finished successfully.
* `failed`, which means the migration failed.

<%= headers 200 %>
<%= json(:migrations) { |h| h['state'] = 'exported'; h } %>

## Download a migration archive

Fetches the URL to a migration archive.

    GET /orgs/:org/migrations/:id/archive

### Response

<%= headers 302 %>
<pre class="body-response"><code>
https://s3.amazonaws.com/github-cloud/migration/79/67?response-content-disposition=filename%3D0b989ba4-242f-11e5-81e1.tar.gz&response-content-type=application/x-gzip
</code></pre>

## Delete a migration archive

Deletes a previous migration archive. Migration archives are automatically deleted after seven days.

    DELETE /orgs/:org/migrations/:id/archive

### Response

<%= headers 204 %>

## Unlock a repository

Unlocks a repository that was locked for migration. You should unlock each migrated repository and [delete them](/v3/repos/#delete-a-repository) when the migration is complete and you no longer need the source data.

    DELETE /orgs/:org/migrations/:id/repos/:repo_name/lock

### Response

<%= headers 204 %>
