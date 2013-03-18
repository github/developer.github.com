---
title: Rendering Data as Graphs | GitHub API
---

# Rendering Data as Graphs

* TOC
{:toc}

In this guide, we're going to poll repositories that we own, and render the
information there with graphs, using the [d3.js][d3.js] library. We'll also
be using Octokit, a Ruby library designed to interact with the GitHub API.

We're going to jump right in and assume you've already read the ["Basics of Authentication"][basics-of-authentication] 
guide.

Note: you can download the complete source code for this project [from the platform-samples repo](https://github.com/github/platform-samples/tree/master/api/ruby/rendering-data-as-graphs).

Go ahead and register an application through GitHub. Set the main URL and callback
URL to `http://localhost:4567/`. As before, we're going to be implementing a Rack middleware
using [sinatra-auth-github][sinatra auth github]:

	require 'sinatra/auth/github'

	module Example
	  class MyGraphApp < Sinatra::Base
	    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
	    # Instead, set and test environment variables, like below
	    # if ENV['GITHUB_CLIENT_ID'] && ENV['GITHUB_CLIENT_SECRET']
	    #  CLIENT_ID        = ENV['GITHUB_CLIENT_ID']
	    #  CLIENT_SECRET    = ENV['GITHUB_CLIENT_SECRET']
	    # end

	    CLIENT_ID = ENV['GH_GRAPH_CLIENT_ID']
	    CLIENT_SECRET = ENV['GH_GRAPH_SECRET_ID']

	    enable :sessions

	    set :github_options, {
	      :scopes    => "repo",
	      :secret    => CLIENT_SECRET,
	      :client_id => CLIENT_ID,
	      :callback_url => "/"
	    }

	    register Sinatra::Auth::Github

	    get '/' do
	      if !authenticated?
	        authenticate!
	      else
	        access_token = github_user["token"]
	      end
	    end
	  end
	end

Set up a similar _config.ru_ file as in the previous example:

    ENV['RACK_ENV'] ||= 'development'
    require "rubygems"
    require "bundler/setup"

    require File.expand_path(File.join(File.dirname(__FILE__), 'server'))

    run Example::MyGraphApp

## Fetching repository information

This time, in order to talk to the GitHub API, we're going to use the [Octokit
Ruby library][Octokit]. This is supremly better than directly making a bunch of
REST calls. Plus, Octokit was developed by a GitHubber, so you know it'll work.

Establishing an Octokit instance is extremly easy; just pass your login
and token to the `Octokit::Client` constructor:

    if !authenticated?
      authenticate!
    else
      octokit_client = Octokit::Client.new(:login => github_user.login, :oauth_token => github_user.token)
    end

Let's do something interesting with our repository information; let's list the count
of each language found in our repositories. To do that, we'll first have to grab 
a list of repositories we own. With Octokit, that looks like this:

    repos = client.repositories

Next, we'll want to iterate each repository, and count the language that GitHub
identifies:

    language_obj = {}
    repos.each do |repo|
      # sometimes language can be nil 
      if repo.language
        if !language_obj[repo.language]
          language_obj[repo.language] = 1
        else
          language_obj[repo.language] += 1
        end
      end
    end

    languages.to_s

When you restart your server, your web page should display some information 
that looks like this:

    {"JavaScript"=>13, "PHP"=>1, "Perl"=>1, "CoffeeScript"=>2, nil=>4, "Python"=>1, "Java"=>3, "Ruby"=>3, "Go"=>1, "C++"=>1}

So far, so good! Now, let's represent this information in a human-friendly format
(no offense to JSON). We'll feed this information into d3.js to get a neat bar
graph representing the popularity of the languages we use.

d3.js likes working with arrays of JSON, so let's convert our Ruby hash into one:


    languages = []
    language_obj.each do |lang, count|
      languages.push :language => lang, :count => count
    end
    
    erb :lang_freq, :locals => { :languages => languages.to_json}

We're iterating over each key-value pair in our object, and just pushing them into
a new array. The reason we didn't do this earlier is because we didn't want to iterate 
over our `language_obj` object whilst we were creating it.

Now, _lang_freq.erb_ is going to need a bunch of code to support rendering a bar graph.
For a really good tutorial on the basics of d3, check out [this article called
 "D3 for Mortals"][d3 mortals]. For now, you can just use the code provided here:

    <!DOCTYPE html>
    <meta charset="utf-8">
    <html>
      <head>
        <script src="//cdnjs.cloudflare.com/ajax/libs/d3/3.0.1/d3.v3.min.js"></script>
        <style>
        svg {
          padding: 20px;
        }
        rect {
          fill: #2d578b
        }
        text {
          fill: white;
        }
        text.yAxis {
          font-size: 12px; 
          font-family: Helvetica, sans-serif;
          fill: black;
        }
        </style>
      </head>
      <body>
        <p>Check this sweet data out:</p>
        <div id="lang_freq"></div>

      </body>
      <script>
        var data = <%= languages %>;

        var barWidth = 40;
        var width = (barWidth + 10) * data.length;
        var height = 300;

        var x = d3.scale.linear().domain([0, data.length]).range([0, width]);
        var y = d3.scale.linear().domain([0, d3.max(data, function(datum) { return datum.count; })]).
          rangeRound([0, height]);

        // add the canvas to the DOM
        var languageBars = d3.select("#lang_freq").
          append("svg:svg").
          attr("width", width).
          attr("height", height);

        languageBars.selectAll("rect").
          data(data).
          enter().
          append("svg:rect").
          attr("x", function(datum, index) { return x(index); }).
          attr("y", function(datum) { return height - y(datum.count); }).
          attr("height", function(datum) { return y(datum.count); }).
          attr("width", barWidth);

        languageBars.selectAll("text").
          data(data).
          enter().
          append("svg:text").
          attr("x", function(datum, index) { return x(index) + barWidth; }).
          attr("y", function(datum) { return height - y(datum.count); }).
          attr("dx", -barWidth/2).
          attr("dy", "1.2em").
          attr("text-anchor", "middle").
          text(function(datum) { return datum.count;});

        languageBars.selectAll("text.yAxis").
          data(data).
          enter().append("svg:text").
          attr("x", function(datum, index) { return x(index) + barWidth; }).
          attr("y", height).
          attr("dx", -barWidth/2).
          attr("text-anchor", "middle").
          text(function(datum) { return datum.language;}).
          attr("transform", "translate(0, 18)").
          attr("class", "yAxis");
      </script>
    </html>

Phew! Again, don't worry about what most of this code is doing. The relevant part
here is a line way at the top--`var data = <%= languages %>;`--which indicates 
that we're passing our previously created `languages` array into ERB for manipulation.

As the "D3 for Mortals" guide suggests, this isn't necessarily the best use of
d3. But it does serve to illustrate how you can use the library, along with Octokit,
to make some really amazing things.

## Combining different API calls

Now it's time for a confession: the `language` attribute within repositories
only identifies the "primary" language defined. That means that if you have 
a repository that combines several languages, the one with the most bytes of code
is considered to be the primary language.

Let's combine a few API calls to get a _true_ representation of which language 
has the greatest number of bytes written across all our code. A [treemap][d3 treemap]
should be a great way to visualize the sizes of our coding languages used, rather 
than simply the count. We'll need to construct an array of objects that looks 
something like this:

    [ { "name": "language1", "size": 100},
      { "name": "language2", "size": 23}
      ...
    ]

Since we already have a list of repositories above, let's inspect each one, and 
call [the language listing API method][language API]:

    repos.each do |repo|
      repo_name = repo.name
      repo_langs = octokit_client.languages("#{github_user.login}/#{repo_name}")
    end

From there, we'll cumulatively add each language found to a "master list":

    repo_langs.each do |lang, count|
      if !language_obj[lang]
        language_obj[lang] = count
      else
        language_obj[lang] += count
      end
    end

After that, we'll format the contents into a structure that d3 understands:

    language_obj.each do |lang, count|
      language_byte_count.push :name => "#{lang} (#{count})", :count => count
    end

    # some mandatory formatting for d3
    language_bytes = [ :name => "language_bytes", :elements => language_byte_count]

(For more information on d3 tree map magic, check out [this simple tutorial][language API].)


To wrap up, we'll want to just pass this JSON information over to the same ERB file:

    erb :lang_freq, :locals => { :languages => languages.to_json, :language_byte_count => language_bytes.to_json}


Just like we did before, here's a bunch of d3 JavaScript code that you can just drop
directly into your template: 

    <div id="byte_freq"></div>
    <script>
      var language_bytes = <%= language_byte_count %>

      var childrenFunction = function(d){return d.elements};
      var sizeFunction = function(d){return d.count;};
      var colorFunction = function(d){return Math.floor(Math.random()*20)};
      var nameFunction = function(d){return d.name;};
   
      var color = d3.scale.linear()
                  .domain([0,10,15,20])
                  .range(["grey","green","yellow","red"]);
   
      drawTreemap(5000, 2000, '#byte_freq', language_bytes, childrenFunction, nameFunction, sizeFunction, colorFunction, color);

      function drawTreemap(height,width,elementSelector,language_bytes,childrenFunction,nameFunction,sizeFunction,colorFunction,colorScale){
       
          var treemap = d3.layout.treemap()
              .children(childrenFunction)
              .size([width,height])
              .value(sizeFunction);
       
          var div = d3.select(elementSelector)
              .append("div")
              .style("position","relative")
              .style("width",width + "px")
              .style("height",height + "px");
       
          div.data(language_bytes).selectAll("div")
              .data(function(d){return treemap.nodes(d);})
              .enter()
              .append("div")
              .attr("class","cell")
              .style("background",function(d){ return colorScale(colorFunction(d));})
              .call(cell)
              .text(nameFunction);
      }
       
      function cell(){
          this
              .style("left",function(d){return d.x + "px";})
              .style("top",function(d){return d.y + "px";})
              .style("width",function(d){return d.dx - 1 + "px";})
              .style("height",function(d){return d.dy - 1 + "px";});
      }
    </script>

And voila! Beautiful rectangles containing your repo languages. You might need to
tweak the width and height to get all the information to show up properly.


[d3.js]: http://d3js.org/
[basics-of-authentication]: ../basics-of-authentication/
[sinatra auth github]: https://github.com/atmos/sinatra_auth_github
[Octokit]: https://github.com/pengwynn/octokit
[d3 mortals]: http://www.recursion.org/d3-for-mere-mortals/
[d3 treemap]: http://bl.ocks.org/mbostock/4063582
[language API]: http://developer.github.com/v3/repos/#list-languages
[simple tree map]: http://2kittymafiasoftware.blogspot.com/2011/09/simple-treemap-visualization-with-d3.html
