//
//  CodeExt.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/6.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import OSLog
import SwiftUI
import Dynamic
import CryptoKit
import DarockKit
import Alamofire
import SwiftyJSON
import Foundation
import AVFoundation
import CommonCrypto

extension String {
    func shorter() -> String {
        let intData = Int(self)
        if intData != nil {
            if intData! >= 10000 {
                let thined = Double(intData!) / 10000.0
                let toThinStr = String(format: "%.1f", thined)
                if toThinStr.hasSuffix(".0") {
                    return String(toThinStr.split(separator: ".")[0]) + " 万"
                } else {
                    return toThinStr + " 万"
                }
            } else {
                return self
            }
        } else {
            Logger().error("转换数据时错误：无法将 String 转为 Int")
            return self
        }
    }
    
    /// MD5加密类型
    enum MD5EncryptType {
        /// 32位小写
        case lowercase32
        /// 32位大写
        case uppercase32
        /// 16位小写
        case lowercase16
        /// 16位大写
        case uppercase16
    }
    /// MD5加密 默认是32位小写加密
    /// - Parameter type: 加密类型
    /// - Returns: 加密字符串
    func DDMD5Encrypt(_ md5Type: MD5EncryptType = .lowercase32) -> String {
        guard self.count > 0 else {
            print("⚠️⚠️⚠️md5加密无效的字符串⚠️⚠️⚠️")
            return ""
        }
        /// 1.把待加密的字符串转成char类型数据 因为MD5加密是C语言加密
        let cCharArray = self.cString(using: .utf8)
        /// 2.创建一个字符串数组接受MD5的值
        var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        /// 3.计算MD5的值
        /*
         第一个参数:要加密的字符串
         第二个参数: 获取要加密字符串的长度
         第三个参数: 接收结果的数组
         */
        CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
        
        switch md5Type {
            /// 32位小写
        case .lowercase32:
            return uint8Array.reduce("") { $0 + String(format: "%02x", $1)}
            /// 32位大写
        case .uppercase32:
            return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
            /// 16位小写
        case .lowercase16:
            //let tempStr = uint8Array.reduce("") { $0 + String(format: "%02x", $1)}
            return ""
            //            tempStr.getString(startIndex: 8, endIndex: 24)
            /// 16位大写
        case .uppercase16:
            //let tempStr = uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
            return ""
            //            tempStr.getString(startIndex: 8, endIndex: 24)
        }
    }
}

extension Date {
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp: Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }

/// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp: String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
}


@discardableResult
public func getMemory() -> Float {
    var taskInfo = task_vm_info_data_t()
    var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
    let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
        $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
            task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
        }
    }
    let usedMb = Float(taskInfo.phys_footprint) / 1048576.0
    let totalMb = Float(ProcessInfo.processInfo.physicalMemory) / 1048576.0
    result != KERN_SUCCESS ? debugPrint("Memory used: ? of \(totalMb)") : debugPrint("Memory used: \(usedMb) of \(totalMb)")
    return usedMb
}

/// 切换时间显示
/// - Parameter b: 是否显示
public func hideDigitalTime(_ b: Bool) {
    let app = Dynamic.PUICApplication.sharedPUICApplication()
    app._setStatusBarTimeHidden(b, animated: true, completion: nil)
}

func biliWbiSign(paramEncoded: String, completion: @escaping (String?) -> Void) {
    func getMixinKey(orig: String) -> String {
        return String(mixinKeyEncTab.map { orig[orig.index(orig.startIndex, offsetBy: $0)] }.prefix(32))
    }
    
    func encWbi(params: [String: Any], imgKey: String, subKey: String) -> [String: Any] {
        var params = params
        let mixinKey = getMixinKey(orig: imgKey + subKey)
        let currTime = round(Date().timeIntervalSince1970)
        params["wts"] = currTime
        params = params.sorted { $0.key < $1.key }.reduce(into: [:]) { $0[$1.key] = $1.value }
        params = params.mapValues { String(describing: $0).filter { !"!'()*".contains($0) } }
        let query = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        let wbiSign = calculateMD5(string: query + mixinKey)
        params["w_rid"] = wbiSign
        return params
    }
    
    func getWbiKeys(completion: @escaping (Result<(imgKey: String, subKey: String), Error>) -> Void) {
        AF.request("https://api.bilibili.com/x/web-interface/nav").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let imgURL = json["data"]["wbi_img"]["img_url"].string ?? ""
                let subURL = json["data"]["wbi_img"]["sub_url"].string ?? ""
                let imgKey = imgURL.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
                let subKey = subURL.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
                completion(.success((imgKey, subKey)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func calculateMD5(string: String) -> String {
        let data = Data(string.utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes {
            CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    let mixinKeyEncTab = [
        46, 47, 18, 2, 53, 8, 23, 32, 15, 50, 10, 31, 58, 3, 45, 35, 27, 43, 5, 49,
        33, 9, 42, 19, 29, 28, 14, 39, 12, 38, 41, 13, 37, 48, 7, 16, 24, 55, 40,
        61, 26, 17, 0, 1, 60, 51, 30, 4, 22, 25, 54, 21, 56, 59, 6, 63, 57, 62, 11,
        36, 20, 34, 44, 52
    ]
    
    getWbiKeys { result in
        switch result {
        case .success(let keys):
            let decParam = paramEncoded.base64Decoded() ?? ""
            let spdParam = decParam.components(separatedBy: "&")
            var spdDicParam = [String: String]()
            spdParam.forEach { pair in
                let components = pair.components(separatedBy: "=")
                if components.count == 2 {
                    spdDicParam[components[0]] = components[1]
                }
            }
            
            let signedParams = encWbi(params: spdDicParam, imgKey: keys.imgKey, subKey: keys.subKey)
            let query = signedParams.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            completion(query)
        case .failure(let error):
            print("Error getting keys: \(error)")
            completion(nil)
        }
    }
}

postfix operator ++
postfix operator --
prefix operator ++
prefix operator --
extension Int {
    @discardableResult
    static postfix func ++ (num: inout Int) -> Int {
        num += 1
        return num - 1
    }
    
    @discardableResult
    static postfix func -- (num: inout Int) -> Int {
        num -= 1
        return num + 1
    }

    @discardableResult
    static prefix func ++ (num: inout Int) -> Int {
        num += 1
        return num
    }

    @discardableResult
    static prefix func -- (num: inout Int) -> Int {
        num -= 1
        return num
    }
}


