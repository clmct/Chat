//
//  TestCGDDataSave.swift
//  ChatTests
//
//  Created by Алмат Кульбаев on 03.12.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class TestCGDDataSave: XCTestCase {
  
//  func testWrite() throws {
//    
//    // Arrange
//    let fileManagerMock = FileManagerComponentMock()
//    let gcd = GCDDataManager(fileManager: fileManagerMock)
//    let data = Data()
//    let urlString = "testWriteGCD"
//    
//    // Act
//    gcd.write(data: data, urlString: urlString)
//    
//    // Assets
//    XCTAssertEqual(fileManagerMock.data, data)
//    XCTAssertEqual(fileManagerMock.urlString, urlString)
//    XCTAssertEqual(fileManagerMock.callsCount, 1)
//  }
  
  func testRead() throws {
    
    // Arrange
    let expectations = expectation(description: "AsyncExpectations")
    let fileManagerMock = FileManagerComponentMock()
    let gcd = GCDDataManager(fileManager: fileManagerMock)
    let data = Data()
    let urlString = "testReadGCD"
    fileManagerMock.data = data
    var testData: Data?
    // Act
    gcd.read(urlString: urlString) { data in
      testData = data
      expectations.fulfill()
    }
    
    waitForExpectations(timeout: 3) { _ in
      // Assets
      XCTAssertEqual(fileManagerMock.data, testData)
      XCTAssertEqual(fileManagerMock.urlString, urlString)
      XCTAssertEqual(fileManagerMock.callsCount, 1)
    }
  }
  
}
