//
//  IntegrationTests.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class IntegrationTests: XCTestCase {
  
  // MARK: GCDDataManager
  
  func testGCDDataManager_ShouldReadAndWriteCorrect() {
    // given
    let expectation = expectation(description: "AsyncExpectation")
    
    let fileManager = FileManagerComponent()
    let GCDDataManager = GCDDataManager(fileManager: fileManager)
    
    let urlString = "Path for password"
    let inputData = Data("secret password: 1234".utf8)
    var outputData: Data?
    
    // when

    GCDDataManager.write(data: inputData, urlString: urlString)
    
    sleep(5)
    
    GCDDataManager.read(urlString: urlString) { data in
      outputData = data
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertEqual(outputData, inputData)
  }
  
  func testGCDDataManager_ShouldReadAndWriteUnCorrect() {
    // given
    let expectation = expectation(description: "AsyncExpectation")
    
    let fileManager = FileManagerComponent()
    let GCDDataManager = GCDDataManager(fileManager: fileManager)
    
    let urlString = "Path for password"
    let inputData = Data("Secret password: 1234".utf8)
    var outputData: Data?
    
    // when

    GCDDataManager.write(data: inputData, urlString: urlString)
    
    sleep(5)
    
    GCDDataManager.read(urlString: "Different path") { data in
      outputData = data
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotEqual(outputData, inputData)
  }
  
  // MARK: OperationDataManager
  
  func testOperationDataManager_ShouldReadAndWriteCorrect() {
    // given
    let expectation = expectation(description: "AsyncExpectation")
    
    let fileManager = FileManagerComponent()
    let operationDataManager = OperationDataManager(fileManager: fileManager)
    
    let urlString = "Path for password"
    let inputData = Data("secret password: 1234".utf8)
    var outputData: Data?
    
    // when

    operationDataManager.write(data: inputData, urlString: urlString)
    
    sleep(5)
    
    operationDataManager.read(urlString: urlString) { data in
      outputData = data
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertEqual(outputData, inputData)
  }
  
  func testOperationDataManager_ShouldReadAndWriteUnCorrect() {
    // given
    let expectation = expectation(description: "AsyncExpectation")
    
    let fileManager = FileManagerComponent()
    let operationDataManager = OperationDataManager(fileManager: fileManager)
    
    let urlString = "Path for password"
    let inputData = Data("Secret password: 1234".utf8)
    var outputData: Data?
    
    // when

    operationDataManager.write(data: inputData, urlString: urlString)
    
    sleep(5)
    
    operationDataManager.read(urlString: "Different path") { data in
      outputData = data
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotEqual(outputData, inputData)
  }
  
  // MARK: NetworkLayer
  
  func testNetworkLayer_RequestShouldGetCorrectCount() {
    // given
    let expectation = expectation(description: "AsyncExpectation")
    
    let pages = 10
    let request = Request(pages: pages)
    let parser = Parser()
    let requestConfig = RequestConfig(request: request, parser: parser)
    let requestSender = RequestSender(requestConfig: requestConfig)
    let networkService: NetworkServiceProtocol = NetworkService(requestSender: requestSender)
    var count: Int?
    
    // when
    
    networkService.sendRequest { result in
      switch result {
      case .success(let urls):
        count = urls.count
        expectation.fulfill()
      case .failure(_):
        count = nil
      }
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertEqual(count, pages)
  }
}
