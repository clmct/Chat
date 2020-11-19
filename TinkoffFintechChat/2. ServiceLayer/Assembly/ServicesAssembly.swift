//
//  ServicesAssembly.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 08.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol ServiceAssemblyProtocol {
  var fireStoreService: FireStoreServiceProtocol { get }
  var saveDataService: SaveDataServiceProtocol { get } // performSave
  var coreDataService: CoreDataServiceProtocol { get } // main context, statistics
  var networkService: NetworkServiceProtocol { get }
}

class ServiceAssembly: ServiceAssemblyProtocol {
   
  // Services
  lazy var fireStoreService: FireStoreServiceProtocol = FireStoreService()
  
  lazy var saveDataService: SaveDataServiceProtocol = SaveDataService(coreDataStack: coreAssembly.coreDataStack)
  
  lazy var coreDataService: CoreDataServiceProtocol = CoreDataService(coreDataStack: coreAssembly.coreDataStack)
  
  lazy var networkService: NetworkServiceProtocol = NetworkService(requestSender: coreAssembly.requestSender)
  
  // components from CoreLayer
  private let coreAssembly: CoreAssemblyProtocol
  
  init(coreAssembly: CoreAssemblyProtocol) {
    self.coreAssembly = coreAssembly
  }
}
