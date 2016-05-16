---
タイトル：認証の基礎知識
---

認証の＃基本！

{:toc}

このセクションでは、認証の基礎に集中するつもりです。具体的には、
[Sinatra] 我々は、Ruby（使用）サーバー実装ことを作成するつもりです [Sinatra]
[web flow] いくつかの異なる方法でアプリケーションの！ [webflow]

{{#tip}}

[from the platform-samples repo] あなたはこのプロジェクト（https://github.com/github/platform-samples/tree/master/api/）の完全なソースコードをダウンロードすることができます。

{{/tip}}

##あなたのアプリを登録します

[register your application] まず、あなたがする必要があります。あらゆる [new oauth app]
登録のOAuthアプリケーションは、一意のクライアントIDとクライアントシークレットが割り当てられています。
クライアントの秘密を共有するべきではありません！それは文字列をチェックも含まれ
リポジトリへ。

**認可コールバックURL **。これは、簡単に設定することに最も重要な部分であり、
{{ site.data.variables.product.product_name }} アプリケーションのアップ。これは、後にユーザーを返すコールバックURLです
認証が成功しました。

我々は、通常のシナトラサーバ、ローカルインスタンスの場所を実行しているので、
HTTP `：// localhostに設定されて：4567`。 // localhostを：4567 / callback`のは `としてhttpコールバックURLを記入してみましょう。

##ユーザー認証を受け入れます

それでは、私たちの単純なサーバーを記入始めましょう。 _server.rb_というファイルを作成し、それにこれを貼り付けます。

`` `ルビー
「シナトラ」を必要とします
「残り-client 'を必要とします
「JSON」を必要とします

['GH_BASIC_CLIENT_ID'] CLIENT_ID = ENV
['GH_BASIC_SECRET_ID'] CLIENT_SECRET = ENV

'/'入手できますか
{:client_id => CLIENT_ID} ERB：インデックス、：地元の人=>
終わり
```

あなたのクライアントIDとクライアント秘密鍵は、[アプリケーションの設定から来ます
[app settings] ページ]。あなたは**、_ever _ **でこれらの値を保存しないでください
{{ site.data.variables.product.product_name }} そのことについては、他の公共の場所を、-OR。私たちは、それらを格納するお勧めします
[environment variables] --whichここでやったまさにです。 [about env vars]

次に、_views / index.erb_に、このコンテンツを貼り付けます。

`` `ERB
<html>
<head>
</head>
<body>
<p>
まあ、こんにちは！
</p>
<p>
現在のGitHub APIに話をするつもりです。準備はできましたか？
<a href="https://github.com/login/oauth/authorize?scope=user:email&client_id=<%= client_id %> ">を開始するには、ここをクリックしてください！ </a> </a>
</p>
<p>
<a href="/v3/oauth/#web-application-flow"> thatリンクが機能しない場合は、独自のクライアントIDを提供することを忘れないでください！ </a>
</p>
</body>
</html>
```

[reading the Sinatra guide] （あなたはシナトラがどのように動作するかをよく知らないなら、私たちはお勧めします。） [Sinatra guide]

また、URLを定義するために `scope`クエリパラメータを使用していることに気付きます
[scopes] アプリケーションによって要求されました。我々のアプリケーションのために、私たちはしています [oauth scopes]
プライベートのメールアドレスを読み取るためのemail`範囲： `ユーザに要求します。

HTTP `にブラウザをナビゲート：// localhostを：4567`。リンクをクリックした後、あなた
{{ site.data.variables.product.product_name }} 取り、次のようになりますダイアログが表示されるはずです：
[GitHub's OAuth Prompt] ！ （/assets/images/oauth_prompt.png）

あなた自身を信頼する場合、**承認アプリ**をクリックします。 WUH-ああ！シナトラが吐き出します
`404`エラー。何ができます！

我々は `callback`れるコールバックURLを指定していた場合はまあ、覚えていますか？我々は提供していませんでした
{{ site.data.variables.product.product_name }} 彼らが承認した後、ユーザーを削除するにはどこのルートは、そのように認識していません
アプリ。それでは、その問題を修正しましょう​​！

###コールバックを提供

_server.rb_では、コールバックが何をすべきかを指定するためにルートを追加します。

`` `ルビー
'/コールバック」入手できますか
＃一時GitHubのコードを取得...
['rack.request.query_hash'] session_code ['code'] = request.env

＃...とバックのGitHubに投稿
結果= RestClient.post（ 'https://github.com/login/oauth/access_token」、
{：CLIENT_ID => CLIENT_ID、
：client_secret => CLIENT_SECRET、
：コード=> session_code}、
：）JSON：=>を受け入れます

＃トークンと付与されたスコープを抽出
['access_token'] access_tokenは= JSON.parse（結果）
終わり
```

{{ site.data.variables.product.product_name }} 成功したアプリの認証後、一時的な `code`値を提供します。
{{ site.data.variables.product.product_name }} あなたは `access_token`と引き換えに戻ってPOST``にこのコードが必要になります。
[rest-client] 私たちのGETとPOST [REST Client] HTTP要求を簡単にするために、我々は、使用しています。
あなたはおそらくRESTを通じてAPIにアクセスすることは決してないだろうことに注意してください。より深刻なのための
[a library written in the language of your choice] アプリケーションは、あなたはおそらく使用する必要があります。 [libraries]

###付与されたスコープを確認します

[edit the scopes you requested] 将来的には、ユーザーができるようになります、 [edit scopes post]
そして、あなたのアプリケーションでは、もともとのために尋ねたよりも少ないアクセスを許可されることがあります。
だから、トークンを持つすべての要求を行う前に、あなたはそのスコープを確認してください
ユーザによってトークンを付与されました。

付与されたスコープはからの応答の一部として返されます
トークンを交換します。

`` `ルビー
'/コールバック」入手できますか
# ...
＃上記のコードサンプルを使用してaccess_tokenはを取得
# ...

＃我々が付与されたかどうかを確認し、ユーザー：電子メールのスコープ
['scope'] スコープ= JSON.parse（結果）.split（ '、'）
Has_user_email_scope = scopes.include？ 「利用者：メール '
終わり
```

このアプリケーションでは、我々は `scopes.includeを使っている？`我々が付与されたかどうかをチェックします
`ユーザ：認証されたユーザーの秘密を取得するために必要なemail`スコープ
メールアドレス。アプリケーションが他のスコープのために求めていた、我々が持っているだろう
同様にそれらをチェック。

スコープ間の階層関係がありますので、また、あなたがすべき
あなたが必要なスコープの最低レベルを付与されたことを確認してください。例えば、
アプリケーションは `user`範囲を求めていた場合、それだけで付与されている可能性があります
`ユーザ：email`スコープ。その場合、アプリケーションが許可されていません
何それはを求めたが、付与されたスコープは、まだ十分なされていると思います。

それが可能だからのみ要求を行う前に、スコープの確認は十分ではありません
ユーザーがあなたのチェックと実際のリクエストの間にスコープを変更すること。
発生した場合、APIは `404`で失敗する可能性がありますあなたが成功することが期待呼び出し
または `401`状態、または情報の異なるサブセットを返します。

あなたは優雅にこれらの状況、要求のためのすべてのAPI応答を処理支援するために、
[`X-OAuth-Scopes` header] 有効なトークンで作らも含まれています。 [oauth scopes]
このヘッダは、作成するために使用されたトークンのスコープのリストが含まれています
要求。それに加えて、許可APIは、エンドポイントへの提供します
[check a token for validity][check token valid].
トークンのスコープの変化を検出するために、この情報を使用して、あなたのユーザーに通知
利用可能なアプリケーション機能の変​​化。

###認証要求を行います

最後に、このアクセ​​ストークンを使用して、あなたは認証された要求などをすることができます
ログインしているユーザー：

`` `ルビー
＃ユーザ情報を取得します
Auth_result = JSON.parse（RestClient.get（ 'https://api.github.com/user」、
{:params => {:access_token => access_token}}))

ユーザーがそれを許可した場合＃、プライベートメールをフェッチ
Has_user_email_scope場合
['private_emails'] auth_result =
JSON.parse（RestClient.get（ 'https://api.github.com/user/emails」、
{:params => {:access_token => access_token}}))
終わり

ERB：基本的な、：地元の人=> auth_result
```

我々は我々の結果とやりたいことができます。この場合、私たちはまっすぐ_basic.erb_にそれらをダンプします：

`` `ERB
<p> こんにちは、 <%= login %> ！ </p>
<p>
<% if !email.nil? && !email.empty? %> あなたの公開メールアドレスがあるように見えます。 <%= email %>
<% else %> あなたが公共の電子メールを持っていないように見えます。カッコいい。
<% end %>
</p>
<p>
<% if defined? private_emails %>
あなたの許可を得て、我々はまた、あなたのプライベートのメールアドレスを掘ることができました：
<%= private_emails.map{ |private_email_address| private_email_address["email"] }.join(', ') %>
<% else %>
また、あなたはあなたのプライベートのメールアドレスについて少し秘密です。
<% end %>
</p>
```

##「永続」の認証を実装します

我々はアプリにすべての単一のログを記録するようにユーザーに必要であればそれはかなり悪いモデルになるだろう
それらがウェブページにアクセスするのに必要な時間。たとえば、に直接ナビゲートしてみてください
`のhttp：// localhostを：4567 / basic`。あなたはエラーになります。

我々は全体を回避することができればどのような
プロセスを「ここをクリック」し、ちょうど限り、ユーザのがログインしたように、ということ_remember_
{{ site.data.variables.product.product_name }} 、彼らはこのアプリケーションにアクセスできるようにすべきですか？あなたの帽子を保持、
_thatの我々はDO_しようとしている正確に何のため。

上記の私たちの小さなサーバーはかなり単純です。いくつかのインテリジェントに押し込むために、
認証は、私たちはトークンを格納するためのセッションを使用してに切り替えるつもりです。
これは、ユーザへの認証を透明にします。

私たちはセッション内でスコープを持続しているので、また、私たちのようにする必要があります
ユーザーは、我々は彼らをチェックした後にスコープを更新、または取り消したときにケースを扱います
トークン。そのためには、 `rescue`ブロックを使用し、最初のAPIことを確認します
コー​​ルは、トークンがまだ有効であることを確認する、成功しました。その後、我々はよ
ユーザーが失効していないことを確認するために `X-OAuthの-Scopes`レスポンスヘッダをチェック
`ユーザ：email`スコープ。

_advanced_server.rb_というファイルを作成し、その中に次の行を貼り付けます。

`` `ルビー
「シナトラ」を必要とします
「rest_client 'を必要と
「JSON」を必要とします

＃!!! EVER REALアプリでハードコードされた値は、使用しないでください！
＃その代わりに、以下のように、変数を設定し、テスト環境
['GITHUB_CLIENT_ID'] ENV ['GITHUB_CLIENT_SECRET'] && ENV場合＃
['GITHUB_CLIENT_ID'] ＃CLIENT_ID = ENV
['GITHUB_CLIENT_SECRET'] ＃CLIENT_SECRET = ENV
＃ 終わり

['GH_BASIC_CLIENT_ID'] CLIENT_ID = ENV
['GH_BASIC_SECRET_ID'] CLIENT_SECRET = ENV

Cookie_only =>偽：ラック::セッション::プールは、使用

デフ認証？
[:access_token] セッション
終わり

デフ認証！
{:client_id => CLIENT_ID} ERB：インデックス、：地元の人=>
終わり

'/'入手できますか
場合！認証？
認証する！
ほかに
[:access_token] access_tokenは=セッション
[] スコープ=

ベギン
Auth_result = RestClient.get（ 'https://api.github.com/user」、
{:params => {:access_token => access_token},
：）} JSON：=>を受け入れます
救助=>電子
トークンは私たちを取り消されたため、＃要求は成功しませんでした
＃セッションに格納されたトークンが無効になり、レンダリング
＃インデックスページユーザーが再びOAuthのフローを開始できるように、

[:access_token] セッション= nilの
認証返します！
終わり

＃リクエストが成功したので、私たちは現在のスコープのリストをチェック
Auth_result.headers.include場合は？ ：x_oauth_scopes
[:x_oauth_scopes] スコープ= auth_result.headers .split（ '、'）
終わり

Auth_result = JSON.parse（auth_result）

Scopes.include場合はどうなりますか？ 「利用者：メール '
['private_emails'] auth_result =
JSON.parse（RestClient.get（ 'https://api.github.com/user/emails」、
{:params => {:access_token => access_token},
：受け入れる=>：JSON}））
終わり

ERB：高度、：地元の人=> auth_result
終わり
終わり

'/コールバック」入手できますか
['rack.request.query_hash'] session_code ['code'] = request.env

結果= RestClient.post（ 'https://github.com/login/oauth/access_token」、
{：CLIENT_ID => CLIENT_ID、
：client_secret => CLIENT_SECRET、
：コード=> session_code}、
：）JSON：=>を受け入れます

[:access_token] セッション= ['access_token'] JSON.parse（結果）

リダイレクト '/'
終わり
```

コー​​ドの大部分はおなじみのはずです。例えば、我々はまだ `RestClient.get`を使用しています
{{ site.data.variables.product.product_name }} APIを呼び出すために、我々はまだ我々の結果を渡しているレンダリングされます
ERBテンプレートで（この時、それは `advanced.erb`と呼ばれています）。

また、私たちは今、ユーザーが既にあるかどうかを確認する `認証？`メソッドを持っています
認証されました。ない場合は、 `認証！`メソッドを実行する、と呼ばれています
OAuthが流れ、付与されたトークンとスコープとのセッションを更新します。

次に、_views_と呼ばれる_advanced.erb_にファイルを作成し、その中にこのマークアップを貼り付けます。

`` `ERB
<html>
<head>
</head>
<body>
<p> まあ、まあ、まあ、！ <%= login %> </p>
<p>
<% if !email.empty? %> あなたの公開メールアドレスがあるように見えます。 <%= email %>
<% else %> あなたが公共の電子メールを持っていないように見えます。カッコいい。
<% end %>
</p>
<p>
<% if defined? private_emails %>
あなたの許可を得て、我々はまた、あなたのプライベートのメールアドレスを掘ることができました：
<%= private_emails.map{ |private_email_address| private_email_address["email"] }.join(', ') %>
<% else %>
また、あなたはあなたのプライベートのメールアドレスについて少し秘密です。
<% end %>
</p>
</body>
</html>
```

コマンドラインから、あなたを起動 `ルビーadvanced_server.rb`、呼び出し
ポート `4567`上のサーバ - 私たちは、単純なシナトラアプリを持っていたとき、我々が使用したのと同じポート。
あなたはHTTP `に移動すると：// localhostを：4567`、アプリが呼び出し`認証 `！
これは `/ callback`にリダイレクトされます。 `/ callback`は、その後、` / `に私たちを送り返し、
私たちが認証されてきたので、_advanced.erb_をレンダリングします。

我々は完全に、単に私たちのコールバックを変更することで、この往復のルーティングを簡素化することができ
{{ site.data.variables.product.product_name }} `/`に内のURL。しかし、_server.rb_と_advanced.rb_両方以降に依存しています
同じコールバックURLは、我々はそれを動作させるためにwonkinessの少しを行うようになってきました。

{{ site.data.variables.product.product_name }} また、我々は我々のデータにアクセスするには、このアプリケーションを承認したことがなかった場合には、
我々は以前のポップアップから同じ確認ダイアログを見て、私たちに警告しただろう。

[yet another Sinatra-GitHub auth example] ご希望の場合はで遊ぶことができます [sinatra auth github test]
別のプロジェクトとして利用可能。

[webflow] ：/ V3 / OAuthの/＃Webアプリケーションフロー
[Sinatra] ：http://www.sinatrarb.com/
[about env vars] ：http://en.wikipedia.org/wiki/Environment_variable#Getting_and_setting_environment_variables
[Sinatra guide] ： https://github.com/sinatra/sinatra-book/blob/master/book/Introduction.markdown#hello-world-application
[REST Client] ：https://github.com/archiloque/rest-client
[libraries] ライブラリ
[sinatra auth github test] ：https://github.com/atmos/sinatra-auth-github-test
[oauth scopes] ：/ V3 /のOAuth /＃スコープ
[edit scopes post] ：/変更/ 2013年10月4日 - OAuthの-変更-来ます/
[check token valid] ：/ V3 / oauth_authorizations /＃チェック-承認
[platform samples] ：https://github.com/github/platform-samples/tree/master/api/ruby/basics-of-authentication
[new oauth app] ：https://github.com/settings/applications/new
[app settings] ：https://github.com/settings/developers
�� [sinatra auth github test]
別のプロジェクトとして利用可能。

[webflow] ：/ V3 / OAuthの/＃Webアプリケーションフロー
[Sinat