---
タイトル：組織ウェブフック
---

＃ウェブフック！

{:toc}

{% if page.version != 'dotcom' and page.version <= 2.2 %}

{{#tip}}

組織ウェブフックAPIは、プレビューする開発者のための現在利用​​可能です。
プレビュー期間中は、APIは予告なく変更することがあります。
[blog post] 完全な詳細については、（/変更/ 2014年12月3日 - プレビュー - 新組織 - ウェブフック-APIを/）を参照してください。

[media type] プレビュー期間中にAPIにアクセスするには、 {{ page.version }} `Accept`ヘッダ内のカスタム（/ V3 /メディア）を提供する必要があります。

```
アプリケーション/ vnd.github.polarisプレビュー+ JSON
```

{{/tip}}

{% endif %}

[Events documentation] 組織ウェブフックは、特定のイベントが組織内で起こるたびに、HTTP [webhook-events] `POST`ペイロードを受信することができます。これらのイベントへの登録GitHub.com上のアクションに反応する統合を構築することが可能となります。あなたが購読できるアクションの詳細については、私たちをチェックしてください。

##スコープおよび制限事項

[the `admin:org_hook` scope] 組織のウェブフックに対するすべてのアクションは、組織の管理者が管理されていることを認証されたユーザーが必要です。また、OAuthのトーク​​ンは（/ V3 /のOAuth /＃スコープ）が必要です。

ウェブフック構成で存在することがある機密データを保護するために、我々はまた、以下のアクセス制御規則を適用します。

-  OAuthのアプリケーションは、自分が作成していない、ビュー、または編集ウェブフックをリストすることはできません。
- ユーザーは、OAuthのアプリケーションによって作成されたビュー、または編集ウェブフックをリストすることはできません。

##リストフック

GET / [組織/：ORG

応答。

<%= headers 200, :pagination => default_pagination_rels％>
<%= json(:org_hook) { |h| [h] } %>


##ゲットシングルフック

GET / [組織/：ORG /フック/：ID

応答。

<%= headers 200 %>
<%= json :org_hook %>


##フックを作成します。

POST / [組織/：ORG /フック

＃＃ パラメーター

名前|タイプ|説明
-----|------|--------------
`NAME` |` STRING` | **必須**。 「ウェブ」として渡されなければなりません。
[These are defined below] `config`を|` object` | **必須**。キー/値のペアは、このウェブフックの設定を提供します。 （＃作成フック-config設定-paramsはを）。
[events] `events` [event-types] |` ["push"] array` |フックのためにトリガされるものを決定します。デフォルト： ``。
`active` |` boolean` |フックは、実際にプッシュでトリガされるかどうかを決定します。

<a name="create-hook-config-params"></a>
`config`をオブジェクトには、次のキーを受け入れることができます：

<%= fetch_content(:org_hook_config_hash) %>

####例

ここでは、JSON形式でポストペイロードフックを作成することができます方法は次のとおりです。

<％= jsonの\
：名前=>「ウェブ」、
：アクティブ=> trueを、
['push', 'pull_request'] ：イベント=>、
：設定=> {
：URL => 'http://example.com/webhook」、
：CONTENT_TYPE => 'JSON'}
%>

応答。

<%= headers 201, :Location => get_resource（：org_hook）％> ['url']
<%= json :org_hook %>


フックを##編集

PATCH / [組織/：ORG /フック/：ID

＃＃ パラメーター

名前|タイプ|説明
-----|------|--------------
[These are defined below] `config`を|` object` | **必須**。キー/値のペアは、このウェブフックの設定を提供します。 （＃更新フック-config設定-paramsは）。
[events] `events` [event-types] |` ["push"] array` |フックのためにトリガされるものを決定します。デフォルト： ``。
`active` |` boolean` |フックは、実際にプッシュでトリガされるかどうかを決定します。

<a name="update-hook-config-params"></a>
`config`をオブジェクトには、次のキーを受け入れることができます：

<%= fetch_content(:org_hook_config_hash) %>


####例

<％= jsonの\
：アクティブ=> trueを、
['pull_request'] ：イベント=>
%>

応答。

<%= headers 200 %>
<%= json(:org_hook) { |h| H.merge "events" => > %w "pull_request"：{


## Pingのフック

[ping event] これは、フックに送信されるようにトリガします。 [ping-event-url]

POST / [組織/：ORG /フック/：ID /ピング

応答。

<%= headers 204 %>


##フックを削除します。

DELETE / [組織/：ORG /フック/：ID

応答。

<%= headers 204 %>


##ウェブフックを受信します

{{ site.data.variables.product.product_name }} ウェブフックペイロードを送信するためには、ご使用のサーバーは、インターネットからアクセスできる必要があります。我々はHTTPSで暗号化されたペイロードを送信できるように、我々はまた、高度にSSLを使用して示唆しています。

[see our guide] より多くのベストプラクティスについては、。 [best-integration-practices]

###ウェブフックヘッダ

{{ site.data.variables.product.product_name }} イベントタイプとペイロード識別子を区別するために、いくつかのHTTPヘッダに沿って送信されます。

名前|説明
-----|-----------|
[event type] `X-GitHubの-Event` |誘発された（/ V3 /活動/イベント/種類/）。
[guid] `X-GitHubの-Delivery` [guid] |ペイロードと、イベントが送信されている識別します。
`X-ハブSignature` |このヘッダの値をキーとして `secret` configオプションを使用して、体のHMAC六角ダイジェストとして計算されます。


[guid] ：http://en.wikipedia.org/wiki/HTTP_ETag
[hub-signature] ： https://github.com/github/github-services/blob/f3bb3dd780feb6318c42b2db064ed6d481b70a1f/lib/service/http_helper.rb#L77
[ping-event-url] ：/ウェブフック/＃ピングイベント
[webhook-events] ：/ウェブフック/＃イベント
[event-types] ：/ V3 /活動/イベント/種類/
[media-type] （/ V3 /メディア/）。
[best-integration-practices] （/ガイド/ベストプラクティス--インテグレータに/）。
[developer-blog-post] ：/変更/ 2014年12月3日 - プレビュー - 新組織 - ウェブフック-API /
�|説明
-----|-----------|
[event type] `X-GitHubの-Event` |誘発された（/ V3 /活動/イベント/種類/）。
[guid] `X-GitHubの-Delivery` [guid] |ペイロードと、イベントが送信されている識別します。
`X-ハブSignature` |このヘッダの値をキーとして `secret` configオプションを使用して、体のHMAC六角ダイジェストとして計算されます。


[guid] ：http