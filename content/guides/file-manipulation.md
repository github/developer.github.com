---
title: File Manipulation | GitHub API
---

# File Manipulation

* TOC
{:toc}

With the GitHub API, you can create, modify, and delete files that are stored
in repositories you have access to. There are two ways to accomplish your goals:

* Using [the Repo Contents API](/v3/repos/contents/)
* Using [the low-level Git API](/v3/git/)

Your choice of which to use depends on what you're trying to accomplish.
The Repo Contents API is far easier to use, while the low-level API enables you to
have more precise control over your updates. 

This guide will focus almost entirely on the Repo Contents API. We'll provide corresponding
gists (with comments) for the low-level git work.

## Creating files

To create a file, you'll perform an HTTP `PUT` request. The URL is the repository
and path where you want to create the file. The path is relative to the top-level
directory.

For example, to create a new file on the `master` branch, called _test.txt_ in 
a sub-directory called _test_, using Ruby, you'd do something like this:


```ruby
require 'octokit'

# !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
login = ENV['GH_LOGIN']
password = ENV['GH_LOGIN_PASSWORD']
repo = "gjtorikian/crud-test"

client = Octokit::Client.new(:login => login, :password => password)

client.create_contents(repo, 'test/test.txt', "Oh I'm just testing some file.")
```

Note that if a sub-directory doesn't exist, the API will create it for you.

Now, here's the same action using the low-level git API:

<script src="https://gist.github.com/gjtorikian/5398906.js"></script>

## Updating Files

In order to update a file in a repository, you'll need to know both the file's 
path, as well as its SHA code. Retrieving the SHA is as simple as querying the
file contents; the SHA comes back as part of the resulting hash:

```ruby
require 'octokit'

# !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
login = ENV['GH_LOGIN']
password = ENV['GH_LOGIN_PASSWORD']
repo = "gjtorikian/crud-test"

client = Octokit::Client.new(:login => login, :password => password)
contents = client.contents(repo, :path => 'test/text.txt')

client.update_contents(repo, contents.sha, 'test/test.txt', "Oh I'm just testing some file.")
```

For the low-level git API, you don't need to provide the SHA; in fact, you can use
the same code as creating a file

## Deleting Files

Deleting a file is just as easy. We're going to call the `DELETE` method on a file
path. Once again, provide the SHA of the file you want deleted. Here's how it'd 
look in Ruby:

```ruby
require 'octokit'

# !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
login = ENV['GH_LOGIN']
password = ENV['GH_LOGIN_PASSWORD']
repo = "gjtorikian/crud-test"

client = Octokit::Client.new(:login => login, :password => password)
contents = client.contents(repo, :path => 'test/text.txt')

client.delete_contents(repo, contents.sha, 'test/test.txt', "Oh I'm just testing some file.")
```

Now, deleting a file with the low-level git API is slightly more complicated. 
We'll need to:

* Fetch the root tree
* Grab the contents of a directory
* Construct a tree with the removed file
* Create a new commit
* Point master to the commit

Here's how that might look:

<script src="https://gist.github.com/gjtorikian/5208350.js"></script>