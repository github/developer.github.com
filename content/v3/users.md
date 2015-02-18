---
title: Users | GitHub API
---

# Users

* TOC
{:toc}

Many of the resources on the users API provide a shortcut for getting
information about the currently authenticated user. If a request URL
does not include a `:username` parameter then the response will be for the
logged in user (and you must pass [authentication
information](/v3/#authentication) with your request).

## Get a single user

    GET /users/:username

### Response

<%= headers 200 %>
<%= json :full_user %>

Note: The returned email is the user's publicly visible email address
(or `null` if the user has not [specified a public email address in their profile](https://github.com/settings/profile)).

## Get the authenticated user

    GET /user

### Response

<%= headers 200 %>
<%= json :private_user %>

## Update the authenticated user

    PATCH /user

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | The new name of the user
`email`|`string` | Publicly visible email address.
`blog`|`string` | The new blog URL of the user.
`company`|`string` | The new company of the user.
`location`|`string` | The new location of the user.
`hireable`|`boolean` | The new hiring availability of the user.
`bio`|`string` | The new short biography of the user.

#### Example

<%= json \
    :name     => "monalisa octocat",
    :email    => "octocat@github.com",
    :blog     => "https://github.com/blog",
    :company  => "GitHub",
    :location => "San Francisco",
    :hireable => true,
    :bio      => "There once..."
%>

### Response

<%= headers 200 %>
<%= json :private_user %>

## Get all users

This provides a dump of every user, in the order that they signed up for
GitHub.

Note: Pagination is powered exclusively by the `since` parameter.
Use the [Link header](/v3/#link-header) to get the URL for the next page of
users.

    GET /users

### Parameters

Name | Type | Description
-----|------|--------------
`since`|`string`| The integer ID of the last User that you've seen.


### Response

<%= headers 200, :pagination => { :next => 'https://api.github.com/users?since=135' } %>
<%= json(:user) { |h| [h] } %>
