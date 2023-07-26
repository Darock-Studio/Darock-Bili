//
//  DarockBili_Watch_App_UI_TestsLaunchTests.swift
//  DarockBili Watch App UI Tests
//
//  Created by WindowsMEMZ on 2023/7/27.
//

import XCTest

final class DarockBili_Watch_App_UI_TestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
