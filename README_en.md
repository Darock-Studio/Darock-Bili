Language: English|<a href="./README.md">Simplified Chinese</a>
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
Open an Pull Request->Wait for review->Repair problem (if have)->Wait for compile ckeck->merge to main（or Close Pull Request）

Everyone（including administrators）cannot skip any steps.

## 📝版本号
Meowbili's Version number is **different** on GitHub and TestFlight(Same on about page). Because if add Version number on Testflight, app need to review by Apple. But if only add build number can prevent this.

So, we only add build number on Testflight. However, on Github we use easy to understand version number. We recommanded to use version number on Github to identity Meowbili.

## 💬User Commits (in Chinese)
~~When people used this, they all say good~~

> [!TIP]
> 当我发现我可以在Apple Watch上直接浏览哔哩哔哩的内容时，我的兴奋可想而知。这要归功于“喵哩喵哩”这款小巧而强大的应用。作为一个整日不离手的智能手表，Apple Watch对于我来说早已不止是时间显示和运动追踪，它逐渐演变成了我的日常生活中的小秘书。但现在，随着“喵哩喵哩”的出现，它的功能越发丰富，我的娱乐生活也因此而提升。
> 
> 首先要赞赏的是“喵哩喵哩”的设计。这款应用针对Apple Watch的小屏幕做了极佳的优化。它的界面干净且直观，方便用户在屏幕尺寸有限的情况下，快速地浏览和搜索内容。字体大小和按钮布局考虑到了触控的便利性，不会让人觉得拥挤或难以操作。
> 
> 其次，功能上的实用性也是我极大的喜爱之处。虽然Apple Watch的屏幕并不适合长时间观看视频，但“喵哩喵哩”让我能在空闲之余迅速地查看更新，了解最新动态，甚至在不便拿出手机的情况下观看一些短视频或者收听up主的声音。这样的体验让我感到十分便捷。
> 
> 总的来说，“喵哩喵哩”不仅为我日常的Apple Watch使用增添了乐趣，同时也满足了我作为一个视频内容爱好者的需求。它是那些喜欢在任何时间地点都保持在线的用户的必备应用。
> 
> ————陵长镜

> [!TIP]
> 如果我高一，
> 
> 我会写七言情诗，引经据典行行不提喜欢；
> 
> 如果我高二,
> 
> 我会写千字散文，辞藻华丽句句点名爱意；
> 
> 如果我高三，
> 
> 我会写一纸情书，哲思神秘再融进荣格和弗洛伊;
> 
> 可惜我现在幼儿园，我只会说，喵哩喵哩我好喜欢你，喵哩喵哩😭😭你带我走吧🚗……喵哩喵哩🏃…喵哩喵哩🏃…喵哩喵哩🧎没有你我怎么活啊😭
> 
> ————Miku

> [!TIP]
> 🐱🍐🐱🍐👍，🈶✨🧑‍🎨、❤️🌐，➕⏰🔄。🧑‍💻🤝👂👥🗣️，🙅⛓️‍💥✍️⏩。
> 
> 🐱🍐🐱🍐🤝🙋👋🐟，🙋💗 🐱🍐🐱🍐
>
> ————ThreeManager785

> [!TIP]
> 你说的对，但是喵哩喵哩是由 Darock 研发的一款开源世界B站第三方 Apple Watch 客户端。游戏发生在一个名为“学校”的真实世界，在这里，被老师选中的人会被没收手机，引导 Apple Watch 之力。你将扮演一位名为“学生”的神秘角色，在教室中浏览性格各异能力独特的视频们，和他们一起击败强敌，找回失散的MEMZ。

> [!TIP]
> 巴山楚水凄凉地，平面直角坐标系
> 
> responsibility，aw也能看视频
> 
> 高猛酸钾制氧气，喵哩喵哩真nb
