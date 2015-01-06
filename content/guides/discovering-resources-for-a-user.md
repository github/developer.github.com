---
title: Discovering resources for a user | GitHub API
---

TODO: Mention pagination

# Discovering resources for a user

* TOC
{:toc}

When making authenticated requests to the GitHub API, applications often need to fetch the current user's repositories and organizations. In this guide, will explain how to reliably discover those resources.

To interact with the GitHub API, we'll be using [Octokit.rb][octokit.rb]. You can find the complete source code for this project in the [platform-samples][platform samples] repository.

## Getting started

If you haven't already, you should read the ["Basics of Authentication"][basics-of-authentication] guide before working through the examples below. The examples below assume that you have [registered an OAuth application][register-oauth-app] and that your [application has an OAuth token for a user][make-authenticated-request-for-user].

## Discover the repositories that your app can access for a user

In addition to having their own personal repositories, a user may be a collaborator on repositories owned by other users and organizations. Collectively, these are the repositories where the user has privileged access: either it's a private repository where the user has read or write access, or it's a public repository where the user has write access.

[OAuth scopes](/v3/oauth/#scopes) and [organization application policies](#todo) determine which of those repositories your app can access for a user. Use the workflow below to discover those repositories.

As always, first we'll require [GitHub's Octokit.rb][octokit.rb] Ruby library. Then, we'll pass in our application's [OAuth token for a given user][make-authenticated-request-for-user]:

    #!ruby
    require 'octokit'

    # TODO Explain why this is needed.
    Octokit.default_media_type = "application/vnd.github.moondragon-preview+json"

    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    # Instead, set and test environment variables, like below.
    client = Octokit::Client.new :access_token => ENV["OAUTH_ACCESS_TOKEN"]

Next, we'll hit the [root endpoint][root endpoint] to get the [hypermedia][hypermedia] URL for the repositories that our application can access for the user:

    #!ruby
    repositories_url = client.root.rels[:current_user_repositories].href

Then, we'll use that URL to fetch the repositories. We'll rely on Octokit.rb to handle [pagination][pagination] for us:

    #!ruby
    repositories = client.paginate(repositories_url)

Once we have the repositories, we can iterate over them to discover information useful to our application:

    #!ruby
    repositories.each do |repository|
      full_name = repository[:full_name]
      has_push_access = repository[:permissions][:push]

      access_type = if has_push_access
                      "write"
                    else
                      "read-only"
                    end

      puts "User has #{access_type} access to #{full_name}."
    end

## Discover the organizations that your app can access for a user

Applications can perform all sorts of organization-related tasks for a user. To perform these tasks, the app needs an [OAuth authorization](/v3/oauth/#scopes) with sufficient permission (e.g., you can [list teams](/v3/orgs/teams/#list-teams) with `read:org` scope, you can [publicize the user’s organization membership](/v3/orgs/members/#publicize-a-users-membership) with `user` scope, etc.). Once a user has granted one or more of these scopes to your app, you're ready to fetch the user’s organizations.

Just as we did when discovering repositories above, we'll start by requiring [GitHub's Octokit.rb][octokit.rb] Ruby library. Then, we'll pass in our application's [OAuth token for a given user][make-authenticated-request-for-user]:

    #!ruby
    require 'octokit'

    # TODO Explain why this is needed.
    Octokit.default_media_type = "application/vnd.github.moondragon-preview+json"

    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    # Instead, set and test environment variables, like below.
    client = Octokit::Client.new :access_token => ENV["OAUTH_ACCESS_TOKEN"]

Now, we'll access the [root endpoint][root endpoint] to fetch the [hypermedia][hypermedia] relation for the organizations that our application can access for the user:

    #!ruby
    organizations_relation = client.root.rels[:user_organizations]

Then, we can use that relation to get the organizations:

    #!ruby
    organizations_relation.get.data.each do |organization|
      puts "User belongs to the #{organization[:login]} organization."
    end

### Don’t rely on public organizations

If you've read the docs from cover to cover, you may have noticed an [API method for listing a user's public organization memberships](/v3/orgs/#list-user-organizations). Most applications should avoid this API method. This method only returns the user's public organization memberships, not their private organization memberships.

As an application, you typically want all of the user's organizations (public and private) that your app is authorized to access. The workflow above will give you exactly that.

[basics-of-authentication]: /guides/basics-of-authentication/
[hypermedia]: /v3/#hypermedia
[make-authenticated-request-for-user]: /guides/basics-of-authentication/#making-authenticated-requests
[octokit.rb]: https://github.com/octokit/octokit.rb
[pagination]: /v3/#pagination
[platform samples]: https://github.com/github/platform-samples/tree/master/api/ruby/discovering-resources-for-a-user
[register-oauth-app]: /guides/basics-of-authentication/#registering-your-app
[root endpoint]: /v3/#root-endpoint
