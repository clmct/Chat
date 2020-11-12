//
//  ChatRequest.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 27.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData

struct ChatRequest {
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
      let a = GetData(context: coreDataStack.mainContext)
      let channel = a.fetchRequestChannelByID(id: id)
      
      let idd: String = channel?.identifier ?? "id"
      let nam: String = channel?.name ?? "name"
      let lm: String? = channel?.lastMessage
      let ld: Date? = channel?.lastActivity
      
      let model = ChannelModel(identifier: idd, name: nam, lastMessage: lm, lastActivity: ld)
      
      let channelMO = ChannelMO(model: model, in: context)
      messagesMO.forEach { channelMO.addToMessages($0) }
      
//      channels.forEach { model in // update channels data
//        let channelMO = ChannelMO(model: model, in: context)
//        if model.identifier == messages.last?.identifier {
//          messagesMO.forEach { channelMO.addToMessages($0) }
//        }
//      }
      
    }
  }
  
}

struct GetData {
  let context: NSManagedObjectContext
  init(context: NSManagedObjectContext) {
    self.context = context
  }
  
  func fetchRequestChannelByID(id: String) -> ChannelMO? {
    let request: NSFetchRequest<ChannelMO> = ChannelMO.fetchRequest()
    request.predicate = NSPredicate(format: "identifier == %@", id)
    request.fetchLimit = 1
    do {
      let result = try context.fetch(request)
      return result.first
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }
}
