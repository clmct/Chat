//
//  MessageMO+CoreDataProperties.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 29.10.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//
//

import Foundation
import CoreData

extension MessageMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageMO> {
        return NSFetchRequest<MessageMO>(entityName: "MessageMO")
    }

    @NSManaged public var content: String
    @NSManaged public var created: Date
    @NSManaged public var identifier: String
    @NSManaged public var senderId: String
    @NSManaged public var senderName: String
    @NSManaged public var channel: ChannelMO?

}
