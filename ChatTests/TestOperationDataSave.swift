//
//  TestOperationDataSave.swift
//  TestOperationDataSave
//
//  Created by Алмат Кульбаев on 03.12.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class TestOperationDataSave: XCTestCase {
  
  override func setUpWithError() throws {
  }
  override func tearDownWithError() throws {
  }
  
//  func testWrite() throws {
//
//    // Arrange
//    let fileManagerMock = FileManagerComponentMock()
//    let gcd = OperationDataManager(fileManager: fileManagerMock)
//    let data = Data()
//    let urlString = "testWriteOperation"
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
    let gcd = OperationDataManager(fileManager: fileManagerMock)
    let data = Data()
    let urlString = "testReadOperation"
    fileManagerMock.data = data
    var testData: Data?
    
    // Act
    gcd.read(urlString: urlString) { data in
      testData = data
      expectations.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
    // Assets 
    XCTAssertEqual(fileManagerMock.data, testData)
    XCTAssertEqual(fileManagerMock.urlString, urlString)
    XCTAssertEqual(fileManagerMock.callsCount, 1)
  }
  
  func testPerformanceExample() throws {
    self.measure {
    }
  }
  
}
