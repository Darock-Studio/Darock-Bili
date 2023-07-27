//
//  DarockBili_Watch_App_UI_Tests.swift
//  DarockBili Watch App UI Tests
//
//  Created by WindowsMEMZ on 2023/7/27.
//

import XCTest

final class DarockBili_Watch_App_UI_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppMain() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        continueAfterFailure = true
        if app.staticTexts["Debug"].exists {
            XCTAssertTrue(app.staticTexts["Debug"].exists, "Debug Mode Not Closed")
            app.buttons["Debug"].tap()
            XCTAssertFalse(app.staticTexts["Text"].waitForExistence(timeout: 2.5), "No Tip Window")
            app.buttons["Show Debug Controls"].tap()
            XCTAssertFalse(app.staticTexts["Memory Usage:"].exists, "Debug - Memory Usage Label?")
            app.buttons["Close Debug Controls"].tap()
        }
        continueAfterFailure = false
        XCTAssertFalse(app.staticTexts["TestVideoCard"].waitForExistence(timeout: 7), "Could not load any video")
        app.buttons["TestVideoCard"].tap()
        app.buttons["OwnerPage"].tap()
        sleep(5)
        app.swipeLeft()
        sleep(5)
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
