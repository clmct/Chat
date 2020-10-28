//
//  ObjectsExtensions.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 25.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData

extension ChannelMO {
  convenience init(model: ChannelModel, in context: NSManagedObjectContext) {
    self.init(context: context)
    self.identifier = model.identifier
    self.name = model.name
    self.lastMessage = model.lastMessage
    self.lastActivity = model.lastActivity
  }
}

extension MessageMO {
  convenience init(model: MessageModel, in context: NSManagedObjectContext) {
    self.init(context: context)
    self.content = model.content
    self.created = model.created
    self.senderId = model.senderId
    self.senderName = model.senderName
  }
}
