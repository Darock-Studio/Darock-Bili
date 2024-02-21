//
//
//  AppFileManager.swift
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

import Foundation

class AppFileManager {
    var path: String
    
    init(path: String) {
        self.path = path
    }
    
    /// 获取单个文件路径
    /// - Parameters:
    ///   - name: 文件名
    ///   - folder: 文件夹名，默认根目录
    /// - Returns: 文件URL
    public func GetFilePath(name: String, folder: String = "root") -> URL {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        if folder == "root" {
            let url = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(name)"))!
            return url
        } else {
            let url = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(folder)/\(name)"))!
            return url
        }
    }
    
    /// 获取文件夹下所有图片路径
    /// - Parameter folder: 文件夹名
    /// - Returns: 图片URL
    public func GetImagePath(folder: String) -> [URL]? {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let folderUrl: URL
        if folder == "root" {
            folderUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "images"))!
        } else {
            folderUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(folder)"))!
        }
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: folderUrl.path)
        if contentsOfPath != nil {
            var urls = [URL]()
            for i in contentsOfPath! where !directoryIsExists(folderUrl.absoluteString + "/\(i)") {
                urls.append(URL(string: folderUrl.absoluteString + "/\(i)")!)
            }
            return urls
        } else {
            return nil
        }
    }
    /// 获取文件夹下所有图片名
    /// - Parameters:
    ///   - folder: 文件夹名
    ///   - withExt: 是否包含扩展名
    /// - Returns: 图片名
    public func GetImageName(folder: String, withExt: Bool = false) -> [String]? {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let folderUrl: URL
        if folder == "root" {
            folderUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/"))!
        } else {
            folderUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(folder)/"))!
        }
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: folderUrl.path)
        if contentsOfPath != nil {
            var names = [String]()
            for i in contentsOfPath! where i.contains(".") && i.split(separator: ".")[1] != "plist" {
                names.append(withExt ? i : String(i.split(separator: ".")[0]))
            }
            return names
        } else {
            return nil
        }
    }
    /// 获取根目录下文件和文件夹
    /// - Returns: [["isDirectory": 是否为文件夹, "name": 文件(夹)名]]
    public func GetRoot() -> [[String: String]]? {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let folderUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + path))!
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: folderUrl.path)
        if contentsOfPath != nil {
            var files = [[String: String]]()
            for i in contentsOfPath! {
                files.append(["isDirectory": String(directoryIsExists(folderUrl.path + "/\(i)")), "name": i])
            }
            return files
        } else {
            return nil
        }
    }
    /// 创建文件夹
    /// - Parameter name: 文件夹名
    public func CreateFolder(_ name: String) {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let folderStr = urlForDocument[0].path + "/\(path)/\(name)"
        try! manager.createDirectory(atPath: folderStr, withIntermediateDirectories: true)
    }
    /// 删除文件(夹)
    /// - Parameter name: 文件(夹)名
    public func DeleteFile(_ name: String) {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileStr = urlForDocument[0].path + "/\(path)/\(name)"
        try! manager.removeItem(atPath: fileStr)
    }
    /// 存储文件夹下图片排序
    /// - Parameters:
    ///   - folder: 文件夹名
    ///   - index: 顺序 Example: ["pic1.png", "pic2.png", "pic3.png"]...
    @available(*, unavailable)
    public func SaveImagesIndex(_ folder: String, index: [String]) {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileStr: String
        if folder == "root" {
            fileStr = urlForDocument[0].path + "/\(path)/metadata.plist"
        } else {
            fileStr = urlForDocument[0].path + "/\(path)/\(folder)/metadata.plist"
        }
        let nArray = NSArray(array: index)
        nArray.write(toFile: fileStr, atomically: true)
    }
    /// 获取文件夹下图片排序
    /// - Parameter folder: 文件夹名
    /// - Returns: 顺序 Example: ["pic1.png", "pic2.png", "pic3.png"]...
    @available(*, unavailable)
    public func GetImagesIndex(_ folder: String) -> [String]? {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl: URL
        if folder == "root" {
            fileUrl = URL(string: urlForDocument[0].absoluteString + "\(path)/metadata.plist")!
        } else {
            fileUrl = URL(string: urlForDocument[0].absoluteString + "\(path)/\(folder)/metadata.plist")!
        }
        if let nArray = NSArray(contentsOf: fileUrl) {
            return nArray as! [String]?
        } else {
            return nil
        }
    }
    
    /// 获取路径
    /// - Parameter folder: 文件夹名
    /// - Returns: absoluteString, URL, path
    public func GetPath(_ folder: String?) -> (string: String, url: URL, path: String) {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl: URL
        if folder == "root" || folder == nil {
            fileUrl = URL(string: urlForDocument[0].absoluteString + "\(path)/")!
        } else {
            fileUrl = URL(string: urlForDocument[0].absoluteString + "\(path)/\(folder!)/")!
        }
        return (fileUrl.absoluteString, fileUrl, fileUrl.path)
    }
    /// 查询文件夹是否为空
    /// - Parameter folder: 文件夹名
    /// - Returns: 是否为空
    public func isFolderEmpty(_ folder: String) -> Bool {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let folderUrl: URL
        if folder == "root" {
            folderUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "images"))!
        } else {
            folderUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(folder)"))!
        }
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: folderUrl.path)
        if contentsOfPath != nil {
            return false
        } else {
            return true
        }
    }
    
    /// 移动文件
    /// - Parameters:
    ///   - file: 源文件
    ///   - withSrcFolder: 源文件文件夹
    ///   - to: 目标文件夹
    public func MoveFile(_ file: String, withSrcFolder: String = "root", to: String) {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let srcFileUrl: URL
        if withSrcFolder == "root" {
            srcFileUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(file)"))!
        } else {
            srcFileUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(withSrcFolder)/\(file)"))!
        }
        let toFileUrl: URL
        if to == "root" {
            toFileUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(file)"))!
        } else {
            toFileUrl = URL(string: ((urlForDocument[0] as URL).absoluteString + "\(path)/\(to)/\(file)"))!
        }
        try! manager.moveItem(at: srcFileUrl, to: toFileUrl)
    }
    
    private func directoryIsExists(_ path: String) -> Bool {
        var directoryExists = ObjCBool.init(false)
        let fileExists = FileManager.default.fileExists(atPath: path, isDirectory: &directoryExists)
        return fileExists && directoryExists.boolValue
    }
}
