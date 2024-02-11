言語：<a href="./README.md">简体中文</a>｜<a href="./README_en.md">English</a>｜日本語
<p align="center">
    <img src="./Artwork/rm-ico.png" width="200" height="200">
</p>

# ニャビリ - Apple Watch の Bilibili クライアント

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)&nbsp;
![GitHub Repo stars](https://img.shields.io/github/stars/Darock-Studio/Darock-Bili?style=flat)&nbsp;
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/Darock-Studio/Darock-Bili)&nbsp;
![GitHub repo size](https://img.shields.io/github/repo-size/Darock-Studio/Darock-Bili)&nbsp;
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Darock-Studio/Darock-Bili)&nbsp;
![Uptime Robot status](https://img.shields.io/uptimerobot/status/m794152937-528042e5aee699af3224e7a6?label=Darock%20Main%20API%20Status)&nbsp;
![GitHub tag](https://img.shields.io/github/v/tag/Darock-Studio/Darock-Bili?label=Latest%20Tag)&nbsp;
![GitHub Release Date](https://img.shields.io/github/release-date-pre/Darock-Studio/Darock-Bili?label=Latest%20Release%20Date)&nbsp;
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/Darock-Studio/Darock-Bili/main?label=Main%20Branch%20Last%20Commit)&nbsp;
![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/Darock-Studio/Darock-Bili/ios.yml)

<p align="center">
    <img src="./Artwork/eg-vd.png" width="240" height="380">
</p>

## ✨機能
- パーソナライズされた推奨事項
- ログインアカウント
- ビデオをダウンロードする
- ビデオの詳細を見る（再生回数、イントロ...）
- ビデオレビューを見る
- コメントを送信する
- おすすめのビデオを見る
- ビデオ操作（のように、コイン、収集...）
- ユーザー詳細ページ（ファン、フォロワー数，バイオ...）
- ユーザービデオ、記事
- ユーザーの操作（フォローする、ダイレクトメッセージ）
- 検索（ビデオ、ユーザー）
- フォローリスト
- お気に入りリスト（お気に入りフォルダ）
- 後で見る（チェック、追加）
- モーメントを見る

## ⬇️インストール
### TestFlight
[ここ](https://testflight.apple.com/join/TbuBT6ig)

## 🙌貢献する
私たちの向上に貢献するために、問題やプル リクエストを送信することを歓迎します。

[/doc/dev](/doc/dev) で開発/貢献関連のドキュメントを表示します。

<details><summary>プロジェクト内の異常なコード スニペット</summary>

```swift
// UserDynamic/UserDynamicMainView.swift :322
                    dynamics.append([
                        "WithText": item.1["modules"]["module_dynamic"]["desc"]["text"].string ?? "",
                        "Type": BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") ?? .text,
                        "Draws": { () -> [[String: String]]? in
                            if BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") == .draw {
                                var dTmp = [[String: String]]()
                                for draw in item.1["modules"]["module_dynamic"]["major"]["draw"]["items"] {
                                    isDynamicImagePresented[itemForCount].append(false)
                                    dTmp.append(["Src": draw.1["src"].string ?? ""])
                                }
                                return dTmp
                            } else {
                                return nil
                            }
                        }(),
                        "Archive": { () -> [String: String]? in
                            if BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") == .video {
                                let archive = item.1["modules"]["module_dynamic"]["major"]["archive"]
                                return ["Pic": archive["cover"].string ?? "", "Title": archive["title"].string ?? "", "BV": archive["bvid"].string ?? "", "UP": item.1["modules"]["module_author"]["name"].string ?? "", "View": archive["stat"]["play"].string ?? "-1", "Danmaku": archive["stat"]["danmaku"].string ?? "-1"]
                            } else {
                                return nil
                            }
                        }(),
                        "Live": { () -> [String: String]? in
                            if BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") == .live {
                                do {
                                    let liveContentJson = try JSON(data: (item.1["modules"]["module_dynamic"]["major"]["live_rcmd"]["content"].string ?? "").data(using: .utf8) ?? Data())
                                    debugPrint(liveContentJson)
                                    return ["Cover": liveContentJson["live_play_info"]["cover"].string ?? "", "Title": liveContentJson["live_play_info"]["title"].string ?? "", "ID": String(liveContentJson["live_play_info"]["room_id"].int ?? 0), "Type": liveContentJson["live_play_info"]["area_name"].string ?? "", "ViewStr": liveContentJson["live_play_info"]["watched_show"]["text_large"].string ?? "-1"]
                                } catch {
                                    return nil
                                }
                            } else {
                                return nil
                            }
                        }(),
                        "Forward": { () -> [String: Any?]? in
                            if BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") == .forward {
                                let origData = item.1["orig"]
                                return [
                                    "WithText": origData["modules"]["module_dynamic"]["desc"]["text"].string ?? "",
                                    "Type": BiliDynamicType(rawValue: origData["type"].string ?? "DYNAMIC_TYPE_WORD") ?? .text,
                                    "Draws": { () -> [[String: String]]? in
                                        if BiliDynamicType(rawValue: origData["type"].string ?? "DYNAMIC_TYPE_WORD") == .draw {
                                            var dTmp = [[String: String]]()
                                            for draw in origData["modules"]["module_dynamic"]["major"]["draw"]["items"] {
                                                isDynamicImagePresented[itemForCount].append(false)
                                                dTmp.append(["Src": draw.1["src"].string ?? ""])
                                            }
                                            return dTmp
                                        } else {
                                            return nil
                                        }
                                    }(),
                                    "Archive": { () -> [String: String]? in
                                        if BiliDynamicType(rawValue: origData["type"].string ?? "DYNAMIC_TYPE_WORD") == .video {
                                            let archive = origData["modules"]["module_dynamic"]["major"]["archive"]
                                            return ["Pic": archive["cover"].string ?? "", "Title": archive["title"].string ?? "", "BV": archive["bvid"].string ?? "", "UP": origData["modules"]["module_author"]["name"].string ?? "", "View": archive["stat"]["play"].string ?? "-1", "Danmaku": archive["stat"]["danmaku"].string ?? "-1"]
                                        } else {
                                            return nil
                                        }
                                    }(),
                                    "Live": { () -> [String: String]? in
                                        if BiliDynamicType(rawValue: origData["type"].string ?? "DYNAMIC_TYPE_WORD") == .live {
                                            do {
                                                let liveContentJson = try JSON(data: (origData["modules"]["module_dynamic"]["major"]["live_rcmd"]["content"].string ?? "").data(using: .utf8) ?? Data())
                                                debugPrint(liveContentJson)
                                                return ["Cover": liveContentJson["live_play_info"]["cover"].string ?? "", "Title": liveContentJson["live_play_info"]["title"].string ?? "", "ID": String(liveContentJson["live_play_info"]["room_id"].int ?? 0), "Type": liveContentJson["live_play_info"]["area_name"].string ?? "", "ViewStr": liveContentJson["live_play_info"]["watched_show"]["text_large"].string ?? "-1"]
                                            } catch {
                                                return nil
                                            }
                                        } else {
                                            return nil
                                        }
                                    }(),
                                    "SenderPic": origData["modules"]["module_author"]["face"].string ?? "",
                                    "SenderName": origData["modules"]["module_author"]["name"].string ?? "",
                                    "SenderID": String(origData["modules"]["module_author"]["mid"].int ?? 0),
                                    "SendTimeStr": origData["modules"]["module_author"]["pub_time"].string ?? "0000/00/00",
                                    "SharedCount": String(origData["modules"]["module_stat"]["forward"]["count"].int ?? -1),
                                    "LikedCount": String(origData["modules"]["module_stat"]["like"]["count"].int ?? -1),
                                    "IsLiked": origData["modules"]["module_stat"]["like"]["status"].bool ?? false,
                                    "CommentCount": String(origData["modules"]["module_stat"]["comment"]["count"].int ?? -1),
                                    "DynamicID": origData["id_str"].string ?? ""
                                ]
                            } else {
                                return nil
                            }
                        }(),
                        "SenderPic": item.1["modules"]["module_author"]["face"].string ?? "",
                        "SenderName": item.1["modules"]["module_author"]["name"].string ?? "",
                        "SenderID": String(item.1["modules"]["module_author"]["mid"].int ?? 0),
                        "SendTimeStr": item.1["modules"]["module_author"]["pub_time"].string ?? "0000/00/00",
                        "SharedCount": String(item.1["modules"]["module_stat"]["forward"]["count"].int ?? -1),
                        "LikedCount": String(item.1["modules"]["module_stat"]["like"]["count"].int ?? -1),
                        "IsLiked": item.1["modules"]["module_stat"]["like"]["status"].bool ?? false,
                        "CommentCount": String(item.1["modules"]["module_stat"]["comment"]["count"].int ?? -1),
                        "DynamicID": item.1["id_str"].string ?? ""
                    ])
```

</details>

### 貢献プロセス
オープンプルリクエスト->レビュー待ち->問題を修正します（ある場合）->CI がコンパイル可能性チェックを完了するまで待ちます->メインにマージ (またはプルリクエストを閉じる)

誰も (管理者を含む)、上記の手順のどの部分もスキップすることはできません。

## 📝バージョン番号
GitHub と TestFlight の ニャビリ のバージョン番号 (についてページと同じ) は**異なります**。これは、TestFlight でバージョン番号を増やすとアプリを再レビューする必要がありますが、ビルド バージョンを増やすと再レビューが必要になるためです。ない。

したがって、TestFlight ではビルド番号のみをインクリメントし、GitHub では可能な限りセマンティック バージョン管理を使用します。ニャビリ プログラムを参照するには、GitHub のバージョン番号を使用することをお勧めします。

## 💬ユーザーレビュー
~~使った人はみんな良いと言っています。~~

> [!TIP]
> Apple Watch で Bilibili コンテンツを直接閲覧できることを発見したときの私の興奮をご想像いただけると思います。 これは小さいながらも強力なアプリケーション「ニャビリ」のおかげです。 一日中手元にあるスマートウォッチである Apple Watch は、私にとって時間表示や運動記録だけでなく、日常生活のちょっとした秘書へと徐々に進化してきました。 しかし今では、「ニャビリ」の登場により、その機能がより豊富になり、私のエンターテインメントライフも向上しました。
> 
> まず感心したいのが「ニャビリ」のデザインです。 このアプリは、Apple Watch の小さな画面向けに非常に最適化されています。 そのインターフェイスはすっきりしていて直感的で、ユーザーは画面サイズが限られているにもかかわらず、コンテンツをすばやく参照および検索できます。 フォントのサイズとボタンのレイアウトは、混雑したり操作が難しくなったりすることなく、タッチの利便性を念頭に置いて設計されています。
> 
> 次に、機能的な実用性もとても気に入っています。 Apple Watchの画面は長時間動画を視聴するのには適していませんが、「ニャビリ」を使えば、空き時間にアップデートを素早くチェックしたり、最新の開発について学んだり、短い動画やビデオを撮影せずに見ることもできます。携帯電話を出して、アップオーナーの声を聞いてください。 この経験をすると、とても便利だと感じます。
> 
> 全体として、「ニャビリ」は、私の毎日の Apple Watch 使用に楽しみを加えるだけでなく、ビデオコンテンツ愛好家としての私のニーズにも応えてくれます。 いつでもどこでもオンラインを維持したい人にとって必須のアプリです。
> 
> ————陵长镜

> [!TIP]
> 私が高校一年生だったら、
> 
> 私は、聖典を引用し、お気に入りの詩には触れずに、ロマンチックな詩を 7 編書くことができます。
> 
> 私が高校二年生だったら、
> 
> 私は愛の名を冠した素晴らしい言葉や文章を含む散文を千語書くことができます。
> 
> 私が高校三年生だったら、
> 
> 私はラブレターを書きます、そして哲学と神秘はユングとフロイトに統合されます。
> 
> もう幼稚園なのに残念だけど、ニャビリ、大好きだニャビリ😭😭 連れて行ってください🚗... ニャビリ🏃... ニャビリ🏃 ... ニャビリ🧎 あなたなしではどうして生きていけますか😭
> 
> ————Miku

> [!TIP]
> 🐱🍐🐱🍐👍，🈶✨🧑‍🎨、❤️🌐，➕⏰🔄。🧑‍💻🤝👂👥🗣️，🙅⛓️‍💥✍️⏩。
> 
> 🐱🍐🐱🍐🤝🙋👋🐟，🙋💗 🐱🍐🐱🍐
>
> ————ThreeManager785

> [!TIP]
> あなたは正しいですが、ニャビリ は、Darock によって開発されたオープンソースの Bilibili サードパーティ Apple Watch クライアントです。 このゲームは「学校」と呼ばれる現実の世界で行われ、教師によって選ばれた生徒は Apple Watch の力を利用するために携帯電話を没収されます。 あなたは「生徒」という名前の謎のキャラクターをプレイし、教室でさまざまな個性とユニークな能力を持つ人々のビデオを閲覧し、彼らと協力して強力な敵を倒し、失われたMEMZを取り戻します。
