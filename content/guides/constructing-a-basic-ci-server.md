---
title: Constructing a basic CI server | GitHub API
---

# Constructing a basic CI server

* TOC
{:toc}

The [Deployment API][deploy API] provides your projects hosted on GitHub with
the capability to launch them on a production server that you own. Combined with
[the status API][status API], you'll be able to coordinate your deployments
the moment your code lands on `master`.

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

Note: you can download the complete source code for this project
[from the platform-samples repo][platform samples].

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
to manage our interactions. We'll configure that client with
[a personal access token][access token]:

    #!ruby
    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    # Instead, set and test environment variables, like below
    ACCESS_TOKEN = ENV['MY_PERSONAL_TOKEN']

    before do
      @client ||= Octokit::Client.new(:access_token => ACCESS_TOKEN)
    end

After that, we'll just need to update the pull request on GitHub to make clear
that we're processing on the CI:

    #!ruby
    def process_pull_request(pull_request)
      puts "Processing pull request..."
      @client.create_status(pull_request['head']['repo']['full_name'], pull_request['head']['sha'], 'pending')
    end

We're doing three very basic things here:

* we're looking up the full name of the repository
* we're looking up the last SHA of the pull request
* we're setting the status to "pending"

That's it! From here, you can run whatever process you need to in order to execute
your test suite. Maybe you're going to pass off your code to Jenkins, or call
on another web service via its API, like [Travis][travis api]. After that, you'd
be sure to update the status once more. In our example, we'll just set it to `"success"`:

    #!ruby
    def process_pull_request(pull_request)
      @client.create_status(pull_request['head']['repo']['full_name'], pull_request['head']['sha'], 'pending')
      sleep 2 # do busy work...
      @client.create_status(pull_request['head']['repo']['full_name'], pull_request['head']['sha'], 'success')
      puts "Pull request processed!"
    end

## Working with deployments

Our CI tests have passed, and the code has been reviewed. When the pull request
is merged, we want our project to be deployed to the production server.

We'll start by modifying our event listener to pay attention when pull requests
have been merged:

    #!ruby
    when "pull_request"
      if @payload["action"] == "opened"
        process_pull_request(@payload["pull_request"])
      elsif @payload["action"] == "closed" && @payload["pull_request"]["merged"]
        start_deployment(@payload["pull_request"])
      end
    when "deployment"
      process_deployment(@payload)
    end

When a pull request is merged (its state is `closed`, and `merged` is `true`), we'll
kick off a deployment. Based on the information from the pull request, we'll fill
out the `start_deployment` method:

    #!ruby
    def start_deployment(pull_request)
      user = pull_request['user']['login']
      payload = JSON.generate(:environment => 'production', :deploy_user => user)
      @client.create_deployment(pull_request['head']['repo']['full_name'], pull_request['head']['sha'], {:payload => payload, :description => "Deploying my sweet branch"})
    end

Deployments can have some metadata attached to them, in the form of a `payload`
and a `description`. Although these values are optional, it's helpful to use
for logging and representing information.

When a new deployment is created, a completely separate event is trigged. That's
why we have a new `switch` case in the event handler for `deployment`. You can
use this information to be notified when a deployment has been triggered.

Deployments can take a rather long time, so we'll want to listen for various events,
such as when the deployment was created, and what state it's in.

Let's simulate a deployment that does some work, and notice the effect it has on
the output. First, let's write our `process_deployment` method:

    #!ruby
    def process_deployment
      payload = JSON.parse(@payload['payload'])
      # you can send this information to your chat room, monitor, pager, e.t.c.
      puts "Processing '#{@payload['description']}' for #{payload['deploy_user']} to #{payload['environment']}"
      sleep 2 # simulate work
      @client.create_deployment_status("repos/#{@payload['repository']['full_name']}/deployments/#{@payload['id']}", 'pending')
      sleep 2 # simulate work
      @client.create_deployment_status("repos/#{@payload['repository']['full_name']}/deployments/#{@payload['id']}", 'success')
    end

We'll also add a new case to the `switch` statement for deployment statuses:

    #!ruby
    when "deployment_status"
      update_deployment_status
    end

Finally, we'll simulate storing the status information as console output:

    #!ruby
    def update_deployment_status
      puts "Deployment status for #{@payload['id']} is #{@payload['state']}"
    end

Let's break down what's going on. A new deployment is created by `start_deployment`,
which triggers the `deployment` event. From there, we call `process_deployment`
to simulate work that's going on. Meanwhile, we also make a call to `create_deployment_status`,
which lets a receiver know what's going on, as we switch the status to `pending`.

After the deployment is finished, we set the status to `success`. You'll notice
that this pattern is the exact same as when we updated our CI status.

## Conclusion

At GitHub, we've used versions of [Janky][janky] and [Heaven][heaven] to manage
our deployments for years. The basic flow is essentially the exact same as the
server we've built above. At GitHub, we:

* Fire to Jenkins when a pull request is created or updated (via Janky)
* Wait for a response on the state of the CI
* If the code is green, we merge the pull request
* Heaven takes the merged code, and deploys it to our production servers
* In the meantime, Heaven also notifies everyone about the build, via [Hubot][hubot] sitting in our chat rooms

That's it! You don't need to build your own CI or deployment setup to use this example.
You can always rely on third-party services like Travis CI, Heroku, or any number
[of additional integrators][integrations].

[deploy API]: /v3/repos/deployments/
[status API]: /v3/repos/statuses/
[ngrok]: https://ngrok.com/
[using ngrok]: /webhooks/configuring/#using-ngrok
[platform samples]: https://github.com/github/platform-samples/tree/master/api/ruby/building-a-deployment-server
[Sinatra]: http://www.sinatrarb.com/
[webhook]: /webhooks/
[octokit.rb]: https://github.com/octokit/octokit.rb
[access token]: https://help.github.com/articles/creating-an-access-token-for-command-line-use
[travis api]: https://api.travis-ci.org/docs/
[janky]: https://github.com/github/janky
[heaven]: https://github.com/atmos/heaven
[hubot]: https://github.com/github/hubot
[integrations]: https://github.com/integrations
