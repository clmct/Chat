//
//  ConversationModel.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

struct MessageModel {
  let identifier: String
  let content: String
  let created: Date
  let senderId: String
  let senderName: String
}
protocol ConversationViewModelProtocol {
  var coreDataService: CoreDataServiceProtocol { get }
  var fireStoreService: FireStoreServiceProtocol { get }
}

class ConversationViewModel: ConversationViewModelProtocol {
  
  public var coreDataService: CoreDataServiceProtocol
  public var fireStoreService: FireStoreServiceProtocol
  
  init(coreDataService: CoreDataServiceProtocol, fireStoreService: FireStoreServiceProtocol) {
    self.coreDataService = coreDataService
    self.fireStoreService = fireStoreService
  }
  
}
