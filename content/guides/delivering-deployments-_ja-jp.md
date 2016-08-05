---
タイトル：展開を実現
---

＃展開を実現！

{:toc}

で上のホストされたプロジェクトを提供 [Deployments API] {{ site.data.variables.product.product_name }} [deploy API]
あなたが所有するサーバーにそれらを起動する機能。と組み合わせ
[the Status API] [status API] 、あなたの展開を調整することができます
瞬間、あなたのコードはmaster` `に着地します。

このガイドでは、使用可能な設定を示すためにそのAPIを使用します。
このシナリオでは、我々は以下となります。

*プルリクエストをマージ
CIが終了したら*、我々はそれに応じてプル要求のステータスを設定します。
プルリクエストがマージされた場合*、我々は我々のサーバに私たちの展開を実行します。

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
@payload = JSON.parse（paramsは） [:payload]
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

：/assets/images/webhook_sample_url.png [A new ngrok URL]

**アップデートウェブフックをクリックします。あなたは `まあ、それは働いた！`のボディ応答が表示されるはずです。
すばらしいです！ **私は**個々のイベントを選択してみましょう、と次の項目を選択しをクリックしてください。

*展開
*展開状況
*プル要求

これらのイベントは、当社のサーバーに送信するときはいつでも、適切なアクション {{ site.data.variables.product.product_name }}
発生します。プルリクエストをマージする場合我々は*だけ*ハンドルに私たちのサーバーを構成します
たった今：

`` `ルビー
ポスト '/ event_handler'を実行
@payload = JSON.parse（paramsは） [:payload]

ケースrequest.env ['HTTP_X_GITHUB_EVENT']
ときに「pull_request」
場合@payload == ["action"] "クローズド" && @payload ["pull_request"] ["merged"]
「...プルリクエストがマージされました！展開が今開始する必要があります "置きます
終わり
終わり
終わり
```

どうしたの？添付 `X-GitHubの-Event`を送出するすべてのイベント {{ site.data.variables.product.product_name }}
HTTPヘッダー。我々は今だけのためのPRイベントを気にします。プル要求がある場合
マージされ、私たちは展開をキックオフします（その状態がmerged`が `true`にある` `でclosed`、と）。

この概念実証をテストするには、あなたのテストでブランチのいくつかの変更を加えます
リポジトリ、およびプルリクエストをオープン。あなたのサーバーは、それに応じて応答する必要があります！

##の展開を使用した作業

代わりに私たちのサーバーを使用すると、コードが見直され、私たちのプル要求されています
マージされ、私たちは私たちのプロジェクトを展開することにしたいです。

我々は、彼らがいるときにプル要求を処理するために、私たちのイベントリスナーを変更することから始めます
マージ、および展開に注意を払って起動します。

`` `ルビー
ときに「pull_request」
場合@payload == ["action"] "クローズド" && @payload ["pull_request"] ["merged"]
Start_deployment（@payload） ["pull_request"]
終わり
ときに「展開」
Process_deployment（@payload）
ときに「deployment_status」
Update_deployment_status
終わり
```

プルリクエストからの情報に基づいて、我々は記入して始めましょう
`start_deployment`方法：

`` `ルビー
デフstart_deployment（pull_request）
ユーザー= pull_request ['user'] ['login']
ペイロード= JSON.generate（：環境=> '生産'、：deploy_user =>ユーザー）
@ ['head'] ['repo'] ['full_name'] client.create_deployment（pull_request、pull_request、） ['head'] ['sha'] {:payload => payload, :description => "Deploying my sweet branch"}
終わり
```

展開は `payload`の形で、それらに取り付けられたいくつかのメタデータを持つことができます
そして、 `description`。これらの値はオプションですが、それを使用すると便利です
ロギング情報を表します。

新しい展開が作成されると、完全に別のイベントがtriggedされます。それです
なぜ我々は `deployment`のイベントハンドラで新しい` switch`ケースを持っています。あなたはできる
展開がトリガされたときに通知されるように、この情報を使用します。

展開はかなり長い時間がかかることがありますので、私たちは様々なイベントをリッスンしたいと思います、
このような展開が作成され、どのような状態それは中だしたときと。

それでは、いくつかの作業を行い、展開をシミュレートしてみましょう、とそれが与える影響に気付きます
出力。まず、私たちの `process_deployment`方法を完了してみましょう：

`` `ルビー
デフprocess_deployment
ペイロード= JSON.parse（@payload） ['payload']
＃あなたはなど、あなたのチャットルーム、モニター、ページャ、この情報を送信することができます
「＃に＃するための処理 '＃' "を置きます {@payload['description']} {payload['deploy_user']} {payload['environment']}
睡眠2＃は仕事をシミュレート
@ {@payload['repository']['full_name']} client.create_deployment_status（「レポ/＃/展開/＃」、「保留中」） {@payload['id']}
睡眠2＃は仕事をシミュレート
@ {@payload['repository']['full_name']} client.create_deployment_status（「レポ/＃/展開/＃」、「成功」） {@payload['id']}
終わり
```

最後に、我々は、コンソール出力としてステータス情報を格納シミュレートします。

`` `ルビー
デフupdate_deployment_status
「＃の展開状況は＃ "置きます {@payload['id']} {@payload['state']}
終わり
```

それでは、何が起こっているのか分解してみましょう。新しい展開はstart_deployment` `によって作成され、
これは `deployment`イベントをトリガします。そこから、我々は `process_deployment`を呼び出します
起こっているの作業をシミュレートします。その処理中に、我々はまたに電話をかけます
受信機は、私たちのように、何が起こっているのかを知ることができます `create_deployment_status`、
Pending` `にステータスを切り替えます。

展開が完了したら、我々はSUCCESS` `にステータスを設定します。

##おわり

GitHubのでは、我々は何年も私たちのCIを管理するためのバージョンを使用しました。 [Heaven] [heaven]
基本的な流れは、基本的に、我々は、上記構築したサーバーとまったく同じです。
私たちは、上記構築したサーバー。 GitHubので、私たち：

* CIの状態での応答を待ちます
コー​​ドが緑の場合*、我々はプル要求をマージ
*天国は、マージされたコードを取得し、当社の生産とステージングサーバーにデプロイします
*一方で、天はまた私達のチャットルームに座っを経由して、ビルドに関するすべての人に通知します [Hubot] [hubot]

それでおしまい！あなたはこの例を使用するために、独自の展開のセットアップを構築する必要はありません。
あなたはいつもに依存することができます。 [third-party services] [integrations]

[deploy API] ：/ V3 /レポ/展開/
[status API] ＃CIサーバを構築します！
[ngrok] ：https://ngrok.com/
[using ngrok] ：/ウェブフック/設定/＃使用して、ngrok
[platform samples] ：https://github.com/github/platform-samples/tree/master/api/ruby/delivering-deployments
[Sinatra] ：http://www.sinatrarb.com/
[webhook] ＃ウェブフック！
[https://github.com/octokit/octokit.rb] ：http://www.unixwiz.net/techtips/ssh-agent-forwarding.html
[access token] ：https://help.github.com/articles/creating-an-access-token-for-command-line-use
[travis api] ：https://api.travis-ci.org/docs/
[janky] ：https://github.com/github/janky
[heaven] ：https://github.com/atmos/heaven
[hubot] ：https://github.com/github/hubot
[integrations] ：https://github.com/integrations
�！あなたはこの例を使用するために、独自の展開のセットアップを構築する必要はありません。
あなたはいつもに依存することができます。 [third-party services] [integrations]

[deploy API] ：/ V3 /レポ/展開/
[status API] ＃CIサーバを構築します！
[ngrok] ：https://ngrok.com/
[using ngrok] ：/ウェブフック/設定/�