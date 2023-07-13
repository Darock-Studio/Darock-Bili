//
//  CodeExt.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/6.
//

import Foundation
import OSLog

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
}
