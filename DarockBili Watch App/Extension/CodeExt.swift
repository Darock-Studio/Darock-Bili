//
//  CodeExt.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/6.
//


import OSLog
import SwiftUI
//import Dynamic
import CryptoKit
import Alamofire
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
//    let app = Dynamic.PUICApplication.sharedPUICApplication()
//    app._setStatusBarTimeHidden(b, animated: true, completion: nil)
}

public class WbiSign: ObservableObject {
    @State var img_key = ""
    @State var sub_key = ""
    func MD5Hash(_ string: String) -> String {
        let data = Data(string.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes { bytes in
            _ = CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
        static let mixinKeyEncTab: [Int] = [46, 47, 18, 2, 53, 8, 23, 32, 15, 50, 10, 31, 58, 3, 45, 35, 27, 43, 5, 49, 33, 9, 42, 19, 29, 28, 14, 39, 12, 38, 41, 13, 37, 48, 7, 16, 24, 55, 40, 61, 26, 17, 0, 1, 60, 51, 30, 4, 22, 25, 54, 21, 56, 59, 6, 63, 57, 62, 11, 36, 20, 34, 44, 52]

        func getMixinKey(orig: String) -> String {
            let result = WbiSign.mixinKeyEncTab.reduce("") { result, index in
                if index < orig.count {
                    let start = orig.index(orig.startIndex, offsetBy: index)
                    return result + String(orig[start])
                } else {
                    return result
                }
            }
            print("Mixin Key: \(result)")
            return result
        }

    func filterInvalidCharacters(from value: Any) -> String {
           let invalidCharacters = CharacterSet(charactersIn: "!'()*")
           if let strValue = value as? String {
               return strValue.components(separatedBy: invalidCharacters).joined()
           } else {
               return String(describing: value)
           }
       }

    func md5(data: String) -> String {
        let digest = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func encWbi(params: [String: Any]) -> String {
        var newParams = params
        let mixinKey = getMixinKey(orig: img_key + sub_key)
        let currTime = Int(Date().timeIntervalSince1970)
        newParams["wts"] = currTime
        let sortedParams = newParams.sorted { $0.key < $1.key }
        let query = sortedParams.map { "\($0.key)=\(filterInvalidCharacters(from: $0.value))" }.joined(separator: "&")
        print("Query: \(query + mixinKey)")
        let dataToHash = (query.urlEncoded() + mixinKey.prefix(32))
        let wbiSign = (dataToHash).DDMD5Encrypt()
        print("WBI Sign: \(wbiSign)")
        newParams["w_rid"] = wbiSign
        var paramStr = ""
        for param in newParams {
            paramStr += "\(param.key)=\(param.value)&"
        }
        paramStr.removeLast()
        return paramStr
    }

    func getWbiKeys(completionHandler: @escaping (String, String) -> Void) {
        AF.request("https://api.bilibili.com/x/web-interface/nav").responseJSON { response in
            switch response.result {
            case .success(let value):
                if let dict = value as? [String: Any],
                let data = dict["data"] as? [String: Any],
                let wbiImg = data["wbi_img"] as? [String: Any],
                let imgUrl = wbiImg["img_url"] as? String,
                let subUrl = wbiImg["sub_url"] as? String {
                let imgKey = String(imgUrl.split(separator: "/").last!.split(separator: ".").first!)
                let subKey = String(subUrl.split(separator: "/").last!.split(separator: ".").first!)
                print("Image Key: \(imgKey)")
                print("Sub Key: \(subKey)")
                completionHandler(imgKey, subKey)
            }
            case .failure(let error):
                print(error)
            }
        }
    }
}
