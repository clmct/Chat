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
    self.identifier = model.identifier
    self.content = model.content
    self.created = model.created
    self.senderId = model.senderId
    self.senderName = model.senderName
  }
}

extension ChannelMO {
  
  var about: String {
    
    let identifier: String = self.identifier
    let name: String = self.name
    let lastMessage: String
    let lastActivity: String
    
    if let message = self.lastMessage {
      lastMessage = message
    } else {
      lastMessage = "nil"
    }
    
    if let activity = self.lastActivity {
      lastActivity = Date.stringFromDate(day: activity)
    } else {
      lastActivity = "nil"
    }
    
    _ = self.messages?.allObjects
      .compactMap { $0 as? MessageMO }
      .map { "\($0.about)" }
      .joined(separator: "\n") ?? ""
    
    let messagesCount: Int = self.messages?.count ?? 0
    
    let aboutString1 = " identifier: \(identifier)\n name: \(name) \n last message: \(lastMessage)"
    let aboutString2 = "\n last activity: \(lastActivity)\n NUMBER OF MESSAGES(CoreData): \(messagesCount)"
    
    return aboutString1 + aboutString2
  }
  
}

extension MessageMO {
  
  var about: String {
    let content: String = self.content
    let created: String = Date.stringFromDate(day: self.created)
    let senderId: String = self.senderId
    let senderName: String = self.senderName
    
    let aboutString = "  content = \(content) \n  created = \(created) \n  senderId = \(senderId) \n  senderName = \(senderName)\n"
    return aboutString
  }
}
