---
title: Issue Assignees | GitHub API
---

# Assignees API

* TOC
{:toc}

## List assignees

This call lists all the available assignees (owner + collaborators) to which
issues may be assigned.

    GET /repos/:owner/:repo/assignees

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Check assignee

You may also check to see if a particular user is an assignee for a repository.

    GET /repos/:owner/:repo/assignees/:assignee

### Response

If the given `assignee` login belongs to an assignee for the repository, a
`204` header with no content is returned.

<%= headers 204 %>

Otherwise a `404` status code is returned.

<%= headers 404 %>
