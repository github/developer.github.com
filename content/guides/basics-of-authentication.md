---
title: Basics of Authentication | GitHub API
---

# Basics of Authentication

In this section, we're going to focus on the basics of authentication. Specifically, 
we're going to create a Ruby server (using [Sinatra][Sinatra]) that implements the [web flow][webflow] of an application
in several different ways.

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
is set to `0.0.0.0:4567`. Let's fill in the callback URL as `http://0.0.0.0:4567/callback`.

## Accepting user authorization

Now, let's start filling out our simple server. Create a file called _server.rb_ and paste this into it:


    require 'sinatra'
    require 'rest_client'

    CLIENT_ID = <your_client_id>
    CLIENT_SECRET = <your_client_secret>

    get '/' do
      erb :index, :locals => {:client_id => CLIENT_ID}
    end

Then, in _views/index.erb_, paste this content:


    <html>
      <head>

      </head>
      <body>
        <p>Well, hello there!</p>
        <p>We're going to now talk to the GitHub API. Ready? <a href="https://github.com/login/oauth/authorize?client_id=<%= client_id %>">Click here</a> to begin!</a></p>
        <p>If that link doesn't work, remember to provide your own <a href="http://developer.github.com/v3/oauth/#web-application-flow">Client ID</a>!</p>
      </body>
    </html>

(If you're unfamiliar with how Sinatra works, we recommend [reading this guide][Sinatra guide].)

Obviously, you'll want to change `<your_client_id>` to match your actual Client ID. 

Navigate your browser to `http://0.0.0.0:4567`. After clicking on the link, you 
should be taken to GitHub, and presented with a dialog that looks something like this:  
![](/images/oauth_prompt.png)

If you trust yourself, click **Authorize App**. Wuh-oh! Sinatra spits out a 
`404` error. What gives?!

Well, remember when we specified a Callback URL to be `callback`? We didn't provide
a route for it, so GitHub doesn't know where to drop the user after they authorize the app.
Let's fix that now!

### Providing a callback

In _server.rb_, add a route to specify what the callback should do:

    get '/callback' do
      # get temporary GitHub code...
      session_code = request.env['rack.request.query_hash']["code"]
      # ... and POST it back to GitHub
      result = RestClient.post("https://github.com/login/oauth/access_token",
                              {:client_id => CLIENT_ID,
                               :client_secret => CLIENT_SECRET,
                               :code => session_code,
                               :accept => :json})
    end

After every successful app authentication, GitHub provides a temporary `code`.
You'll need to `POST` this code back to GitHub in exchange for an access token. 

[webflow]: http://developer.github.com/v3/oauth/#web-application-flow
[Sinatra]: http://www.sinatrarb.com/
[Sinatra guide]: http://sinatra-book.gittr.com/#hello_world_application