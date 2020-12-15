//
//  ChannelMO+CoreDataProperties.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 29.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//
//

import Foundation
import CoreData

extension ChannelMO {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ChannelMO> {
    return NSFetchRequest<ChannelMO>(entityName: "ChannelMO")
  }
  
  @NSManaged public var identifier: String
  @NSManaged public var name: String
  @NSManaged public var lastActivity: Date?
  @NSManaged public var lastMessage: String?
  @NSManaged public var messages: NSSet?
  
}

// MARK: Generated accessors for messages
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
