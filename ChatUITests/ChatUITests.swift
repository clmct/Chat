//
//  ChatUITests.swift
//  ChatUITests
//
//  Created by Алмат Кульбаев on 03.12.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import XCTest

class ChatUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
    }
    override func tearDownWithError() throws {
    }
  
  func testProfilePage() throws {
    
    let app = XCUIApplication()
    app.launch()
    
    let navBar = app.navigationBars
    
    let button = navBar.buttons["profileButton"]
    _ = button.waitForExistence(timeout: 5)
    XCTAssert(button.exists)
    button.tap()
    
    let textField = app.textFields.firstMatch
    _ = textField.waitForExistence(timeout: 3)
    XCTAssert(textField.exists)
    
    let textView = app.textViews.firstMatch
    _ = textView.waitForExistence(timeout: 3)
    XCTAssert(textView.exists)
    
    let textFieldCount = app.descendants(matching: .textField).count
    let textViewCount = app.descendants(matching: .textView).count
    
    XCTAssertEqual(textFieldCount, 1)
    XCTAssertEqual(textViewCount, 1)
  }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
