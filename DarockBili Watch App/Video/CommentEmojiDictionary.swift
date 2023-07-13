//
//  CommentEmojiDictionary.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/13.
//

import Foundation

let emojiPlist = Bundle.main.path(forResource: "biliEmoji", ofType: "plist")!
let biliEmojiDictionary = NSDictionary(contentsOfFile: emojiPlist)! as! Dictionary<String, String>
