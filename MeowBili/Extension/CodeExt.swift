//
//
//  CodeExt.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
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
import CoreHaptics
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

// MARK: Networking
public func autoRetryRequestApi(_ url: String, headers: HTTPHeaders?, maxReqCount: Int = 10, callback: @escaping (JSON, Bool) -> Void) {
    var retryCount = 0
    DispatchQueue.global().async {
        sigReq(url, headers: headers, maxReqCount: maxReqCount, callback: callback)
    }

    func sigReq(_ url: String, headers: HTTPHeaders?, maxReqCount: Int = 10, callback: @escaping (JSON, Bool) -> Void) {
        DarockKit.Network.shared.requestJSON(url, headers: headers) { respJson, isSuccess in
            if isSuccess {
                if CheckBApiError(from: respJson, noTip: true) { // Requesting succeed
                    callback(respJson, true)
                } else if retryCount < maxReqCount { // Failed but can retry
                    retryCount++
                    sigReq(url, headers: headers, maxReqCount: maxReqCount, callback: callback)
                } else { // Failed and not able to retry, callback json for next level code processing error.
                    callback(respJson, true)
                }
            } else {
                callback(respJson, isSuccess)
            }
        }
    }
}

func biliWbiSign(paramEncoded: String, completion: @escaping (String?) -> Void) {
    func getMixinKey(orig: String) -> String {
        return String(mixinKeyEncTab.map { orig[orig.index(orig.startIndex, offsetBy: $0)] }.prefix(32))
    }

    func encWbi(params: [String: Any], imgKey: String, subKey: String) -> (wts: String, w_rid: String) {
        var params = params
        let mixinKey = getMixinKey(orig: imgKey + subKey)
        let currTime = round(Date().timeIntervalSince1970)
        params["wts"] = Int(currTime)
        let std = params.sorted { $0.key < $1.key }
        var query = ""
        for q in std {
            query += "\(q.key)=\(q.value)&"
        }
        query.removeLast()
        query = query.urlEncoded()
        let wbiSign = calculateMD5(string: query + mixinKey)
        return (String(Int(currTime)), wbiSign)
    }
    
    func getWbiKeys(completion: @escaping (Result<(imgKey: String, subKey: String), Error>) -> Void) {
        let headers: HTTPHeaders = [
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        AF.request("https://api.bilibili.com/x/web-interface/nav", headers: headers).responseJSON { response in
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
            var query = decParam + "&w_rid=\(signedParams.w_rid)&wts=\(signedParams.wts)"
            query = query.urlEncoded()
            completion(query)
        case .failure(let error):
            print("Error getting keys: \(error)")
            completion(nil)
        }
    }
}

// AV & BV ID Convert Logic
fileprivate let XOR_CODE: UInt64 = 23442827791579
fileprivate let MASK_CODE: UInt64 = 2251799813685247
fileprivate let MAX_AID: UInt64 = 1 << 51

fileprivate let data: [UInt8] = [70, 99, 119, 65, 80, 78, 75, 84, 77, 117, 103, 51, 71, 86, 53, 76, 106, 55, 69, 74, 110, 72, 112, 87, 115, 120, 52, 116, 98, 56, 104, 97, 89, 101, 118, 105, 113, 66, 122, 54, 114, 107, 67, 121, 49, 50, 109, 85, 83, 68, 81, 88, 57, 82, 100, 111, 90, 102]

fileprivate let BASE: UInt64 = 58
fileprivate let BV_LEN: Int = 12
fileprivate let PREFIX: String = "BV1"

func av2bv(avid: UInt64) -> String {
    var bytes: [UInt8] = [66, 86, 49, 48, 48, 48, 48, 48, 48, 48, 48, 48]
    var bvIdx = BV_LEN - 1
    var tmp = (MAX_AID | avid) ^ XOR_CODE
    
    while tmp != 0 {
        bytes[bvIdx] = data[Int(tmp % BASE)]
        tmp /= BASE
        bvIdx -= 1
    }
    
    bytes.swapAt(3, 9)
    bytes.swapAt(4, 7)
    
    return String(decoding: bytes, as: UTF8.self)
}

func bv2av(bvid: String) -> UInt64 {
    let fixedBvid: String
    if bvid.hasPrefix("BV") {
        fixedBvid = bvid
    } else {
        fixedBvid = "BV" + bvid
    }
    var bvidArray = Array(fixedBvid.utf8)
    
    bvidArray.swapAt(3, 9)
    bvidArray.swapAt(4, 7)
    
    let trimmedBvid = String(decoding: bvidArray[3...], as: UTF8.self)
    
    var tmp: UInt64 = 0
    
    for char in trimmedBvid {
        if let idx = data.firstIndex(of: char.utf8.first!) {
            tmp = tmp * BASE + UInt64(idx)
        }
    }
    
    return (tmp & MASK_CODE) ^ XOR_CODE
}

// MARK: Get buvid_fp cookie
enum BuvidFpError: Error {
    case readError
}

struct BuvidFp {
    static func gen(key: String, seed: UInt32) throws -> String {
        let m = try murmur3_x64_128(key: key, seed: seed)
        return String(format: "%016llx%016llx", m.low, m.high)
    }
    
    private static func murmur3_x64_128(key: String, seed: UInt32) throws -> UInt128 {
        let C1: UInt64 = 0x87c3_7b91_1142_53d5
        let C2: UInt64 = 0x4cf5_ad43_2745_937f
        let C3: UInt64 = 0x52dc_e729
        let C4: UInt64 = 0x3849_5ab5
        let R1: UInt32 = 27
        let R2: UInt32 = 31
        let R3: UInt32 = 33
        let M: UInt64 = 5
        
        var h1: UInt64 = UInt64(seed)
        var h2: UInt64 = UInt64(seed)
        var processed: Int = 0
        var index = key.startIndex
        
        var buf = [UInt8](repeating: 0, count: 16)
        
        while index < key.endIndex {
            let remaining = key.distance(from: index, to: key.endIndex)
            let read = min(remaining, 16)
            
            _ = key.withCString { cString in
                // Using withCString to convert the Swift String to a C-style string
                memcpy(&buf, cString + index.utf16Offset(in: key), read)
            }
            
            processed += read
            if read == 16 {
                let k1 = UInt64(bitPattern: Int64(littleEndianBytes: buf[0..<8]))
                let k2 = UInt64(bitPattern: Int64(littleEndianBytes: buf[8..<16]))
                
                h1 ^= k1.multipliedFullWidth(by: C1).high &<< R2
                h1 = h1 &<< R1 &+ h2 &* M &+ C3
                h2 ^= k2.multipliedFullWidth(by: C2).high &<< R3
                h2 = h2 &<< R2 &+ h1 &* M &+ C4
            } else if read == 0 {
                h1 ^= UInt64(processed)
                h2 ^= UInt64(processed)
                h1 = h1 &+ h2
                h2 = h2 &+ h1
                h1 = fmix64(k: h1)
                h2 = fmix64(k: h2)
                h1 = h1 &+ h2
                h2 = h2 &+ h1
                
                let x: UInt128 = UInt128(high: h2, low: h1)
                return x
            } else {
                var k1: UInt64 = 0
                var k2: UInt64 = 0
                
                if read >= 15 { k2 ^= UInt64(buf[14]) &<< 48 }
                if read >= 14 { k2 ^= UInt64(buf[13]) &<< 40 }
                if read >= 13 { k2 ^= UInt64(buf[12]) &<< 32 }
                if read >= 12 { k2 ^= UInt64(buf[11]) &<< 24 }
                if read >= 11 { k2 ^= UInt64(buf[10]) &<< 16 }
                if read >= 10 { k2 ^= UInt64(buf[9]) &<< 8 }
                if read >= 9 {
                    k2 ^= UInt64(buf[8])
                    k2 = k2.multipliedFullWidth(by: C2).high &<< 33
                    k2 = k2.multipliedFullWidth(by: C1).high &<< 32
                    h2 ^= k2
                }
                if read >= 8 { k1 ^= UInt64(buf[7]) &<< 56 }
                if read >= 7 { k1 ^= UInt64(buf[6]) &<< 48 }
                if read >= 6 { k1 ^= UInt64(buf[5]) &<< 40 }
                if read >= 5 { k1 ^= UInt64(buf[4]) &<< 32 }
                if read >= 4 { k1 ^= UInt64(buf[3]) &<< 24 }
                if read >= 3 { k1 ^= UInt64(buf[2]) &<< 16 }
                if read >= 2 { k1 ^= UInt64(buf[1]) &<< 8 }
                if read >= 1 { k1 ^= UInt64(buf[0]) }
                
                k1 = k1.multipliedFullWidth(by: C1).high &<< 31
                k1 = k1.multipliedFullWidth(by: C2).high &<< 32
                h1 ^= k1
            }
            
            index = key.index(index, offsetBy: read)
        }
        
        throw BuvidFpError.readError
    }
    
    private static func fmix64(k: UInt64) -> UInt64 {
        let C1: UInt64 = 0xff51_afd7_ed55_8ccd
        let C2: UInt64 = 0xc4ce_b9fe_1a85_ec53
        let R: UInt32 = 33
        var tmp = k
        tmp ^= tmp &>> R
        tmp = tmp.multipliedFullWidth(by: C1).high
        tmp ^= tmp &>> R
        tmp = tmp.multipliedFullWidth(by: C2).high
        tmp ^= tmp &>> R
        return tmp
    }
}

extension Int64 {
    init(littleEndianBytes bytes: ArraySlice<UInt8>) {
        self = Int64(bitPattern: UInt64(littleEndianBytes: bytes))
    }
}

extension UInt64 {
    init(littleEndianBytes bytes: ArraySlice<UInt8>) {
        var value: UInt64 = 0
        withUnsafeMutableBytes(of: &value) { buffer in
            for (index, byte) in bytes.enumerated() {
                buffer[index] = byte
            }
        }
        self = UInt64(littleEndian: value)
    }
}

struct UInt128 {
    let low: UInt64
    let high: UInt64
    
    init(high: UInt64, low: UInt64) {
        self.high = high
        self.low = low
    }
    
    static func &<< (lhs: UInt128, rhs: UInt64) -> UInt128 {
        if rhs == 0 {
            return lhs
        } else if rhs < 64 {
            return UInt128(high: lhs.high << rhs | lhs.low >> (64 - rhs), low: lhs.low << rhs)
        } else if rhs < 128 {
            return UInt128(high: lhs.low << (rhs - 64), low: 0)
        } else {
            return UInt128(high: 0, low: 0)
        }
    }
}

// MARK: Get _uuid cookie
struct UuidInfoc {
    static func gen() -> String {
        let digitMap: [String] = [
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "10"
        ]
        let t = Int64(Date().timeIntervalSince1970 * 1000) % 100_000

        return randomChoice(range: [8, 4, 4, 4, 12], separator: "-", choices: digitMap) + String(format: "%05d", t) + "infoc"
    }
}

func randomChoice(range: [Int], separator: String, choices: [String]) -> String {
    var result = ""

    for r in range {
        for _ in 0..<r {
            let randomIndex = Int.random(in: 0..<choices.count)
            result += choices[randomIndex]
        }
        result += separator
    }

    result.removeLast(separator.count)
    return result
}

public func getBuvid(url: String, callback: @escaping (String, String, String, String) -> Void) {
    let _uuid = UuidInfoc.gen()
    let postParams: [String: Any] = [
        "3064":1, // ptype, mobile => 2, others => 1
        "5062":Date.now.milliStamp, // timestamp
        "03bf":url, // url accessed
        "39c8":"333.1007.fp.risk", // spm_id,
        "34f1":"", // target_url, default empty now
        "d402":"", // screenx, default empty
        "654a":"", // screeny, default empty
        "6e7c":"3440x1440", // browser_resolution, window.innerWidth || document.body && document.body.clientWidth + "x" + window.innerHeight || document.body && document.body.clientHeight
        "3c43":[ // 3c43 => msg
            "2673":1, // hasLiedResolution, window.screen.width < window.screen.availWidth || window.screen.height < window.screen.availHeight
            "5766":24, // colorDepth, window.screen.colorDepth
            "6527":0, // addBehavior, !!window.HTMLElement.prototype.addBehavior, html5 api
            "7003":1, // indexedDb, !!window.indexedDB, html5 api
            "807e":1, // cookieEnabled, navigator.cookieEnabled
            "b8ce":"Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebK…KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", // ua
            "641c":0, // webdriver, navigator.webdriver, like Selenium
            "07a4":"zh-CN", // language
            "1c57":4, // deviceMemory in GB, navigator.deviceMemory
            "0bd0":4, // hardwareConcurrency, navigator.hardwareConcurrency
            "748e":[
                3440, // window.screen.width
                1440  // window.screen.height
            ], // screenResolution
            "d61f":[
                3440, // window.screen.availWidth
                1440  // window.screen.availHeight
            ], // availableScreenResolution
            "fc9d":-480, // timezoneOffset, (new Date).getTimezoneOffset()
            "6aa9":"Asia/Shanghai", // timezone, (new window.Intl.DateTimeFormat).resolvedOptions().timeZone
            "75b8":1, // sessionStorage, window.sessionStorage, html5 api
            "3b21":1, // localStorage, window.localStorage, html5 api
            "8a1c":0, // openDatabase, window.openDatabase, html5 api
            "d52f":"not available", // cpuClass, navigator.cpuClass
            "adca":"Win32", // platform, navigator.platform
            "80c9":[
                [
                    "PDF Viewer",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ],
                [
                    "Chrome PDF Viewer",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ],
                [
                    "Chromium PDF Viewer",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ],
                [
                    "Microsoft Edge PDF Viewer",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ],
                [
                    "WebKit built-in PDF",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ]
            ], // plugins
            "13ab":"mTUAAAAASUVORK5CYII=", // canvas fingerprint
            "bfe9":"aTot0S1jJ7Ws0JC6QkvAL/A4H1PbV+/QA3AAAAAElFTkSuQmCC", // webgl_str
            "a3c1":[], // webgl_params, cab be set to [] if webgl is not supported
            "6bc5":"Broadcom~V3D 4.2", // webglVendorAndRenderer
            "ed31":0, // hasLiedLanguages
            "72bd":0, // hasLiedOs
            "097b":0, // hasLiedBrowser
            "52cd":[
                0, // void 0 !== navigator.maxTouchPoints ? t = navigator.maxTouchPoints : void 0 !== navigator.msMaxTouchPoints && (t = navigator.msMaxTouchPoints);
                0, // document.createEvent("TouchEvent"), if succeed 1 else 0
                0 // "ontouchstart" in window ? 1 : 0
            ], // touch support
            "a658":[
                "Arial",
                "Courier",
                "Courier New",
                "Helvetica",
                "Times",
                "Times New Roman"
            ], // font details. see https://github.com/fingerprintjs/fingerprintjs for implementation details
            "d02f":"124.04347527516074" // audio fingerprint. see https://github.com/fingerprintjs/fingerprintjs for implementation details
        ],
        "54ef":"{\"b_ut\":\"7\",\"home_version\":\"V8\",\"i-wanna-go-back\":\"-1\",\"in_new_ab\":true,\"ab_version\":{\"for_ai_home_version\":\"V8\",\"tianma_banner_inline\":\"CONTROL\",\"enable_web_push\":\"DISABLE\"},\"ab_split_num\":{\"for_ai_home_version\":54,\"tianma_banner_inline\":54,\"enable_web_push\":10}}", // abtest info, embedded in html
        "8b94":"", // refer_url, document.referrer ? encodeURIComponent(document.referrer).substr(0, 1e3) : ""
        "df35":_uuid, // _uuid, set from cookie, generated by client side(algorithm remains unknown)
        "07a4":"zh-CN", // language
        "5f45":0, // laboratory, set from cookie, null if empty, source remains unknown
        "db46":0 // is_selfdef, default 0
    ]
    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/frontend/finger/spi") { respJson, isSuccess in
        if isSuccess {
            let buvid3 = respJson["data"]["b_3"].string ?? ""
            let buvid4 = respJson["data"]["b_4"].string ?? ""
            let postHeaders: HTTPHeaders = [
                "cookie": "innersign=0; buvid3=\(buvid3); b_nut=\(Date.now.timeStamp); i-wanna-go-back=-1; b_ut=7; b_lsid=9910433CB_18CF260AB89; _uuid=\(_uuid); enable_web_push=DISABLE; header_theme_version=undefined; home_feed_column=4; browser_resolution=3440-1440; buvid4=\(buvid4); buvid_fp=e651c1a382430ea93631e09474e0b395"
            ]
            AF.request("https://api.bilibili.com/x/internal/gaia-gateway/ExClimbWuzhi", method: .post, parameters: postParams, encoding: JSONEncoding.default, headers: postHeaders).response { response in
                callback(buvid3, buvid4, _uuid, response.debugDescription)
            }
        }
    }
}

public func PlayHaptic(sharpness: Float, intensity: Float) {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    var events = [CHHapticEvent]()
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
    events.append(event)
    do {
        let pattern = try CHHapticPattern(events: events, parameters: [])
        let player = try globalHapticEngine?.makePlayer(with: pattern)
        try player?.start(atTime: 0)
    } catch {
        print("Failed to play pattern: \(error.localizedDescription).")
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

extension Bool {
    init(_ input: Int) {
        if input == 0 {
            self = false
        } else {
            self = true
        }
    }
}

infix operator ~
extension Float {
    static func ~ (lhs: Float, rhs: Int) -> String {
        return String(format: "%.\(rhs)f", lhs)
    }
}
extension Double {
    static func ~ (lhs: Double, rhs: Int) -> String {
        return String(format: "%.\(rhs)f", lhs)
    }
}

prefix operator &&
prefix func &&<T>(input: inout T) -> UnsafeMutablePointer<T> {
    withUnsafeMutablePointer(to: &input) { $0 }
}
