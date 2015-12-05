# developer.github.com

This is a GitHub API resource built with [Nanoc][nanoc].

All submissions are welcome. To submit a change, fork this repo, commit your changes, and send us a [pull request](http://help.github.com/send-pull-requests/).

## Setup

Ruby 2.2 is required to build the site.

Get the Nanoc gem, plus kramdown for Markdown parsing:

```sh
$ bundle install
```

You can see the available commands with Nanoc:

```sh
$ bundle exec nanoc -h
```

Nanoc has [some nice documentation](http://nanoc.ws/docs/tutorial/) to get you started.  Though if you're mainly concerned with editing or adding content, you won't need to know much about Nanoc.

[nanoc]: http://nanoc.ws/

## Styleguide

Not sure how to structure the docs?  Here's what the structure of the
API docs should look like:

    # API title

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

**Note**: We're using [Kramdown Markdown extensions](http://kramdown.gettalong.org/syntax.html), such as definition lists.

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

You can specify terminal blocks by using the `command-line` syntax highlighting.

    ``` command-line
    $ curl foobar
    ```

You can use certain characters, like `$` and `#`, to emphasize different parts
of commands.

    ``` command-line
    # call foobar
    $ curl <em>foobar<em>
    ....
    ```

For more information, see [the reference documentation](https://github.com/gjtorikian/extended-markdown-filter#command-line-highlighting).

## Development

You can fetch the latest dependencies by opening the command line and running `script/bootstrap`:

``` sh
$ script/bootstrap
==> Installing gem dependencies…
==> Installing npm dependencies…
```

You'll need Ruby 2.2.3 and at least Node v4.x.

You can run `bundle exec rake build` to generate the site, but it's often more useful
to simply build the server *and* start the site at the same time.

Nanoc compiles the site into static files living in `./output`.  It's
smart enough not to try to compile unchanged files.

You can start the site with `script/server`:

``` sh
$ script/server
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
   …

Site compiled in 5.81s.
```

The site is hosted at `http://localhost:4000`.

## Deploy

```sh
$ bundle exec rake publish
```
