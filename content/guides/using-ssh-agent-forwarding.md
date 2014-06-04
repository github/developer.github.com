---
title: Using SSH Agent Forwarding | GitHub API
---

# Using SSH agent forwarding

* TOC
{:toc}

SSH agent forwarding can be used to make deploying to a server simple.  It allows you to use your local SSH keys instead of leaving keys (without passphrases!) sitting on your server.

If you've already set up an SSH key to interact with GitHub, you're probably familiar with `ssh-agent`. It's a program that runs in the background and keeps your key loaded into memory, so that you don't need to enter your passphrase every time you need to use the key. The nifty thing is, you can choose to let servers access your local `ssh-agent` as if they were already running on the server. This is sort of like asking a friend to enter their password so that you can use their computer.

Check out [Steve Friedl's Tech Tips guide][tech-tips] for a more detailed explanation of SSH agent forwarding.

## Setting up SSH agent forwarding

Ensure that your own SSH key is set up and working. You can use [our guide on generating SSH keys][generating-keys] if you've not done this yet.

You can test that your local key works by entering `ssh -T git@github.com` in the terminal:

<pre class="terminal">
$ ssh -T git@github.com
<span class="comment"># Attempt to SSH in to github</span>
<span class="output">Hi <em>username</em>! You've successfully authenticated, but GitHub does not provide</span>
<span class="output">shell access.</span>
</pre>

We're off to a great start. Let's set up SSH to allow agent forwarding to your server.

1. Using your favorite text editor, open up the file at `~/.ssh/config`. If this file doesn't exist, you can create it by entering `touch ~/.ssh/config` in the terminal.

2. Enter the following text into the file, replacing `example.com` with your server's domain name or IP:

        Host example.com
          ForwardAgent yes

<div class="warning">
<p>
<strong>Warning</strong>: You may be tempted to use a wildcard like <code>Host *</code> to just apply this setting to all SSH connections. That's not really a good idea, as you'd be sharing your local SSH keys with <em>every</em> server you SSH into. They won't have direct access to the keys, but they will be able to use them <em>as you</em> while the connection is established. <strong>You should only add servers you trust and that you intend to use with agent forwarding.</strong>
</p>
</div>

## Testing SSH agent forwarding

To test that agent forwarding is working with your server, you can SSH into your server and run `ssh -T git@github.com` once more.  If all is well, you'll get back the same prompt as you did locally.

If you're unsure if your local key is being used, you can also inspect the `SSH_AUTH_SOCK` variable on your server:

<pre class="terminal">
$ echo "$SSH_AUTH_SOCK"
<span class="comment"># Print out the SSH_AUTH_SOCK variable</span>
<span class="output">/tmp/ssh-4hNGMk8AZX/agent.79453</span>
</pre>

If the variable is not set, it means that agent forwarding is not working:

<pre class="terminal">
$ echo "$SSH_AUTH_SOCK"
<span class="comment"># Print out the SSH_AUTH_SOCK variable</span>
<span class="output"><em>[No output]</em></span>
$ ssh -T git@github.com
<span class="comment"># Try to SSH to github</span>
<span class="output">Permission denied (publickey).</span>
</pre>

## Troubleshooting SSH agent forwarding

Here are some things to look out for when troubleshooting SSH agent forwarding.

### Your SSH keys must work locally

Before you can make your keys work through agent forwarding, they must work locally first. [Our guide on generating SSH keys][generating-keys] can help you set up your SSH keys locally.

### Your system must allow SSH agent forwarding

Sometimes, system configurations disallow SSH agent forwarding. You can check if a system configuration file is being used by entering the following command in the terminal:

<pre class="terminal">
$ ssh -v <em>example.com</em>
<span class="comment"># Connect to example.com with verbose debug output</span>
<span class="output">OpenSSH_5.6p1, OpenSSL 0.9.8r 8 Feb 2011</span>
<span class="output">debug1: Reading configuration data /Users/<em>you</em>/.ssh/config</span>
<span class="output">debug1: Applying options for example.com</span>
<span class="output">debug1: Reading configuration data /etc/ssh_config</span>
<span class="output">debug1: Applying options for *</span>
$ exit
<span class="comment"># Returns to your local command prompt</span>
</pre>

In the example above, the file *~/.ssh/config* is loaded first, then */etc/ssh_config* is read.  We can inspect that file to see if it's overriding our options by running the following commands:

<pre class="terminal">
$ cat /etc/ssh_config
<span class="comment"># Print out the /etc/ssh_config file</span>
<span class="output"> Host *</span>
<span class="output">   SendEnv LANG LC_*</span>
<span class="output">   ForwardAgent no</span>
</pre>

In this example, our */etc/ssh_config* file specifically says `ForwardAgent no`, which is a way to block agent forwarding. Deleting this line from the file should get agent forwarding working once more.

### Your server must allow SSH agent forwarding on inbound connections

Agent forwarding may also be blocked on your server. You can check that agent forwarding is permitted by SSHing into the server and running `sshd_config`. The output from this command should indicate that `AllowAgentForwarding` is set.

### Your local `ssh-agent` must be running

On most computers, the operating system automatically launches `ssh-agent` for you.  On Windows, however, you need to do this manually. We have [a guide on how to start `ssh-agent` whenever you open Git Bash][autolaunch-ssh-agent].

To verify that `ssh-agent` is running on your computer, type the following command in the terminal:

<pre class="terminal">
$ echo "$SSH_AUTH_SOCK"
<span class="comment"># Print out the SSH_AUTH_SOCK variable</span>
<span class="output">/tmp/launch-kNSlgU/Listeners</span>
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
[generating-keys]: https://help.github.com/articles/generating-ssh-keys
[ssh-passphrases]: https://help.github.com/ssh-key-passphrases/
[autolaunch-ssh-agent]: https://help.github.com/articles/working-with-ssh-key-passphrases#auto-launching-ssh-agent-on-msysgit
