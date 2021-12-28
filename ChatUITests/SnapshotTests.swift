//
//  SnapshotTests.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import FBSnapshotTestCase

class SnapshotUITests: FBSnapshotTestCase {
  
  let app = XCUIApplication()
  
  func verifyView(identifier: String, perPixelTolerance: CGFloat = 0.00, overallTolerance: CGFloat = 0.05) {
    
    guard let screenshotWithoutStatusBar = app.screenshot().image.removingStatusBar else {
      return XCTFail("An error occurred while cropping the screenshot", file: #file, line: #line)
    }
    
    FBSnapshotVerifyView(
      UIImageView(image: screenshotWithoutStatusBar),
      identifier: identifier,
      perPixelTolerance: perPixelTolerance,
      overallTolerance: overallTolerance
    )
  }
  
  func verifyElement(element: XCUIElement, identifier: String) {
    FBSnapshotVerifyView(UIImageView(image: element.screenshot().image), identifier: identifier)
  }
  
  override func setUp() {
    super.setUp()
    
    app.launch()
    
    recordMode = false
    
    fileNameOptions = [
      .OS,
      .device,
      .screenScale,
      .screenSize
    ]
    
  }
  
  func testListPage_DayTheme() {
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
    
    Thread.sleep(forTimeInterval: 5)
    verifyView(identifier: "list_day")
  }
  
  func testSettingsPage_DayTheme() {
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
    
    let button = app.navigationBars.buttons["settingsButton"]
    _ = button.waitForExistence(timeout: 5)
    button.tap()
    
    Thread.sleep(forTimeInterval: 5)
    verifyView(identifier: "settings_day")
  }
  
  func testProfilePage_DayTheme() {
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
    
    let button = app.navigationBars.buttons["profileButton"]
    _ = button.waitForExistence(timeout: 5)
    button.tap()
    
    Thread.sleep(forTimeInterval: 5)
    verifyView(identifier: "profile_day")
  }
  
  func testListPage_NightTheme() {
    let buttonSettings = app.navigationBars.buttons["settingsButton"]
    _ = buttonSettings.waitForExistence(timeout: 5)
    XCTAssert(buttonSettings.exists)
    buttonSettings.tap()
    
    let buttonDay = app.buttons["night"]
    _ = buttonDay.waitForExistence(timeout: 5)
    XCTAssert(buttonDay.exists)
    buttonDay.tap()
    
    let backButton = app.navigationBars.buttons.element(boundBy: 0)
    _ = backButton.waitForExistence(timeout: 5)
    XCTAssert(backButton.exists)
    backButton.tap()
    
    Thread.sleep(forTimeInterval: 5)
    verifyView(identifier: "list_night")
  }
  
  func testSettingsPage_NightTheme() {
    let buttonSettings = app.navigationBars.buttons["settingsButton"]
    _ = buttonSettings.waitForExistence(timeout: 5)
    XCTAssert(buttonSettings.exists)
    buttonSettings.tap()
    
    let buttonDay = app.buttons["night"]
    _ = buttonDay.waitForExistence(timeout: 5)
    XCTAssert(buttonDay.exists)
    buttonDay.tap()
    
    let backButton = app.navigationBars.buttons.element(boundBy: 0)
    _ = backButton.waitForExistence(timeout: 5)
    XCTAssert(backButton.exists)
    backButton.tap()
    
    let button = app.navigationBars.buttons["settingsButton"]
    _ = button.waitForExistence(timeout: 5)
    button.tap()
    
    Thread.sleep(forTimeInterval: 5)
    verifyView(identifier: "settings_night")
  }
  
  func testProfilePage_NightTheme() {
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
    
    let button = app.navigationBars.buttons["profileButton"]
    _ = button.waitForExistence(timeout: 5)
    button.tap()
    
    Thread.sleep(forTimeInterval: 5)
    verifyView(identifier: "profile_night")
  }
}
