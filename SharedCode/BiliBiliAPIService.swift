//
//
//  BiliBiliAPIService.swift
//  DarockBili
//
//  Created by feng on 10/19/24.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Foundation

class BiliBiliAPIService {
    
    enum ContentType {
        case trending, recommendations
    }
    
    /// 获取BiliBili数据
    /// - Parameters:
    ///   - type: 内容类型（热门或推荐）
    ///   - limit: 限制返回的视频数量，默认是5
    func fetchBiliBiliData(for type: ContentType, limit: Int = 5) async -> Result<[(title: String, description: String, author: String, views: String)], Error> {
        do {
            let urlString: String
            switch type {
            case .trending:
                urlString = "https://api.bilibili.com/x/web-interface/popular?ps=\(limit)"
                //这里ps=几就会让返回数据有几条
            case .recommendations:
                urlString = "https://api.bilibili.com/x/web-interface/index/top/rcmd?ps=1"
                //这里ps=任何数字都不影响返回值 所以不更改\(limit)
            }

            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }

            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let dataDict = json["data"] as? [String: Any],
               let list = dataDict["list"] as? [[String: Any]] {

                let videos = list.prefix(limit).map { video -> (String, String, String, String) in
                    let videoTitle = video["title"] as? String ?? "无标题"
                    let videoDesc = video["desc"] as? String ?? "无描述"
                    let videoAuthor = video["author"] as? String ?? "未知作者"
                    let videoViews = video["view"] as? String ?? "未知播放量"
                    return (title: videoTitle, description: videoDesc, author: videoAuthor, views: videoViews)
                }
                
                return .success(videos)
            } else {
                return .failure(NSError(domain: "BiliBiliAPIService", code: -1, userInfo: [NSLocalizedDescriptionKey: "数据格式错误"]))
            }

        } catch {
            return .failure(error)
        }
    }
}
