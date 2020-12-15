//
//  TestNetworkService.swift
//  ChatTests
//
//  Created by Алмат Кульбаев on 03.12.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class TestNetworkService: XCTestCase {

    func testSendRequestIsSuccess() throws {
      
      // Arrange
      let images = [Images(previewURL: "https://www.test.com")]
      let requestSender = RequestSenderMock(imagesStub: images, isSuccess: true)
      let networkService = NetworkService(requestSender: requestSender)

      // Act
      networkService.sendRequest { result in
        switch result {
        case .success(let urls):
          // Assets
          XCTAssertEqual(urls, [URL(string: "https://www.test.com")])
        case .failure(let error):
          print(error)
        }
      }
    }
  
  func testSendRequestIsFailure() throws {
    
    // Arrange
    let images = [Images(previewURL: "https://www.test.com")]
    let requestSender = RequestSenderMock(imagesStub: images, isSuccess: false)
    let networkService = NetworkService(requestSender: requestSender)

    // Act
    networkService.sendRequest { result in
      // Assets
      switch result {
      case .success(let urls):
        print(urls)
      case .failure(let error):
        XCTAssertEqual("\(error)", "serverError")
      }
    }
  }

}
