//
//  ConversationModel.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 28.09.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation
import CoreData

struct MessageModel {
  let identifier: String
  let content: String
  let created: Date
  let senderId: String
  let senderName: String
}
protocol ConversationViewModelProtocol {
  func createMessage(identifire: String, newMessage: String)
  func fetchDataMessages(identifire: String)
  
  // чтобы не использовать import обращаюсь из VC в service напрямую - false
  //
  // так как я абстрагируюсь, то VC завязан исключительно на Model
  // в примере используется import
  // Services отсаются приватными свойсвами модели
    var mainContext: NSManagedObjectContext { get }
}

class ConversationViewModel: ConversationViewModelProtocol {
  
  // Methods
  func createMessage(identifire: String, newMessage: String) {
    fireStoreService.createMessage(identifire: identifire, newMessage: newMessage)
    fetchDataMessages(identifire: identifire)
  }
  
  func fetchDataMessages(identifire: String) {
    fireStoreService.fetchDataMessages(identifire: identifire) { data in
      self.saveDataService.makeRequestMessages(messagesModels: data)
    }
  }
  
  lazy var mainContext = coreDataService.mainContext
  
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
