---
title: Using SSH Agent Forwarding | GitHub API
---

# Using SSH Agent Forwarding

* TOC
{:toc}

SSH agent forwarding can be used to make deploying to a remote server simpler for you and your developers.  It allows you to use your local SSH keys instead of leaving keys (without passphrases!) sitting on your server.

If you've already set up an SSH key, you're probably familiar with `ssh-agent`. This is an app that runs in the background and keeps your key loaded into memory so you do not have to enter your passphrase every time you need to use the key. The nifty thing is, you can selectively let remote servers access your local `s`sh-agent as if it was running on the server. This is sort of like asking a friend to enter their password so that you can use their computer.

Check out [Steve Friedl's Tech Tips guide][tech-tips] for a more detailed explanation of SSH agent forwarding.

## Setting up SSH agent forwarding

First, ensure that you your local SSH key is set up and working.  You can use [our guide on generating SSH keys][generating-keys] if you've not done this yet.

You can test that your local key works by typing `ssh -T git@github.com` in the terminal:

<pre class="terminal">
$ ssh -T git@github.com
# Attempt to SSH in to github
> Hi <em>username</em>! You've successfully authenticated, but GitHub does not provide
> shell access.
</pre>

We're off to a great start.  Let's set up SSH to allow agent forwarding to your remote server.

1. Using your favorite text editor, open up the file at `~/.ssh/config`.
  * If this file doesn't exist, you can create it by typing `touch ~/.ssh/config` on the terminal.

2. Enter the following text into the file, replacing `example.com` with your server's domain name or IP:

        Host example.com
          ForwardAgent yes


**Warning**: You may be tempted to use a wildcard like `Host *` to just apply this setting to all SSH connections.  That's not really a good idea, as you'd be sharing access to your local SSH keys with *every* server you SSH into.  They won't have direct access to the keys, but they will be able to use them while the connection is established.  **You should only add servers you intend to use agent forwarding with.**

## Testing SSH agent forwarding

To test that agent forwarding is working with your server, you need to SSH into your server and run the `ssh -T git@github.com` command once more.  If all is well, you'll get back the same prompt as you did locally.  If you are unsure if your local key is being used, you can also inspect the `SSH_AUTH_SOCK` variable on your server:

<pre class="terminal">
$ echo "$SSH_AUTH_SOCK"
# Print out the SSH_AUTH_SOCK variable
> /tmp/ssh-4hNGMk8AZX/agent.79453
</pre>

If the variable is not set, it means that agent forwarding is not working:

<pre class="terminal">
$ echo "$SSH_AUTH_SOCK"
# Print out the SSH_AUTH_SOCK variable
> <em>[No output]</em>
$ ssh -T git@github.com
# Try to SSH to github
> Permission denied (publickey).
</pre>

## Troubleshooting SSH agent forwarding

Here are some things to look out for when troubleshooting SSH agent forwarding.

### Your SSH keys must work locally

Before you can make your keys work through agent forwarding, they must work locally first. [Our guide on generating SSH keys][generating-keys] can help you set up your SSH keys locally.

### Your local machine must allow SSH agent forwarding

Not only do you need to enable agent forwarding in your user's *~/.ssh/config* file, but you may need to set it in your system's SSH settings as well.  You can check if a system config file is being used by typing `ssh -v example.com` on the terminal, and checking the first few lines of the output.  Make sure you use your server's domain name or IP, of course.

<pre class="terminal">
$ ssh -v <em>example.com</em>
# Connect to example.com with verbose debug output
> OpenSSH_5.6p1, OpenSSL 0.9.8r 8 Feb 2011
> debug1: Reading configuration data /Users/<em>you</em>/.ssh/config
> debug1: Applying options for example.com
> debug1: Reading configuration data /etc/ssh_config
> debug1: Applying options for *
</pre>

Don't forget to type `exit` to return to your local system!

In the example above, the file *~/.ssh/config* is loaded first, then */etc/ssh_config* is read.  We can inspect that file to see if it's overriding our options by running the following commands:

<pre class="terminal">
$ cat /etc/ssh_config
# Print out the /etc/ssh_config file
> Host *
>   SendEnv LANG LC_*
>   ForwardAgent no
</pre>

In this example, our */etc/ssh_config* file specifically says `ForwardAgent no`, which is a way to block agent forwarding. Deleting this line from the file should get forwarding working once more.

### Your server must allow SSH agent forwarding on inbound connections

Agent forwarding may also be blocked on your server. You can check that agent forwarding is permitted by typing the `sshd_config` command and ensuring that `AllowAgentForwarding` is set.

### Your local `ssh-agent` must be running

On most computers, the operating system automatically launches `ssh-agent` for you.  On Windows, however, you need to do this manually. We have [a guide on how to start `ssh-agent` whenever you open Git Bash](https://help.github.com/ssh-key-passphrases/).

To check to see if `ssh-agent` is running on your machine, type the following command in the terminal:

<pre class="terminal">
$ echo "$SSH_AUTH_SOCK"
# Print out the SSH_AUTH_SOCK variable
> /tmp/launch-kNSlgU/Listeners
</pre>

### Your key must be available to `ssh-agent`

You can check that your key is visible to `ssh-agent` by running the following command:

<pre class="terminal">
ssh-add -L
</pre>

If the command says that no identity is available, you'll need to add your key:

<pre class="terminal">
ssh-add <em>yourkey</em>
</pre>

[tech-tips]: http://www.unixwiz.net/techtips/ssh-agent-forwarding.html
[generating-keys]: /articles/generating-ssh-keys
[ssh-passphrases]: https://help.github.com/ssh-key-passphrases/
