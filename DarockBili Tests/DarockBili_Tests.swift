//
//  DarockBili_Tests.swift
//  DarockBili Tests
//
//  Created by WindowsMEMZ on 2023/7/4.
//

import XCTest
import SwiftUI
import DarockKit
import Alamofire

final class DarockBili_Tests: XCTestCase {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        measure {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata);"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/member/web/account", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    
                }
            }
            DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("mid=\(dedeUserID)".base64Encoded())") { respStr, isSuccess in
                if isSuccess {
                    debugPrint(respStr.apiFixed())
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/acc/info?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            
                        }
                    }
                }
            }
        }
    }

}
