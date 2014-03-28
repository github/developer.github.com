---
title: Building a Deployment Server | GitHub API
---

# Building a Deployment Server

* TOC
{:toc}

The [Deployment API][deploy API] provides your projects hosted on GitHub with
the capability to launch them on a production server that you own. Combined with
[the status API][status API], you'll be able to instantaneously serve projects
that pass your CI tests.

This guide will combine these two API to demonstrate an end-to-end setup that
you can use. In our scenario, we will:

* Run our CI suite when a Pull Request is opened (we'll set the CI status to pending).
* When the CI is finished, we'll set the Pull Request's status accordingly.
* When the Pull Request is merged, we'll run our deployment to our server.

Our CI system and host server will be figments of our imagination. They could be
Travis, Jenkins, Heroku, or Amazon. The crux of this guide will be setting up
and configuring the server managing the communication.

If you haven't already, be sure to [download ngrok][ngrok], and learn how
to [use it][using ngrok]. We find it to be a very useful tool for exposing local
connections.

## Writing your server

We'll write a quick Sinatra app to prove that our local connections are working.
Let's start with this:

    #!ruby
    require 'sinatra'
    require 'json'

    post '/event_handler' do
      payload = JSON.parse(params[:payload])
      "Well, it worked!"
    end


(If you're unfamiliar with how Sinatra works, we recommend [reading the Sinatra guide][Sinatra].)

Start this server up. By default, Sinatra starts on port `9393`, so you'll want
to configure ngrok to start listening for that, too.

In order for this server to work, we'll need to set a repository up with a webhook.
The webhook should be configured to fire whenever a Pull Request is created, or merged.
Go ahead and create a repository you're comfortable playing around in. Might we
suggest [@octocat's Spoon/Knife repository](https://github.com/octocat/Spoon-Knife)?
After that, you'll create a new webhook in your repository, feeding it the URL
that ngrok gave you:

![A new ngrok URL](/images/webhooks_recent_deliveries.png)

Click **Update webhook**. You should see a body response of `Well, it worked!`.
Great! Click on **Let me select individual events.**, and select the following:

* Status
* Deployment
* Deployment status
* Pull Request

These are the events GitHub will send to our server whenever the relevant action
occurs. Let's update our server to *just* handle the Pull Request scenario right now:

    #!ruby
    post '/event_handler' do
      @payload = JSON.parse(params[:payload])

      case request.env['HTTP_X_GITHUB_EVENT']
      when "pull_request"
        if @payload["action"] == "opened"
          process_pull_request(@payload["pull_request"])
        end
      end
    end

    helpers do
      def process_pull_request(pull_request)
        puts "It's #{pull_request['title']}"
      end
    end

What's going on? Every event that GitHub sends out attached a `X-GitHub-Event`
HTTP header. We'll only care about the PR events for now. From there, we'll
take the payload of information, and return the title field. In an ideal scenario,
our server would be concerned with every time a pull request is updated, not just
when it's updated. That would make sure that every new push passes the CI tests.
But for this demo, we'll just worry about when it's opened.

To test out this proof-of-concept, make some changes in a branch in your test
repository, and open a pull request. Your server should respond accordingly!

## Working with statuses

With our server in place, we're ready to start our first requirement, which is
setting (and updating) CI statuses. Note that at any time you update your server,
you can click **Redeliver** to send the same payload. There's no need to make a
new pull request every time you make a change!

Since we're interacting with the GitHub API, we'll use [Octokit.rb][octokit.rb]
to manage our interactions.






[deploy API]: /v3/repos/deployments/
[status API]: /v3/repos/statuses/
[ngrok]: https: /ngrok.com/
[using ngrok]: /webhooks/configuring/#using-ngrok
[platform samples]: https://github.com/github/platform-samples/tree/master/hooks/ruby/configuring-your-server
[Sinatra]: http://www.sinatrarb.com/
[webhook]: /webhooks/
[octokit.rb]: https://github.com/octokit/octokit.rb
