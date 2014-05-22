# developer.github.com

This is a GitHub API resource built with [nanoc][nanoc].

All submissions are welcome. To submit a change, fork this repo, commit your changes, and send us a [pull request](http://help.github.com/send-pull-requests/).

## Setup

Ruby 1.9 is required to build the site.

Get the nanoc gem, plus kramdown for Markdown parsing:

```sh
$ bundle install
```

You can see the available commands with nanoc:

```sh
$ bundle exec nanoc -h
```

Nanoc has [some nice documentation](http://nanoc.ws/docs/tutorial/) to get you started.  Though if you're mainly concerned with editing or adding content, you won't need to know much about nanoc.

[nanoc]: http://nanoc.stoneship.org/

## Styleguide

Not sure how to structure the docs?  Here's what the structure of the
API docs should look like:

    # API title

    * TOC
    {:toc}

    ## API endpoint title

        [VERB] /path/to/endpoint

    ### Parameters

    Name | Type | Description
    -----|------|--------------
    `name`|`type` | Description.

    ### Input (request JSON body)

    Name | Type | Description
    -----|------|--------------
    `name`|`type` | Description.

    ### Response

    <%= headers 200, :pagination => default_pagination_rels, 'X-Custom-Header' => "value" %>
    <%= json :resource_name %>

**Note**: We're using [Kramdown Markdown extensions](http://kramdown.rubyforge.org/syntax.html), such as definition lists.

### JSON Responses

We specify the JSON responses in Ruby so that we don't have to write
them by hand all over the docs.  You can render the JSON for a resource
like this:

```erb
<%= json :issue %>
```

This looks up `GitHub::Resources::ISSUE` in `lib/resources.rb`.

Some actions return arrays.  You can modify the JSON by passing a block:

```erb
<%= json(:issue) { |hash| [hash] } %>
```

### Terminal blocks

You can specify terminal blocks with `pre.terminal` elements.  (It'd be
nice if Markdown could do this more cleanly.)

```html
<pre class="terminal">
$ curl foobar
....
</pre>
```

This is not a `curl` tutorial though. Not every API call needs
to show how to access it with `curl`.

## Development

Nanoc compiles the site into static files living in `./output`.  It's
smart enough not to try to compile unchanged files:

```sh
$ bundle exec nanoc compile
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
```

You can setup whatever you want to view the files. If using the adsf
gem (as listed in the Gemfile), you can start Webrick:

```sh
$ bundle exec nanoc view
$ open http://localhost:3000
```

Compilation times got you down?  Use `autocompile`!

```sh
$ bundle exec nanoc autocompile
```

This starts a web server too, so there's no need to run `nanoc view`.
One thing: remember to add trailing slashes to all nanoc links!

## Deploy

```sh
$ bundle exec rake publish
```
