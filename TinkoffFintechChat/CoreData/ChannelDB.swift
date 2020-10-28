//
//  ChannelDB.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 25.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData

@objc(ChannelMO)
public class ChannelMO: NSManagedObject {
  
  lazy var about: String = {
    
    let identifier = self.identifier
    let name = self.name
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
    
    let messages = self.messages?.allObjects
      .compactMap { $0 as? MessageMO }
      .map { "\($0.about)" }
      .joined(separator: "\n") ?? ""
    
    let aboutString = " identifier = \(identifier) \n name = \(name) \n lastMessage = \(lastMessage) \n lastActivity = \(lastActivity)\n"
    
    return aboutString + messages
  }()

}

extension ChannelMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChannelMO> {
        return NSFetchRequest<ChannelMO>(entityName: "ChannelMO")
    }

    @NSManaged public var identifier: String
    @NSManaged public var name: String
    @NSManaged public var lastMessage: String?
    @NSManaged public var lastActivity: Date?
    @NSManaged public var messages: NSSet?

}

// MARK: - Generated accessors for message
extension ChannelMO {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: MessageMO)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: MessageMO)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}
