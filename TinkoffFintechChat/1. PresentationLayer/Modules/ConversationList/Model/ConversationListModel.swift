//
//  ConversationListModel.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData

struct ChannelModel {
  let identifier: String
  let name: String
  let lastMessage: String?
  let lastActivity: Date?
}

protocol ConversationsListModelProtocol {
  var delegateFRC: NSFetchedResultsControllerDelegate? { get set }
  var coreDataService: CoreDataServiceProtocol { get }
  var fireStoreService: FireStoreServiceProtocol { get }
  func createChannel(newChannel: String)
  func createMessage(identifire: String, newMessage: String)
  func fetchData()
  func fetchDataMessages(identifire: String)
  
//  var delegate: ConversationsListModelDelegate? { get set }
}

//protocol ConversationsListModelDelegate: class { у меня даннеы загружаются из FRC
//    func setup(dataSource: [ChannelMO])
//}

class ConversationsListModel: ConversationsListModelProtocol {
  func createChannel(newChannel: String) {
    fireStoreService.createChannel(newChannel: newChannel)
    fireStoreService.fetchData { data in
      ChatRequest(coreDataStack: self.coreDataService.coreDataStack).makeRequestChannels(channelModels: data)
    }
  }
  
  func createMessage(identifire: String, newMessage: String) {
    fireStoreService.createMessage(identifire: identifire, newMessage: newMessage)
  }
  
  // load data from server
  // need to save in CoreData
  func fetchData() {
    fireStoreService.fetchData { data in
      ChatRequest(coreDataStack: self.coreDataService.coreDataStack).makeRequestChannels(channelModels: data)
    }
  }
  
  // load data messages by ID from server
  // need to save in CoreData
  func fetchDataMessages(identifire: String) {
    fireStoreService.fetchDataMessages(identifire: identifire) { data in
      ChatRequest(coreDataStack: self.coreDataService.coreDataStack).makeRequestMessages(messagesModels: data)
    }
  }
  // BLL
  var delegateFRC: NSFetchedResultsControllerDelegate?
  
  public var coreDataService: CoreDataServiceProtocol
  public var fireStoreService: FireStoreServiceProtocol
  
//  weak var delegate: ConversationsListModelDelagate?
  
  init(coreDataService: CoreDataServiceProtocol, fireStoreService: FireStoreServiceProtocol) {
    self.coreDataService = coreDataService
    self.fireStoreService = fireStoreService
  }
}
