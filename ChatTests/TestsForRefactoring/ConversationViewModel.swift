//
//  ConversationViewModel.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import XCTest
@testable import ChatTF

class TestConversationViewModel: XCTestCase {
  // MARK: createMessage
  
  func testConversationViewModel_createMessage_shouldCreateMessage() {
    // given
    let fireStoreService = FireStoreServiceMock()
    let saveDataService = SaveDataServiceMock()
    let coreDataService = CoreDataServiceMock()
    
    let model: ConversationViewModelProtocol = ConversationViewModel(fireStoreService: fireStoreService,
                                                                     saveDataService: saveDataService,
                                                                     coreDataService: coreDataService)
    
    // when
    let expectation = expectation(description: "AsyncExpectation")
    model.createMessage(identifire: "id", newMessage: "message")
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertEqual(fireStoreService.fetchDataMessagesCount, 1)
    XCTAssertEqual(fireStoreService.fetchDataCount, 0)
    XCTAssertEqual(fireStoreService.createMessageCount, 1)
    XCTAssertEqual(fireStoreService.createChannelCount, 0)
    
    XCTAssertEqual(saveDataService.makeRequestChannelsCount, 0)
    XCTAssertEqual(saveDataService.makeRequestMessagesCount, 1)
    
    XCTAssertEqual(coreDataService.printDataStatisiticsCount, 0)
  }
  
  // MARK: fetchDataMessages
  
  func testConversationViewModel_fetchDataMessages_shouldFetchDataMessages() {
    // given
    let fireStoreService = FireStoreServiceMock()
    let saveDataService = SaveDataServiceMock()
    let coreDataService = CoreDataServiceMock()
    
    let model: ConversationViewModelProtocol = ConversationViewModel(fireStoreService: fireStoreService,
                                                                     saveDataService: saveDataService,
                                                                     coreDataService: coreDataService)
    
    // when
    let expectation = expectation(description: "AsyncExpectation")
    model.fetchDataMessages(identifire: "id")
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertEqual(fireStoreService.fetchDataMessagesCount, 1)
    XCTAssertEqual(fireStoreService.fetchDataCount, 0)
    XCTAssertEqual(fireStoreService.createMessageCount, 0)
    XCTAssertEqual(fireStoreService.createChannelCount, 0)
    
    XCTAssertEqual(saveDataService.makeRequestChannelsCount, 0)
    XCTAssertEqual(saveDataService.makeRequestMessagesCount, 1)
    
    XCTAssertEqual(coreDataService.printDataStatisiticsCount, 0)
  }
}
