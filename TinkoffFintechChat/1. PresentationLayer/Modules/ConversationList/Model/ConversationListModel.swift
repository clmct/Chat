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
//  var delegateFRC: NSFetchedResultsControllerDelegate? { get set }
  func createChannel(newChannel: String)
  func fetchData()
  var mainContext: NSManagedObjectContext { get }
  // Сначало принимаю даннеы сообщений из сервера
  // потом они сохроняются в CoreData
  // потом уже в VC диалога они читаются через FRC
  //
  // можно делeть запрос в VC чата в ViewDidLoad ----- !
  // я его длеаю при отправки сообщения
  // это будет правильно с точки зрения SRP
//  func fetchDataMessages(identifire: String)
  
  //  var delegate: ConversationsListModelDelegate? { get set }
}

//protocol ConversationsListModelDelegate: class { у меня даннеы загружаются из FRC
//    func setup(dataSource: [ChannelMO])
//}

class ConversationsListModel: ConversationsListModelProtocol {
  
  func createChannel(newChannel: String) {
    fireStoreService.createChannel(newChannel: newChannel)
    fireStoreService.fetchData { data in
      self.saveDataService.makeRequestChannels(channelModels: data)
    }
  }
  
  lazy var mainContext: NSManagedObjectContext = coreDataService.mainContext
  
  // load data from server
  // need to save in CoreData
  func fetchData() {
    fireStoreService.fetchData { data in
      self.saveDataService.makeRequestChannels(channelModels: data)
    }
  }
  
//   load data messages by ID from server
//   need to save in CoreData
//  func fetchDataMessages(identifire: String) {
//    fireStoreService.fetchDataMessages(identifire: identifire) { data in
//      self.saveDataService.makeRequestMessages(messagesModels: data)
//    }
//  }
  
  // BLL
  //  var delegateFRC: NSFetchedResultsControllerDelegate?
  //  weak var delegate: ConversationsListModelDelagate?

  // Services
  private var fireStoreService: FireStoreServiceProtocol
  
  private var saveDataService: SaveDataServiceProtocol
  private var coreDataService: CoreDataServiceProtocol
  
  // init
  init(fireStoreService: FireStoreServiceProtocol,
       saveDataService: SaveDataServiceProtocol,
       coreDataService: CoreDataServiceProtocol) {
    self.saveDataService = saveDataService
    self.fireStoreService = fireStoreService
    self.coreDataService = coreDataService
  }
}
