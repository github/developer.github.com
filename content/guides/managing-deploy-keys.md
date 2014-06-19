---
title: Managing deploy keys | GitHub API
---

# Managing Deploy Keys

* TOC
{:toc}

There are four ways to manage SSH keys on your servers when automating deployment scripts:

* SSH agent forwarding
* HTTPS with OAuth tokens
* Deploy keys
* Machine users

This guide will help you decide what strategy is best for you.

## SSH agent forwarding

In many cases, especially in the beginning of a project, SSH agent forwarding is the quickest and simplest method to use.  Agent forwarding uses the same SSH keys that your local development computer uses.

#### Pros

* You do not have to generate or keep track of any new keys.
* There is no key management; users have the same permissions on the server that they do locally.
* No keys are stored on the server, so in case the server is compromised, you don't need to hunt down and remove the compromised keys.

#### Cons

* Users **must** SSH in to deploy; automated deploy processes can't be used.
* SSH agent forwarding can be troublesome to run for Windows users.

#### Setup

1. Turn on agent forwarding locally. See [our guide on SSH agent forwarding][ssh-agent-forwarding] for more information.
2. Set your deploy scripts to use agent forwarding. For example, on a bash script, enabling agent forwarding would look something like this: `ssh -A serverA 'bash -s' < deploy.sh`

## HTTPS cloning with OAuth tokens

If you don't want to use SSH keys, you can use [HTTPS with OAuth tokens][git-automation].

#### Pros

* Anyone with access to the server can deploy the repository.
* Users don't have to change their local SSH settings.
* Multiple tokens (one for each user) are not needed; one token per server is enough.
* A token can be revoked at any time, turning it essentially into a one-use password.
* Generating new tokens can be easily scripted using [the OAuth API](https://developer.github.com/v3/oauth_authorizations/#create-a-new-authorization)

#### Cons

* You must make sure that you configure your token with the correct access scopes.
* Tokens are essentially passwords, and must be protected the same way.

#### Setup

See [our guide on Git automation with tokens][git-automation].

## Deploy keys

A deploy key is an SSH key that is stored on your server and grants access to a single GitHub repository.  This key is attached directly to the repository instead of to a personal user account.

#### Pros

* Anyone with access to the repository and server has the ability to deploy the project.
* Users don't have to change their local SSH settings.

#### Cons

* Deploy keys only grant access to a single repository. More complex projects may have many repositories to pull to the same server.
* The key has full read/write access to the repository.
* Deploy keys are usually not protected by a passphrase, making the key easily accessible if the server is compromised.

#### Setup

1. [Run the `ssh-keygen` procedure][generating-ssh-keys] on your server.
2. In the top right corner of any GitHub page, click your profile photo.
   ![Sample of an avatar](https://github-images.s3.amazonaws.com/help/profile/top_right_avatar.png)
3. On your profile page, click the **Repositories** tab, then click the name of your repository.
   ![Repository tab](https://github-images.s3.amazonaws.com/help/profile/profile_repositories_tab.png)
4. In your repository's right sidebar, click **Settings**.
   ![Settings tab](https://github-images.s3.amazonaws.com/help/repository/repo-actions-settings.png)
3. In the sidebar, click **Deploy Keys**.
   ![Deploy Keys section](/images/deploy-keys.png)
3. Click **Add deploy key**. Paste your public key in and submit.
   ![Add Deploy Key button](https://github-images.s3.amazonaws.com/help/repository/repo-deploy-key.png)

## Machine users

If your server needs to access multiple repositories, you can choose to attach an SSH key to an automated user account. Since this account won't be used by a human, it's called a machine user. You can then [add the machine account as collaborator][collaborator] or [add the machine user to a team][team] with access to the repositories it needs to manipulate.

<div class="alert">
<p>
<strong>Tip</strong>: Our <a href="https://help.github.com/articles/github-terms-of-service">terms of service</a> do mention that <em>'Accounts registered by "bots" or other automated methods are not permitted.'</em> and that <em>'One person or legal entity may not maintain more than one free account.'</em>  But don't fear, we won't send rabid lawyers out to hunt you down if you make machine users for your server deploy scripts. Machine users are completely kosher.
</p>
</div>

#### Pros

* Anyone with access to the repository and server has the ability to deploy the project.
* No (human) users need to change their local SSH settings.
* Multiple keys are not needed; one per server is adequate.
* Organizations can give read-only access to their machine users.

#### Cons

* By default, the key has full read/write access to the repository if the repository belongs to a user account. You can add the machine user to a read-only team if it's accessing repositories in an organization.
* Machine user keys, like deploy keys, are usually not protected by a passphrase.

#### Setup

1. [Run the `ssh-keygen` procedure][generating-ssh-keys] on your server and attach the public key to the machine user account.
2. Give that account access to the repositories it will need to access. You can do this by [adding the account as collaborator][collaborator] or [adding it to a team][team] in an organization.

[ssh-agent-forwarding]: /guides/using-ssh-agent-forwarding/
[generating-ssh-keys]: https://help.github.com/articles/generating-ssh-keys
[tos]: https://help.github.com/articles/github-terms-of-service
[git-automation]: https://help.github.com/articles/git-automation-with-oauth-tokens
[collaborator]: https://help.github.com/articles/how-do-i-add-a-collaborator
[team]: https://help.github.com/articles/adding-organization-members-to-a-team
