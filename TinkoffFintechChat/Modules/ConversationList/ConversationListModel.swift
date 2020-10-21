//
//  ConversationListModel.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

struct ChannelModel {
  let identifier: String
  let name: String
  let lastMessage: String?
  let lastActivity: Date?
}
