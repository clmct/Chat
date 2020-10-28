//
//  MessageDB.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 25.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData

@objc(MessageMO)
public class MessageMO: NSManagedObject {

  lazy var about: String = {
    let content: String = self.content
    let created: String = Date.stringFromDate(day: self.created)
    let senderId: String = self.senderId
    let senderName: String = self.senderName
    
    let aboutString = "  content = \(content) \n  created = \(created) \n  senderId = \(senderId) \n  senderName = \(senderName)\n"
    return aboutString
  }()
  
}

extension MessageMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageMO> {
        return NSFetchRequest<MessageMO>(entityName: "MessageMO")
    }

    @NSManaged public var content: String
    @NSManaged public var created: Date
    @NSManaged public var senderId: String
    @NSManaged public var senderName: String
    @NSManaged public var channel: ChannelMO?

}
