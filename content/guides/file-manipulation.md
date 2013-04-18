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

    require 'octokit'

    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    login = ENV['GH_LOGIN']
    password = ENV['GH_LOGIN_PASSWORD']
    repo = "gjtorikian/crud-test"

    client = Octokit::Client.new(:login => login, :password => password)

    client.create_contents(repo, 'test/test.txt', :content => "Here's some new content"
                                                  :message => "My :cool: commit message")

Note that if a sub-directory doesn't exist, the API will create it for you.

Now, here's the same action using the low-level git API:

    require 'octokit'
     
    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    login = ENV['GH_LOGIN']
    password = ENV['GH_LOGIN_PASSWORD']
    repo = "gjtorikian/crud-test"
     
    client = Octokit::Client.new(:login => login, :password => password)
     
    # grab the current master branch
    master = client.ref(repo, "heads/master")
     
    # Create and return a tree from the path and content pointed
    new_tree = client.create_tree(repo,
        [{path: "test/test.txt", mode: "100644", type: "blob", content: "Here's some new content"}],
        {base_tree: master.object.sha})
     
    # Create a commit with the tree, and a commit message
    new_commit = client.create_commit(repo, "My :cool: commit message", new_tree.sha, master.object.sha)
     
    # Point the master branch to this new commit
    client.update_ref(repo, "heads/master", new_commit.sha)

You can see how much more verbose this option is.

## Updating Files

In order to update a file in a repository, you'll need to know both the file's 
path, as well as its SHA hash. In order to determine the SHA, you'll need to calculate
it [the same way that git does][git-sha-calc]. In Ruby, updating a file with the
API might look like this:

    require 'octokit'
    require 'digest/sha1'
    
    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    login = ENV['GH_LOGIN']
    password = ENV['GH_LOGIN_PASSWORD']
    repo = "gjtorikian/crud-test"
    
    client = Octokit::Client.new(:login => login, :password => password)
    contents = "I changed the contents"

    header = "blob #{contents.size}\0#{contents}"
    sha1 = Digest::SHA1.hexdigest(header)
    
    client.update_contents(repo, 'test/test.txt', :content => contents,
                                              :sha => sha1,
                                              :message => "My next :cool: commit message")


For the low-level git API, you don't need to provide the SHA; in fact, you can use
the same code as creating a file. Just provide some new content and you're good to go.

## Deleting Files

Deleting a file is just as easy. We're going to call the `DELETE` method on a file
path. Once again, you need to provide the SHA of the file you want deleted. Here's how it'd 
look in Ruby:

    require 'octokit'
    require 'digest/sha1'

    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    login = ENV['GH_LOGIN']
    password = ENV['GH_LOGIN_PASSWORD']
    repo = "gjtorikian/crud-test"

    client = Octokit::Client.new(:login => login, :password => password)
    contents = "I changed the contents"

    header = "blob #{contents.size}\0#{contents}"
    sha1 = Digest::SHA1.hexdigest(header)

    client.delete_contents(repo, 'test/test.txt', :sha => sha1,
                                                  :message => "My next :cool: commit message")

Now, deleting a file with the low-level git API is slightly more complicated, especially
if the file is in a subpath. We'll need to:

* Fetch the root tree
* Grab the contents of a directory
* Construct a tree with the removed file
* Create a new commit
* Point master to the commit

Here's how that might look:

    #!/usr/bin/env ruby
    require 'octokit'
     
    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    login = ENV['GH_LOGIN']
    password = ENV['GH_LOGIN_PASSWORD']
    repo = "gjtorikian/crud-test"
     
    master = client.ref(repo, "heads/master")
     
    root_tree = client.tree(repo, master.object.sha)
    subdir_name = "test"
     
    # grab blob with matching subdir name
    subdir_blob = root_tree.tree.detect { |blob| blob["path"] == subdir_name }
    subdir_sha = subdir_blob.sha
     
    # remove the requested file from that subdir's tree
    removed_tree = client.tree(repo, subdir_sha).tree.reject {|blob| blob.path == "test.txt" }
     
    # create a new subdir blob with the file removed
    new_tree = client.create_tree(repo, removed_tree)
     
    # with the magic of pass by reference, replace
    # the root tree's subdir_blob sha with the newly created one
    subdir_blob.sha = new_tree.sha
     
    # create a new root tree (since we changed the subdir_blob)
    new_root_tree = client.create_tree(repo, root_tree.tree)
     
    # commit against master
    new_commit = client.create_commit(repo, "Removing file from subdir", new_root_tree.sha, master.object.sha)
     
    client.update_ref(repo, "heads/master", new_commit.sha)

[git-sha-calc]: http://stackoverflow.com/questions/552659/assigning-git-sha1s-without-git/552725#552725
