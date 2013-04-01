---
title: Basics of Authentication | GitHub API
---

# Basics of Authentication

* TOC
{:toc}

In this section, we're going to focus on the basics of authentication. Specifically, 
we're going to create a Ruby server (using [Sinatra][Sinatra]) that implements 
the [web flow][webflow] of an application in several different ways.

Note: you can download the complete source code for this project [from the platform-samples repo](https://github.com/github/platform-samples/tree/master/api/ruby/basics-of-authentication).

## Registering your app

First, you'll need to [register your
application](https://github.com/settings/applications/new) application. Every 
registered OAuth application is assigned a unique Client ID and Client Secret. 
The Client Secret should not be shared! That includes checking the string
into your repository.

You can fill out every piece of information however you like, except the 
**Authorization callback URL**. This is easily the most important piece to setting 
up your application. It's the callback URL that GitHub returns the user to after 
successful authentication.

Since we're running a regular Sinatra server, the location of the local instance 
is set to `http://localhost:4567`. Let's fill in the callback URL as `http://localhost:4567/callback`.

## Accepting user authorization

Now, let's start filling out our simple server. Create a file called _server.rb_ and paste this into it:

    require 'sinatra'
    require 'rest-client'

    CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
    CLIENT_SECRET = ENV['GH_BASIC_SECRET_ID']

    get '/' do
      erb :index, :locals => {:client_id => CLIENT_ID}
    end

Your client ID and client secret keys come from [your application's configuration page](https://github.com/settings/applications). You should **never, _ever_** store these values in 
GitHub--or any other public place, for that matter. We recommend storing them as
[environment variables][about env vars]--which is exactly what we've done here.

Next, in _views/index.erb_, paste this content:


    <html>
      <head>
      </head>
      <body>
        <p>Well, hello there!</p>
        <p>We're going to now talk to the GitHub API. Ready? <a href="https://github.com/login/oauth/authorize?client_id=<%= client_id %>">Click here</a> to begin!</a></p>
        <p>If that link doesn't work, remember to provide your own <a href="http://developer.github.com/v3/oauth/#web-application-flow">Client ID</a>!</p>
      </body>
    </html>

(If you're unfamiliar with how Sinatra works, we recommend [reading the Sinatra guide][Sinatra guide].)

Obviously, you'll want to change `<your_client_id>` to match your actual Client ID. 

Navigate your browser to `http://localhost:4567`. After clicking on the link, you 
should be taken to GitHub, and presented with a dialog that looks something like this:  
![](/images/oauth_prompt.png)

If you trust yourself, click **Authorize App**. Wuh-oh! Sinatra spits out a 
`404` error. What gives?!

Well, remember when we specified a Callback URL to be `callback`? We didn't provide
a route for it, so GitHub doesn't know where to drop the user after they authorize 
the app. Let's fix that now!

### Providing a callback

In _server.rb_, add a route to specify what the callback should do:

    get '/callback' do
      # get temporary GitHub code...
      session_code = request.env['rack.request.query_hash']["code"]
      # ... and POST it back to GitHub
      result = RestClient.post("https://github.com/login/oauth/access_token",
                              {:client_id => CLIENT_ID,
                               :client_secret => CLIENT_SECRET,
                               :code => session_code
                              },{
                               :accept => :json
                              })
      access_token = JSON.parse(result)["access_token"]
    end

After a successful app authentication, GitHub provides a temporary `code` value.
You'll need to `POST` this code back to GitHub in exchange for an `access_token`. 
To simplify our GET and POST HTTP requests, we're using the [rest-client][REST Client].
Note that you'll probably never access the API through REST. For a more serious 
application, you should probably use [a library written in the language of your choice][libraries].

At last, with this access token, you'll be able to make authenticated requests as
the logged in user:

    auth_result = RestClient.get("https://api.github.com/user", {:params => {:access_token => access_token}})

    erb :basic, :locals => {:auth_result => auth_result}

We can do whatever we want with our results. In this case, we'll just dump them straight into _basic.erb_:

    <p>Okay, here's a JSON dump:</p>
    <p>
      <p>Hello, <%= login %>! It looks like you're <%= hire_status %>.</p>
    </p>

## Implementing "persistent" authentication

It'd be a pretty bad model if we required users to log into the app every single
time they needed to access the web page. For example, try navigating directly to 
`http://localhost:4567/basic`. You'll get an error.

What if we could circumvent the entire
"click here" process, and just _remember_ that, as log as the user's logged into
GitHub, they should be able to access this application? Hold on to your hat, 
because _that's exactly what we're going to do_.

Our little server above is rather simple. In order to wedge in some intelligent
authentication, we're going to switch over to implementing [a Rack layer][rack guide]
into our Sinatra app. On top of that, we're going to be using a middleware called
[sinatra-auth-github][sinatra auth github] (which was written by a GitHubber).
This will make authentication transparent to the user.

After you run `gem install sinatra_auth_github`, create a file called _advanced_server.rb_,
and paste these lines into it:

    require 'sinatra/auth/github'
    require 'rest-client'

    module Example
      class MyBasicApp < Sinatra::Base
        # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
        # Instead, set and test environment variables, like below
        # if ENV['GITHUB_CLIENT_ID'] && ENV['GITHUB_CLIENT_SECRET']
        #  CLIENT_ID        = ENV['GITHUB_CLIENT_ID']
        #  CLIENT_SECRET    = ENV['GITHUB_CLIENT_SECRET']
        # end

        CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
        CLIENT_SECRET = ENV['GH_BASIC_SECRET_ID']

        enable :sessions

        set :github_options, {
          :scopes    => "user",
          :secret    => CLIENT_SECRET,
          :client_id => CLIENT_ID,
          :callback_url => "/callback"
        }

        register Sinatra::Auth::Github

        get '/' do
          if !authenticated?
            authenticate!
          else
            access_token = github_user["token"]
            auth_result = RestClient.get("https://api.github.com/user", {:params => {:access_token => access_token, :accept => :json}, 
                                                                                      :accept => :json})

            auth_result = JSON.parse(auth_result)

            erb :advanced, :locals => {:login => auth_result["login"],
                                       :hire_status => auth_result["hireable"] ? "hireable" : "not hireable"}
          end
        end

        get '/callback' do
          if authenticated?
            redirect "/"
          else
            authenticate!
          end
        end
      end
    end

Much of the code should look familiar. For example, we're still using `RestClient.get` 
to call out to the GitHub API, and we're still passing our results to be renderend
in an ERB template (this time, it's called `advanced.erb`). Some of the other
details--like turning our app into a class that inherits from `Sinatra::Base`--are a result
of inheriting from `sinatra/auth/github`, which is written as [a Sinatra extension][sinatra extension].

Also, we now have a `github_user` object, which comes from `sinatra-auth-github`. The
`token` key represents the same `access_token` we used during our simple server. 

`sinatra-auth-github` comes with quite a few options that you can customize. Here,
we're establishing them through the `:github_options` symbol. Passing your client ID
and client secret, and calling `register Sinatra::Auth::Github`, is everything you need
to simplify your authentication.

We must also create a _config.ru_ config file, which Rack will use for its configuration
options:

    ENV['RACK_ENV'] ||= 'development'
    require "rubygems"
    require "bundler/setup"

    require File.expand_path(File.join(File.dirname(__FILE__), 'advanced_server'))

    run Example::MyBasicApp

Next, create a file in _views_ called _advanced.erb_, and paste this markup into it:

    <html>
      <head>
      </head>
      <body>
        <p>Well, well, well, <%= login %>! It looks like you're <em>still</em> <%= hire_status %>!</p>
      </body>
    </html>

From the command line, call `rackup -p 4567`, which starts up your
Rack server on port `4567`--the same port we used when we had a simple Sinatra app.
When you navigate to `http://localhost:4567`, the app calls `authenticate!`--another
internal `sinatra-auth-github` method--which redirects you to `/callback`. `/callback`
then sends us back to `/`, and since we've been authenticated, renders _advanced.erb_.

We could completely simplify this roundtrip routing by simply changing our callback
URL in GitHub to `/`. But, since both _server.rb_ and _advanced.rb_ are relying on
the same callback URL, we've got to do a little bit of wonkiness to make it work.

Also, if we had never authorized this Rack application to access our GitHub data,
we would've seen the same confirmation dialog from earlier pop-up and warn us.

If you'd like, you can play around with [yet another Sinatra-GitHub auth example][sinatra auth github test]
available as a separate project.

[webflow]: http://developer.github.com/v3/oauth/#web-application-flow
[Sinatra]: http://www.sinatrarb.com/
[about env vars]: http://en.wikipedia.org/wiki/Environment_variable#Getting_and_setting_environment_variables
[Sinatra guide]: http://sinatra-book.gittr.com/#hello_world_application
[REST Client]: https://github.com/archiloque/rest-client
[libraries]: http://developer.github.com/v3/libraries/
[rack guide]: http://en.wikipedia.org/wiki/Rack_(web_server_interface)
[sinatra auth github]: https://github.com/atmos/sinatra_auth_github
[sinatra extension]: http://www.sinatrarb.com/extensions.html
[sinatra auth github test]: https://github.com/atmos/sinatra-auth-github-test
