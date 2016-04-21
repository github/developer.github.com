---
タイトル：GitHubのAPIのv3の
---

＃概要

これは、公式を構成するリソースについて説明します。
[support][].

{:toc}

＃＃ 現行版

[version] デフォルトでは、すべてのリクエストは、APIの** v3の**（/ V3 /バージョン）を受け取ります。
[explicitly request this version via the `Accept` header] 我々は（/ V3 /メディア/＃要求固有のバージョン）になることをお勧めします。

受け入れ：アプリケーション/ vnd.github.v3 + JSON

##スキーマ

{{ site.data.variables.product.api_url_code }} すべてのAPIアクセスはHTTPS経由で行われ、かつ ``からアクセス。すべてのデータは
JSONとして送信し、受信しました。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i /ユーザー/ octocat / [組織カール$

> HTTP / 1.1 200 OK
>サーバ：nginxの
>日付：金、2012年10月12日午後11時33分14秒GMT
>のContent-Type：アプリケーション/ JSON。文字セット= UTF-8
>接続：キープアライブ
>ステータス：200 OK
>のETag： "a00049ba79152d03380c34652f2cb612"
> X-GitHubのメディアタイプ：github.v3
> X-RateLimitリミット：5000
> X-RateLimit-残り：4987
> X-RateLimit-リセット：1350085394
>のContent-Length：5
>のCache-Control：maxの年齢= 0、プライベート、マスト再検証
> X-Content-Typeの-オプション：nosniff
```

空白のフィールドではなく、省略されているの `null`なのでとして含まれています。

すべてのタイムスタンプは、ISO 8601形式で返されます。

YYYY-MM-DD T HH：MM：SSZ

###要約表現

あなたは、リソースのリストを取得すると、応答がの_subset_を含み
そのリソースの属性。これは、の「まとめ」表現であります
リソース。 （一部の属性は、APIが提供するのは計算コストが高いです。
パフォーマンス上の理由から、要約表現は、それらの属性を除外します。
これらの属性を取得するには、「詳細」の表現を取得します。）

**例**：あなたがリポジトリのリストを取得すると、あなたは要約を取得します
各リポジトリの表現。ここでは、所有しているリポジトリのリストを取得します
[octokit] （https://github.com/octokit）組織による：

GET / [組織/ octokit /レポ

###詳細な表現

あなたは、個々のリソースを取得する場合、応答は、一般的に_all_含み
そのリソースの属性。これは、の「詳細」表示であります
リソース。 （認可は時々詳細情報の量に影響を与えることに注意してください
表現に含まれています。）

**例**：あなたは、個々のリポジトリを取得すると、あなたは詳細を取得します
リポジトリの表現。ここでは、フェッチ
[octokit/octokit.rb] （https://github.com/octokit/octokit.rb）リポジトリ：

/repos/octokit/octokit.rb GET

ドキュメントは、各APIメソッドの例応答を提供します。例
応答は、そのメソッドによって返されるすべての属性を示しています。

＃＃ パラメーター

多くのAPIメソッドは、オプションのパラメータを取ります。 GETリクエスト、任意のパラメータではないために
パス内のセグメントは、HTTPクエリ文字列として渡すことができますように指定
パラメータ：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $ -i "/レポ/ VMG / redcarpet /問題？状態=閉」カール
```

Owner`：この例では、「VMG 'と' redcarpet '値が `のために提供されています
そして、 `：`ながらパスにrepo`パラメータ：state`がクエリに渡されます
文字列。

POSTの場合は、PATCH、PUT、およびDELETE要求を、URLに含まれていないパラメータは、JSONとしてエンコードする必要があります
「アプリケーション/ JSON」のコンテンツタイプを持ちます：

`` `コマンドライン
{"scopes":["public_repo"]} $カール-i {{ site.data.variables.product.api_url_pre }} -uユーザ名-d '' /権限
```

##ルートエンドポイント

あなたは、APIがサポートするすべてのエンドポイントのカテゴリを取得するには、ルートエンドポイントに `GET`要求を発行することができます。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール
```

{% if page.version != 'dotcom' %}

{{#tip}}

[as with all other endpoints] **ヒント：** GitHubの企業については、（https://developer.github.com/v3/enterprise/#endpoint-urls）は、*と同様に、ホスト名としてあなたのGitHubエンタープライズエンドポイントに渡す必要がありますユーザ名とパスワード*：

`` `コマンドライン
<em> $カールます。https：//ホスト名/ </em> API <em> / </em> V3 <em> / </em> -uユーザ名：パスワード
```

{{/tip}}

{% endif %}

##クライアントのエラー

そのAPI呼び出しのクライアントエラーの三つの可能なタイプがあります。
要求本体を受け取ります。

1.無効なJSONを送信すると、 `400不正Request`応答になります。

HTTP / 1.1 400不正な要求
Content-Length：35

{"message":"Problems parsing JSON"}

2. `400不正になりますJSON値の間違ったタイプを送信
Request`応答。

HTTP / 1.1 400不正な要求
>のContent-Length：5

{"message":"Body should be a JSON object"}

3.無効なフィールドを送信すると、 `422処理不能Entity`になります
応答。

HTTP / 1.1 422処理不可能なエンティティ
>のContent-Length：5

{
"メッセージ"： "検証に失敗しました」、
"エラー"：[
{
"リソース"： "問題」、
"フィールド"： "タイトル"、
"コード"： "missing_field"
}
]
}

すべてのエラーオブジェクトは、リソースとフィールド特性を持っているので、あなたのクライアント
問題が何であるかを伝えることができます。あなたをできるように、エラーコードもあります
フィールドと間違っているものを知っています。これらは、可能な検証エラーです
コー​​ド：


エラー名|説明
-----------|-----------|
`missing` |これは、リソースが存在しないことを意味します。
`missing_field` |これは、リソース上の必須フィールドが設定されていないことを意味します。
`invalid` |これは、フィールドの書式設定が無効であることを意味します。そのリソースのドキュメントはあなたのより具体的な情報を与えることができるはずです。
`already_exists` |これは、他のリソースは、このフィールドと同じ値を有しています。これは、（ラベル名など）いくつかのユニークなキーが必要なリソースに発生する可能性があります。

リソースは、カスタム検証エラーを送信することができる（ここで、 `code`はcustom``です）。カスタムエラーは常にエラーを記述する `message`でフィールドを持ち、ほとんどのエラーはまた、あなたがエラーの解決に役立つかもしれないいくつかのコンテンツを指す` documentation_url`フィールドが含まれます。

## HTTPリダイレクト

API v3は、適切な場合にHTTPリダイレクトを使用しています。クライアントは、任意のものを想定する必要があり
リクエストがリダイレクトになることがあります。 HTTPリダイレクトを受信すると、* * ANではありません
エラーおよびクライアントがそのリダイレクトに従ってください。リダイレクト応答があります
リソースのURIが含まれている `Location`ヘッダフィールド
クライアントが要求を繰り返す必要があります。

ステータスコード|説明
-----------|-----------|
`301` |永続的にリダイレクト。あなたが要求を行うために使用されるURIは `Location`ヘッダフィールドで指定された1に取って代わられています。これとこのリソースへの今後のすべての要求は、新しいURIに向けられるべきです。
`302`、` 307` |一時的なリダイレクト。リクエストは、URIに逐語的に繰り返されるべき `Location`ヘッダフィールドで指定されたが、クライアントは将来の要求のためのオリジナルのURIを使用し続ける必要があります。

他のリダイレクションステータスコードは、HTTP 1.1仕様に従って使用することができます。

## HTTP動詞

可能な場合、API v3は、それぞれに適切なHTTP動詞を使用するように努めています
アクション。

動詞|説明
-----|-----------
`HEAD` |単にHTTPヘッダ情報を取得するために、任意のリソースに対して発行することができます。
`GET` |リソースを取得するために使用されます。
`POST` |リソースを作成するために使用します。
`PATCH` |部分的なJSONデータとリソースを更新するために使用されます。例えば、問題のリソースは `title`と` body`属性があります。 PATCH要求は、リソースを更新するための属性の一つ以上を受け入れることができます。 PATCHは比較的新しく、珍しいHTTP動詞なので、リソースのエンドポイントは `POST`リクエストを受け付けます。
`PUT` |リソースまたはコレクションを交換するために使用されます。ノー `body`属性を持つ` PUT`要求の場合、ゼロに `のContent-Length`ヘッダーを設定してください。
リソースを削除するために使用され| `DELETE`。

##認証

{{ site.data.variables.product.product_name }} API v3のを介して認証する方法は3つあります。要求しています
認証の代わりに、 `404ませんFound`を返します。必要
いくつかの場所で `403 Forbidden`、。これは、偶発的な漏洩を防止することです
権限のないユーザーにプライベートリポジトリの。

###基本認証

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール-u「ユーザー名」
```

（ヘッダーで送信された）###のOAuth2トークン

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール-H「認可：トークンのOAuth-TOKEN」
```

（パラメータとして送信された）###のOAuth2トークン

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール/？access_tokenは=のOAuth-TOKEN
```

[more about OAuth2] 読む（/ V3 / OAuthの/）。 OAuth2トークンは[取得できることに注意してください
プログラムで]（/ V3 / oauth_authorizations /＃作成--新しい-承認）を、そのアプリケーションのための
ウェブサイトではありません。

###のOAuth2キー/秘密

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール '/ユーザー/何？client_idの= XXXX＆client_secret = YYYY'
```

これは、サーバーのシナリオにサーバーで使用する必要があります。リークしないようにあなたの
ユーザーへのOAuthアプリケーションのクライアントシークレット。

{% if page.version == 'dotcom' %}

[more about unauthenticated rate limiting] 読む（＃増加- - 未認証のレート制限-用-OAuthの-アプリケーション）。

{% endif %}

###失敗したログイン制限

`401 Unauthorized`を返します無効な資格情報を使用する認証：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール-i -u FOO：バー
無断> HTTP / 1.1 401

> {
> "メッセージ"： "悪い資格情報」、
> "documentation_url"： "https://developer.github.com/v3"
> }
```

短い期間内に無効な資格情報を使用して複数の要求を検出した後、
APIは、一時的にそのユーザのすべての認証の試行を拒否します
`403 Forbidden`と（有効な資格情報を持つものを含みます）：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール-i -u valid_username：valid_password
> HTTP / 1.1 403禁止

> {
> "メッセージ"： "。ログイン試行の最大数を超えた後にもう一度試してください。"、
> "documentation_url"： "https://developer.github.com/v3"
> }
```

##ハイパーメディア

すべてのリソースは、他にリンクする1以上の `* _url`特性を有していてもよいです
リソース。これらは、明示的なURLを提供するために意図されているので、適切なAPIクライアント
自分でURLを作成する必要はありません。それは非常にそのAPIを推奨します
クライアントは、これらを使用しています。そうすることのためのAPIの将来のアップグレードが容易になります
[RFC 6570] 開発者。すべてのURLが適切なURIテンプレートであることが予想されます。 [rfc]

[uri_template] あなたはその後のようなものを使用して、これらのテンプレートを展開することができます [uri]
宝石：

{?since,all,participating} >> TMPL = URITemplate.new（ '/通知'）
>> tmpl.expand
=> "/通知」

>> tmpl.expand：すべて=> 1
=> "/通知？すべて= 1"

>> tmpl.expand：すべて=> 1、：参加=> 1
=> "/通知？すべて= 1＆参加= 1"

[rfc] ：http://tool​​s.ietf.org/html/rfc6570
[uri] ：https://github.com/hannesg/uri_template

##ページネーション

複数のアイテムを返す要求は、30項目にページ分割されます
デフォルト。あなたは `？page`パラメータを使用して、さらにページを指定することができます。いくつかのための
リソースは、あなたはまた、 `？per_page`パラメータで100のカスタムページサイズアップを設定することができます。
、技術的な理由ではないすべてのエンドポイントが `？per_page`パラメータを尊重することに注意してください
[events] 例えば（https://developer.github.com/v3/activity/events/）を参照してください。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール '/ユーザ/レポ？ページ= 2＆PER_PAGE = 100'
```

そのページ番号は1ベースであり、 `？page`を省略することに注意してください
パラメータは、最初のページを返します。

[Traversing with Pagination] ページネーションの詳細については、上の私たちのガイドをチェックしてください。 [pagination-guide]

リンクヘッダ###

ページネーション情報は、[リンクに含まれています
ヘッダ]（http://tool​​s.ietf.org/html/rfc5988）。それはすることが重要です
代わりに、独自のURLを構築するこれらのリンクヘッダーの値に従ってください。一部では
このような[コミットのようにインスタンス、
API]（/ V3 /レポ/ /コミット）、ページネーションをベースにしています
ページ番号にSHA1およびません。

<https://api.github.com/user/repos?page=3&per_page=100> リンク：; rel = "次"、
<https://api.github.com/user/repos?page=50&per_page=100> ; rel = "最後"

_Linebreakはreadability._のために含まれています

[Hypermedia] この [URI templates] `Link`レスポンスヘッダは、（http://tool​​s.ietf.org/html/rfc6570）などの拡張が必要な​​場合があり、そのいくつかのリンク関係、一つ以上の（/ V3 /＃ハイパーメディア）が含まれています。

可能な `rel`値は次のとおりです。

名前|説明
-----------|-----------|
`next` |結果を即座に次のページのリンク関係。
`last` |結果の最後のページのリンク関係。
`first` |結果の最初のページのリンク関係。
`prev` |結果の直前のページのリンク関係。

{% if page.version == 'dotcom' %}

##レート制限

基本認証またはOAuthのを使用して要求の場合、あなたは5000まで作ることができます
時間あたりの要求。認証されていない要求の場合、レート制限は、あなたがすることができます
時間あたり60の要求に作ります。認証されていない要求は、あなたのIPアドレスに関連付けられています
ユーザーは要求をしていません。 [検索APIは、カスタムレート制限があることに注意してください
ルール]（/ V3 /検索/＃のレート制限）。

あなたの現在を表示するには、任意のAPIリクエストの返されたHTTPヘッダを確認することができます
レート制限の状態：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i /ユーザーカール$ /何
> HTTP /1.1 200 OK
>日付：月、2013午後05時27分06秒GMT 7月1日
>ステータス： 200 OK
> X-RateLimitリミット：60
> X-RateLimit-残り： 56
> X-RateLimit-リセット： 1372700873
```

ヘッダをあなたの現在のレートリミットの状態を知るために必要なすべてのものを教えて：

ヘッダ名|説明
-----------|-----------|
`X-RateLimit-Limit` |消費者が時間当たりにするために許可されている要求の最大数。
`X-RateLimit-Remaining` |現在のレートリミットウィンドウ内に残っている要求の数。
[UTC epoch seconds] `X-RateLimit-Reset` |時刻は現在のレートリミットウィンドウが（http://en.wikipedia.org/wiki/Unix_time）にリセットされます。

あなたが別の形式で時間が必要な場合は、任意の近代的なプログラミング言語は、仕事を得ることができます。あなたのWeb​​ブラウザ上でコンソールを開く場合たとえば、あなたは簡単にJavaScriptのDateオブジェクトとしてリセット時間を得ることができます。

`` `ジャバスクリプト
新しい日付（* 1000年1372700873）
// =>月2013年7月1日13時47分53秒GMT-0400（EDT）
```

あなたはレート制限を乗り越えたら、エラー応答を受信します。

`` `コマンドライン
> HTTP / 1.1 403禁止
>日付：火、2013年午後02時50分41秒GMT 8月20日
>ステータス：403禁止
> X-RateLimitリミット： 60
> X-RateLimit-残り： 0
> X-RateLimit-リセット： 1377013266

> {
> "メッセージ"： "APIのレート制限は、xxx.xxx.xxx.xxxを超え（しかし、ここでは良いニュースだ：認証要求がより高いレートの上限を得るより多くの詳細についてはドキュメントを参照してください）​​。」、
> "documentation_url"： "https://developer.github.com/v3/#rate-limiting"
> }
```

[check your rate limit status] あなたがすることもでき（/ V3 / RATE_LIMIT）負うことなく
APIヒット。
<br>

###のOAuthアプリケーションのための認証されていないレート制限を増やします

あなたのOAuthアプリケーションは、より高いレート制限と認証されていない呼び出しを行うために必要がある場合は、クエリ文字列の一部として、アプリのクライアントIDとシークレットを渡すことができます。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $ -iカール '/ユーザー/何？client_idの= XXXX＆client_secret = YYYY'
> HTTP / 1.1 200 OK
>日付：月、2013午後05時27分06秒GMT 7月1日
>ステータス： 200 OK
> X-RateLimitリミット： 5000
> X-RateLimit-残り： 4966
> X-RateLimit-リセット：1372700873
```

このメソッドは、サーバーからサーバーへのコールに使用されるべきです。あなたは決してすべき
誰とでもクライアントの秘密を共有したり、クライアント側のブラウザのコードに含めます。

###レート制限内にとどまります

あなたは、基本認証またはOAuthのを使用している、とあなたは超えている場合
あなたのレート制限は、おそらくAPIの応答をキャッシュすることで問題を解決することができます
[conditional requests] そして、（＃条件付き要求）を使用。

あなたは条件付きリクエストを使用し、まだあなたの速度を超えている場合
[contact us] 制限は、要求するために喜ば [support]
あなたのOAuthアプリケーションのためのより高いレートの上限。

###乱用レート制限

GitHubのからのサービスの品質を保護するために、追加のレート制限は、いくつかのアクションに適用される場合があります。
例えば、急速コンテンツ、ポーリング積極的に代わりのウェブフックを使用して作成し、
同時実行性の高いAPI呼び出しを行う、または繰り返し計算コストでデータを要求します
虐待のレート制限をもたらす可能性があります。

任意の正当な使用を妨害し、このレート制限のためのものではありません
[rate limits] API。あなたの通常の（/ V3 /＃律速）のみであるべきです
[contact support] あなたのターゲットを制限します。あなたの使用はの影響を受けているしてください場合 [abuse-support]
このレート制限。あなたが良いのAPI市民として演技している確保するために、私たちをチェックアウト
[Best Practices guidelines] （/ガイド/ベストプラクティス--インテグレータに/）。

アプリケーションがこのレート制限をトリガする場合、あなたは情報が届きます
応答：

`` `コマンドライン
> HTTP / 1.1 403禁止
>のContent-Type：アプリケーション/ JSON。文字セット= UTF-8
>接続：閉じます

> {
> "メッセージ"： "あなたは虐待の検出メカニズムを引き起こしたし、一時的にコンテンツの作成からブロックされた後にもう一度リクエストを再試行してください。」、
> "documentation_url"： "https://developer.github.com/v3#abuse-rate-limits"
> }
```

{% endif %}

##ユーザーエージェントが必要

すべてのAPIリクエストは、有効な `ユーザーAgent`ヘッダを含まなければなりません。ノー `ユーザーAgent`と要求
{{ site.data.variables.product.product_name }} ヘッダが拒否されます。私たちは、あなたのユーザ名を使用することを要求したり、あなたの名前
`ユーザーAgent`ヘッダ値のためのアプリケーション、。これは、問題がある場合私たちはあなたに連絡することができます。

次に例を示します。

`` `コマンドライン
ユーザーエージェント：素晴らしい-Octocatアプリ
```

無効な `ユーザーAgent`ヘッダを提供する場合は、` 403 Forbidden`応答を受け取ります。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール-iH」のUser-Agent： '/メタ
> HTTP / 1.0 403禁止
>接続：閉じます
>のContent-Type：text / htmlの

>リクエストは、管理規則で禁止されています。
>あなたのリクエストはUser-Agentヘッダを持っていることを確認してください。
>その他の考えられる原因をhttps://developer.github.comを確認してください。
```

##条件付きリクエスト

ほとんどの応答は `ETag`ヘッダを返します。多くの応答も `最終-Modified`ヘッダを返します。あなたは値を使用することができます
これらのヘッダーを使用して、これらのリソースへの以降の要求を作るために
`場合 - なし -  Match`それぞれ`修飾する場合-Since`ヘッダ、。リソースの場合
変更されていない、サーバーは `304ませんModified`を返します。また、注意してください：作ります
条件付き要求と304応答を受け取るには、あなたにカウントされません。
[Rate Limit] （＃レート制限）ので、我々は可能な限りそれを使用することをお勧めします。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール-i /ユーザー
> HTTP /1.1 200 OK
>のCache-Control：プライベート、最大エージング= 60
>のETag： "644b5b0155e6404a9cc4bd9d8b1ae730"
> Last-Modifiedの：木、2012年7月5日15時31分30秒GMT
>ステータス： 200 OK
>構成変更：承諾、許可、クッキー
> X-RateLimitリミット： 5000
> X-RateLimit-残り： 4996
> X-RateLimit-リセット： 1372700873

{{ site.data.variables.product.api_url_pre }} 'の場合 - なし - 一致：「644b5b0155e6404a9cc4bd9d8b1ae730 "' $カール-i /ユーザー-H
> HTTP / 1.1 304は変更されません
>のCache-Control：プライベート、最大エージング= 60
>のETag： "644b5b0155e6404a9cc4bd9d8b1ae730"
> Last-Modifiedの：木、2012年7月5日15時31分30秒GMT
>ステータス：304は変更されません
>構成変更：承諾、許可、クッキー
> X-RateLimitリミット： 5000
> X-RateLimit-残り： 4996
> X-RateLimit-リセット： 1372700873

{{ site.data.variables.product.api_url_pre }} 「修飾された場合--ので：木、2012年7月5日夜三時31分30秒GMT "$カール-i /ユーザー-H
> HTTP / 1.1 304は変更されません
>のCache-Control：プライベート、最大エージング= 60
> Last-Modifiedの：木、2012年7月5日15時31分30秒GMT
>ステータス：304は変更されません
>構成変更：承諾、許可、クッキー
> X-RateLimitリミット：5000
> X-RateLimit-残り： 4996
> X-RateLimit-リセット： 1372700873
```

##クロスオリジンリソースの共有

APIはからAJAX要求のためのクロスオリジンリソースの共有（CORS）をサポートしています
任意の起源。
[CORS W3C Recommendation] あなたが読むことができる（http://www.w3.org/TR/cors/）、または
[this intro] （http://code.google.com/p/html5security/wiki/CrossOriginRequestSecurity）から
HTML 5セキュリティガイド。

ここでは、ブラウザの打撃から送信されたサンプルリクエストです
`のhttp：// example.com`：

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -i -H "：http://example.com起源"カール$
HTTP / 1.1 302見つけました
アクセス制御 - 許可 - 原産地：*
アクセス制御-公開-ヘッダ：ETagを、リンク、X-GitHubの-OTP、X-RateLimitリミット、X-RateLimit-残り、X-RateLimit・リセット、X-OAuthの-スコープ、X-受理-OAuthの-スコープ、 X-ポーリング間隔
Access-Control-Allow-Credentials：真
```

これは、CORSプリフライトリクエストは次のようになります。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} -Xオプション：$ -i -H "http://example.com起源」をカール
HTTP / 1.1 204コンテンツなし
アクセス制御 - 許可 - 原産地：*
アクセス制御 - 許可 - ヘッダ：許可、コンテンツタイプ、もしマッチ、変更 - 開始、もし-なしマッチ、場合-未修飾-以来、X-GitHubの-OTP、X-要求-付
アクセス制御 - 許可-方法：、、POST、PATCHをGET、PUT、DELETE
アクセス制御-公開-ヘッダ：ETagを、リンク、X-GitHubの-OTP、X-RateLimitリミット、X-RateLimit-残り、X-RateLimit・リセット、X-OAuthの-スコープ、X-受理-OAuthの-スコープ、 X-ポーリング間隔
アクセス制御 - マックス・年齢：86400
Access-Control-Allow-Credentials：真
```

## JSON-Pコールバック

あなたは結果を持っている任意のGET呼び出しに `？callback`パラメータを送信することができます
JSON関数に包まれました。ブラウザが欲しいときにこれは一般的に使用されています
{{ site.data.variables.product.product_name }} クロスドメインを歩き回ることで、Webページのコンテンツを埋め込みます
問題。反応は、通常のAPIと同じデータ出力を含み、
プラス関連するHTTPヘッダー情報。

`` `コマンドライン
$カールhttps://api.github.com?callback=foo

> / ** / fooの（{
> "メタ"：{
> "ステータス"：200、
> X-RateLimitリミット：5000
> X-RateLimit-残り：4966
> X-RateLimit-リセット：1372700873
> "リンク"：[//ページネーションヘッダとその他のリンク
>       ["https://api.github.com?page=2", {"rel": "next"}]
>     ]
>   },
> "データ"：{
> //データ
>   }
> })
```

あなたは、コールバックを処理するためのJavaScriptハンドラを記述することができます。ここでは、試してみることができ、最小限の例です：

<html>
<head>
<script type="text/javascript">
関数foo（レスポンス）{
するvarメタ= response.meta。
VARデータ= response.data。
Console.log（メタ）;
Console.log（データ）;
}

VARスクリプト=のdocument.createElement（ 'スクリプト'）;
Script.src = 'https://api.github.com?callback=foo';

[0] document.getElementsByTagName（ '頭'）.appendChild（スクリプト）;
</script>
</head>

<body>
<p> ブラウザのコンソールを開きます。 </p>
</body>
</html>

ヘッダーのすべてが1とHTTPヘッダと同じ文字列値です
顕著な例外：リンク。リンクヘッダーはあなたのために事前に解析されてきています
[url, options] ``タプルの配列としてを通じて。

このように見えるリンク：

<url1> リンク：; <url2> rel = "次"、。 rel = "foo"という。バーは= "バズ"

...コールバック出力に次のようになります。

<%= json "Link" => [
["url1", {:rel => "next"}],
["url2", {:rel => "foo", :bar => "baz"}]] %>

＃＃ 時間帯

いくつかの要求がタイムスタンプを指定するための許可または時間でタイムスタンプを生成します
ゾーン情報。我々はに、優先度の高い順に、次の規則を適用します
API呼び出しのタイムゾーン情報を決定します。

明示的にタイムゾーン情報とISO 8601のタイムスタンプを提供####

タイムスタンプが指定されるのを可能にするAPIコールのために、我々はその正確な使用します
[Commits API] タイムスタンプ。この例は、（/ / V3 / gitのコミット）です。

05：06 + 01：00これらのタイムスタンプは2014-02-27T15 `のようなものを見て。参照してください
[this example] （https://developer.github.com/v3/git/commits/#example-input）のために
どのようにこれらのタイムスタンプを指定することができます。

#### `タイムZone`ヘッダーを使用しました

応じてタイムゾーンを定義し `タイムZone`ヘッダを供給することが可能です
[list of names from the Olson database] （https://en.wikipedia.org/wiki/List_of_tz_database_time_zon​​es）へ。

`` `コマンドライン
{{ site.data.variables.product.api_url_pre }} $カール-H "タイムゾーン：ヨーロッパ/アムステルダム" -X POST /repos/github/linguist/contents/new_file.md
```

これは、我々はあなたのAPI呼び出しがで作られた瞬間のタイムスタンプを生成することを意味します
[Contents API] タイムゾーンこのヘッダが定義されています。たとえば、（/ V3 /レポ/コンテンツ/）
Gitは各追加または変更のコミット生成し、現在の時刻を使用しています
タイムスタンプとして。このヘッダは、生成するために使用するタイムゾーンを決定します
その現在のタイムスタンプ。

####ユーザーのための最後の既知のタイムゾーンを使用しました

何 `タイムZone`ヘッダーが指定されていないとされている場合は、への認証電話をかけます
APIは、私たちは、認証されたユーザーのために最後の既知のタイムゾーンを使用します。最後の既知の
{{ site.data.variables.product.product_name }} あなたがウェブサイトを閲覧するたびにタイムゾーンが更新されます。

＃＃＃＃ UTC

上記の手順は、任意の情報をもたらさない場合、我々は、タイムゾーンとしてUTCを使用します
Gitのコミットを作成することができます。

[support] ：https://github.com/contact?form [subject] = APIv3
[abuse-support] ：https://github.com/contact?form [subject] = API +乱用レート+リミット+
[pagination-guide] ：/ガイド/横断-で、ページネーション
��に使用するタイムゾーンを決定します
その現在のタイムスタンプ。

####ユーザーのための最後の既知のタイムゾーンを使用しました

何 `タイムZone`ヘッダーが指定されていないとされている場合は、への認証電話をかけます
APIは、私たちは、認証されたユーザーのために最後の既知のタイムゾーンを使用します。最後の既知の
{{ site.data.variables.product.product_name }} あなたがウェブサイトを閲覧す�