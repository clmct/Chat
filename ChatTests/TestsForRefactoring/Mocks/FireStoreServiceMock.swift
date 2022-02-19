//
//  FireStoreServiceMock.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import Foundation
@testable import ChatTF

class FireStoreServiceMock: FireStoreServiceProtocol {
  var fetchDataCount = 0
  var createChannelCount = 0
  var fetchDataMessagesCount = 0
  var createMessageCount = 0
  
  func fetchData(completion: @escaping ([ChannelModel]) -> Void) {
    fetchDataCount += 1
    completion([])
  }
  
  func createChannel(newChannel channel: String) {
    createChannelCount += 1
  }
  
  func fetchDataMessages(identifire id: String, completion: @escaping ([MessageModel]) -> Void) {
    fetchDataMessagesCount += 1
    completion([])
  }
  
  func createMessage(identifire id: String, newMessage message: String) {
    createMessageCount += 1
  }
}
