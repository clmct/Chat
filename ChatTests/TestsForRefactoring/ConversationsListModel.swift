//
//  ConversationsListModel.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class TestConversationsListModel: XCTestCase {
  // MARK: createMessage
  
  func testConversationsListModel_createChannel_expectedBehavior() {
    // given
    let fireStoreService = FireStoreServiceMock()
    let saveDataService = SaveDataServiceMock()
    let coreDataService = CoreDataServiceMock()
    
    let model: ConversationsListModelProtocol = ConversationsListModel(fireStoreService: fireStoreService,
                                                                       saveDataService: saveDataService,
                                                                       coreDataService: coreDataService)
    
    // when
    let expectation = expectation(description: "AsyncExpectation")
    model.createChannel(newChannel: "channel")
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertEqual(fireStoreService.fetchDataMessagesCount, 0)
    XCTAssertEqual(fireStoreService.fetchDataCount, 1)
    XCTAssertEqual(fireStoreService.createMessageCount, 0)
    XCTAssertEqual(fireStoreService.createChannelCount, 1)
    
    XCTAssertEqual(saveDataService.makeRequestChannelsCount, 1)
    XCTAssertEqual(saveDataService.makeRequestMessagesCount, 0)
    
    XCTAssertEqual(coreDataService.printDataStatisiticsCount, 0)
  }
  
  // MARK: fetchDataMessages
  
  func testConversationsListModel_fetchData__expectedBehavior() {
    // given
    let fireStoreService = FireStoreServiceMock()
    let saveDataService = SaveDataServiceMock()
    let coreDataService = CoreDataServiceMock()
    
    let model: ConversationsListModelProtocol = ConversationsListModel(fireStoreService: fireStoreService,
                                                                     saveDataService: saveDataService,
                                                                     coreDataService: coreDataService)
    
    // when
    let expectation = expectation(description: "AsyncExpectation")
    model.fetchData()
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertEqual(fireStoreService.fetchDataMessagesCount, 0)
    XCTAssertEqual(fireStoreService.fetchDataCount, 1)
    XCTAssertEqual(fireStoreService.createMessageCount, 0)
    XCTAssertEqual(fireStoreService.createChannelCount, 0)
    
    XCTAssertEqual(saveDataService.makeRequestChannelsCount, 1)
    XCTAssertEqual(saveDataService.makeRequestMessagesCount, 0)
    
    XCTAssertEqual(coreDataService.printDataStatisiticsCount, 0)
  }
}
