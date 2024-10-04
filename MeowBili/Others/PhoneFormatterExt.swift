//
//
//  PhoneFormatterExt.swift
//  MeowBili
//
//  Created by linecom on 2024/7/16.
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

func phoneFormatter(region: String) -> String {
    switch region {
    case "":
        return "手机号码"
    case "86":
        return "000 0000 0000"
    case "us", "ca":
        return "000 000 0000"
    case "886", "351":
        return "000 000 000"
    case "852", "853", "65", "64":
        return "0000 0000"
    case "44":
        return "0000 000000"
    case "32":
        return "000 00 00 00"
    case "61":
        return "0 0000 0000"
    case "33":
        return "0 00 00 00 00"
    case "81", "234":
        return "00 0000 0000"
    case "82":
        return "00 0000 000"
    case "39", "7":
        return "000 000 0000"
    case "1681":
        return "000 0000"
    case "47":
        return "000 00 000"
    case "227":
        return "00 00 00 00"
    default:
        return "手机号码"
    }
}

func validatePhoneNumber(num: String, cc: String) -> Bool {
    switch cc {
    case "86":
        if num.count == 11 {
            return true
        } else {
            return false
        }
    case "852", "853":
        if num.count == 8 {
            return true
        } else {
            return false
        }
    case "886":
        if num.count == 9 {
            return true
        } else {
            return false
        }
    case "1","44":
        if num.count == 10 {
            return true
        } else {
            return false
        }
    default:
        //一些地区手机号无固定格式
        return true
    }
}
