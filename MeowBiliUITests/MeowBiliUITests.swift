//
//
//  MeowBiliUITests.swift
//  MeowBiliUITests
//
//  Created by memz233 on 2024/2/22.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import XCTest

final class MeowBiliUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppUI() throws {
        let app = XCUIApplication()
        app.launch()

        takeScreenshot(of: app, named: "AppLaunch")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}


var screenshotCount = 1

extension XCTestCase {
    /// Take a screenshot of a given app and add it to the test attachements.
    /// - Parameters:
    ///   - app: The app to take a screenshot of.
    ///   - name: The name of the screenshot.
    func takeScreenshot(of app: XCUIApplication, named name: String) {
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        let name = "Screenshot-\(screenshotCount)-\(name)-\(UIDevice.current.name).png"
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
        screenshotCount += 1
    }
}
