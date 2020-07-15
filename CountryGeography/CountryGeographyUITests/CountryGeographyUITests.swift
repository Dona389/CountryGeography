//
//  CountryGeographyUITests.swift
//  CountryGeographyUITests
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import XCTest

class CountryGeographyUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    func testForCellExistence() {
        let app = XCUIApplication()
        app.launch()
        let detailstable = app.tables.matching(identifier: TestStringUtil.tableviewAccessibilityId.rawValue)
        let firstCell =
            detailstable.cells.element(matching: .cell, identifier: TestStringUtil.cellAccessibilityTestId.rawValue)
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 5.0)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
    }
}
