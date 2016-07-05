---
タイトル：問題のコメント
---

注釈

{:toc}

問題のコメントAPIは、リスト、表示、編集、および作成をサポートしています
問題とプル要求のコメント。

[these custom media types] 問題のコメント（＃カスタムメディアタイプ）を使用します。
APIのメディアタイプの使用についての詳細を読むことができます
[here] （/ V3 /メディア/）。

##リストは、この問題についてコメント

所有者/：：レポ/プル/：数/コミット/レポは/ GET

問題のコメントはIDを昇順に並べられています。

＃＃ パラメーター

`NAME` |` type`が|説明。
-----|------|--------------
`since` |` STRING` |この時以降に更新されたコメントだけが返されます。これは、ISO 8601形式のタイムスタンプです： `YYYY-MM-DD T HH：MM：SSZ`。

応答。

<%= headers 200, :pagination => default_pagination_rels％>
<%= json(:issue_comment) { |h| [h] } %>

リポジトリ内の##のリストのコメント

所有者/：：レポ/問題/コメント/レポ/ GET

デフォルトでは、問題のコメントはIDを昇順に並べられています。

＃＃ パラメーター

`NAME` |` type`が|説明。
-----|------|--------------
`sort` |` STRING` |どちらか `created`または` updated`。デフォルト： `created`
`direction` |` STRING` |どちらか `asc`または` desc`。 `sort`パラメータを指定せずに無視されます。
`since` |` STRING` |この時以降に更新されたコメントだけが返されます。これは、ISO 8601形式のタイムスタンプです： `YYYY-MM-DD T HH：MM：SSZ`。


応答。

<%= headers 200 %>
<%= json(:issue_comment) { |h| [h] } %>

##単一のコメントを取得

GET /レポ/：所有者/：レポ/問題/コメント/：ID

応答。

<%= headers 200, :pagination => default_pagination_rels％>
<%= json :issue_comment %>

##コメントを作成します。

POST /レポ/：所有者/：レポ/問題/：数/コメント

###入力

`NAME` |` type`が|説明。
-----|------|--------------
`body` |` STRING` |プル要求の内容。


<%= json :body => 「私も "％>

応答。

<%= headers 201, :Location => get_resource（：issue_comment）％> ['url']
<%= json :issue_comment %>

##コメントを編集します

PATCH /レポ/：所有者/：レポ/問題/コメント/：ID

###入力

`NAME` |` type`が|説明。
-----|------|--------------
`body` |` STRING` |プル要求の内容。


<%= json :body => 「私も "％>

応答。

<%= headers 200 %>
<%= json :issue_comment %>

##コメントを削除

DELETE /レポ/：所有者/：レポ/問題/コメント/：ID

応答。

<%= headers 204 %>

##カスタムメディアタイプ

これらは、プル要求のためにサポートされているメディアの種類です。あなたはについての詳細を読むことができます
[here] APIのメディアタイプを使用する（/ V3 /メディア/）。

アプリケーション/ vnd.github.VERSION.raw + JSON
アプリケーション/ vnd.github.VERSION.text + JSON
アプリケーション/ vnd.github.VERSION.html + JSON
アプリケーション/ vnd.github.VERSION.full + JSON
s 201, :Location => get_resource（：issue_comment）％> ['url']
<%= json :issue_comment %>

##コメントを編集します

PATCH /レポ/：所有者/：レポ/問題/コメント/：ID

###入力

`NAME` |` type`が|説明。
-----|------|--------------
`body` |` STRING` |プル要求の内容。


<%= json :body => 「私も "％>

応答。

<%= headers 200 %>
<%= json :issue_comment %>

##コメントを削除

DELETE /レポ/：所有者/：レポ/問題/コメント/：ID

応答。

<%= headers 204 %>

##カスタムメディアタイプ

これらは、プル要求のためにサポートされているメディアの種類です。あなたはについての詳細を読むことができます
[here] APIのメディアタイプを使用する（/ V3 /メディア/）。

アプリケーション/ vnd.github.VE