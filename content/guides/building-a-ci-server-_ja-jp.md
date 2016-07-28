---
タイトル：CIサーバの構築
---

＃CIサーバを構築します！

{:toc}

一緒にコミット同点に責任があります [Status API] [status API]
テストサービスは、すべてのあなたが作るプッシュは、テストの結果、表現することができるように、
プルリクエストを更新## {{ site.data.variables.product.product_name }}

このガイドでは、使用可能な設定を示すためにそのAPIを使用します。
このシナリオでは、我々は以下となります。

*プル要求が開かれたときに私たちのCIスイートを実行します（私たちは保留中にCIのステータスを設定します）。
CIが終了したら*、我々はそれに応じてプル要求のステータスを設定します。

私たちのCIシステムとホストサーバは、私たちの想像のfigmentsになります。彼らは可能性があり
トラヴィス、ジェンキンス、または完全に何か他のもの。このガイドの核心は、設定されます
そして、通信を管理するサーバを設定します。

あなたはまだ行っていない場合は、に必ず、および方法を学びます [download ngrok] [ngrok]
へ。それはローカル露出させるための非常に便利なツールであることが私たちを見つけます [use it] [using ngrok]
接続。

注：このプロジェクトのための完全なソースコードをダウンロードすることができます
[from the platform-samples repo][platform samples].

##サーバーを書きます

私たちは、ローカル接続が機能していることを証明するために迅速なシナトラアプリを書きます。
それでは、このを見てみましょう：

`` `ルビー
「シナトラ」を必要とします
「JSON」を必要とします

ポスト '/ event_handler'を実行
ペイロード= JSON.parse（paramsは） [:payload]
「まあ、それは働きました！」
終わり
```

（あなたはシナトラがどのように動作するかをよく知らないなら、私たちはお勧めします。） [reading the Sinatra guide] [Sinatra]

このサーバを起動します。あなたがたいと思うので、デフォルトでは、シナトラは、ポート `4567`で開始します
あまりにも、そのためのリスニングを開始するngrok設定します。

このサーバが動作するために、我々はウェブフックでリポジトリのセットアップを設定する必要があります。
ウェブフックは、プル要求が作成されるたびに起動するように構成された、またはマージする必要があります。
先に行くとあなたが遊んで満足しているリポジトリを作成します。私たちマイト
示唆している（https://github.com/octocat/Spoon-Knife）？ [@octocat's Spoon/Knife repository]
その後、あなたはそれをURLを供給し、あなたのリポジトリに新しいウェブフックを作成します
そのngrokはあなたを与えた、として `アプリケーション/ X-WWW-フォームurlencoded`を選択します
コンテンツタイプ：

！ [A new ngrok URL] （/assets/images/webhook_sample_url.png）

**アップデートウェブフックをクリックします。あなたは `まあ、それは働いた！`のボディ応答が表示されるはずです。
すばらしいです！ **私は**個々のイベントを選択してみましょう、と次の項目を選択しをクリックしてください。

状態
*プル要求

これらのイベントは、当社のサーバーに送信するときはいつでも、適切なアクション {{ site.data.variables.product.product_name }}
発生します。の*はちょうど、今すぐプルリクエストのシナリオを処理するために私たちのサーバーを更新してみましょう：

`` `ルビー
ポスト '/ event_handler'を実行
@payload = JSON.parse（paramsは） [:payload]

ケースrequest.env ['HTTP_X_GITHUB_EVENT']
ときに「pull_request」
@payloadは== "開かれた"場合 ["action"]
Process_pull_request（@payload） ["pull_request"]
終わり
終わり
終わり

ヘルパーが行います
デフprocess_pull_request（pull_request）
置く「それは＃です」 {pull_request['title']}
終わり
終わり
```

どうしたの？添付 `X-GitHubの-Event`を送出するすべてのイベント {{ site.data.variables.product.product_name }}
HTTPヘッダー。我々は今だけのためのPRイベントを気にします。そこから、我々はよ
情報のペイロードを取り、タイトル欄を返します。理想的なシナリオでは、
弊社のサーバーだけではなく、プルリクエストが更新されるたびに関係だろう
それが開かれていたとき。それはすべての新しいプッシュはCIテストに合格していることを確認してくださいだろう。
しかし、このデモのために、私達はちょうどそれが開いていたときに心配します。

この概念実証をテストするには、あなたのテストでブランチのいくつかの変更を加えます
リポジトリ、およびプルリクエストをオープン。あなたのサーバーは、それに応じて応答する必要があります！

##状態での作業

代わりに私たちのサーバーでは、我々は我々の最初の要件を開始する準備が整いました
設定（および更新）CIのステータス。いつでもあなたのサーバーを更新することに注意してください、
あなたは、同じペイロードを送信するために**再配信**クリックすることができます。する必要はありません
新しいプル要求変更を加えるたびに！

我々は、APIと対話しているので、我々が使用します {{ site.data.variables.product.product_name }} [Octokit.rb] [octokit.rb]
私たちの相互作用を管理することができます。私たちは、とそのクライアントを設定します
[a personal access token][access token]:

`` `ルビー
＃!!! EVER REALアプリでハードコードされた値は、使用しないでください！
＃その代わりに、以下のように、変数を設定し、テスト環境
Access_tokenは= ENV ['MY_PERSONAL_TOKEN']

前にやります
@client || = Octokit :: Client.new（：access_tokenは=> access_tokenは）
終わり
```

その後、私達はちょうど明確にする上で、プルリクエストを更新する必要があります {{ site.data.variables.product.product_name }}
我々は、CIに処理していること：

`` `ルビー
デフprocess_pull_request（pull_request）
プット「プルリクエストを処理しています... "
@ ['base'] ['repo'] ['full_name'] client.create_status（pull_request、pull_request、「保留中」） ['head'] ['sha']
終わり
```

ここでは3つの非常に基本的なことをやっています：

*我々は、リポジトリの完全な名前を探しています
*我々は、プル要求の最後のSHAを探しています
*私たちは、「保留」にステータスを設定しています

それでおしまい！ここから、あなたが実行するためにする必要がどのようなプロセスを実行することができます
あなたのテストスイート。たぶん、あなたはジェンキンス、またはコールにコードをオフに渡すつもりです
そのAPIを介して、他のWebサービスに、など。その後、あなたがしたいです [Travis] [travis api]
もう一度ステータスを更新してください。この例では、単に ``「成功」に設定します：

`` `ルビー
デフprocess_pull_request（pull_request）
@ ['base'] ['repo'] ['full_name'] client.create_status（pull_request、pull_request、「保留中」） ['head'] ['sha']
睡眠2＃は忙しい仕事を...
@ ['base'] ['repo'] ['full_name'] client.create_status（pull_request、pull_request、「成功」） ['head'] ['sha']
「プルリクエストを処理！ "置きます
終わり
```

##おわり

GitHubのでは、我々は何年も私たちのCIを管理するためのバージョンを使用しました。 [Janky] [janky]
基本的な流れは、基本的に、我々は、上記構築したサーバーとまったく同じです。
GitHubので、私たち：

（変な経由で）プル要求が作成または更新されたジェンキンスさんへ*火災
* CIの状態での応答を待ちます
コー​​ドが緑の場合*、我々はプル要求をマージ

この通信のすべては、私たちのチャットルームに戻って注ぎ込まれます。あなたがする必要はありません
この例を使用するために、独自のCIのセットアップを構築します。
あなたはいつもに依存することができます。 [third-party services] [integrations]

[deploy API] ：/ V3 /レポ/展開/
[status API] ：/ V3 /レポ/ステータス/
[ngrok] ：https://ngrok.com/
[using ngrok] ：/ウェブフック/設定/＃使用して、ngrok
[platform samples] ：https://github.com/github/platform-samples/tree/master/api/ruby/building-a-ci-server
[Sinatra] ：http://www.sinatrarb.com/
[webhook] ＃ウェブフック！
[octokit.rb] ：https://github.com/octokit/octokit.rb
[access token] ：https://help.github.com/articles/creating-an-access-token-for-command-line-use
[travis api] ：https://api.travis-ci.org/docs/
[janky] ：https://github.com/github/janky
[heaven] ：https://github.com/atmos/heaven
[hubot] ：https://github.com/github/hubot
[integrations] ：https://github.com/integrations
��トルームに戻って注ぎ込まれます。あなたがする必要はありません
この例を使用するために、独自のCIのセットアップを構築します。
あなたはいつもに依存することができます。 [third-party services] [integrations]

[deploy API] ：/ V3 /レポ/展開/
[status API] ：/ V3 /レポ/ステータス/
[ngrok] ：https://ngrok.com/
[using ngrok] ：/ウェブフック/設定/＃使用して、ng