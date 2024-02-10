Language: <a href="./README.md">简体中文</a>｜English
<p align="center">
    <img src="./Artwork/rm-ico.png" width="200" height="200">
</p>

# Meowbili - Bilibili client on Apple Watch

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

## ✨Features
- Customized Suggestion
- Account Login
- Video Download
- View Video Details（Play counts、introduction...）
- View Video Comments
- Send Comments
- View Suggested Video
- Video Actions（Like、Throw Coins、Add to favorites...）
- User Detail Page（Fans、Follows count，User bio...）
- User Videos and Articles
- User Actions（Follow、D.M.）
- Search（Videos、Users）
- Follow List
- Favorites（Folder）
- Watch Later（View、Add）
- View Moments

## ⬇️Install
### TestFlight
[Here](https://testflight.apple.com/join/TbuBT6ig)

## 🙌Contribute
Welcome to open issues and pull requests to help us get better.

View contribute/develop document at [/doc/dev](/doc/dev) 

<details><summary>Some unreasonable code clip in this project</summary>

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

### Contribute Steps
Open an Pull Request -> Wait for review -> Repair problem (if have) -> Wait for compile check -> merge to main（or Close Pull Request）

Everyone（including administrators）cannot skip any steps.

## 📝Version Number
Meowbili's Version number is **different** on GitHub and TestFlight(Same on about page). Because if add Version number on Testflight, app need to review by Apple. But if only add build number can prevent this.

So, we only add build number on Testflight. However, on Github we use easy to understand version number. We recommanded to use version number on Github to identity Meowbili.

## 💬User Comments
Translated by ThreeManager785
~~Everyone says good when they use~~

> [!TIP]
> It's obvious how excited I am when I realized that I can browse Bilibili contents directly on Apple Watch. This is all attributed to a small but powerful App ——— MeowBili. For a smart watch that wears all day, Apple Watch is more than displaying time and tracking workouts, it had turned into a little secretary in my daily lifve. But now, as MeowBili appears, it's features has gone more and more, and my entertainment life had improved.
> 
> To appreciate first is MeowBili's design. This App optimizes excellently for Apple Watch's small screen. It's interface is clear and audio-visual, help user to browse and search content's in a limited screen size. Font size and button typesets all thought about the convienence if touching, which won't make people fill crowded or unpleasant.
> 
> Further more, it's useful features is also why I like it. Although Apple Watch's screen isn't suitable for long-time watching, but MeowBili allows me to check update in free time quickly, get to know about the latest news, even watch short videos or listen to uploader's voice in where it's inconvenient to take the phone out. The experience make me feel very instant.
> 
> To conclude, MeowBili make my daily Apple Watch experience more interesting, meanwhile satisfied my need as a video enthusiasts. It's a must-have app for users who like to keep online anywhere anytime.
> 
> ————陵长镜

> [!TIP]
> If I'm in first year of high school,
> 
> I would write elegant poems, quote classics and enjoy in it;
> 
> If I'm in second year of high school,
> 
> I would write long-term essays, type in literary sentences and express my love;
> 
> If I;m in third year of high school,
> 
> I wolrd write a love letter, tells philosophical words and adds in Floy;
>
> But unfortunately I'm currently in kindergarden,
> I can only say, I like u so much MeowBili, MeowBili 😭😭 carry me on 🚗 ... MeobwBili🏃... MeobwBili🏃... MeobwBili🧎How could i live without u 😭
> 
> ————Miku

> [!TIP]
> 🐱🍐🐱🍐👍，🈶✨🧑‍🎨、❤️🌐，➕⏰🔄。🧑‍💻🤝👂👥🗣️，🙅⛓️‍💥✍️⏩。
> 
> 🐱🍐🐱🍐🤝🙋👋🐟，🙋💗 🐱🍐🐱🍐
>
> ————ThreeManager785

> [!TIP]
> Ur right, but MeowBili is a third-party Apple Watch Bilibili client made by Daorck. the game starts in a real world called "school", in here, people who are chosen by teacher will confiscate their phone, leads the power of Apple Watch. You're acting as a mystery character called "student", browse videos with different personalities and unique abilities in the clasroom, beat the enemies with them, find the lost MEMZ, and resolve the mystery of MeowBili.

> [!TIP]
> [Homophonic Meme is Hard to Translate]
> 
> 巴山楚水凄凉地，平面直角坐标系
> 
> responsibility，aw也能看视频
> 
> 高猛酸钾制氧气，喵哩喵哩真nb
