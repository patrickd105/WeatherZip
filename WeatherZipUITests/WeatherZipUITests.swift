//
//  WeatherZipUITests.swift
//  WeatherZipUITests
//
//  Created by Patrick Dunshee on 5/5/19.
//  Copyright © 2019 Patrick Dunshee. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func waitForElement(evaluatedWith object: Any, timeout: TimeInterval) {
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: object, handler: nil)
        waitForExpectations(timeout: timeout, handler: nil)
    }
}

class WeatherZipUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testDataDisplays() {
        let tablesQuery = XCUIApplication().tables
        waitForElement(evaluatedWith: tablesQuery.staticTexts["City: Austin"], timeout: 3.0)
        waitForElement(evaluatedWith: tablesQuery.staticTexts["State: Texas"], timeout: 3.0)
    }

}
