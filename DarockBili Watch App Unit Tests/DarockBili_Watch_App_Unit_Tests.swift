//
//  DarockBili_Watch_App_Unit_Tests.swift
//  DarockBili Watch App Unit Tests
//
//  Created by WindowsMEMZ on 2023/7/27.
//

import XCTest
import DarockKit

final class DarockBili_Watch_App_Unit_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDarockApiBase() throws {
        DarockKit.Network.shared.requestString("https://api.darock.top") { respStr, isSuccess in
            if isSuccess {
                XCTAssert(respStr == "\"OK\"", "Darock API 返回错误")
            } else {
                XCTAssert(false, "无法连接到 Darock API")
            }
        }
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
