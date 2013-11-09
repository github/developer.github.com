---
title: Issue Milestones | GitHub API
---

# Milestones API

* TOC
{:toc}

## List milestones for a repository

    GET /repos/:owner/:repo/milestones

### Parameters

Name | Type | Description | Default
----|------|--------------|---------
`state`|`string` | The state of the milestone. Either `open` or `closed`.|`open`
`sort`|`string` | What to sort results by. Either `due_date` or `completeness`.|`due_date`
`direction`|`string` | The direction of the sort. Either `asc` or `desc`.|`asc`


### Response

<%= headers 200, :pagination => true %>
<%= json(:milestone) { |h| [h] } %>

## Get a single milestone

    GET /repos/:owner/:repo/milestones/:number

### Response

<%= headers 200 %>
<%= json :milestone %>

## Create a milestone

    POST /repos/:owner/:repo/milestones

### Input

Name | Type | Description | Default
----|------|--------------|---------
`title`|`string` | **Required**. The title of the milestone.|
`state`|`string` | The state of the milestone. Either `open` or `closed`.|`open`
`description`|`string` | A description of the milestone.|
`due_on`|`string` | The milestone due date. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.|

#### Example

<%= json \
  :title => "String",
  :state => "open or closed",
  :description => "String",
  :due_on => "2012-10-09T23:39:01Z"
%>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/user/repo/milestones/1" %>
<%= json :milestone %>

## Update a milestone

    PATCH /repos/:owner/:repo/milestones/:number

### Input

Name | Type | Description | Default
----|------|--------------|---------
`title`|`string` | The title of the milestone.|
`state`|`string` | The state of the milestone. Either `open` or `closed`.|`open`
`description`|`string` | A description of the milestone.|
`due_on`|`string` | The milestone due date. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.|

#### Example

<%= json \
  :title => "String",
  :state => "open or closed",
  :description => "String",
  :due_on => "Time"
%>

### Response

<%= headers 200 %>
<%= json :milestone %>

## Delete a milestone

    DELETE /repos/:owner/:repo/milestones/:number

### Response

<%= headers 204 %>

