//
//  CoreAssembly.swift
//  TinkoffFintechChat
//
//  Created by Almat Kulbaev on 08.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import Foundation

protocol CoreAssemblyProtocol {
  var coreData: CoreDataProtocol { get }
  var fireStore: FireStoreProtocol { get }
}

class CoreAssembly: CoreAssemblyProtocol {
  lazy var coreData: CoreDataProtocol = CoreDataStack()
  lazy var fireStore: FireStoreProtocol = FireStoreService()
}
