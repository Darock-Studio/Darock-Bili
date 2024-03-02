//
//
//  DarockBili_dynamic.swift
//  DarockBili.dynamic
//
//  Created by memz233 on 2024/3/2.
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

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON

@_silgen_name("testPrint")
public func testPrint() {
    print("Darock Dynamic Here!")
}

@_silgen_name("GetAppMainView")
public func GetAppMainView() -> UnsafeMutableRawPointer {
    return UnsafeMutableRawPointer(Unmanaged.passRetained(Wrapper(view: AnyView(AppMainView()))).toOpaque())
}
final class Wrapper {
    let view: AnyView
    init(view: AnyView) {
        self.view = view
    }
}

@_cdecl("GetDylibVersion")
public func GetDylibVersion() -> String {
    return "1.0.2"
}
