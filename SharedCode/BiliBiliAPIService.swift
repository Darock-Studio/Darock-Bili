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

// 定义 Video 数据模型
struct Video: Identifiable {
    let id: Int
    let title: String
    let description: String
    let authorName: String
    let viewCount: Int
    let likeCount: Int
    let coinCount: Int
    let shareCount: Int
    let danmakuCount: Int
}

class BiliBiliAPIService {
    
    static let shared = BiliBiliAPIService()
    private init() {}

    // MARK: - 数据获取

    /// 获取热门内容
    func fetchPopularVideos(completion: @escaping ([Video]) -> Void) {
        let url = "https://api.bilibili.com/x/web-interface/popular"
        fetchVideos(from: url, completion: completion)
    }

    /// 获取推荐内容
    func fetchRecommendedVideos(completion: @escaping ([Video]) -> Void) {
        let url = "https://api.bilibili.com/x/web-interface/index/top/rcmd"
        fetchVideos(from: url, completion: completion)
    }

    // MARK: - 数据解析

    /// 从 URL 获取视频数据
    private func fetchVideos(from urlString: String, completion: @escaping ([Video]) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion([])
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received")
                completion([])
                return
            }

            do {
                // 解析 JSON 数据
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let data = json["data"] as? [String: Any],
                   let list = data["list"] as? [[String: Any]] {

                    let videos = list.compactMap { self?.parseVideo(from: $0) }

                    DispatchQueue.main.async {
                        completion(videos)
                    }
                } else {
                    print("Invalid JSON structure")
                    completion([])
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion([])
            }
        }

        task.resume()
    }

    /// 解析单个视频条目
    private func parseVideo(from dict: [String: Any]) -> Video? {
        guard
            let id = dict["aid"] as? Int,
            let title = dict["title"] as? String,
            let description = dict["desc"] as? String,
            let owner = dict["owner"] as? [String: Any],
            let authorName = owner["name"] as? String,
            let stat = dict["stat"] as? [String: Any],
            let viewCount = stat["view"] as? Int,
            let likeCount = stat["like"] as? Int,
            let coinCount = stat["coin"] as? Int,
            let shareCount = stat["share"] as? Int,
            let danmakuCount = stat["danmaku"] as? Int
        else {
            print("Missing data in video entry")
            return nil
        }

        return Video(
            id: id,
            title: title,
            description: description,
            authorName: authorName,
            viewCount: viewCount,
            likeCount: likeCount,
            coinCount: coinCount,
            shareCount: shareCount,
            danmakuCount: danmakuCount
        )
    }
}
