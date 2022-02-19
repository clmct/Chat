//
//  SaveDataServiceMock.swift
//  ChatTests
//
//  Created by Almat Kulbaev on 28.12.2021.
//  Copyright © 2021 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData
@testable import ChatTF

class SaveDataServiceMock: SaveDataServiceProtocol {
  var makeRequestChannelsCount = 0
  var makeRequestMessagesCount = 0
  
  func makeRequestChannels(channelModels models: [ChannelModel]) {
    makeRequestChannelsCount += 1
  }
  
  func makeRequestMessages(messagesModels messages: [MessageModel]) {
    makeRequestMessagesCount += 1
  }
}
