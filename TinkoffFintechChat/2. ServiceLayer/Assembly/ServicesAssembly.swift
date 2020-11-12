//
//  ServicesAssembly.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 08.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol ServiceAssemblyProtocol {
  var coreDataService: CoreDataServiceProtocol { get }
  var fireStoreService: FireStoreServiceProtocol { get }
}

class ServiceAssembly: ServiceAssemblyProtocol {
  private let coreAssembly: CoreAssemblyProtocol
  
  lazy var coreDataService: CoreDataServiceProtocol = CoreDataService(coreDataStack: coreAssembly.coreDataStack)
  
  lazy var fireStoreService: FireStoreServiceProtocol = FireStoreService()
  
  init(coreAssembly: CoreAssemblyProtocol) {
    self.coreAssembly = coreAssembly
  }
}
