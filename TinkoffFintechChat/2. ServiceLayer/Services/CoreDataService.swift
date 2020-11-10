//
//  CoreDataService.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 09.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol CoreDataServiceProtocol {
//  func getChats() -> [ChannelMO]
//  func getMessagesForChat() -> [MessageMO]
//  func createChannel() // подумать над обработкой результата
//  func sendMessage(idChannel id: String) // передавать id канала или нет?
}

class CoreDataService: CoreDataServiceProtocol {
  
  let coreData: CoreDataProtocol
  
  init(coreData: CoreDataProtocol) {
    self.coreData = CoreDataStack()
  }
  
}
