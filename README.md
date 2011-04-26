# dev.github.com

This is a GitHub API resource built with [nanoc][nanoc].

## Setup

Get the nanoc gem, plus kramdown for markdown parsing:

    bundle install

You can see the available commands with nanoc:

    nanoc -h

Nanoc has [some nice documentation](http://nanoc.stoneship.org/docs/3-getting-started/) to get you started.  Though if you're mainly concerned with editing or adding content, you won't need to know much about nanoc.

[nanoc]: http://nanoc.stoneship.org/

## Development

Nanoc compiles the site into static files living in `./output`.  It's
smart enough not to try to compile unchanged files:

    $ nanoc compile
    Loading site data...
    Compiling site...
       identical  [0.00s]  output/css/960.css
       identical  [0.00s]  output/css/pygments.css
       identical  [0.00s]  output/css/reset.css
       identical  [0.00s]  output/css/styles.css
       identical  [0.00s]  output/css/uv_active4d.css
          update  [0.28s]  output/index.html
          update  [1.31s]  output/v3/gists/comments/index.html
          update  [1.92s]  output/v3/gists/index.html
          update  [0.25s]  output/v3/issues/comments/index.html
          update  [0.99s]  output/v3/issues/labels/index.html
          update  [0.49s]  output/v3/issues/milestones/index.html
          update  [0.50s]  output/v3/issues/index.html
          update  [0.05s]  output/v3/index.html

    Site compiled in 5.81s.

You can setup whatever you want to view the files.  If you have the adsf
gem, however (I hope so, it was in the Gemfile), you can start Webrick:

    $ nanoc view
    $ open http://localhost:3000

## TODO

* Need some way to deploy?  Look into GitHub pages to start, until we
  can integrate through a simple hurl.it app for live API calls.
* Flesh out the missing components of the requests.
* Maybe add a nice TOC at the top of each page.
