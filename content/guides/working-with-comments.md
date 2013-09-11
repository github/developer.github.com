---
title: Working with Comments | GitHub API
---

# Working with Comments

* TOC
{:toc}

For any Pull Request, GitHub provides three different kinds of comment views:
[comments on the Pull Request][PR comment], [comments on an entire commit][entire commit comment],
and [comments on a specific line in a committed file][single comment].

Each of these types of comments goes through a different portion of the GitHub API.
In this guide, we'll explore how you can access and manipulate each one. For every
example, we'll be using [this sample Pull Request made][sample PR] on the "octocat"
repository. As always, samples can be found in [our platform-samples repository][platform-samples].

## Pull Request Comments

To access comments on a Pull Request, you'll go through [the Issues API][issues].
This may seem counterintuitive at first. But once you understand that a Pull
Request is just an Issue with code, it makes sense to use the Issues API to
create comments on a Pull Request.

We'll demonstrate fetching Pull Request comments by creating a Ruby script using
[Octokit.rb][octokit.rb]. You'll also want to create a [personal access token][personal token].

The following code should help you get started accessing comments from a Pull Request
using Octokit.rb:

    require 'octokit'

    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    # Instead, set and test environment variables, like below
    client = Octokit::Client.new :access_token => ENV['MY_PERSONAL_TOKEN']

    client.issue_comments("octocat/Spoon-Knife", 1176).each do |comment|
      username = comment[:user][:login]
      post_date = comment[:created_at]
      content = comment[:body]

      puts "#{username} made a comment on #{post_date}. It says:\n'#{content}'\n"
    end

Here, we're specifically calling out to the Issues API to get the comments (`issue_comments`),
providing both the repository's name (`octocat/Spoon-Knife`), and the Pull Request ID
we're interested in (`1176`). After that, it's simply a matter of iterating through
the comments to fetch information about each one.

## Comments on a diff

Within the diff view, you can start a discussion on a particular aspect of a singular
change made within the Pull Request. This is vastly different than commenting on a
single line in a commit, because it deals with the entirety of the Pull Request.
For that reason, the endpoint URL for this discussion comes from [the Pull Request Review API][PR Review API].

The following code fetches all the Pull Review comments made, givn a single Pull Request number:

    require 'octokit'

    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    # Instead, set and test environment variables, like below
    client = Octokit::Client.new :access_token => ENV['MY_PERSONAL_TOKEN']

    client.pull_request_comments("octocat/Spoon-Knife", 1176).each do |comment|
      username = comment[:user][:login]
      post_date = comment[:created_at]
      content = comment[:body]

      puts "#{username} made a comment on #{post_date}. It says:\n'#{content}'\n"
    end

You'll notice that it's incredibly similar to the example above. The difference
between this view and the Pull Request comment is the focus of the conversation.
A comment made on a Pull Request should be reserved for discussion or ideas on
the direction of the code. A comment made as pat of a Pull Request review should
deal specifically with he way a particular change was implemented.

## Commenting on commits

The last type of comments occur specifically on single commits. For this reason,
they make use of [the commit comment API][commit comment API].

To retrieve the comments on a commit, you'd want to use the SHA1 of the commit,
as opposed to any identifier related to the Pull Request. Here's an example:

    require 'octokit'

    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    # Instead, set and test environment variables, like below
    client = Octokit::Client.new :access_token => ENV['MY_PERSONAL_TOKEN']

    client.commit_comments("octocat/Spoon-Knife", "cbc28e7c8caee26febc8c013b0adfb97a4edd96e").each do |comment|
      username = comment[:user][:login]
      post_date = comment[:created_at]
      content = comment[:body]

      puts "#{username} made a comment on #{post_date}. It says:\n'#{content}'\n"
    end

Note that this API call will retrieve single line comments, as well as comments made
on the entire commit.

[PR comment]: https://github.com/octocat/Spoon-Knife/pull/1176#issuecomment-24114792
[entire commit comment]: https://github.com/octocat/Spoon-Knife/pull/1176#discussion_r6252889
[single comment]: https://github.com/octocat/Spoon-Knife/commit/cbc28e7c8caee26febc8c013b0adfb97a4edd96e#commitcomment-4049848
[sample PR]: https://github.com/octocat/Spoon-Knife/pull/1176
[platform-samples]: https://github.com/github/platform-samples/tree/master/api/ruby/working-with-comments
[issues]: http://developer.github.com/v3/issues/comments/
[personal token]: https://help.github.com/articles/creating-an-access-token-for-command-line-use
[octokit.rb]: https://github.com/octokit/octokit.rb
[PR Review API]: http://developer.github.com/v3/pulls/comments/
[commit comment API]: http://developer.github.com/v3/repos/comments/#get-a-single-commit-comment
