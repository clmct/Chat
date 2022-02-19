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
  func createChannel(newChannel: String)
  func fetchData()
  var mainContext: NSManagedObjectContext { get }
}

class ConversationsListModel: ConversationsListModelProtocol {
  
  lazy var mainContext: NSManagedObjectContext = coreDataService.mainContext
  private var fireStoreService: FireStoreServiceProtocol
  private var saveDataService: SaveDataServiceProtocol
  private var coreDataService: CoreDataServiceProtocol
  
  init(fireStoreService: FireStoreServiceProtocol,
       saveDataService: SaveDataServiceProtocol,
       coreDataService: CoreDataServiceProtocol) {
    self.saveDataService = saveDataService
    self.fireStoreService = fireStoreService
    self.coreDataService = coreDataService
  }
  
  func createChannel(newChannel: String) {
    fireStoreService.createChannel(newChannel: newChannel)
    fireStoreService.fetchData { data in
      self.saveDataService.makeRequestChannels(channelModels: data)
    }
  }
  
  func fetchData() {
    fireStoreService.fetchData { data in
      self.saveDataService.makeRequestChannels(channelModels: data)
    }
  }
}
