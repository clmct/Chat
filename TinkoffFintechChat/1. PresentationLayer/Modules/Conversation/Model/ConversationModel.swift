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
  func createMessage(identifire: String, newMessage: String)
}

class ConversationViewModel: ConversationViewModelProtocol {
  func createMessage(identifire: String, newMessage: String) {
    fireStoreService.createMessage(identifire: identifire, newMessage: newMessage)
    fireStoreService.fetchDataMessages(identifire: identifire) { data in
      ChatRequest(coreDataStack: self.coreDataService.coreDataStack).makeRequestMessages(messagesModels: data)
    }
  }
    
  public var coreDataService: CoreDataServiceProtocol
  public var fireStoreService: FireStoreServiceProtocol
  
  init(coreDataService: CoreDataServiceProtocol, fireStoreService: FireStoreServiceProtocol) {
    self.coreDataService = coreDataService
    self.fireStoreService = fireStoreService
  }
  
}
