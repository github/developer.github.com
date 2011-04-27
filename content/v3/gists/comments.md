---
title: Gist Comments API v3 | dev.github.com
---

# Gist Comments API

## List

    GET https://api.github.com/gists/:id/comments.json

### Response

<pre class="highlight"><code class="language-javascript">
[
  {
    "url": "https://api.github.com/gists/comments/27658.json",
    "created_at": "2011-04-18T23:23:10Z",
    "body": "Love this gist thing.",
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
    "id": 27658
  }, ...
]
</code></pre>

## Get

    GET /gists/comments/:id.json

### Response

<pre class="highlight"><code class="language-javascript">
{
  "url": "https://api.github.com/gists/comments/27660.json",
  "created_at": "2011-04-18T23:23:56Z",
  "body": "Just commenting for the sake of commenting",
  "user": {
    "email": "timothy.clem@gmail.com",
    "type": "User",
    "url": "https://api.github.com/users/tclem.json",
    "created_at": "2009-10-07T20:26:53Z",
    "login": "tclem",
    "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "blog": "http://timclem.wordpress.com",
    "name": "Tim Clem",
    "company": "GitHub",
    "location": "San Francisco, CA"
  },
  "id": 27660
}
</code></pre>

## Create

    POST /gists/365370/comments.json

### Response

<pre class="highlight"><code class="language-javascript">
    {
      "url": "https://api.github.com/gists/comments/27669.json",
      "created_at": "2011-04-18T23:44:35Z",
      "body": "a new comment",
      "user": {
        "email": "timothy.clem@gmail.com",
        "type": "User",
        "url": "https://api.github.com/users/tclem.json",
        "created_at": "2009-10-07T20:26:53Z",
        "blog": "http://timclem.wordpress.com",
        "login": "tclem",
        "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
        "name": "Tim Clem",
        "company": "GitHub",
        "location": "San Francisco, CA"
      },
      "id": 27669
    }
</code></pre>

## Edit

    PUT /gists/comments/:id.json

### Response

<pre class="highlight"><code class="language-javascript">
{
  "url": "https://api.github.com/gists/comments/27669.json",
  "created_at": "2011-04-18T23:44:35Z",
  "body": "update comment text",
  "user": {
    "email": "timothy.clem@gmail.com",
    "type": "User",
    "url": "https://api.github.com/users/tclem.json",
    "created_at": "2009-10-07T20:26:53Z",
    "login": "tclem",
    "name": "Tim Clem",
    "company": "GitHub",
    "blog": "http://timclem.wordpress.com",
    "gravatar_url": "https://secure.gravatar.com/avatar/2f4861b27dc35663ed271d39f5358261?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "location": "San Francisco, CA"
  },
  "id": 27669
}
</code></pre>

## Delete

    DELETE /gists/comments/:id.json

### Response

<pre class="highlight"><code class="language-javascript">
{}
</pre>

