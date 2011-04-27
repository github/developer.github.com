---
title: Gists API v3 | dev.github.com
---

# Gists API

The Gist API v3 has been unified into the core GitHub API and can be
accessed via the domain api.github.com. SSL is required so the base url
for all API calls should be: `https://api.github.com`.
Please see the [overview](/v3/) for a complete description of the API
including information about data format and authentication.

## List a user's gists

    GET /users/:user/gists.json

### Response

<pre class="highlight"><code class="language-javascript">
[
  {
    "url": "https://api.github.com/gists/890753.json",
    "comments": 0,
    "repo": "890753",
    "description": "API design thoughts for libgit2sharp",
    "created_at": "2011-03-28T16:18:16Z",
    "public": true,
    "files": {
      "libgit2sharp.cs": {
        "raw_url": "https://gist.github.com/raw/890753/013ef351a2bb25462ad50f82ee410f5786033341/libgit2sharp.cs",
        "size": 1696,
        "filename": "libgit2sharp.cs"
      }
    },
    "git_pull_url": "git://gist.github.com/890753.git",
    "git_push_url": "git@gist.github.com:890753.git",
    "user": {
      "email": "timothy.clem@gmail.com",
      "type": "User",
      "url": "https://api.github.com/users/tclem.json",
      "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
      "created_at": "2009-10-07T20:26:53Z",
      "blog": "http://timclem.wordpress.com",
      "login": "tclem",
      "name": "Tim Clem",
      "company": "GitHub",
      "location": "San Francisco, CA"
    },
    "id": "890753"
  }, ...
]
</code></pre>

## Get a single gist

   GET /gists/:id.json

### Response

<pre class="highlight"><code class="language-javascript">
{
  "url": "https://api.github.com/gists/365370.json",
  "comments": 0,
  "repo": "365370",
  "description": null,
  "created_at": "2010-04-14T02:15:15Z",
  "public": true,
  "git_pull_url": "git://gist.github.com/365370.git",
  "history": [
    {
      "url": "https://api.github.com/gists/365370/57a7f021a713b1c5a6a199b54cc514735d2d462f.json",
      "version": "57a7f021a713b1c5a6a199b54cc514735d2d462f",
      "committed_at": "2010-04-14T02:15:15Z",
      "user": {
        "email": "timothy.clem@gmail.com",
        "type": "User",
        "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
        "url": "https://api.github.com/users/tclem.json",
        "created_at": "2009-10-07T20:26:53Z",
        "blog": "http://timclem.wordpress.com",
        "login": "tclem",
        "name": "Tim Clem",
        "company": "GitHub",
        "location": "San Francisco, CA"
      },
      "change_status": {
        "deletions": 0,
        "additions": 180,
        "total": 180
      }
    }
  ],
  "files": {
    "ring.erl": {
      "content": "<details ommitted for clarity>",
      "size": 932,
      "filename": "ring.erl",
      "raw_url": "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
    },
    "ring.cs": {
      "content": "<details ommitted for clarity>",
      "size": 3153,
      "filename": "ring.cs",
      "raw_url": "https://gist.github.com/raw/365370/163b3e49f9959154722c1973155bd8042abd1802/ring.cs"
    }
  },
  "git_push_url": "git@gist.github.com:365370.git",
  "user": {
    "email": "timothy.clem@gmail.com",
    "type": "User",
    "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "url": "https://api.github.com/users/tclem.json",
    "created_at": "2009-10-07T20:26:53Z",
    "blog": "http://timclem.wordpress.com",
    "login": "tclem",
    "name": "Tim Clem",
    "company": "GitHub",
    "location": "San Francisco, CA"
  },
  "id": "365370"
}
</code></pre>

## Create a new gist

    POST /users/:user/gists.json

<pre class="highlight"><code class="language-javascript">
{
  "description": "the description for this gist",
  "public": true|false,
  "files": {
    "file1.txt": {
      "content": "file content goes here"
    }
    ...
  }
}
</code></pre>

### Response

<pre class="highlight"><code class="language-javascript">
{
  "url": "https://api.github.com/gists/922168.json",
  "comments": 0,
  "repo": "922168",
  "git_pull_url": "git://gist.github.com/922168.git",
  "description": "new gist",
  "created_at": "2011-04-15T18:12:02Z",
  "public": true,
  "git_push_url": "git@gist.github.com:922168.git",
  "history": [
    {
      "url": "https://api.github.com/gists/922168/a67e6a66274f335c45f65fd0023eee3668b51dce.json",
      "version": "a67e6a66274f335c45f65fd0023eee3668b51dce",
      "change_status": {
        "deletions": 0,
        "additions": 1,
        "total": 1
      },
      "user": {
        "email": "timothy.clem@gmail.com",
        "type": "User",
        "url": "https://api.github.com/users/tclem.json",
        "created_at": "2009-10-07T20:26:53Z",
        "blog": "http://timclem.wordpress.com",
        "login": "tclem",
        "name": "Tim Clem",
        "company": "GitHub",
        "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
        "location": "San Francisco, CA"
      },
      "committed_at": "2011-04-15T18:12:02Z"
    }
  ],
  "files": {
    "file1.txt": {
      "content": "this is a file",
      "size": 14,
      "filename": "file1.txt",
      "raw_url": "https://gist.github.com/raw/922168/21e64d50b2aa18cc1a62ba1be2d568f85f053903/file1.txt"
    }
  },
  "user": {
    "email": "timothy.clem@gmail.com",
    "type": "User",
    "url": "https://api.github.com/users/tclem.json",
    "created_at": "2009-10-07T20:26:53Z",
    "blog": "http://timclem.wordpress.com",
    "login": "tclem",
    "name": "Tim Clem",
    "company": "GitHub",
    "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "location": "San Francisco, CA"
  },
  "id": "922168"
}
</code></pre>

## Edit a gist

    PUT /gists/:id.json

<pre class="highlight"><code class="language-javascript">
{
  "description": "update description for this gist",
  "files": {
    "file2.txt": {
      "content": "file content goes here"
    }
    ...
  }
}
</code></pre>

### Response

<pre class="highlight"><code class="language-javascript">
{
  "url": "https://api.github.com/gists/922688.json",
  "comments": 0,
  "repo": "922688",
  "description": "add a file",
  "created_at": "2011-04-16T00:17:52Z",
  "public": true,
  "files": {
    "file1.txt": {
      "size": 14,
      "filename": "file1.txt",
      "raw_url": "https://gist.github.com/raw/922688/21e64d50b2aa18cc1a62ba1be2d568f85f053903/file1.txt"
    }
  },
  "git_pull_url": "git://gist.github.com/922688.git",
  "user": {
    "email": "timothy.clem@gmail.com",
    "type": "User",
    "url": "https://api.github.com/users/tclem.json",
    "created_at": "2009-10-07T20:26:53Z",
    "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "blog": "http://timclem.wordpress.com",
    "login": "tclem",
    "name": "Tim Clem",
    "company": "GitHub",
    "location": "San Francisco, CA"
  },
  "git_push_url": "git@gist.github.com:922688.git",
  "id": "922688"
}
</code></pre>

## Delete a gist

   DELETE /gists/:id.json

### Response

<pre class="highlight"><code class="language-javascript">
{}
</code></pre>
