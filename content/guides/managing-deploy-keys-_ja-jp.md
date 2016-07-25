---
タイトル：キーを展開管理
---

＃管理の展開の鍵！

{:toc}

サーバー導入スクリプトを自動化する上でのSSH鍵を管理するための4つの方法があります。

* SSHエージェント転送
* HTTPSのOAuthトークンを持ちます
*展開の鍵
*マシンのユーザー

このガイドでは、あなたのために何が最善かの戦略を決定するのに役立ちます。

## SSHエージェント転送

多くの場合、特にプロジェクトの初めに、SSHエージェント転送を使用する最も迅速かつ最も簡単な方法です。エージェント転送は、開発用のローカルコンピュータが使用するのと同じSSHキーを使用しています。

####プロ

*あなたが生成したり、任意の新しいキーを追跡する必要はありません。
*どのキー管理はありません。ユーザーがローカルで行うサーバー上の同じ権限を持っています。
*いいえキーはサーバー上に格納されていませんので、サーバーが危険にさらされた場合に、あなたは追い詰めると妥協のキーを削除する必要はありません。

####短所

*ユーザー**必見** SSHで展開します。自動化展開プロセスを使用することができません。
* SSHエージェント転送は、Windowsユーザのために実行することが面倒なことができます。

＃＃＃＃ セットアップ

[our guide on SSH agent forwarding] 1.ローカルに転送エージェントをオンにします。詳細については、を参照してください。 [ssh-agent-forwarding]
2.エージェント転送を使用するようにデプロイスクリプトを設定します。たとえば、bashスクリプトで、エージェント転送を有効にすると、次のようになります。 `sshの-AサーバA 'bashは-s' <deploy.sh`

## HTTPSのOAuthトークンでクローニング

[HTTPS with OAuth tokens] あなたはSSHキーを使用したくない場合は、使用することができます。 [git-automation]

####プロ

*サーバーへのアクセス権を持つ誰もがリポジトリを展開することができます。
*ユーザーは、ローカルのSSHの設定を変更する必要はありません。
*複数のトークン（各ユーザーごとに1つ）が必要とされていません。サーバーごとに1トークンが十分です。
*トークンは、一用パスワードに本質的にそれを回す、いつでも取り消すことができます。
[the OAuth API] *新しいトークンを生成すること、容易に使用してスクリプトすることができます（https://developer.github.com/v3/oauth_authorizations/#create-a-new-authorization）

####短所

*あなたは正しいアクセススコープを使用してトークンを設定することを確認する必要があります。
*トークンは、本質的に、パスワードであり、同じように保護されなければなりません。

＃＃＃＃ セットアップ

[our guide on Git automation with tokens] 見る [git-automation] 。

キーを展開する##

{{ site.data.variables.product.product_name }} デプロイキーは、単一のリポジトリにあなたのサーバーおよび補助金のアクセスに保存されているSSHキーです。このキーは、リポジトリに代わりの個人のユーザーアカウントに直接取り付けられています。

####プロ

*リポジトリとサーバーへのアクセス権を持つ誰もがプロジェクトを展開する能力を持っています。
*ユーザーは、ローカルのSSHの設定を変更する必要はありません。
*展開のキーは、読み取りと書き込みのデフォルトではなく、読み取り専用にすることができることができます。

####短所

*展開の鍵は単一のリポジトリへのアクセス権を付与します。もっと複雑なプロジェクトは、同じサーバーにプルするために多くのリポジトリを有していてもよいです。
*展開のキーは、通常はサーバーが侵害された場合、キーは簡単にアクセスできるように、パスフレーズで保護されていません。

＃＃＃＃ セットアップ

[Run the `ssh-keygen` procedure] サーバー上の1。 [generating-ssh-keys]
{{ site.data.variables.product.product_name }} 任意のページの右上には2、プロフィール写真をクリックします。
[Sample of an avatar] ！ （https://github-images.s3.amazonaws.com/help/profile/top_right_avatar.png）
自分のプロフィールページ3.は、**タブ、その後、リポジトリの名前をクリックします**リポジトリをクリックします。
[Repository tab] ！ （https://github-images.s3.amazonaws.com/help/profile/profile_repositories_tab.png）
リポジトリの右サイドバー4. ** ** [設定]をクリックします。
[Settings tab] ！ （https://github-images.s3.amazonaws.com/help/repository/repo-actions-settings.png）
サイドバーで、[** **展開の鍵]をクリックします。
[Deploy Keys section] ！ （/assets/images/deploy-keys.png）
3. [** **キーを展開する追加します。あなたの公開鍵を貼り付けて提出してください。
[Add Deploy Key button] ！ （https://github-images.s3.amazonaws.com/help/repository/repo-deploy-key.png）

##マシンのユーザー

{{ site.data.variables.product.product_name }} サーバーが複数のリポジトリにアクセスする必要がある場合は、新しいアカウントを作成することを選択し、自動化のためのみに使用されるSSH鍵を添付することができます。このアカウントは、人間によって使用されませんので、マシンのユーザーと呼ばれています。その後、またはそれを操作するために必要なリポジトリへのアクセス権を持つことができます。 {{ site.data.variables.product.product_name }} ** [add the machine user as collaborator] NOTE [collaborator] **：協力者は常に読み取り/書き込みアクセスを許可するようにマシンのユーザーを追加します。チームにマシンのユーザーを追加すると、チームの権限を付与します。 [add the machine user to a team] [team]

{% if page.version == 'dotcom' %}

{{#tip}}

[terms of service] **ヒント：**私達の状態： [tos]

「ボット」または許可されていない他の自動化された方法により登録> *アカウント。*

これは、アカウントの作成を自動化することができないことを意味します。あなたのプロジェクトや組織に、このような展開スクリプトなどのタスクを自動化するための単一のマシンのユーザーを作成したい場合はしかし、それは完全にクールです。

{{/tip}}

{% endif %}

####プロ

*リポジトリとサーバーへのアクセス権を持つ誰もがプロジェクトを展開する能力を持っています。
*いいえ（ヒト）のユーザーは、ローカルのSSHの設定を変更する必要はありません。
*複数のキーが必要とされていません。サーバーごとに1つで十分です。

####短所

*のみの組織では、チームを作成するためのアクセス権を持っています。したがって、唯一の組織では、読み取り専用アクセスを機械ユーザーを制限するためにそれらを使用することができます。個人リポジトリは常に協力者が読み取り/書き込みアクセスを許可します。
*マシンのユーザーキーは、デプロイキーのように、通常、パスフレーズで保護されていません。

＃＃＃＃ セットアップ

[Run the `ssh-keygen` procedure] サーバー上の1とマシンのユーザーアカウントに公開鍵を添付してください。 [generating-ssh-keys]
[adding the account as collaborator] 2.それがアクセスする必要がありますリポジトリにそのアカウントのアクセス権を与えます。あなたは組織によってかでこれを行うことができます。 [collaborator] [adding it to a team] [team]

[ssh-agent-forwarding] ：/ガイド/使用して、ssh-agentの転送/
[generating-ssh-keys] ：https://help.github.com/articles/generating-ssh-keys
[tos] ：https://help.github.com/articles/github-terms-of-service/
[git-automation] ：https://help.github.com/articles/git-automation-with-oauth-tokens
[collaborator] ：https://help.github.com/articles/how-do-i-add-a-collaborator
[team] ：https://help.github.com/articles/adding-organization-members-to-a-team
イキーのように、通常、パスフレーズで保護されていません。

＃＃＃＃ セットアップ

[Run the `ssh-keygen` procedure] サーバー上の1とマシンのユーザーアカウントに公開鍵を添付してください。 [generating-ssh-keys]
[adding the account as collaborator] 2.それがアクセスする必要がありますリポジトリにそのアカウント�