---
タイトル：はじめに
---

＃ 入門！！

{:toc}

我々はいくつかの日常的な使用の例に取り組むとしてのコアAPIの概念を見てみましょう。

＃概要

[wrapper library] ほとんどのアプリケーションは、言語で、既存を使用します。 [wrappers]
お好みのが、それは根本的なAPIを理解することが重要です
最初のHTTPメソッド。

[cURL] よりタイヤを蹴るない簡単な方法はありません。 [curl]

＃＃＃ こんにちは世界

私たちのセットアップをテストしてみましょう。コマンドプロンプトを開き、入力してください
次のコマンドを実行します。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール/禅

>論理的に素晴らしい、それを保管してください。
```

応答は、私たちの設計思想からランダムに選択されます。

[Chris Wanstrath's] ：次に、 [defunkt github] `GET`てみましょう [GitHub profile] [users api]

`` `コマンドライン
＃GET /ユーザー/ defunkt
{{ site.data.variables.product.api_url_pre }} $カール/ユーザー/ defunkt

> {
> "ログイン"： "defunkt」を、
> "ID"：2、
{{ site.data.variables.product.api_url_pre }} > "URL"： "/ユーザ/ defunkt」、
> "html_url"： "https://github.com/defunkt」、
>   ...
> }
```

[JSON] MMMMM、のような味。ヘッダーを含めるために [json] `-i`フラグを追加してみましょう：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i /ユーザーカール$ /何

> HTTP /1.1 200 OK
>サーバ：GitHub.com
>日付：日、2012年11月11日午後06時43分28秒GMT
>のContent-Type：アプリケーション/ JSON。文字セット= UTF-8
>接続：キープアライブ
>ステータス： 200 OK
>のETag： "bfd85cbf23ac0b0c8a29bee02e7117c6"
> X-RateLimitリミット： 60
> X-RateLimit-残り： 57
> X-RateLimit-リセット： 1352660008
> X-GitHubのメディアタイプ：github.v3
>構成変更：承諾
>のCache-Control：公共、最大エージング= 60、S-MAXAGE = 60
> X-Content-Typeの-オプション：nosniff
>のContent-Length：5
> Last-Modifiedの：火曜、2012年10月30日午前18時58分42秒GMT

> {
> "ログイン"： "defunkt」を、
> "ID"：2、
{{ site.data.variables.product.api_url_pre }} > "URL"： "/ユーザ/ defunkt」、
> "html_url"： "https://github.com/defunkt」、
>   ...
> }
```

レスポンスヘッダにはいくつかの興味深いのビットがあります。予想されるように、
`のContent-type`がは`アプリケーション/ json`です。

`X-`で始まるヘッダは、カスタムヘッダであり、中に含まれていません
HTTPの仕様。のは、それらのいくつかを見てみましょう：

[media type] * [media types] `X-GitHubのメディア-type`がはgithub.v3``の値を持ちます。これは、私たちは知ることができます
応答のため。メディアタイプは、私たちのAPI v3ではバージョン我々の出力に貢献しています。私たちは、よ
後でその詳細に​​ついて話しています。
* `X-RateLimit-Limit`と` X-RateLimit-Remaining`ヘッダーのメモします。この
[how many requests a client can make] ヘッダーのペアはで示しています [rate limiting]
ローリング期間（通常1時間）とどのようにそれらの要求の多く
クライアントがすでに費やしてきました。

##認証

認証されていないクライアントは、時速60要求を行うことができます。多くを得るために、我々はする必要があります
{{ site.data.variables.product.product_name }} _認証する_。実際には、APIで興味深い何かを行うことは必要です
[authentication][authentication].

基本

{{ site.data.variables.product.product_name }} APIを使用して認証する最も簡単な方法は、単にあなたを使用することです {{ site.data.variables.product.product_name }}
基本認証を介したユーザー名とパスワードを入力します。

`` `コマンドライン
<em> $カール-i </em> -u {{ site.data.variables.product.api_url_pre }} your_username /ユーザー/ defunkt

<em> >ユーザーyour_usernameのホストのパスワードを入力してください： </em>
```

`-u`フラグは、ユーザー名を設定し、cURLのはパスワードの入力を求めます。君は
プロンプトを回避するために `が、これはあなたを残し：` -u "パスワードユーザー名」を使用することができます
シェルの歴史の中でパスワードとは推奨されません。認証、あなた
に示すように、あなたのレート制限は、5000要求時間にぶつかっ表示されるはずです
> X-RateLimitリミット：60

わずか1時間あたりのコールを取得することに加えて、認証がへの鍵です
読み、APIを介して個人情報を書き込みます。

### 2因子認証

[two-factor authentication] あなたが有効にしている場合、APIが返されます [2fa]
`401上記の要求のためのUnauthorized`エラーコード（および他のすべてのAPIリクエスト）：

`` `コマンドライン
<em> $カール-i </em> -u {{ site.data.variables.product.api_url_pre }} your_username /ユーザー/ defunkt

<em> >ユーザーyour_usernameのホストのパスワードを入力してください： </em>

無断> HTTP /1.1 401
> X-GitHubの-OTP：必要。 ：2FA型

> {
> "メッセージ"： "2要素認証OTPコードを指定する必要があります。」、
> "documentation_url"： "https://developer.github.com/v3/auth#working-with-two-factor-authentication"
> }
```

そのエラーを回避する最も簡単な方法は、OAuthのトーク​​ンと使用を作成することです
代わりに基本認証のOAuth認証。見ます
[OAuth section] 詳細については、以下。 [oauth section]

###取得し、独自のユーザー・プロファイル

正しく認証するときは、権限を利用することができます
{{ site.data.variables.product.product_name }} アカウントに関連付けられています。例えば、取得してみてください
[your own user profile][auth user api]:

`` `コマンドライン
<em> $カール-i </em> -u {{ site.data.variables.product.api_url_pre }} your_username /ユーザー

> {
>   ...
> "プラン"：{
> "スペース"：2516582、
>「共同編集者」：10、
> "private_repos"：20、
> "名前"： "中"
>  }
>   ...
> }
```

公開情報の同じセットに加えて今回、我々
[@defunkt] 以前用に取得、あなたはまた、非公共表示されるはずです [defunkt github]
ユーザープロファイルのための情報。たとえば、 `plan`オブジェクトが表示されます
{{ site.data.variables.product.product_name }} 応答でアカウントの計画についての詳細を与えます。

OAuthの###

{{ site.data.variables.product.product_name }} 便利な一方で、あなたを与えるべきではありませんので、基本認証は理想的ではありません
誰にも、ユーザー名とパスワードを入力します。読み書きする必要があるアプリケーション
[OAuth] 別のユーザーの代わりにAPIを使用して個人情報を使用する必要があります。 [oauth]

代わりに、ユーザー名とパスワードの、OAuthが_tokens_を使用しています。トークンは、大きな2を提供します
特徴：

* ** Revokableアクセス**：ユーザーが任意の時点で、サードパーティのアプリに許可を取り消すことができます
* **限定アクセス**：ユーザーがトークンことを特定のアクセスを確認することができます
サードパーティのアプリを許可する前に提供します

[web flow] 通常、トークンは介して作成されます。アプリケーション [webflow]
{{ site.data.variables.product.product_name }} ログインするようにユーザーに送信します。その後、ダイアログを提示 {{ site.data.variables.product.product_name }}
アプリの名前だけでなく、アクセスのレベルを示すアプリ
{{ site.data.variables.product.product_name }} それは、ユーザーが許可していたら、持っています。ユーザーがアクセスを許可した後、
バックアプリケーションにユーザーをリダイレクトします。

[GitHub's OAuth Prompt] ！ （/assets/images/oauth_prompt.png）

ただし、OAuthのトーク​​ンの使用を開始するためにウェブ全体の流れを設定する必要はありません。
[create a **personal access token**] トークンを取得する簡単な方法は、あなたを介しです [personal token]
[Personal access tokens settings page][tokens settings]:

[Personal Token selection] ！ （/assets/images/personal_t​​oken.png）

[**Authorizations API**] また、それは単純な基本認証を使用することを可能にします [authorizations api]
OAuthのトーク​​ンを作成します。貼り付けて、次のコマンドを実行してみてください：

`` `コマンドライン
<em> $カール-i </em> -u {"scopes": ["repo", "user"], "note": "getting-started"} your_username -d '' \
{{ site.data.variables.product.api_url_pre }} $ /権限

> HTTP / 1.1 201作成
{{ site.data.variables.product.api_url_pre }} >場所：/権限/ 2
>のContent-Length：5

> {
スコープ=
>「レポ」、
ユーザー
>  ],
> "トークン"： "5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4」、
> "updated_atの"： "2012-11-14T14：04：24Z」、
{{ site.data.variables.product.api_url_pre }} > "URL"： "/オーソリゼーション/ 2」、
> "アプリ"：{
> "URL"： "https://developer.github.com/v3/oauth/#oauth-authorizations-api」、
> "名前"： "GitHubのAPI」
>  },
> "のcreated_at"： "2012-11-14T14：04：24Z」、
> "note_url"：ヌル、
> "ID"：2、
> "注意"： "-入門」
> }
```

この一つの小さな呼び出しで起こっ多くはそうのは、それを打破しましょう​​、あります。最初、
`-d`フラグが使用して、我々は` POST`をやっている示し、
`アプリケーション/ X-WWW-フォームurlencoded`コンテンツタイプ（` GET`とは対照的に）。すべての `POST`
{{ site.data.variables.product.product_name }} APIへのリクエストはJSONにする必要があります。

次に、我々はこのコールに渡って送信している `scopes`を見てみましょう。作成するとき
[_scopes_] 新しいトークンは、我々はオプションの配列、またはアクセスが含まれます [scopes]
このトークンがアクセスできる情報を示しているレベル。この場合、
我々が読むためにアクセス権を付与_repo_アクセス、トークンを設定していると
読ん補助金パブリックおよびプライベートリポジトリへの書き込み、および_USER_範囲、
そしてパブリックおよびプライベートユーザープロファイルデータへの書き込みアクセスを。見る
[the scopes docs] の完全なリストについては、 [scopes]
スコープ。もしあなたのアプリケーションが実際に必要とするべきである**のみ**リクエストスコープ、
潜在的に侵襲的なアクションをユーザーに怖がらないようにするためです。 `201`
ステータスコードは、呼び出しが成功した、とJSONを返すことを教えてくれる
私たちの新しいOAuthのトーク​​ンの詳細が含まれています。

[two-factor authentication] あなたが有効にしている場合、APIはなります [2fa]
[previously described `401 Unauthorized` error code] 返します [2fa section]
上記の要求のための。あなたは2FA OTPコードを提供することによって、そのエラーを回避することができます
[X-GitHub-OTP request header] の中に [2fa header] ：

`` `コマンドライン
<em> $カール-i </em> -u <em> your_username </em> -H "X-GitHubの-OTP：your_2fa_OTP_code" \
{"scopes": ["repo", "user"], "note": "getting-started"} '' -d \
{{ site.data.variables.product.api_url_pre }} /権限
```

あなたがモバイルアプリケーションで2FAを有効にした場合、先に行くとからOTPコードを取得
お使いの携帯電話上のあなたのワンタイムパスワードアプリケーション。テキストで2FAを有効にした場合
メッセージは、あなたがに要求を行った後、あなたのOTPコードでSMSを受信します
このエンドポイント。

今、私たちは40文字 `token`の代わりに、ユーザー名とパスワードを使用することができます
私たちの例の残りの部分インチのは、OAuthのこの時間を使って、再び私たち自身のユーザ情報を取得してみましょう：

`` `コマンドライン
$ -i -H '認可：トークン5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4」をカール\
{{ site.data.variables.product.api_url_pre }} ユーザー
```

**パスワードのようなトリートOAuthのトーク​​ン！**他のユーザーや店舗と共有しないでください
安全でない場所でそれら。これらの例では、トークンは偽物であり、名前は持っています
無実を保護するために変更されて。

今、私たちが認証呼び出しを行うのこつを持っていること、のがに沿って移動してみましょう
[Repositories API] 。 [repos-api]

##リポジトリ

{{ site.data.variables.product.product_name }} APIのほとんどすべての意味の使用は、リポジトリのいくつかのレベルを含むであろう
[`GET` repository details] 情報。私たちは、同じように私たちは、ユーザーをフェッチすることができます [get repo]
以前の詳細：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $ -i /レポ/ twbs /ブートストラップをカール
```

[view repositories for the authenticated user] 同様に、私たちは次のことができます。 [user repos api]

`` `コマンドライン
$ -i -H '認可：トークン5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4」をカール\
{{ site.data.variables.product.api_url_pre }} /ユーザー/レポ
```

[list repositories for another user] それとも、私たちは次のことができます。 [other user repos api]

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i /ユーザー/ technoweenie /レポカール$
```

[list repositories for an organization] それとも、私たちは次のことができます。 [org repos api]

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i / [組織/モジラ/レポカール$
```

これらの呼び出しから返された情報は、我々は認証方法に依存します：

*基本認証を使用して、レスポンスがすべてのリポジトリ含ま
ユーザーは、github.comに表示するためのアクセス権を持っています。
* OAuthのを使用して、プライベートリポジトリにのみOAuthのトーク​​ン場合に返されます。
[scope] `repo`が含まれています。 [scopes]

[docs] 示すように、これらの方法は、 [repos-api] `type`がパラメータを取ります
ユーザーが持つアクセスの種類に基づいて、返されたリポジトリをフィルタリングすることができます
リポジトリの。このように、我々は唯一の直接所有のリポジ​​トリを取得することができ、
組織のリポジトリ、またはリポジトリユーザーがチームを経て上協力しています。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール-i "/ユーザ/ technoweenie /レポ？タイプ=所有者"
```

この例では、technoweenieが所有するものだけのリポジトリではなく、つかみます
彼は協力しているもの。上記引用されたURLに注意してください。あなたに応じて、
シェルの設定は、cURLのは時々引用されたURLを必要とするか、またはそうでなければ無視されます
クエリ文字列。

###リポジトリを作成します。

既存のリポジトリのフェッチ情報は一般的な使用例であるが、
{{ site.data.variables.product.product_name }} APIは、同様に、新しいリポジトリの作成をサポートしています。へ、 [create a repository] [create repo]
我々は `POST`詳細と構成オプションを含むいくつかのJSONをする必要があります。

`` `コマンドライン
$ -i -H '認可：トークン5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4」をカール\
\ { '-d
"名前"： "ブログ"、\
「auto_init "：trueの場合、\
"プライベート"：trueの場合、\
「gitignore_template "：" nanoc "\
}' \
{{ site.data.variables.product.api_url_pre }} /ユーザー/レポ
```

この最小限の例では、我々は（提供されるのを私たちのブログのために新しいリポジトリを作成します
[GitHub Pages] ）おそらく、上。ブログは公開されているが、我々が作りました [pages]
リポジトリのプライベート。この単一のステップでは、我々はまた、でそれを初期化します
[nanoc] READMEと-flavored。 [nanoc] [.gitignore template] [gitignore templates]

<your_username> 得られたリポジトリは `https://github.com/ / blog`で発見されます。
あなたがしている対象の組織の下にリポジトリを作成するには
<org_name> 所有者は、ちょうど `/ [組織/ / repos`に/ユーザー/ repos``からAPIメソッドを変更します。

次は、新しく作成したリポジトリを取得してみましょう：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $ -i /レポ/ pengwynn /ブログをカール

HTTP /1.1 404見つけました

> {
> "メッセージ"： "見つかりません"
> }
```

NOEがああ！それはどこに行きましたか？我々は_private_としてリポジトリを作成しているので、我々が必要です
それを見るために認証します。あなたは白髪交じりのHTTPユーザーであれば、あなたがかもしれません
代わりに `403`を期待しています。私たちは、民間の情報を漏洩したくないので、
{{ site.data.variables.product.product_name }} 我々はできる」と言っているかのようにリポジトリ、APIは、この場合には `404`を返します。
このリポジトリの存在を確認することも、拒否もありません。」

##の問題

{{ site.data.variables.product.product_name }} 目的上の問題のためのUIを提供するために、「ちょうど十分」ワークフローながら、
{{ site.data.variables.product.product_name }} あなたの方法の外に滞在。では、あなたが引くことができます [Issues API] [issues-api]
データはアウトかのために働くのワークフローを作成するために、他のツールから問題を作成します
あなたのチーム。

ちょうどgithub.comのように、APIはのための問題を表示するには、いくつかのメソッドを提供します
[see all your issues] 認証されたユーザー。 [get issues api] 、issues` / GET `呼び出すには：

`` `コマンドライン
$ -i -H '認可：トークン5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4」をカール\
{{ site.data.variables.product.api_url_pre }} /問題
```

[issues under one of your {{ site.data.variables.product.product_name }} organizations] 取得する唯一の、呼び出し [get issues api] `GET
<org> / [組織/ / issues`：

`` `コマンドライン
$ -i -H '認可：トークン5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4」をカール\
{{ site.data.variables.product.api_url_pre }} / [組織/レール/問題
```

[all the issues under a single repository] また、取得することができます。 [repo issues api]

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i /レポ/レール/レール/問題カール$
```

##ページネーション

[paginate] プロジェクトのRailsの大きさは問題の数千を持っています。私たちはする必要があります、 [pagination]
複数のAPI呼び出しを行うと、データを取得します。これは、のは、その最後の呼び出しを繰り返してみましょう
レスポンスヘッダに着目した時間：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i /レポ/レール/レール/問題カール$

> HTTP /1.1 200 OK

> ...
&lt; >リンク：/リポジトリ/ {{ site.data.variables.product.api_url_pre }} 8514 &gt; /問題ページ= &lt; 2;？ {{ site.data.variables.product.api_url_pre }} ？のrel &gt; = "次"、/リポジトリ/ 8514 /問題ページ= 30; rel = "最後"
> ...
```

[`Link` header] リンク先の応答のための方法を提供します [link-header]
外部リソース、データのこの場合は追加のページ。私たちの呼び出しが見つかりましたので、
以上の30の問題（デフォルトのページ・サイズ）、APIはどこに我々はできるを教えてくれる
次のページと結果の最後のページを見つけます。

###問題の作成

[create an issue] 今、私たちは問題のリストをページ分割する方法を見てきたことからしてみましょう [create issue]
API。

問題を作成するには、認証される必要があるので、我々は通過します
ヘッダー内のOAuthトークン。また、我々はJSONにタイトル、本文、およびラベルを渡します
私たちが作成するリポジトリの下に `/ issues`パスに体
問題：

`` `コマンドライン
$ -i -H '認可：トークン5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4」をカール\
$ -d '{\
$ "タイトル"： "新ロゴ"、\
$ "身体"： "我々は、いずれかを持っている必要があります"、\
["design"] $ "ラベル"：\
$       }' \
{{ site.data.variables.product.api_url_pre }} $ /レポ/ pengwynn / API-サンドボックス/問題

> HTTP / 1.1 201作成
{{ site.data.variables.product.api_url_pre }} >場所：/レポ/ pengwynn / API-サンドボックス/問題/ 17
> X-RateLimitリミット： 5000

> {
> "pull_request"：{
> "patch_url"：ヌル、
> "html_url"：ヌル、
> "diff_url"：ヌル
>   },
> "のcreated_at"： "2012-11-14T15：25：33Z」、
> "コメント"：0、
> "マイルストーン"：ヌル、
> "タイトル"： "新しいロゴ」、
> "身体"： "我々は、いずれかを持っているべきです」、
ユーザー
> "ログイン"： "pengwynn」、
> "gravatar_id"： "7e19cd5486b5d6dc1ef90e671ba52ae0」、
> "avatar_url"： "https://secure.gravatar.com/avatar/7e19cd5486b5d6dc1ef90e671ba52ae0?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
> "ID"：2、
{{ site.data.variables.product.api_url_pre }} > "URL"： "/ユーザ/ pengwynn」
>   },
> "closed_at"：ヌル、
> "updated_atの"： "2012-11-14T15：25：33Z」、
> "数"：17、
> "closed_by"：ヌル、
> "html_url"： "https://github.com/pengwynn/api-sandbox/issues/17」、
> "ラベル"：[
>     {
> "色"： "ededed」、
> "名前"： "デザイン"、
{{ site.data.variables.product.api_url_pre }} > "URL"： "/レポ/ pengwynn / API-サンドボックス/ラベル/デザイン"
>     }
>   ],
> "ID"：2、
> "譲受人"：ヌル、
：状態=> "オープン"
{{ site.data.variables.product.api_url_pre }} > "URL"： "/レポ/ pengwynn / API-サンドボックス/問題/ 17"
> }
```

応答が両方で、新しく作成された問題に私たちにポインタのカップルを与えます
`Location`レスポンスヘッダとJSONレスポンスの` url`フィールド。

##条件付きリクエスト

良いAPIの市民であることの大部分は、によってレート制限を尊重され、
変更されていない情報をキャッシュします。 APIがサポート[条件付き
[conditional-requests] リクエスト]あなたは正しいことを行うことができます。考えます
最初の呼び出し我々はdefunktのプロファイルを取得するために作られました。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i /ユーザーカール$ /何

> HTTP /1.1 200 OK
>のETag： "bfd85cbf23ac0b0c8a29bee02e7117c6"
```

JSON本体に加えて、 `200`のHTTPステータスコードのノートを取り、
`ETag`ヘッダー。
[ETag] 応答の指紋です。我々はそれが後続の呼び出しに渡すと、 [etag]
我々はそれが変更された場合にのみ、再び私たちのリソースを与えるためにAPIを指示することができます。

`` `コマンドライン
\：$ ' "bfd85cbf23ac0b0c8a29bee02e7117c6」の場合 - なし - マッチ' -i -Hをカール
{{ site.data.variables.product.api_url_pre }} $ /ユーザー/ defunkt

> HTTP /1.1 304は変更されません
```

`304`ステータスは、リソースが前回から変化していないことを示しています
我々はそれを求め、応答には、ボディは含まれません。ボーナスとして、 `304`
[rate limit] 応答はあなたにカウントされません。 [rate-limiting]

{{ site.data.variables.product.product_name }} やりました！今、あなたは、APIの基本を知っています！

*基本＆OAuthの認証
*フェッチとリポジトリの作成と課題
##条件付きリクエスト

[Basics of Authentication] 次のAPIのガイドと一緒に学習してください！ [auth guide]


[wrappers] ライブラリ
[curl] ：http://curl.haxx.se/
[media types] （/ V3 /メディア/）。
[oauth] ：/ V3 / OAuthの/
[webflow] ：/ V3 / OAuthの/＃Webアプリケーションフロー
[authorizations api] ：/ V3 / oauth_authorizations /＃作成--新しい承認を
[scopes] ：/ V3 /のOAuth /＃スコープ
[repos-api] ：/ V3 /レポ/
[pages] ：http://pages.github.com
[nanoc] ：http://nanoc.ws/
[gitignore templates] ：https://github.com/kdyby/github
[issues-api] ：/ V3 /問題/
[link-header] ：http://www.w3.org/wiki/LinkHeader/
[conditional-requests] ：/ V3 /＃条件付きリクエスト
[rate-limiting] ：/ V3 /＃のレート制限
[users api] ：/ V3 /ユーザー/＃GET--シングルユーザー
[auth user api] ：/ V3 /ユーザー/＃GET-認証済みユーザ
[defunkt github] > "html_url"： "https://github.com/defunkt」、
[json] ：http://en.wikipedia.org/wiki/JSON
[rate limiting] ：/ V3 /＃のレート制限
[authentication] ：/ V3 /＃認証
[2fa] ：https://help.github.com/articles/about-two-factor-authentication
[2fa header] ：/ V3 /認証/＃労働者と-二要素認証
[oauth section] ：/ガイド/-入門/＃のOAuthの
[personal token] ：https://help.github.com/articles/creating-an-access-token-for-command-line-use
[tokens settings] ：https://github.com/settings/developers
[pagination] ：/ V3 /＃ページネーション
[get repo] ：/ V3 /レポ/＃取得
[create repo] ：/ V3 /レポ/＃作成
[create issue] ：/ V3 /問題/＃作成-発行
[auth guide] 認証の＃基本！
[user repos api] ：/ V3 /レポ/＃リスト - あなたの-リポジトリ
[other user repos api] ：/ V3 /レポ/＃リスト-ユーザーリポジトリ
[org repos api] ：/ V3 /レポ/＃リスト-組織のリポジトリ
[get issues api] ：/ V3 /問題/＃リスト-問題
[repo issues api] ：/ V3 /問題/＃リスト-問題--、リポジトリの
[etag] ：http://en.wikipedia.org/wiki/HTTP_ETag
[2fa section] ：/ガイド/-入門/＃2ファクタ認証
�
[2fa] ：https://help.github.com/articles/about-two-factor-authentication
[2fa header] ：/ V3 /認証/＃労働者と-二要素認証
[oauth section] ：/ガイド/-入門/＃のOAuthの
[personal token] ：https://help.github.com/articles/creating-an-access-token-for-command-line-use
[tokens settings] ：https://github.com/settings/developers
[pagination] ：/ V3 /＃ページネーション
[get repo] ：/ V3 /レポ/＃取得
[create repo] ：/ V3 /レポ/＃作成
[create issue] ：/ V3 /問題/＃作成-発行
[auth guide] 認証の＃基本！
[user repos api] ：/ V3 /レポ/＃リスト - あなたの-リポジトリ
[other