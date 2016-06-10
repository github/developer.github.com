---
タイトル：あなたのウェブフックを確保
レイアウト：ウェブフ​​ック
---

＃あなたのウェブフックを確保！

{:toc}

サーバーがペイロードを受信するように構成されたら、それはあなたが設定されたエンドポイントに送信されたペイロードをリッスンします。セキュリティ上の理由から、あなたはおそらく、GitHubのから来たものへの要求を制限したいです。例えば、あなたはGitHubでのIPアドレスからホワイトリストの要求に選ぶことができ -   - そこにこのについて移動するいくつかの方法があるが、はるかに容易に方法は秘密のトークンを設定し、情報を検証することです。


あなたの秘密のトークンを設定する##

GitHubのとサーバー：次の2つの場所であなたの秘密のトークンを設定する必要があります。

GitHubの上であなたのトークンを設定するには：

1.あなたのウェブフックを設定しているリポジトリに移動します。
2.シークレットテキストボックスに必要事項を記入してください。高エントロピーでランダムな文字列を使用します（ルビー-rsecurerandom -e `の出力を取ることによって、例えば`端末での 'SecureRandom.hex（20）を置きます'）。
[Webhook secret token field] ！ （/assets/images/webhook_secret_token.png）
3. [**更新ウェブフック**。

次に、このトークンを格納するサーバー上の環境変数を設定します。通常、これは実行するだけです：

`` `コマンドライン
<em> $輸出SECRET_TOKEN </em> = your_token
```

** **アプリにトークンをハードコーディングしないでください！

##のGitHubからペイロードを検証

[in our Ruby implementation] あなたの秘密のトークンが設定されている場合は、GitHubには、それぞれのペイロードを持つハッシュ署名を作成するためにそれを使用しています。あなたは、実装の詳細を見つけることができます。 [ruby-secret]

このハッシュ署名は `X-ハブSignature`としてヘッダー内の各要求とともに渡されます。あなたはこのように見えるウェブフックを聞いて、基本的なサーバーがあるとします。

`` `ルビー
「シナトラ」を必要とします
「JSON」を必要とします

ポスト '/ペイロード'を実行
[:payload] プッシュ= JSON.parse（paramsは）
{push.inspect} "私はいくつかのJSONを得た：＃"置きます
終わり
```

目標は、あなたの `SECRET_TOKEN`を使用してハッシュを計算し、GitHubのからハッシュが一致していることを確認することです。 GitHubのは、ハッシュを計算するために、HMACのhexdigestを使用していますので、あなたはこのように少し見えるようにサーバーを変更することができます：

`` `ルビー
ポスト '/ペイロード'を実行
Request.body.rewind
Payload_body = request.body.read
Verify_signature（payload_body）
[:payload] プッシュ= JSON.parse（paramsは）
{push.inspect} "私はいくつかのJSONを得た：＃"置きます
終わり

デフverify_signature（payload_body）
['SECRET_TOKEN'] 署名= 'SHA1 =' +のOpenSSL :: HMAC.hexdigest（OpenSSLの:: Digest.new（ 'SHA1'）、ENV、payload_body）
['HTTP_X_HUB_SIGNATURE'] 停止500を返し、「署名が一致しませんでした！」場合を除き、ラック:: Utils.secure_compare（署名、request.env）
終わり
```

明らかに、あなたの言語とサーバーの実装は、このコードよりも異なる場合があります。しかし、指摘するために非常に重要なことがいくつかあります：

*ご使用の実装に関係なく、ハッシュ署名があなたの秘密トークンのキーとペイロード体を使用して、 `SHA1 =`で始まります。

[`secure_compare`] *プレーン [secure_compare] `==`演算子を使用すると、** **お勧めではありません。以下のような方法は、通常の等価演算子に対して一定のタイミング攻撃から安全にそれをレンダリングする「一定時間」文字列の比較を行います。

[ruby-secret] ： https://github.com/github/github-services/blob/14f4da01ce29bc6a02427a9fbf37b08b141e81d9/lib/services/web.rb#L47-L50
[secure_compare] ：http://rubydoc.info/github/rack/rack/master/Rack/Utils.secure_compare
た！」場合を除き、ラック:: Utils.secure_compare（署名、request.env）
終わり
```

明らかに、あなたの言語とサーバーの実装は、このコードよりも異なる場合があります。しかし、指摘するために非常に重要なことがいくつかあります：

*ご使用の実装に関係なく、ハッシュ署名があなたの秘密トークンのキーとペイロード体を使用して、 `SHA1 =`で始まります。

[`secure_compare`] *プレーン [secure_compar