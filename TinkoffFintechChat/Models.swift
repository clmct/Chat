//
//  Models.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 29.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

struct ConversationModel {
  let name: String
  let messages: [Messages]
  let isOnline: Bool
  let hasUnreadMessages: Bool
}

struct Messages {
  let message: String
  let isIncoming: Bool
  let date: Date
}
