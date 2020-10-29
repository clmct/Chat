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
  
  func makeRequestChannels(channelModels models: [ChannelModel]) {
    coreDataStack.performSave { context in
      models.forEach { model in
        _ = ChannelMO(model: model, in: context)
      }
    }
  }
  
  func makeRequestChannelWithMessages(channelModels channels: [ChannelModel], messagesModels messages: [MessageModel]) {
    coreDataStack.performSave { context in
      var messagesMO: [MessageMO] = [MessageMO]()
      messages.forEach { model in // update messages data for one channel
        let messageMO = MessageMO(model: model, in: context)
        messagesMO.append(messageMO)
      }
      channels.forEach { model in // update channels data
        let channelMO = ChannelMO(model: model, in: context)
        if model.identifier == messages.last?.identifier {
          messagesMO.forEach { channelMO.addToMessages($0) }
        }
      }
      
    }
  }
}
