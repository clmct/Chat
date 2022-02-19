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
  
  func testProfilePage_ShouldShowCorrectCountTextFieldAndTextView() throws {
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
  
  func testProfilePage_ShouldShowCorrectCountImages() throws {
    let app = XCUIApplication()
    app.launch()
    
    let navBar = app.navigationBars
    
    let button = navBar.buttons["profileButton"]
    _ = button.waitForExistence(timeout: 5)
    XCTAssert(button.exists)
    button.tap()
    
    let imagesCount = app.images.count
    XCTAssertEqual(imagesCount, 1)
  }
  
  func testProfilePage_ShouldShowConcurrencyButtons() throws {
    let app = XCUIApplication()
    app.launch()
    
    let navBar = app.navigationBars
    
    let button = navBar.buttons["profileButton"]
    _ = button.waitForExistence(timeout: 5)
    XCTAssert(button.exists)
    button.tap()
    
    let gcdButton = app.buttons["gcd"]
    _ = gcdButton.waitForExistence(timeout: 3)
    XCTAssert(gcdButton.exists)
    
    let operationButton = app.buttons["operation"]
    _ = operationButton.waitForExistence(timeout: 3)
    XCTAssert(operationButton.exists)
  }
  
  func testSettings_ShouldShowCorrectCountAllButtons() throws {
    let app = XCUIApplication()
    app.launch()
    
    let navBar = app.navigationBars
    
    let button = navBar.buttons["settingsButton"]
    _ = button.waitForExistence(timeout: 5)
    XCTAssert(button.exists)
    button.tap()
    
    let buttons = app.buttons
    _ = buttons.firstMatch.waitForExistence(timeout: 3)

    XCTAssertEqual(buttons.count, 7)
  }
  
  func testSettings_canChooseNightThemeAndBack() throws {
    let app = XCUIApplication()
    app.launch()
    
    let buttonSettings = app.navigationBars.buttons["settingsButton"]
    _ = buttonSettings.waitForExistence(timeout: 5)
    XCTAssert(buttonSettings.exists)
    buttonSettings.tap()
    
    let buttonNight = app.buttons["night"]
    _ = buttonNight.waitForExistence(timeout: 5)
    XCTAssert(buttonNight.exists)
    buttonNight.tap()
    
    let backButton = app.navigationBars.buttons.element(boundBy: 0)
    _ = backButton.waitForExistence(timeout: 5)
    XCTAssert(backButton.exists)
    backButton.tap()
  }
  
  func testSettings_canChooseClassicThemeAndBack() throws {
    let app = XCUIApplication()
    app.launch()
    
    let buttonSettings = app.navigationBars.buttons["settingsButton"]
    _ = buttonSettings.waitForExistence(timeout: 5)
    XCTAssert(buttonSettings.exists)
    buttonSettings.tap()
    
    let buttonClassic = app.buttons["classic"]
    _ = buttonClassic.waitForExistence(timeout: 5)
    XCTAssert(buttonClassic.exists)
    buttonClassic.tap()
    
    let backButton = app.navigationBars.buttons.element(boundBy: 0)
    _ = backButton.waitForExistence(timeout: 5)
    XCTAssert(backButton.exists)
    backButton.tap()
  }
  
  func testSettings_canChooseDayThemeAndBack() throws {
    let app = XCUIApplication()
    app.launch()
    
    let buttonSettings = app.navigationBars.buttons["settingsButton"]
    _ = buttonSettings.waitForExistence(timeout: 5)
    XCTAssert(buttonSettings.exists)
    buttonSettings.tap()
    
    let buttonDay = app.buttons["day"]
    _ = buttonDay.waitForExistence(timeout: 5)
    XCTAssert(buttonDay.exists)
    buttonDay.tap()
    
    let backButton = app.navigationBars.buttons.element(boundBy: 0)
    _ = backButton.waitForExistence(timeout: 5)
    XCTAssert(backButton.exists)
    backButton.tap()
  }
}
