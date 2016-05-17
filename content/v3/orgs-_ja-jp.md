---
タイトル：団体
---

＃組織!!!

{:toc}

##あなたの組織を一覧表示

認証されたユーザのリスト団体。

###のOAuthスコープの要件

あなたの許可があなたには、いくつかの方法でオン動作することを可能にするこのリストだけの組織（例えば、あなたがチームを一覧表示することができます `読み：org`範囲を、あなたは` user`スコープなどで組織のメンバーシップを公表することができます）。 org`範囲：したがって、このAPIは、少なくとも `user`または`読みが必要です。不十分な範囲でのOAuthリクエストは `403 Forbidden`応答を受け取ります。

GET /ユーザー/ [組織

応答。

<%= headersnull :pagination => default_pagination_rels％>
<%= json(:org) { |h| [h] } %>

##すべての組織を一覧表示

{{ site.data.variables.product.product_name }} 彼らが作成された順序で、すべての組織をLists。

注意：ページネーションは `since`パラメータによって独占的に供給されています。
[Link header] の次のページのURLを取得する（/ V3 /＃リンクヘッダ）を使用します
団体。

GET /団体

＃＃ パラメーター

`NAME` |` type`が|説明。
-----|------|--------------
`since` |` STRING` |あなたが見てきた最後の組織の整数ID。

応答。

<%= headers 200, :pagination => { :next => 'https://api.github.com/organizations?since=135' } %>
<%= json(:org) {|h| [h] } %>

##リストのユーザー組織

[public organization memberships] 指定したユーザーのリスト（https://help.github.com/articles/publicizing-or-concealing-organization-membership）。

[List your organizations] このメソッドは関係なく、認証の、*公共*メンバーシップを示しています。あなたが認証されたユーザーのための組織のメンバーシップ（パブリックとプライベート）の全てを取得する必要がある場合は、代わりに（＃リスト - あなたの-団体）APIを使用します。

GET /ユーザー/：ユーザー名/ [組織

応答。

<%= headersnull :pagination => default_pagination_rels％>
<%= json(:org) { |h| [h] } %>

##ゲット組織

GET / [組織/：ORG

応答。

<%= headers 200 %>
<%= json(:full_org) %>

##団体を編集します

PATCH / [組織/：ORG

###入力

`NAME` |` type`が|説明。
-----|------|--------------
`billing_email` |` STRING` |請求先のメールアドレス。このアドレスは公表されていません。
`company` |` STRING` |会社名。
`email` |` STRING` |一般公開のメールアドレス。
`location` |` STRING` |場所。
`NAME` |` STRING` |会社の短縮名。
`description` |` STRING` |会社の説明。

####例

<％= jsonの\
：billing_email => "support@github.com」、
：ブログ=> "https://github.com/blog」、
：会社=> "GitHubの"、
：メール=> "support@github.com」、
：場所=> "サンフランシスコ"、
：名前=> "githubの"、
：説明=> "GitHubの、会社。"
%>

応答。

<%= headers 200 %>
<%= json(:private_org) %>
��ユーザー名/ [組織

応答。

<%= headersnull :pagination => default_pagination_rels％>
<%= json(:org) { |h| [h] } %>

##ゲット組織

GET / [組織/：ORG

応答。

<%= headers 200 %>
<%= json(:full_org) %>

##団体を編集します

PATCH / [組織/：ORG

###入力

`NAME` |` type`が|説明。
-----|------|--------------
`billing_email` |` STRING` |請求先のメールアドレス。このアドレスは公表されていません。
`company` |` STRING` |会社名。
`email` |` STRING` |一般公開のメールアドレス。
`location` |` STRING` |場所。
`NAME` |` STRING` |会社の短縮名。
`description` |` STRING` |会社の説明。

####例

<％= jsonの\
：billing_email => "support@github.com」、
：ブログ=> "https://github.com/blog」、
：会社=> "GitHubの"、
：メール=> "support@github.com」、
：場所=> "サンフランシスコ"、
：名前=> "githubの"、
：説明=>