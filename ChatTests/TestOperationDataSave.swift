//
//  TestOperationDataSave.swift
//  ChatTests
//
//  Created by Алмат Кульбаев on 03.12.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class TestOperationDataSave: XCTestCase {
  
//  func testWrite() throws {
//
//    // Arrange
//    let fileManagerMock = FileManagerComponentMock()
//    let operation = OperationDataManager(fileManager: fileManagerMock)
//    let data = Data()
//    let urlString = "testWriteOperation"
//
//    // Act
//    operation.write(data: data, urlString: urlString)
//
//    // Assets
//    XCTAssertEqual(fileManagerMock.callsCount, 1)
//  }
  
  func testRead() throws {
    
    // Arrange
    let expectations = expectation(description: "AsyncExpectations")
    let fileManagerMock = FileManagerComponentMock()
    let operation = OperationDataManager(fileManager: fileManagerMock)
    let data = Data()
    let urlString = "testReadOperation"
    fileManagerMock.data = data
    var testData: Data?
    
    // Act
    operation.read(urlString: urlString) { data in
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
