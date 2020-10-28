//
//  ChatRequest.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 27.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

struct ChatRequest {
  let coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func makeRequest() {
    coreDataStack.performSave { context in
//      let modelC = ChannelModel(identifier: "1", name: "name", lastMessage: "my chat", lastActivity: Date())
//      let modelM = MessageModel(content: "hi", created: Date(), senderId: "XYZ", senderName: "Alex")
//      let modelM1 = MessageModel(content: "its worl", created: Date(), senderId: "XYZ", senderName: "Alex")
//
//      let channel1 = ChannelMO(model: modelC, in: context)
//      let message1 = MessageMO(model: modelM, in: context)
//      let message2 = MessageMO(model: modelM1, in: context)
//      let message3 = MessageMO(model: modelM1, in: context)
//
//      let modelC2 = ChannelModel(identifier: "2", name: "name", lastMessage: "my chat", lastActivity: Date())
//      let channel2 = ChannelMO(model: modelC2, in: context)
//      [message1, message2, message3].forEach { channel1.addToMessages($0) }
    }
  }
  
  func makeRequestChannel(channelModels models: [ChannelModel]) {
    coreDataStack.performSave { context in
      models.forEach { model in
//        _ = ChannelMO(model: model, in: context)
      }
    }
  }
}
