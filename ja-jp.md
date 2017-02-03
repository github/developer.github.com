＃developer.github.com（https://travis-ci.org/github/developer.github.com.svg?branch=master)](https://travis-ci.org/github/developer.github.com ） [![Build Status]


これはで構築されたのGitHub APIリソースです。 [Nanoc] [nanoc]

すべての応募を歓迎します。 、変更を送信このレポをフォーク、変更をコミットし、私たち（http://help.github.com/send-pull-requests/）を送信します。 [pull request]

進行中の##の開発

あなたは、コマンドラインを開き、 `スクリプト/ bootstrap`を実行して、最新の依存関係を取得することができます。

`` `shを
$スクリプト/ブートストラップ
==>宝石の依存関係をインストールしています...
==> NPMの依存関係をインストールしています...
```

あなたはRubyとノードがシステムにインストールされている必要があります。これらの言語のそれぞれのための必要なバージョンはそれぞれ、* .rubyバージョンの*と* package.json *ファイルで見つけることができます。

あなたはサイトを生成するために `バンドルのexecすくいbuild`を実行することができますが、それは多くの場合便利です
単にサーバー*を構築し、*同時にサイトを開始します。

Nanocはoutput` `に住んで静的ファイルにサイトをコンパイルします。その
未変更のファイルをコンパイルしようとしないように十分にスマート。

あなたは `スクリプト/ server`でサイトを開始することができます。

`` `shを
$スクリプト/サーバー
読み込んでサイトのデータ...
サイトのコンパイル...
出力/ [0.28s] index.htmlを作成
出力/ [1.31s] V3 /要旨/コメント/ index.htmlを作成
同一の出力/ [1.92s] V3 /要旨/ index.htmlを
同一の出力/ [0.25s] V3 /問題/コメント/ index.htmlを
出力/ [0.99s] V3 /問題/ラベル/ index.htmlをを更新
出力/ [0.05s] V3 / index.htmlを更新
…

5.81sでコンパイルされたサイト。
```

サイトは、HTTP `でホストされています：// localhostを：4000`。

Nanocは、あなたが始めるために（http://nanoc.ws/docs/tutorial/）を有しています。あなたが編集や追加コンテンツを主とならけれども、あなたはNanocについて多くを知っている必要はありません。 [some nice documentation]

[nanoc]: http://nanoc.ws/

###エンタープライズ

`/ enterprise`バージョンを生成するには、スクリプト/ server``にEnterpriseバージョンを渡します。例えば：

`` `shを
$スクリプト/サーバ2.6
```

ライブリロードがEnterpriseのマニュアルでは使用できませんので注意してください。

##スタイルガイド

いないドキュメントを構造化する方法がわから？ここでは何の構造
APIドキュメントは、次のようになります。

＃APIのタイトル

{:toc}

## APIエンドポイントのタイトル

[VERB] /パス/に/エンドポイント

＃＃＃ パラメーター

名前|タイプ|説明
-----|------|--------------
`NAME` |` type`が|説明。

###入力（要求JSON本体）

名前|タイプ|説明
-----|------|--------------
`NAME` |` type`が|説明。

###レスポンス

<%= headers 200, :pagination => default_pagination_rels、 'X-カスタムヘッダー' => "値"％>
<%= json :resource_name %>

**注：私たちは、このような定義リストとして、（http://kramdown.gettalong.org/syntax.html）を使用しています。 [Kramdown Markdown extensions]

### JSONレスポンス

我々は記述する必要はありませんように、私たちはRubyでJSONレスポンスを指定します
それらすべてのドキュメントの上に手で。あなたは、リソースのJSONをレンダリングすることができます
このような：

`` `ERB
<%= json :issue %>
```

これは `libに/ resources.rb`に` GitHubの::リソース:: ISSUE`を検索します。

一部のアクションは、配列を返します。あなたはブロックを渡すことによって、JSONを変更することができます。

`` `ERB
<%= json(:issue) { |hash| [hash] } %>
```

ドキュメントのサンプル応答からJSONファイルを生成するためのrakeタスクもあります。

`` `shを
$すくいgenerate_json_from_responses
```

生成されたファイルは、* / * JSON-ダンプになってしまいます。

###ターミナルブロック

あなたは `コマンドline`構文ハイライトを使用して、ターミナルブロックを指定することができます。

`` `コマンドライン
$カールfoobarに
```

あなたは、さまざまな部分を強調するために、 `$`と `＃`のように、特定の文字を使用することができます
コマンドの。

`` `コマンドライン
＃コールfoobarに
$カールfoobarに <em> <em>
....
```

詳細については、（https://github.com/gjtorikian/extended-markdown-filter#command-line-highlighting）を参照してください。 [the reference documentation]

##デプロイ

PRはmaster` `にマージされた後の展開が自動的に行われます。 （https://github.com/gjtorikian/publisher）と呼ばれるツールは、 `master`ブランチを取るNanocを使用してそれを構築し、` GH-pages`にコンテンツを公開します。したがって、任意のは、 `master`が自動的にそれをピックアップし、GitHubのページによって提供されるの` GH-pages`に渡って送信されることを約束します。 [Publisher]

##ライセンス

サイト（資産を除くすべてのもの、コンテンツを生成するためのコード、
そして、サイ​​ト上のレイアウトのディレクトリ）だけでなく、コードサンプルは、
以下の下でライセンス
[CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/legalcode).
CC0はすべて著作権の制限を放棄しますが、あなたに任意の商標を付与するものではありません
権限を与えます。

サイトのコンテンツ（資産のすべて、コンテンツ、レイアウトディレクトリ、
個別にマークされたオープンソースライセンス）の下を除いたファイルがライセンスされています
下（https://creativecommons.org/licenses/by/4.0/）。 [CC-BY-4.0] CC-BY-4.0
あなたは、ほぼすべての目的のためにコンテンツを使用する許可を与えるが、付与するものではありません
もしあなたがライセンスに注意し、信用を与える限り、任意の商標の権限、
次のような：

>内容に基づいて、
> <a href="https://github.com/github/developer.github.com">developer.github.com</a>
>下で使用
> <a href="https://creativecommons.org/licenses/by/4.0/"> CC-BY-4.0 </a>
>ライセンス。 </a>

これはあなたがを除いてこのリポジトリにコードとコンテンツを使用できることを意味します
独自のプロジェクトでGitHubの商標。

あなたは上記の下でそうしているこのリポジトリに貢献すると
ライセンス。
