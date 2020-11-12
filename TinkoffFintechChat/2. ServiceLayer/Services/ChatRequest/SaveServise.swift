//
//  ChatRequest.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 27.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

struct ChatRequest { // should it be a struct?
  let coreDataStack: CoreDataStackProtocol
  
  init(coreDataStack: CoreDataStackProtocol) {
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
  } // не рационально, лучше при возваращение на главный экран делать запрос каналов
  func makeRequestMessages(messagesModels messages: [MessageModel]) {
    coreDataStack.performSave { context in
      var messagesMO: [MessageMO] = [MessageMO]()
      messages.forEach { model in // update messages data for one channel
        let messageMO = MessageMO(model: model, in: context)
        messagesMO.append(messageMO)
      }
      guard let id = messagesMO.last?.identifier else { return }
      
      let channel = getChannelByID(context: context, id: id)
      
      guard let idd: String = channel?.identifier else { return }
      guard let nam: String = channel?.name else { return }
      let lm: String? = channel?.lastMessage
      let ld: Date? = channel?.lastActivity
      
      let model = ChannelModel(identifier: idd, name: nam, lastMessage: lm, lastActivity: ld)
      
      let channelMO = ChannelMO(model: model, in: context)
      messagesMO.forEach { channelMO.addToMessages($0) }
      
    }
  }
  
}
