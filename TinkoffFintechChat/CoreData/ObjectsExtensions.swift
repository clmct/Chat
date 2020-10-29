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
    
    let identifier: String
    let name: String
    let lastMessage: String
    let lastActivity: String
    
    if let id = self.identifier {
      identifier = id
    } else {
      identifier = "nil"
    }
    
    if let nam = self.name {
      name = nam
    } else {
      name = "nil"
    }
    
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
    
    let messages = self.messages?.allObjects
      .compactMap { $0 as? MessageMO }
      .map { "\($0.about)" }
      .joined(separator: "\n") ?? ""
    
    let aboutString = " identifier = \(identifier) \n name = \(name) \n lastMessage = \(lastMessage) \n lastActivity = \(lastActivity)\n"
    
    return aboutString + messages
  }
  
  var messagesCount: Int {
    return messages?.count ?? 0
    
  }
}

extension MessageMO {
  
  var about: String {
    if let content = self.content, let created = self.created, let senderId = self.senderId, let senderName = self.senderName {
      let content: String = content
      let created: String = Date.stringFromDate(day: created)
      let senderId: String = senderId
      let senderName: String = senderName
      
      let aboutString = "  content = \(content) \n  created = \(created) \n  senderId = \(senderId) \n  senderName = \(senderName)\n"
      return aboutString
    }
    return "Not valid"
  }
}
